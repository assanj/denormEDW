--4. Присоединение справочников (аналог LEFT JOIN в Qlik)

-- 4.1. Присоединение справочника Сегменты
DROP TABLE IF EXISTS actuary.rep_osago_data_step1;
CREATE TABLE actuary.rep_osago_data_step1 AS
SELECT d.*
FROM actuary.rep_osago_data d
LEFT JOIN actuary.ref_xls4triangles_segments s 
    ON d."Тип страхователя" = s."Тип страхователя" 
    AND COALESCE(d."Тип убытка крупный", '') = COALESCE(s."Тип убытка крупный", '');

-- 4.2. Присоединение справочника Коэффициенты (по Сегмент, Год_месяц, Сдвиг)
DROP TABLE IF EXISTS actuary.rep_osago_data_step2;
CREATE TABLE actuary.rep_osago_data_step2 AS
SELECT d.*,
       c."Коэф_развития_1",
       c."Коэф_развития_2",
       c."k_risk",
       c."k_season"
FROM actuary.rep_osago_data_step1 d
LEFT JOIN actuary.ref_xls4triangles_coefficients c 
    ON d."Сегмент" = c."Сегмент" 
    AND d."Год_месяц" = c."Месяц"
    AND d."Сдвиг" = (c."Сдвиг"::int + 1)::text;

