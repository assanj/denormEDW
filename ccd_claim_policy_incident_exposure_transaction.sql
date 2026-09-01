-- DROP PROCEDURE actuary.rep_frequency_osago(varchar, int4, date);

CREATE OR REPLACE PROCEDURE actuary.rep_frequency_osago(p_check integer DEFAULT 1, 
p_proc character varying DEFAULT 'all'::character varying, 
p_report_date date DEFAULT ((date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone) - '1 day'::interval))::date)
 LANGUAGE plpgsql
AS $procedure$
--- Kazakov 25.08.2026

/*
предварительно:
repsrv2edw_XLS_EXPOSISION_PREMIUM_OSAGO_O
repsrv2edw_REP_GURU_OSAGO_TRIANGLE_R
xls2edw_ref_xls4triangles

\\qs9\qfs_Actuary\
\\qs9\qfs_Actuary\Справочники для треугольников.xlsx
C:\!csv2xlsx\Справочники для треугольников.xlsx

do $$
begin
	call actuary.rep_frequency_osago(1);
end $$

 код из 3-х приложений QS:
ЗП+экспо https://devbi.rgs.ru/dataloadeditor/app/7c7459f2-38a6-4b43-8661-9089f85fef4e?qlikTicket=iYxzu4DIOt8o-P5x
Треугольники https://devbi.rgs.ru/dataloadeditor/app/47111a18-5837-48f3-a910-5c8549d36c7b?qlikTicket=ihidkfo0uroOwBXX
Частоты https://devbi.rgs.ru/dataloadeditor/app/65f5fdc1-e676-418f-bad1-02f6f731f3bd?qlikTicket=yjPbUKiv8zhbB3sE
1.	На их базе реализовал код в EDW (работает ~ 1 час):
     call actuary.rep_osago_ep_expo_triangle(1);

2.	Создал ETL на загрузку справочников:
actuary.ref_xls4triangle_osago_type_claim
actuary.ref_xls4triangles_type_insurer
actuary.ref_xls4triangles_coef_ts
actuary.ref_xls4triangles_coefficients
actuary.ref_xls4triangles_segments
actuary.ref_xls4triangles_coefficients_covid
В части коэфф-ов все справочники придётся вести (делать копию) в нормальном XLS, «один лист одна таблица»,  без пустых столбцов.

Первоисточниками взял таблицы на REPSRV, которые пока тоже придется перекачивать на EDW.

Результаты для выгрузки:
select * from actuary.rep_osago_data_coeff


*/

declare
    v_ok 				 integer := 1;
    p_pack               varchar := 'rep_frequency_osago';
  --p_proc               varchar := '';
    v_row_count          integer := 0;
    v_sql                text;

  --p_check              integer := 0;  --<<<< 0 - для пустого прогона
begin
-- Логирование общего старта процедуры
PERFORM actuary.logz(p_pack, p_proc, 'started', 'step000', 0);
-- разбили процедуру на 2 стейджа


begin--================================ stage1: ==================================================================================================================
if v_ok = 1 and (lower(p_proc) = lower('stage1') or lower(p_proc) ='all') then


if 1=1 then  --нужен пересчёт базы?

-- ============================================================================
-- 1.0. База премия + экспрозиция + регионы
-- ============================================================================

DROP TABLE IF EXISTS actuary.rep_osago_ep_expo_tmp;
CREATE TABLE actuary.rep_osago_ep_expo_tmp AS
SELECT
    -- Служебные поля
    report_date::date as report_date,
    CURRENT_TIMESTAMP as sysmoment,
    current_user      as osuser,
    
    DB as "База данных",
    NEW_REGIONNAME as "Регион",
    NEW_REGIONNAME_EXT as "Регион ОФР",
    PROPERTYFORMNAME as "Тип страхователя",
    SALECHANNELFULLNAME_DE as "Канал продаж",
    IS_DEAD_POLICY,
    YEAR_MONTH as "Месяц",
    YEAR_QUARTER as "Квартал",
    D1_QUARTER as "Квартал начала",
    IS_POLICY_FROM_E_GARANT,
    IS_POLICY_FROM_EA,
    IS_NEED_REINSURANCE as "Передан в пул?",
    D1_MONTH as "Месяц начала",
    CONTRACTOPTION,
    OSAGO_CHAIN_NUMBER,
  --KC,
    EXPOSURE as "Количество полисолет",
    
        CASE 
            WHEN YEAR_MONTH <= TO_CHAR(report_date, 'YYYYMM')
            THEN (EXPOSURE)
            ELSE 0 
        END as "Экспозиция",
    
    EP as "Заработанная премия",
    
    WRITTENPREMIUM as "Начисленная премия",
    POLICYCOUNT as "Количество договоров",
    RETURNPREMIUM as "Возвраты",
    
    -- Вычисляемые поля
    CASE WHEN CONTRACTOPTION = '2' THEN 'Возобновлённый' ELSE 'Первоначальный' END as "Признак договора",
    CASE 
        WHEN PROPERTYFORMNAME = 'Физическое лицо' AND OSAGO_CHAIN_NUMBER > 1 THEN 'Возобновлённый'
        WHEN PROPERTYFORMNAME = 'Физическое лицо' THEN 'Первоначальный'
        WHEN CONTRACTOPTION = '2' THEN 'Возобновлённый'
        ELSE 'Первоначальный'
    END as "Признак пролонгации",
    CASE 
        WHEN SALECHANNELFULLNAME_DE IN ('грМК Партнер Онлайн', 'грМК Сайт', 'грМК Телемаркетинг') 
             OR IS_POLICY_FROM_E_GARANT = '1' THEN 1 
        ELSE 0 
    END as "Флаг Е-ОСАГО",
    CASE WHEN PROPERTYFORMNAME = 'Физическое лицо' THEN 'ФЛ' ELSE 'ЮЛ' END as "Тип страхователя_кр",
    
    -- Присоединяем данные из справочника регионов
    r."Федеральный округ" as "Федеральный округ",
    r."Флаг РСА-Агент" as "Флаг Токс_регион",
    r."Регион крупный" as "Регион крупный"
