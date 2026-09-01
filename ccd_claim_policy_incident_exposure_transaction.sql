-- ============================================================
-- Скрипт удаления всех таблиц, создаваемых процедурой
-- actuary.rep_frequency_osago
-- ============================================================

-- Основные финальные таблицы
DROP TABLE IF EXISTS actuary.rep_frequency_osago;
DROP TABLE IF EXISTS actuary.rep_osago_data;
DROP TABLE IF EXISTS actuary.rep_osago_data_coeff;

-- Промежуточные таблицы этапа 1 (Stage1)
DROP TABLE IF EXISTS actuary.rep_osago_ep_expo_tmp;
DROP TABLE IF EXISTS actuary.rep_osago_ep_expo;
DROP TABLE IF EXISTS actuary.rep_osago_ep_expo_trunc;
DROP TABLE IF EXISTS actuary.rep_osago_triangle_tmp;
DROP TABLE IF EXISTS actuary.rep_osago_triangle;
DROP TABLE IF EXISTS actuary.rep_osago_triangle_trunc;

-- Промежуточные таблицы этапа 2 (Stage2) - пошаговые
DROP TABLE IF EXISTS actuary.rep_osago_data_step1;
DROP TABLE IF EXISTS actuary.rep_osago_data_step2;
DROP TABLE IF EXISTS actuary.rep_osago_data_step3;
DROP TABLE IF EXISTS actuary.rep_osago_data_step4;
DROP TABLE IF EXISTS actuary.rep_osago_data_step5;
DROP TABLE IF EXISTS actuary.rep_osago_data_step6;
DROP TABLE IF EXISTS actuary.rep_osago_data_step7;
DROP TABLE IF EXISTS actuary.rep_osago_data_step8;
DROP TABLE IF EXISTS actuary.rep_osago_data_step9;

-- Дополнительные таблицы
DROP TABLE IF EXISTS actuary.rep_osago_data_step5_phase2;
DROP TABLE IF EXISTS actuary.temp_covid;

-- Срезовые таблицы (бэкапы по месяцам)
-- ВАЖНО: Эти таблицы создаются динамически, их может быть много
-- Удаление всех срезовых таблиц (осторожно!):
DO $$
DECLARE
    tbl_name text;
BEGIN
    FOR tbl_name IN 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'actuary' 
          AND table_name LIKE 'rep_osago_ep_expo_%' 
          AND table_name ~ 'rep_osago_ep_expo_\d{4}_\d{2}$'
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS actuary.' || tbl_name || ' CASCADE';
        RAISE NOTICE 'Dropped table: %', tbl_name;
    END LOOP;
    
    FOR tbl_name IN 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'actuary' 
          AND table_name LIKE 'rep_osago_triangle_%' 
          AND table_name ~ 'rep_osago_triangle_\d{4}_\d{2}$'
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS actuary.' || tbl_name || ' CASCADE';
        RAISE NOTICE 'Dropped table: %', tbl_name;
    END LOOP;
END $$;

-- ============================================================
-- Альтернативный вариант - удаление всех таблиц одной командой
-- (если нужно удалить все без разбора)
-- ============================================================
/*
DO $$
DECLARE
    tbl_name text;
BEGIN
    FOR tbl_name IN 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'actuary' 
          AND table_name IN (
              'rep_frequency_osago',
              'rep_osago_data',
              'rep_osago_data_coeff',
              'rep_osago_ep_expo_tmp',
              'rep_osago_ep_expo',
              'rep_osago_ep_expo_trunc',
              'rep_osago_triangle_tmp',
              'rep_osago_triangle',
              'rep_osago_triangle_trunc',
              'rep_osago_data_step1',
              'rep_osago_data_step2',
              'rep_osago_data_step3',
              'rep_osago_data_step4',
              'rep_osago_data_step5',
              'rep_osago_data_step6',
              'rep_osago_data_step7',
              'rep_osago_data_step8',
              'rep_osago_data_step9',
              'rep_osago_data_step5_phase2',
              'temp_covid'
          )
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS actuary.' || tbl_name || ' CASCADE';
        RAISE NOTICE 'Dropped table: %', tbl_name;
    END LOOP;
END $$;
*/
