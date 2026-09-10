PROCEDURE XLS_EXPOSISION_PREMIUM_KASKO_O is
-- запускаем только после "Сформированных основных форм" и "Рассчитанного агрегата" по КАСКО
-- в "Актуарном отчетном модуле" + GWPC Каско!!!,
-- результат вставляем на соответствующий лист в xlsb "YYYY-MM-DD - Экспозиция и ЗП по ОСАГО и КАСКО.xlsb"

  v_proc varchar2(128) := 'XLS_EXPOSISION_PREMIUM_KASKO_O';
  v_scri varchar2(128) := 'YYYY-MM-DD - Экспозиция и ЗП по КАСКО для Ольги.sql';

begin
utils.logz(v_proc, v_scri, 'START');

execute immediate 'truncate table XLS_EXPOSISION_PREMIUM_KASKO_O';

-- собираем и агрегируем экспозицию по GWPC+АРМ+ЕКИС:

-- если закрываем квартал:
if trunc(sysdate,'MM')-1 = trunc(sysdate,'q')-1 then
   utils.logz(v_proc, v_scri, 'квартал');
ELSE
   utils.logz(v_proc, v_scri, 'месяц');
END IF;

insert --+ APPEND
  into XLS_EXPOSISION_PREMIUM_KASKO_O
SELECT /*+ parallel(krf 16) */
       krf.db,
       krf.NEW_REGIONNAME,
       krf.PROPERTYFORMNAME,
       krf.PRODUCT_PROGRAM_TYPE,
       krf.OBJECTCLASS,
       krf.is_dead_policy,
       CH.SALECHANNELFULLNAME_DE,
       krf.category_id_2020,
       to_char(krf.T1, 'yyyymm') YEAR_MONTH,
       to_char(krf.T1, 'yyyyq') YEAR_QUARTER,
       CASE WHEN krf.PROPERTYFORMNAME = 'Физическое лицо' THEN
            CASE WHEN krf.kasko_chain_number > 1 THEN 'Возобновлённый'
                 ELSE 'Первоначальный'
            END
            ELSE
            CASE krf.CONTRACTOPTION
                  WHEN '1' THEN 'Первоначальный'
                  WHEN '2' THEN 'Возобновлённый'
                  ELSE 'нд'
            END
       END as IS_PROLONGATION,
       SUM(krf.EXPOSURE) EXPOSURE,
       SUM(krf.AC_EXPOSURE) AC_EXPOSURE,
       SUM(krf.AC_EXPOSURE60) AC_EXPOSURE60,
       SUM(krf.DE_ZPOP60_INITIAL - krf.RETURNPREMIUM) DE_ZPOP60_INITIAL,
       SUM(krf.POLICYCOUNT) POLICYCOUNT,
       SUM(krf.WRITTENPREMIUM) WP,
       SUM(krf.WRITTENPREMIUM60) WP60,
       SUM(krf.OBJECTQUANTITY) OBJECTQUANTITY,
       SUM(krf.RETURNPREMIUM) RETURNPREMIUM,
       SUM(krf.LIABILITY) LIABILITY
FROM KASKO_RESULT_FULL_PARTS krf
LEFT JOIN DICTSALECHANNELTYPE2008 ch ON CH.SALE_CHANNEL_TYPE2008_ID = krf.SALECHANNEL2008
WHERE krf.part = CASE
                    WHEN TRUNC(SYSDATE, 'MM') - 1 = TRUNC(SYSDATE, 'Q') - 1 THEN 'q'  -- квартал
                    ELSE 'm'  -- месяц
                 END
GROUP BY
    krf.db,
    krf.NEW_REGIONNAME,
    krf.PROPERTYFORMNAME,
    krf.PRODUCT_PROGRAM_TYPE,
    krf.OBJECTCLASS,
    krf.is_dead_policy,
    CH.SALECHANNELFULLNAME_DE,
    krf.category_id_2020,
    to_char(krf.T1, 'yyyymm'),
    to_char(krf.T1, 'yyyyq'),
    CASE WHEN krf.PROPERTYFORMNAME = 'Физическое лицо' THEN
         CASE WHEN krf.kasko_chain_number > 1 THEN 'Возобновлённый'
              ELSE 'Первоначальный'
         END
         ELSE
         CASE krf.CONTRACTOPTION
               WHEN '1' THEN 'Первоначальный'
               WHEN '2' THEN 'Возобновлённый'
               ELSE 'нд'
         END
    END
ORDER BY 1, 2, 3, 4;

utils.logz(v_proc, v_scri, 'END. считали экспозицию по Каско за '||CASE
                    WHEN TRUNC(SYSDATE, 'MM') - 1 = TRUNC(SYSDATE, 'Q') - 1 THEN 'Квартал'
                    ELSE 'Месяц'
                 END);
COMMIT;

-- вставляем данные прошлых периодов из ранее расчитанного агрегата
-- (по аналогии с OSAGO_O):
insert --+ APPEND
  into XLS_EXPOSISION_PREMIUM_KASKO_O
select
       DB,
       NEW_REGIONNAME,
       PROPERTYFORMNAME,
       PRODUCT_PROGRAM_TYPE,
       OBJECTCLASS,
       IS_DEAD_POLICY,
       SALECHANNELFULLNAME_DE,
       CATEGORY_ID_2020,
       YEAR_MONTH,
       YEAR_QUARTER,
       'нд' as IS_PROLONGATION,
       EXPOSURE,
       AC_EXPOSURE,
       AC_EXPOSURE60,
       DE_ZPOP60_INITIAL,
       POLICYCOUNT,
       WP,
       WP60,
       OBJECTQUANTITY,
       RETURNPREMIUM,
       LIABILITY
from XLS_EXPOSISION_PREMIUM_KASKO16 ex16
 where ex16.YEAR_QUARTER < (select min(YEAR_QUARTER) from XLS_EXPOSISION_PREMIUM_KASKO_O);

utils.logz(v_proc, v_scri, 'данные прошлых периодов');
COMMIT;

utils.logz(v_proc, v_scri, 'END');

utils.email(v_proc, v_scri || ' accomplished', 'Anastasiya_Zhukova@rgs.ru');

EXCEPTION  when others then  utils.logz(v_proc, v_scri, sqlerrm || chr(10) || chr(13) || dbms_utility.format_error_backtrace || chr(10) || chr(13) || DBMS_UTILITY.format_call_stack );
RAISE;
END;--XLS_EXPOSISION_PREMIUM_KASKO_O