FROM actuary.XLS_EXPOSISION_PREMIUM_OSAGO_O_repsrv ad
LEFT JOIN actuary.ref_xls4triangles_regions r ON ad.NEW_REGIONNAME = r."Регион"
where p_check = 1;

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_ep_expo_tmp <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step01', v_row_count);


-- ============================================================================
-- 1.1. Полная  ОСАГО ЗП и экспозиция 20гг-мм.csv
-- ============================================================================

DROP TABLE IF EXISTS actuary.rep_osago_ep_expo;
CREATE TABLE actuary.rep_osago_ep_expo AS

WITH
aggregated_data AS (
    SELECT 
        -- Группировочные поля (уже с русскими названиями из tmp)
        report_date,
      --KC,
        "База данных",
        "Регион",
        "Регион ОФР",
        "Тип страхователя",
        IS_POLICY_FROM_EA,
        IS_POLICY_FROM_E_GARANT,
        "Передан в пул?",
        IS_DEAD_POLICY,
        "Канал продаж",
        "Признак договора",
        "Признак пролонгации",
        "Квартал начала",
        "Месяц начала",
        "Квартал",
        "Месяц",
        "Флаг Е-ОСАГО",
        "Тип страхователя_кр",
        "Федеральный округ",
        "Флаг Токс_регион",
        "Регион крупный",

        -- Агрегированные поля:
        SUM("Количество полисолет") as "Количество полисолет",
        SUM("Экспозиция") as "Экспозиция",

        SUM("Заработанная премия") as "Заработанная премия",
        SUM("Количество договоров") as "Количество договоров",
        SUM("Начисленная премия") as "Начисленная премия",
        SUM("Возвраты") as "Возвраты"
    FROM actuary.rep_osago_ep_expo_tmp
    GROUP BY 
        report_date,
      --KC,
        "База данных",
        "Регион",
        "Регион ОФР",
        "Тип страхователя",
        IS_POLICY_FROM_EA,
        IS_POLICY_FROM_E_GARANT,
        "Передан в пул?",
        IS_DEAD_POLICY,
        "Канал продаж",
        "Признак договора",
        "Признак пролонгации",
        "Квартал начала",
        "Месяц начала",
        "Квартал",
        "Месяц",
        "Флаг Е-ОСАГО",
        "Тип страхователя_кр",
        "Федеральный округ",
        "Флаг Токс_регион",
        "Регион крупный"
)
SELECT 
    CURRENT_TIMESTAMP as sysmoment,
    session_user as osuser,
    report_date,
    
    "База данных",
    "Регион",
    "Регион ОФР",
    "Тип страхователя",
    IS_POLICY_FROM_EA,
    IS_POLICY_FROM_E_GARANT,
    "Передан в пул?",
    IS_DEAD_POLICY,
    "Канал продаж",
    "Признак договора",
    "Признак пролонгации",
    "Квартал начала",
    "Месяц начала",
    "Квартал",
    "Месяц",
    "Флаг Е-ОСАГО",
    "Тип страхователя_кр",
    "Федеральный округ",
    "Флаг Токс_регион",
    "Регион крупный",
    
    "Экспозиция",
    "Заработанная премия",
    "Количество договоров",
    "Количество полисолет",
    "Начисленная премия",
    "Возвраты"
FROM aggregated_data
WHERE (IS_DEAD_POLICY IS NULL OR IS_DEAD_POLICY = 0 OR IS_DEAD_POLICY = -1);

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_ep_expo <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step101', v_row_count);

if 1 = 1 then -- СРЕЗ для rep_osago_ep_expo
begin  -- срез среза, если срез уже был
   execute 'drop table if exists ACTUARY.rep_osago_ep_expo_yyyy_mm';
   execute 'create table ACTUARY.rep_osago_ep_expo_yyyy_mm as select * from ACTUARY.rep_osago_ep_expo_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm');
