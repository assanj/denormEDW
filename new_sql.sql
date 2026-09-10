insert --+ APPEND
  into XLS_EXPOSISION_PREMIUM_KASKO_O
SELECT /*+ parallel(krf 16) */
       krf.db                                              as "База данных"
      ,krf.NEW_REGIONNAME                                  as "Регион"
      ,CASE WHEN krf.PROPERTYFORMNAME = 'Физическое лицо'
            THEN 'ФЛ' ELSE 'ЮЛ'
       END                                                 as "Тип страхователя"
      ,CASE WHEN krf.OBJECTCLASS = 'ТС'
            THEN 'ТС' ELSE 'Иное'
       END                                                 as "Тип объекта"
      ,krf.PROPERTYFORMNAME                                as "PROPERTYFORMNAME"
      ,CH.SALECHANNELFULLNAME_DE                           as "Канал продаж"
      ,krf.SALECHANNEL2008                                 as "SALECHANNEL2008"
      ,krf.IS_DEAD_POLICY                                  as "IS_DEAD_POLICY"
      ,krf.OBJECTCLASS                                     as "OBJECTCLASS"
      ,krf.PRODUCT_PROGRAM_TYPE                            as "PRODUCT_PROGRAM_TYPE"
      ,nvl(krf.FRANCHIZE_TYPE, 'Нет')                      as "FRANCHISE_TYPE"
      ,CASE krf.CONTRACTOPTION
            WHEN '2' THEN 'Возобновлённый'
            ELSE 'Первоначальный'
       END                                                 as "Признак договора"
      ,krf.D1QUARTER                                       as "Квартал начала"
      ,krf.D1MONTH                                         as "Месяц начала"
      ,to_char(krf.T1, 'yyyyq')                            as "Квартал"
      ,to_char(krf.T1, 'yyyymm')                           as "Месяц"
      ,SUM(krf.AC_EXPOSURE60)                              as "Экспозиция"
      ,SUM(krf.DE_ZPOP60_INITIAL - krf.RETURNPREMIUM)      as "Заработанная премия"
      ,SUM(krf.POLICYCOUNT)                                as "Количество договоров"
      ,SUM(krf.WRITTENPREMIUM)                             as "НП"
      ,SUM(krf.OBJECTQUANTITY)                             as "Количество объектов"
      ,SUM(krf.WRITTENPREMIUM60)                           as "НПОП60"
      ,SUM(krf.PROPERTYLIABILITYEXPOSURE)                  as "СС_экспозиция"
      ,SUM(krf.LIABILITY * krf.OBJECTQUANTITY)             as "СС_перв"
FROM KASKO_RESULT_FULL_PARTS krf
LEFT JOIN DICTSALECHANNELTYPE2008 ch
       ON CH.SALE_CHANNEL_TYPE2008_ID = krf.SALECHANNEL2008
WHERE krf.part = CASE
                    WHEN TRUNC(SYSDATE, 'MM') - 1 = TRUNC(SYSDATE, 'Q') - 1 THEN 'q'
                    ELSE 'm'
                 END
  AND (krf.db <> 'ЕКИС' OR krf.BRANCH_CHAR_ID <> 17701010)
GROUP BY
       krf.db
      ,krf.NEW_REGIONNAME
      ,CASE WHEN krf.PROPERTYFORMNAME = 'Физическое лицо'
            THEN 'ФЛ' ELSE 'ЮЛ'
       END
      ,CASE WHEN krf.OBJECTCLASS = 'ТС'
            THEN 'ТС' ELSE 'Иное'
       END
      ,krf.PROPERTYFORMNAME
      ,CH.SALECHANNELFULLNAME_DE
      ,krf.SALECHANNEL2008
      ,krf.IS_DEAD_POLICY
      ,krf.OBJECTCLASS
      ,krf.PRODUCT_PROGRAM_TYPE
      ,nvl(krf.FRANCHIZE_TYPE, 'Нет')
      ,CASE krf.CONTRACTOPTION
            WHEN '2' THEN 'Возобновлённый'
            ELSE 'Первоначальный'
       END
      ,krf.D1QUARTER
      ,krf.D1MONTH
      ,to_char(krf.T1, 'yyyyq')
      ,to_char(krf.T1, 'yyyymm')
ORDER BY 1, 2, 3, 4;
