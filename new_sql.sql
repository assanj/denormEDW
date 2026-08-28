

    SELECT 
        "Месяц начала" as start_month,
        "Месяц" as year_month,
        "Канал продаж" as sale_channel,
        "Флаг Е-ОСАГО" as flag_e_osago,
        IS_POLICY_FROM_EA,
        IS_POLICY_FROM_E_GARANT,
        "Передан в пул?" as is_need_reinsurance,
        CASE WHEN IS_POLICY_FROM_EA = '1' OR IS_POLICY_FROM_E_GARANT = '1' THEN '1' ELSE '0' END as drums_rca,
        "Флаг Токс_регион" as flag_toks_region,
        "Регион" as region_name,
        "Регион ОФР" as region_ofr,
        "Регион крупный" as region_big,
        "Признак договора" as contract_type,
        "Признак пролонгации" as prolongation_type,
        "Тип страхователя" as insurer_type,
        "Заработанная премия" as earned_premium,
        "Экспозиция" as exposure,
        "Начисленная премия" as written_premium,
        "Количество договоров" as policy_count,
        "Количество полисолет" as policy_year_count,
        NULL::text as claim_type_big,
        NULL::numeric as loss_count,
        NULL::numeric as loss_sum,
        'premium' as data_source
    FROM actuary.rep_osago_ep_expo
    WHERE left("Месяц", 4)::int >= 2019
union all
    SELECT 
        "Месяц начала" as start_month,
        "Месяц события" as year_month,
        "Канал продаж" as sale_channel,
        "Флаг Е-ОСАГО" as flag_e_osago,
        IS_POLICY_FROM_EA,
        IS_POLICY_FROM_E_GARANT,
        /*"Передан в пул?" as */is_need_reinsurance,
        CASE WHEN IS_POLICY_FROM_EA = '1' OR IS_POLICY_FROM_E_GARANT = '1' THEN '1' ELSE '0' END as drums_rca,
        "Флаг Токс_регион" as flag_toks_region,
        "Регион" as region_name,
        "Регион ОФР" as region_ofr,
        "Регион крупный" as region_big,
        "Признак договора" as contract_type,
        "Признак пролонгации" as prolongation_type,
        "Тип страхователя" as insurer_type,
        NULL::numeric as earned_premium,
        NULL::numeric as exposure,
        NULL::numeric as written_premium,
        NULL::numeric as policy_count,
        NULL::numeric as policy_year_count,
        "Тип убытка крупный" as claim_type_big,
        "Количество_убытков" as loss_count,
        "Сумма_убытков" as loss_sum,
        'loss' as data_source
    FROM actuary.rep_osago_triangle
    WHERE left("Месяц события", 4)::int >= 2019