exception
when others then 
null;
end;

   execute 'drop table if exists ACTUARY.rep_osago_ep_expo_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm');
   execute         'create table ACTUARY.rep_osago_ep_expo_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm')||' as select * from ACTUARY.rep_osago_ep_expo  order by CLAIMNUMBER, PLAINTIFF, MATTERID';
   get diagnostics v_row_count := ROW_COUNT;
   execute      'grant select on ACTUARY.rep_osago_ep_expo_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm')||' to all_actuary';      
    
   PERFORM actuary.logz(p_pack, p_proc, 'batched. rep_osago_ep_expo_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm'), v_row_count); 

else
   PERFORM actuary.logz(p_pack, p_proc, 'p_batch = '||p_batch::varchar, 'NO_BATCH', v_row_count); 
end if;   

-- ============================================================================
-- 1.2. ОСАГО ЗП и экспозиция 20гг-мм_усеченный
-- ============================================================================

DROP TABLE IF EXISTS actuary.rep_osago_ep_expo_trunc;
CREATE TABLE actuary.rep_osago_ep_expo_trunc AS

WITH
aggregated_data AS (
    SELECT 
        -- Группировочные поля (только нужные для усеченной версии)
        report_date,
      --KC,
        "База данных",
        "Тип страхователя",
        "Передан в пул?",
        IS_DEAD_POLICY,
        "Признак пролонгации",
        "Квартал начала",
        "Месяц начала",
        "Квартал",
        "Месяц",
        "Флаг Е-ОСАГО",
        "Тип страхователя_кр",
        "Федеральный округ",
        "Флаг Токс_регион",
        "Регион крупный",

        -- Агрегированные поля:
        SUM("Экспозиция") as "Экспозиция",
        SUM("Заработанная премия") as "Заработанная премия",
        SUM("Количество договоров") as "Количество договоров",
        SUM("Начисленная премия") as "Начисленная премия",
        SUM("Возвраты") as "Возвраты"
    FROM actuary.rep_osago_ep_expo_tmp
    GROUP BY 
        report_date,
      --KC,
        "База данных",
        "Тип страхователя",
        "Передан в пул?",
        IS_DEAD_POLICY,
        "Признак пролонгации",
        "Квартал начала",
        "Месяц начала",
        "Квартал",
        "Месяц",
        "Флаг Е-ОСАГО",
        "Тип страхователя_кр",
        "Федеральный округ",
        "Флаг Токс_регион",
        "Регион крупный"
)
SELECT 
    CURRENT_TIMESTAMP,
    session_user,
    report_date,
    
    "База данных",
    "Тип страхователя",
    "Передан в пул?",
    IS_DEAD_POLICY,
    "Признак пролонгации",
    "Квартал начала",
    "Месяц начала",
    "Квартал",
    "Месяц",
    "Флаг Е-ОСАГО",
    "Тип страхователя_кр",
    "Федеральный округ",
    "Флаг Токс_регион",
    "Регион крупный",
    
    "Экспозиция",
    "Заработанная премия",
    "Количество договоров",
    "Начисленная премия",
    "Возвраты"
FROM aggregated_data
WHERE (IS_DEAD_POLICY IS NULL OR IS_DEAD_POLICY = 0 OR IS_DEAD_POLICY = -1);

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_ep_expo_trunc <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step102', v_row_count);


-- ============================================================================
-- 2.0. База <= регионы + справочники для треугольника убытков
-- ============================================================================

