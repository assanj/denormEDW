"C19_Нормализованное количество убытков" =
Sum([Количество убытков]*[Коэф_развития_1]*if([Тип убытка крупный]='ППВУ',0,1)*if(isnull(k_covid19_osago),1,k_covid19_osago)/(if(isnull(K_risk),1,K_risk)*K_season))