-- 4.3. Преобразование кварталов через прямое вычисление (вместо LEFT JOIN с ref_xls4triangles_quarters)
-- Вычисляем поля: Год, Месяц, DS, Квартал, Квартал начала, Год начала, DN
DROP TABLE IF EXISTS actuary.rep_osago_data_step3;
CREATE TABLE actuary.rep_osago_data_step3 AS
SELECT d.*,
       LEFT(d."Год_месяц", 4)::int as "Год",
       RIGHT(d."Год_месяц", 2)::int as "Месяц",
       TO_DATE(d."Год_месяц'||'01', 'YYYYMMDD') as "DS",
       EXTRACT(QUARTER FROM TO_DATE(d."Год_месяц'||'01', 'YYYYMMDD'))::int as "Квартал",
       -- Для Месяца начала
       LEFT(d."Месяц начала", 4)::int as "Год начала",
       TO_DATE(d."Месяц начала"||'01', 'YYYYMMDD') as "DN",
       -- Квартал начала (аналог to_char(date_trunc('quarter', ...), 'YYYY_"_"Q'))
       to_char(date_trunc('quarter', TO_DATE(d."Месяц начала"||'01', 'YYYYMMDD')), 'YYYY_"_"Q') as "Квартал начала"
FROM actuary.rep_osago_data_step2 d;

-- 4.4. Присоединение справочника Коэффициенты COVID (k_covid19_osago)
DROP TABLE IF EXISTS actuary.temp_covid;
CREATE TABLE actuary.temp_covid AS
SELECT DISTINCT "Месяц" as "Месяц_COVID19", "k_covid19_osago"
FROM actuary.ref_xls4triangles_coefficients
WHERE "k_covid19_osago" IS NOT NULL;

DROP TABLE IF EXISTS actuary.rep_osago_data_step4;
CREATE TABLE actuary.rep_osago_data_step4 AS
SELECT d.*,
       c."k_covid19_osago"
FROM actuary.rep_osago_data_step3 d
LEFT JOIN actuary.temp_covid c 
    ON d."Год_месяц" = c."Месяц_COVID19";

-- 4.5. Вычисление Месяц календарный и Meсяц действия (как в NoConcatenate Данные2)
DROP TABLE IF EXISTS actuary.rep_osago_data_step5;
CREATE TABLE actuary.rep_osago_data_step5 AS
SELECT d.*,
       EXTRACT(MONTH FROM d."DS")::int as "Месяц календарный",
       GREATEST(
           (EXTRACT(YEAR FROM d."DS") - EXTRACT(YEAR FROM d."DN")) * 12 
           + EXTRACT(MONTH FROM d."DS") - EXTRACT(MONTH FROM d."DN") + 1,
           1
       ) as "Meсяц действия"
FROM actuary.rep_osago_data_step4 d;

-- 4.6. Присоединение K_risk
DROP TABLE IF EXISTS actuary.rep_osago_data_step6;
CREATE TABLE actuary.rep_osago_data_step6 AS
SELECT d.*,
       c."K_risk"
FROM actuary.rep_osago_data_step5 d
LEFT JOIN actuary.ref_xls4triangles_coefficients c 
    ON d."Тип убытка крупный" = c."Тип убытка крупный"
    AND d."Тип страхователя" = c."Тип страхователя"
    AND d."Признак пролонгации" = c."Признак пролонгации"
    AND d."Meсяц действия" = c."Месяц_";

-- 4.7. Присоединение K_season
DROP TABLE IF EXISTS actuary.rep_osago_data_step7;
CREATE TABLE actuary.rep_osago_data_step7 AS
SELECT d.*,
       c."K_season"
FROM actuary.rep_osago_data_step6 d
LEFT JOIN actuary.ref_xls4triangles_coefficients c 
    ON d."Тип убытка крупный" = c."Тип убытка крупный"
    AND d."Тип страхователя" = c."Тип страхователя"
    AND d."Признак пролонгации" = c."Признак пролонгации"
    AND d."Месяц календарный" = c."Месяц_";

-- 4.8. Присоединение K_risk_all, K_risk_ppvu из справочника Коэф_ты
DROP TABLE IF EXISTS actuary.rep_osago_data_step8;
CREATE TABLE actuary.rep_osago_data_step8 AS
SELECT d.*,
       c."K_risk_all",
       c."K_risk_ppvu"
FROM actuary.rep_osago_data_step7 d
LEFT JOIN actuary.ref_xls4triangles_coef_ts c 
    ON d."Тип страхователя" = c."Тип страхователя"
    AND d."Признак пролонгации" = c."Признак пролонгации"
    AND d."Meсяц действия" = c."Месяц_";

-- 4.9. Присоединение K_season_all, K_season_ppvu из справочника Коэф_ты
DROP TABLE IF EXISTS actuary.rep_osago_data_step9;
CREATE TABLE actuary.rep_osago_data_step9 AS
SELECT d.*,
       c."K_season_all",
       c."K_season_ppvu"
FROM actuary.rep_osago_data_step8 d
LEFT JOIN actuary.ref_xls4triangles_coef_ts c 
    ON d."Тип страхователя" = c."Тип страхователя"
    AND d."Признак пролонгации" = c."Признак пролонгации"
    AND d."Месяц календарный" = c."Месяц_";

-- 5. Финальная таблица с вычислением Сдвиг_дн (аналог NoConcatenate Данные2)
DROP TABLE IF EXISTS actuary.rep_osago_data_merged;
CREATE TABLE actuary.rep_osago_data_merged AS
SELECT d.*,
       GREATEST(d."Meсяц действия", 1) + COALESCE(d."Сдвиг"::int, 0) - 1 as "Сдвиг_дн"
FROM actuary.rep_osago_data_step9 d;

-- 6. Очистка промежуточных таблиц
DROP TABLE IF EXISTS actuary.temp_covid;
DROP TABLE IF EXISTS actuary.rep_osago_data_step1;
DROP TABLE IF EXISTS actuary.rep_osago_data_step2;
DROP TABLE IF EXISTS actuary.rep_osago_data_step3;
DROP TABLE IF EXISTS actuary.rep_osago_data_step4;
DROP TABLE IF EXISTS actuary.rep_osago_data_step5;
DROP TABLE IF EXISTS actuary.rep_osago_data_step6;
DROP TABLE IF EXISTS actuary.rep_osago_data_step7;
DROP TABLE IF EXISTS actuary.rep_osago_data_step8;
DROP TABLE IF EXISTS actuary.rep_osago_data_step9;

-- 7. Логирование завершения присоединения справочников
PERFORM actuary.logz(v_pack_name, p_procedure_name || '_dictionaries', 'finished', 'step200', 
    (SELECT COUNT(*) FROM actuary.rep_osago_data_merged));

-- 8. Создание представления для удобства использования (как в Qlik - Данные)
DROP VIEW IF EXISTS actuary.v_rep_osago_data;
CREATE VIEW actuary.v_rep_osago_data AS
SELECT * FROM actuary.rep_osago_data_merged;

-- Итоговое логирование
PERFORM actuary.logz(v_pack_name, p_procedure_name, 'finished', 'step999', 
    (SELECT COUNT(*) FROM actuary.rep_osago_data_merged));