DROP TABLE IF EXISTS actuary.rep_osago_triangle_tmp;
CREATE TABLE actuary.rep_osago_triangle_tmp AS
SELECT
    -- Служебные поля
    report_date,
    CURRENT_TIMESTAMP as sysmoment,
    current_user as osuser,
    
    -- Исходные поля
    s.REGIONNAME_FINAL as "Регион",
    s.CATEGORY_ID_FINAL as "Тип страхователя_код",
    s.ARM_EKIS_CONTRACTOPTION as "Опция договора",
    s.SALECHANNELFULLNAME_DE as "Канал продаж",
    s.IS_PVU as "Тип убытка",
    s.D1_MONTH as "Месяц начала",
    s.ACCIDENT_MONTH as "Месяц события",
    s.DEVELOPMENT_MONTH as "Месяц развития",
    s.IS_POLICY_FROM_EA,
    s.IS_POLICY_FROM_E_GARANT,
    s.IS_NEED_REINSURANCE as "Передан в пул?",
    s.OSAGO_CHAIN_NUMBER as "Цепочка ОСАГО",
    s.RESERVESUM as "Сумма ЗНУ",
    s.RESERVECOUNT as "Количество ЗНУ",
    s.APPROVEDSUM as "Сумма выплат",
    s.APPROVEDCOUNT as "Количество выплат",
    
    -- Вычисляемые поля
    CASE 
        WHEN s.ARM_EKIS_CONTRACTOPTION = 'Возобновлённый' THEN 'Возобновлённый'
        ELSE 'Первоначальный'
    END as "Признак договора",
    
    CASE 
        WHEN s.CATEGORY_ID_FINAL IN ('OSAGO', 'OSAGOFL') THEN
            CASE 
                WHEN s.OSAGO_CHAIN_NUMBER > 1 THEN 'Возобновлённый'
                ELSE 'Первоначальный'
            END
        ELSE
            CASE 
                WHEN s.ARM_EKIS_CONTRACTOPTION = 'Возобновлённый' THEN 'Возобновлённый'
                ELSE 'Первоначальный'
            END
    END as "Признак пролонгации",
    
    CASE 
        WHEN s.SALECHANNELFULLNAME_DE IN ('грМК Партнер Онлайн', 'грМК Сайт', 'грМК Телемаркетинг') 
             OR s.IS_POLICY_FROM_E_GARANT = '1' THEN 1 
        ELSE 0 
    END as "Флаг Е-ОСАГО",
    
             -- [Регион ОФР] - сложная логика из Qlik
            CASE 
                WHEN IS_NEED_REINSURANCE = '1' THEN 'Е-Гарант и пул, в т. ч. ЮЛ'
                WHEN ti."Тип страхователя" = 'ФЛ' AND REGIONNAME_FINAL = 'Центральный офис' THEN
                    CASE 
                        WHEN IS_POLICY_FROM_E_GARANT = '1' THEN 'Е-Гарант и пул, в т. ч. ЮЛ'
                        WHEN SALECHANNELFULLNAME_DE IN ('грМК Партнер Онлайн', 'грМК Сайт', 'грМК Телемаркетинг') 
                            THEN 'Онлайн-ОСАГО'
                        ELSE REGIONNAME_FINAL
                    END
                ELSE REGIONNAME_FINAL
            END as "Регион ОФР",
    
    ti."Тип страхователя",
    
    to_char(date_trunc('quarter', to_date(s.ACCIDENT_MONTH, 'YYYYMM')), 'YYYY_"_"Q') AS "Квартал события",
    
    -- Присоединяем данные из справочника регионов
    r."Федеральный округ" as "Федеральный округ",
    r."Флаг РСА-Агент" as "Флаг Токс_регион",
    r."Регион крупный" as "Регион крупный",
    
    -- Присоединяем данные из справочника типов убытков
    ct."Тип убытка крупный" as "Тип убытка крупный"
 
FROM actuary.REP_GURU_OSAGO_TRIANGLE_R_repsrv s
LEFT JOIN actuary.ref_xls4triangles_regions r ON s.REGIONNAME_FINAL = r."Регион"
LEFT JOIN actuary.ref_xls4triangles_osago_type_claim ct ON s.IS_PVU = ct."Тип убытка"
LEFT JOIN actuary.ref_xls4triangles_type_insurer ti  ON s.CATEGORY_ID_FINAL = ti.category_id_final
WHERE p_check = 1;
           
get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_triangle_tmp <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step200', v_row_count);

-- ============================================================================
-- 2.1. ОСАГО Треугольник убытков полный (ОСАГО понесенные убытки 20гг-мм.csv)
-- ============================================================================

DROP TABLE IF EXISTS actuary.rep_osago_triangle;
CREATE TABLE actuary.rep_osago_triangle AS

    SELECT 
	    -- Служебные поля
	    CURRENT_TIMESTAMP as sysmoment,
	    session_user as osuser,
	    report_date,
	    
        "Регион",
        "Регион ОФР",
        "Тип страхователя_код",
        "Опция договора",
        "Канал продаж",
        "Тип убытка",
        "Месяц начала",
        "Месяц события",
        "Месяц развития",
        IS_POLICY_FROM_EA,
        IS_POLICY_FROM_E_GARANT,
        "Передан в пул?",
        "Цепочка ОСАГО",
        "Признак договора",
        "Признак пролонгации",
        "Флаг Е-ОСАГО",
        "Тип страхователя",
        "Квартал события",
        "Федеральный округ",
        "Флаг Токс_регион",
        "Регион крупный",
        "Тип убытка крупный",

        -- Агрегированные поля:
        -- Агрегированные поля:
        SUM(COALESCE("Сумма ЗНУ", 0)) as "Сумма ЗНУ",
        SUM(COALESCE("Количество ЗНУ", 0)) as "Количество ЗНУ",
        SUM(COALESCE("Сумма выплат", 0)) as "Сумма выплат",
        SUM(COALESCE("Количество выплат", 0)) as "Количество выплат",
        
        -- Итоговые агрегированные метрики
        SUM(COALESCE("Количество выплат", 0) + COALESCE("Количество ЗНУ", 0)) as "Количество_убытков",
        SUM(COALESCE("Сумма выплат", 0) + COALESCE("Сумма ЗНУ", 0)) as "Сумма_убытков",
        
        COUNT(*) as "Количество_записей"
        
    FROM actuary.rep_osago_triangle_tmp
    GROUP BY 
        report_date,
        "Регион",
        "Регион ОФР",
        "Тип страхователя_код",
        "Опция договора",
        "Канал продаж",
        "Тип убытка",
        "Месяц начала",
        "Месяц события",
        "Месяц развития",
        IS_POLICY_FROM_EA,
        IS_POLICY_FROM_E_GARANT,
        "Передан в пул?",
        "Цепочка ОСАГО",
        "Признак договора",
        "Признак пролонгации",
        "Флаг Е-ОСАГО",
        "Тип страхователя",
        "Квартал события",
        "Федеральный округ",
        "Флаг Токс_регион",
        "Регион крупный",
        "Тип убытка крупный";

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_triangle <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step201', v_row_count);

