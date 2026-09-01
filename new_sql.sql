"C19_Нормализованное количество убытков" =
Sum([Количество убытков]*[Коэф_развития_1]*if([Тип убытка крупный]='ППВУ',0,1)*if(isnull(k_covid19_osago),1,k_covid19_osago)/(if(isnull(K_risk),1,K_risk)*K_season))



    SUM(
        количество_убытков 
        * коэф_развития_1 
        * CASE WHEN тип_убытка_крупный = 'ППВУ' THEN 0 ELSE 1 END
        * COALESCE(k_covid19_osago, 1)
        / (COALESCE(k_risk, 1) * k_season)
    ) AS c19_нормализованное_количество_убытков