if 1 = 1 then -- СРЕЗ для треугольника rep_osago_triangle
begin  -- срез среза, если срез уже был
   execute 'drop table if exists ACTUARY.rep_osago_triangle_yyyy_mm';
   execute 'create table ACTUARY.rep_osago_triangle_yyyy_mm as select * from ACTUARY.rep_osago_triangle_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm');
exception
when others then 
null;
end;

   execute 'drop table if exists ACTUARY.rep_osago_triangle_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm');
   execute         'create table ACTUARY.rep_osago_triangle_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm')||' as select * from ACTUARY.rep_osago_triangle  order by CLAIMNUMBER, PLAINTIFF, MATTERID';
   get diagnostics v_row_count := ROW_COUNT;
   execute      'grant select on ACTUARY.rep_osago_triangle_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm')||' to all_actuary';      
    
   PERFORM actuary.logz(p_pack, p_proc, 'batched. rep_osago_triangle_'||to_char(date_trunc('month', current_date) - interval ' 1 day ' , 'yyyy_mm'), v_row_count); 
   
else
   PERFORM actuary.logz(p_pack, p_proc, 'p_batch = '||p_batch::varchar, 'NO_BATCH', v_row_count); 
end if;   

-- =========================================================================================
-- 2.2. ОСАГО Треугольник убытков усечённый (ОСАГО понесенные убытки 20гг-мм_усеченные.csv)
-- =========================================================================================

DROP TABLE IF EXISTS actuary.rep_osago_triangle_trunc;
CREATE TABLE actuary.rep_osago_triangle_trunc AS

    SELECT 
	    -- Служебные поля
	    CURRENT_TIMESTAMP as sysmoment,
	    session_user as osuser,
	    report_date,
	    
      --"Регион",
        "Тип страхователя_код",
        "Опция договора",
      --"Канал продаж",
        "Тип убытка",
      --"Месяц начала",
        "Месяц события",
        "Месяц развития",
      --IS_POLICY_FROM_EA,
      --IS_POLICY_FROM_E_GARANT,
        "Передан в пул?",
        "Цепочка ОСАГО",
      --"Признак договора",
        "Признак пролонгации",
        "Флаг Е-ОСАГО",
        "Тип страхователя",
        "Квартал события",
        "Федеральный округ",
        "Флаг Токс_регион",
        "Регион крупный",
        "Тип убытка крупный",

        -- Агрегированные поля:
        SUM(COALESCE("Сумма ЗНУ", 0)) as "Сумма ЗНУ",
        SUM(COALESCE("Количество ЗНУ", 0)) as "Количество ЗНУ",
        SUM(COALESCE("Сумма выплат", 0)) as "Сумма выплат",
        SUM(COALESCE("Количество выплат", 0)) as "Количество выплат",
        
        -- Итоговые агрегированные метрики
        SUM(COALESCE("Количество выплат", 0) + COALESCE("Количество ЗНУ", 0)) as "Количество_убытков",
        SUM(COALESCE("Сумма выплат", 0) + COALESCE("Сумма ЗНУ", 0)) as "Сумма_убытков",
        
        COUNT(*) as "Количество_записей"
        
    FROM actuary.rep_osago_triangle_tmp
    GROUP BY 
        report_date,
      --"Регион",
        "Тип страхователя_код",
        "Опция договора",
      --"Канал продаж",
        "Тип убытка",
      --"Месяц начала",
        "Месяц события",
        "Месяц развития",
      --IS_POLICY_FROM_EA,
      --IS_POLICY_FROM_E_GARANT,
        "Передан в пул?",
        "Цепочка ОСАГО",
      --"Признак договора",
        "Признак пролонгации",
        "Флаг Е-ОСАГО",
        "Тип страхователя",
        "Квартал события",
        "Федеральный округ",
        "Флаг Токс_регион",
        "Регион крупный",
        "Тип убытка крупный";

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_triangle_trunc <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step203', v_row_count);

--================================== ОСАГО частоты по месяцам ==================================================
--3. Создание объединенной таблицы данных (аналог таблицы Данные в Qlik в модели "ОСАГО частоты по месяцам" - Кислякова О.)
DROP TABLE IF EXISTS actuary.rep_osago_data;
CREATE TABLE actuary.rep_osago_data AS
SELECT 
	    sysmoment,
	    osuser,
	    report_date,

        "Месяц начала",
        "Месяц" as "Год_месяц",
        null as "Сдвиг",
        "Канал продаж",
        "Флаг Е-ОСАГО",
        IS_POLICY_FROM_EA,
        IS_POLICY_FROM_E_GARANT,
        "Передан в пул?",
        CASE WHEN IS_POLICY_FROM_EA = '1' OR IS_POLICY_FROM_E_GARANT = '1' THEN '1' ELSE '0' END as "Барабаны РСА",
        "Флаг Токс_регион",
        "Регион",
        "Регион ОФР",
        "Регион крупный",
        "Признак договора",
        "Признак пролонгации",
        "Тип страхователя",
        "Заработанная премия",
        "Экспозиция",
        "Начисленная премия",
        "Количество договоров",
        "Количество полисолет",
        NULL::text as "Тип убытка крупный",
        NULL::numeric as "Количество_убытков",
        NULL::numeric as "Сумма_убытков",
        'rep_osago_ep_expo' as data_source
    FROM actuary.rep_osago_ep_expo
    WHERE left("Месяц", 4)::int >= 2019
union all
SELECT 
	    sysmoment,
	    osuser,
	    report_date,
 
        "Месяц начала",
        "Месяц события" as "Год_месяц",
        "Месяц развития" as "Сдвиг",
        "Канал продаж",
        "Флаг Е-ОСАГО",
        IS_POLICY_FROM_EA,
        IS_POLICY_FROM_E_GARANT,
        "Передан в пул?",
        CASE WHEN IS_POLICY_FROM_EA = '1' OR IS_POLICY_FROM_E_GARANT = '1' THEN '1' ELSE '0' END as "Барабаны РСА",
        "Флаг Токс_регион",
        "Регион",
        "Регион ОФР",
        "Регион крупный",
        "Признак договора",
        "Признак пролонгации",
        "Тип страхователя",
        NULL::numeric as "Заработанная премия",
        NULL::numeric as "Экспозиция",
        NULL::numeric as "Начисленная премия",
        NULL::numeric as "Количество договоров",
        NULL::numeric as "Количество полисолет",
        "Тип убытка крупный",
        "Количество_убытков",
        "Сумма_убытков",
        'rep_osago_triangle' as data_source
    FROM actuary.rep_osago_triangle
    WHERE left("Месяц события", 4)::int >= 2019;

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step300', v_row_count);


--4. Присоединение справочников (аналог LEFT JOIN в Qlik)

-- 4.1. Присоединение справочника Сегменты
DROP TABLE IF EXISTS actuary.rep_osago_data_step1;
CREATE TABLE actuary.rep_osago_data_step1 AS
SELECT d.*,
       s."Сегмент"
FROM actuary.rep_osago_data d
LEFT JOIN actuary.ref_xls4triangles_segments s 
    ON d."Тип страхователя" = s."Тип страхователя" 
    AND COALESCE(d."Тип убытка крупный", '') = COALESCE(s."Тип убытка крупный", '');

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step1 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step401', v_row_count);

end if; --нужен пересчёт базы? -----------------------------------------------------------------------------------------------

-- 4.2. Присоединение справочника Коэффициенты (по Сегмент, Год_месяц, Сдвиг)
DROP TABLE IF EXISTS actuary.rep_osago_data_step2;
CREATE TABLE actuary.rep_osago_data_step2 AS
SELECT d.*,
       c."Коэф_развития_1",
       c."Коэф_развития_2"
     FROM actuary.rep_osago_data_step1 d
LEFT JOIN actuary.ref_xls4triangles_coefficients c 
    ON d."Сегмент" = c."Сегмент" 
    AND d."Год_месяц"::text = c."Месяц"::text
    AND d."Сдвиг"::text = (c."Сдвиг"::int + 1)::text;

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step2 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step402', v_row_count);

-- 4.3. Преобразование кварталов через прямое вычисление (вместо LEFT JOIN с ref_xls4triangles_quarters)
-- Вычисляем поля: Год, Месяц, DS, Квартал, Квартал начала, Год начала, DN
DROP TABLE IF EXISTS actuary.rep_osago_data_step3;
CREATE TABLE actuary.rep_osago_data_step3 AS
SELECT d.*,
       LEFT(d."Год_месяц", 4)::int as "Год",
       RIGHT(d."Год_месяц", 2)::int as "Месяц",
       TO_DATE(d."Год_месяц"||'01', 'YYYYMMDD') as "DS",
       EXTRACT(QUARTER FROM TO_DATE(d."Год_месяц"||'01', 'YYYYMMDD'))::int as "Квартал",
       -- Для Месяца начала
       LEFT(d."Месяц начала", 4)::int as "Год начала",
       TO_DATE(d."Месяц начала"||'01', 'YYYYMMDD') as "DN",
       -- Квартал начала (аналог to_char(date_trunc('quarter', ...), 'YYYY_"_"Q'))
       to_char(date_trunc('quarter', TO_DATE(d."Месяц начала"||'01', 'YYYYMMDD')), 'YYYY_"_"Q') as "Квартал начала"
FROM actuary.rep_osago_data_step2 d;
get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step3 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step403', v_row_count);

-- 4.4. Вычисление Месяц календарный и Meсяц действия (как в NoConcatenate Данные2)
DROP TABLE IF EXISTS actuary.rep_osago_data_step4;
CREATE TABLE actuary.rep_osago_data_step4 AS
SELECT d.*,
       EXTRACT(MONTH FROM d."DS")::int as "Месяц календарный",
       GREATEST(
           (EXTRACT(YEAR FROM d."DS") - EXTRACT(YEAR FROM d."DN")) * 12 
           + EXTRACT(MONTH FROM d."DS") - EXTRACT(MONTH FROM d."DN") + 1,
           1
       ) as "Meсяц действия"
FROM actuary.rep_osago_data_step3 d;

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step4 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step404', v_row_count);

-- 4.5. Присоединение справочника Коэффициенты COVID (k_covid19_osago)
-- Нужно создать справочник COVID из существующих данных, так как в комментариях его нет
-- Создаем временно на основе ref_xls4triangles_coefficients, если там есть поле k_covid19_osago
DROP TABLE IF EXISTS actuary.temp_covid;
CREATE TABLE actuary.temp_covid AS
SELECT DISTINCT 
        -- Служебные поля
	    CURRENT_TIMESTAMP as sysmoment,
	    session_user as osuser,

		"Месяц_covid19", "k_covid19_osago"
FROM actuary.ref_xls4triangles_coefficients_covid
WHERE "k_covid19_osago" IS NOT NULL;
get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'temp_covid <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step405', v_row_count);


DROP TABLE IF EXISTS actuary.rep_osago_data_step5;
CREATE TABLE actuary.rep_osago_data_step5 AS
SELECT d.*,
       c."k_covid19_osago"
FROM actuary.rep_osago_data_step4 d
LEFT JOIN actuary.temp_covid c 
    ON d."Год_месяц"::text = c."Месяц_covid19"::text;

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step2 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step405', v_row_count);

--клик "Выгрузка данных для фазы 2" из модели "Осаго частоты по месяцам"

DROP TABLE IF EXISTS actuary.rep_osago_data_step5_phase2;
CREATE TABLE actuary.rep_osago_data_step5_phase2 AS
SELECT
		-- Служебные поля
	    CURRENT_TIMESTAMP as sysmoment,
	    session_user as osuser,
	    report_date,

	"Тип страхователя", "Признак пролонгации", "Meсяц действия", "Месяц календарный", "Месяц начала",
	CASE 
	    WHEN Тип_убытка_крупный IN ('Традиция', 'ОПВУ') THEN 'ОтвСтр'
	    WHEN Тип_убытка_крупный = 'ППВУ' THEN 'ПрСтр'
    	ELSE '-'
	END as "Отв_Пр"
FROM actuary.rep_osago_data_step5 d
group by report_date, "Тип страхователя", "Признак пролонгации", "Meсяц действия", "Месяц календарный", "Месяц начала",
	CASE 
	    WHEN Тип_убытка_крупный IN ('Традиция', 'ОПВУ') THEN 'ОтвСтр'
	    WHEN Тип_убытка_крупный = 'ППВУ' THEN 'ПрСтр'
    	ELSE '-'
	END;-- as "Отв_Пр"


get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step5_phase2 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step405', v_row_count);


end if; -- v_ok = 1
exception
when others then
  v_ok := 0;
  PERFORM actuary.logz(p_pack, p_proc, 'SQLERRM: '|| SQLERRM ||', '||'SQLERRM: '|| SQLERRM , 'ERROR', -77777); 
  --raise notice 'SQLSTATE: %', SQLSTATE;
  raise notice 'SQLERRM: %', SQLERRM;
end;  --//end proc stage1

begin--================================ stage2: ==================================================================================================================
if v_ok = 1 and (lower(p_proc) = lower('stage2') or lower(p_proc) ='all') then

-- 4.6. Присоединение K_risk
DROP TABLE IF EXISTS actuary.rep_osago_data_step6;
CREATE TABLE actuary.rep_osago_data_step6 AS
SELECT d.*,
       c.k_risk
FROM actuary.rep_osago_data_step5 d
LEFT JOIN actuary.ref_xls4triangles_coefficients c 
    ON d."Тип убытка крупный" = c."Тип убытка крупный"
    AND d."Тип страхователя" = c."Тип страхователя"
    AND d."Признак пролонгации" = c."Признак пролонгации"
    AND d."Meсяц действия" = c."Месяц_";

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step6 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step406', v_row_count);

-- 4.7. Присоединение K_season
DROP TABLE IF EXISTS actuary.rep_osago_data_step7;
CREATE TABLE actuary.rep_osago_data_step7 AS
SELECT d.*,
       c.k_season
FROM actuary.rep_osago_data_step6 d
LEFT JOIN actuary.ref_xls4triangles_coefficients c 
    ON d."Тип убытка крупный" = c."Тип убытка крупный"
    AND d."Тип страхователя" = c."Тип страхователя"
    AND d."Признак пролонгации" = c."Признак пролонгации"
    AND d."Месяц календарный" = c."Месяц_";

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step7 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step407', v_row_count);

-- 4.8. Присоединение K_risk_all, K_risk_ppvu из справочника Коэф_ты
DROP TABLE IF EXISTS actuary.rep_osago_data_step8;
CREATE TABLE actuary.rep_osago_data_step8 AS
SELECT d.*,
       c.k_risk_all,
       c.k_risk_ppvu
FROM actuary.rep_osago_data_step7 d
LEFT JOIN actuary.ref_xls4triangles_coef_ts c 
    ON d."Тип страхователя" = c."Тип страхователя"
    AND d."Признак пролонгации" = c."Признак пролонгации"
    AND d."Meсяц действия" = c."Месяц_";

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step8 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step408', v_row_count);

-- 4.9. Присоединение K_season_all, K_season_ppvu из справочника Коэф_ты
DROP TABLE IF EXISTS actuary.rep_osago_data_step9;
CREATE TABLE actuary.rep_osago_data_step9 AS
SELECT d.*,
       c.k_season_all,
       c.k_season_ppvu
FROM actuary.rep_osago_data_step8 d
LEFT JOIN actuary.ref_xls4triangles_coef_ts c 
    ON d."Тип страхователя" = c."Тип страхователя"
    AND d."Признак пролонгации" = c."Признак пролонгации"
    AND d."Месяц календарный" = c."Месяц_";

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_osago_data_step9 <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step409', v_row_count);

-- 5. Финальная таблица с вычислением Сдвиг_дн (аналог NoConcatenate Данные2)
DROP TABLE IF EXISTS actuary.rep_frequency_osago;
CREATE TABLE actuary.rep_frequency_osago AS
SELECT d.*,
       GREATEST(d."Meсяц действия", 1) + COALESCE(d."Сдвиг"::int, 0) - 1 as "Сдвиг_дн"
FROM actuary.rep_osago_data_step9 d;

get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(p_pack, p_proc, 'rep_frequency_osago <= '||to_char(p_report_date, 'dd.mm.yyyy'), 'step500', v_row_count);

/*
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
*/


end if; -- v_ok = 1
exception
when others then
  v_ok := 0;
  PERFORM actuary.logz(p_pack, p_proc, 'SQLERRM: '|| SQLERRM ||', '||'SQLERRM: '|| SQLERRM , 'ERROR', -77777); 
  --raise notice 'SQLSTATE: %', SQLSTATE;
  raise notice 'SQLERRM: %', SQLERRM;
end;  --//end proc stage2

    -- Итоговое логирование успешного завершения всей процедуры
PERFORM actuary.logz(p_pack, p_proc, 'finished', 'step999', 0);
/**/

/*ДЛЯ СПРАВКИ: имеем следующие структуры справочнииков из экселя (других иных больше нет):
CREATE TABLE actuary.ref_xls4triangle_osago_type_claim (
	"Тип убытка" text NULL,
	"Тип убытка крупный" text NULL
);

CREATE TABLE actuary.ref_xls4triangles_regions (
	"Регион" text NULL,
	"Федеральный округ" text NULL,
	"Флаг РСА-Агент" float8 NULL,
	"Регион крупный" text NULL,
	"Регион для отчета" text NULL
);

CREATE TABLE actuary.ref_xls4triangles_type_insurer (
	category_id_final text NULL,
	"Тип страхователя" text NULL
);

CREATE TABLE actuary.ref_xls4triangles_coef_ts (
	"Тип страхователя" text NULL,
	"Признак пролонгации" text NULL,
	"Месяц_" float8 NULL,
	k_risk_all text NULL,
	k_season_all text NULL,
	k_risk_ppvu text NULL,
	k_season_ppvu text NULL
);

CREATE TABLE actuary.ref_xls4triangles_coefficients (
	"Сегмент" text NULL,
	"Месяц" text NULL,
	"Сдвиг" text NULL,
	"Коэф_развития_1" text NULL,
	"Коэф_развития_2" text NULL,
	"Тип убытка крупный" text NULL,
	"Тип страхователя" text NULL,
	"Признак пролонгации" text NULL,
	"Месяц_" text NULL,
	k_risk text NULL,
	k_season text NULL,
	"КАСКО_Сегмент" text NULL,
	"КАСКО_Месяц" text NULL,
	"КАСКО_Сдвиг" text NULL,
	"КАСКО_Коэф_развития_1" text NULL,
	"КАСКО_Коэф_развития_2" text NULL,
	"Сегмент_1" text NULL,
	"Месяц_КАСКО" text NULL,
	k_risk_1 text NULL,
	k_season_1 text NULL
);


CREATE TABLE actuary.ref_xls4triangles_segments (
	"Тип страхователя" text NULL,
	"Тип убытка крупный" text NULL,
	"Сегмент" text NULL
);

CREATE TABLE actuary.ref_xls4triangles_coefficients_covid (
	"Месяц_covid19" float8 NULL,
	k_covid19_osago float8 NULL,
	k_covid19_kasko float8 NULL
);


*/
END $procedure$
;

-- Permissions

ALTER PROCEDURE actuary.rep_frequency_osago(varchar, int4, date) OWNER TO mskazakov;
GRANT ALL ON PROCEDURE actuary.rep_frequency_osago(varchar, int4, date) TO mskazakov;
