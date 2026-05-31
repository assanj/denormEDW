-- ============================================================================
-- PostgreSQL переписанный скрипт на основе Oracle INSERT
-- Оригинал: REP_GURU_OSAGO_TRIANGLE_in_Oracle.sql
-- Конвертировано для PostgreSQL (ядро)
-- Удалены Oracle-специфичные хинты, заменены функции дат.
-- Предполагается, что таблицы REP_GURU_OSAGO_TR_CP и VOSIPOV.CC_FOR_RESERVE_AND_APPROVEDSUM
-- существуют в целевой БД PostgreSQL с теми же именами колонок.
-- Параметр p_indent – целое число (день месяца), например 1.
-- ============================================================================

-- Пример вызова (можно обернуть в функцию или использовать DO):
-- DO $$ DECLARE p_indent integer := 1; BEGIN ... END; $$;

INSERT INTO REP_GURU_OSAGO_TRIANGLE
(
    contract_id,
    policy_series,
    policy_number,
    claimnumber,
    is_capital_insurance,
    new_regionname,
    claim_level_risk,
    claim_ins_type,
    lossdate,
    is_pvu,
    arm_ekis_contractoption,
    arm_ekis_is_partner,
    salechannelfullname_de,
    category_id_final,
    category_id_2020_final,
    regionname_final,
    d1_month,
    accident_month,
    is_policy_from_ea,
    is_policy_from_e_garant,
    is_need_reinsurance,
    accepted_for_reinsurance_main,
    osago_chain_number,
    plus_1_month_11_reserve,
    plus_2_month_11_reserve,
    plus_3_month_11_reserve,
    plus_4_month_11_reserve,
    plus_5_month_11_reserve,
    plus_6_month_11_reserve,
    plus_7_month_11_reserve,
    plus_8_month_11_reserve,
    plus_9_month_11_reserve,
    plus_10_month_11_reserve,
    plus_11_month_11_reserve,
    plus_12_month_11_reserve,
    plus_13_month_11_reserve,
    plus_14_month_11_reserve,
    plus_15_month_11_reserve,
    plus_16_month_11_reserve,
    plus_17_month_11_reserve,
    plus_18_month_11_reserve,
    plus_19_month_11_reserve,
    plus_20_month_11_reserve,
    plus_21_month_11_reserve,
    plus_22_month_11_reserve,
    plus_23_month_11_reserve,
    plus_24_month_11_reserve,
    plus_25_month_11_reserve,
    plus_26_month_11_reserve,
    plus_27_month_11_reserve,
    plus_28_month_11_reserve,
    plus_29_month_11_reserve,
    plus_30_month_11_reserve,
    plus_31_month_11_reserve,
    plus_32_month_11_reserve,
    plus_33_month_11_reserve,
    plus_34_month_11_reserve,
    plus_35_month_11_reserve,
    plus_36_month_11_reserve,
    plus_37_month_11_reserve,
    plus_38_month_11_reserve,
    plus_39_month_11_reserve,
    plus_40_month_11_reserve,
    plus_41_month_11_reserve,
    plus_42_month_11_reserve,
    plus_43_month_11_reserve,
    plus_44_month_11_reserve,
    plus_45_month_11_reserve,
    plus_46_month_11_reserve,
    plus_47_month_11_reserve,
    plus_48_month_11_reserve,
    plus_49_month_11_reserve,
    plus_50_month_11_reserve,
    plus_51_month_11_reserve,
    plus_52_month_11_reserve,
    plus_53_month_11_reserve,
    plus_54_month_11_reserve,
    plus_55_month_11_reserve,
    plus_56_month_11_reserve,
    plus_57_month_11_reserve,
    plus_58_month_11_reserve,
    plus_59_month_11_reserve,
    plus_60_month_11_reserve,
    plus_1_month_11_approved,
    plus_2_month_11_approved,
    plus_3_month_11_approved,
    plus_4_month_11_approved,
    plus_5_month_11_approved,
    plus_6_month_11_approved,
    plus_7_month_11_approved,
    plus_8_month_11_approved,
    plus_9_month_11_approved,
    plus_10_month_11_approved,
    plus_11_month_11_approved,
    plus_12_month_11_approved,
    plus_13_month_11_approved,
    plus_14_month_11_approved,
    plus_15_month_11_approved,
    plus_16_month_11_approved,
    plus_17_month_11_approved,
    plus_18_month_11_approved,
    plus_19_month_11_approved,
    plus_20_month_11_approved,
    plus_21_month_11_approved,
    plus_22_month_11_approved,
    plus_23_month_11_approved,
    plus_24_month_11_approved,
    plus_25_month_11_approved,
    plus_26_month_11_approved,
    plus_27_month_11_approved,
    plus_28_month_11_approved,
    plus_29_month_11_approved,
    plus_30_month_11_approved,
    plus_31_month_11_approved,
    plus_32_month_11_approved,
    plus_33_month_11_approved,
    plus_34_month_11_approved,
    plus_35_month_11_approved,
    plus_36_month_11_approved,
    plus_37_month_11_approved,
    plus_38_month_11_approved,
    plus_39_month_11_approved,
    plus_40_month_11_approved,
    plus_41_month_11_approved,
    plus_42_month_11_approved,
    plus_43_month_11_approved,
    plus_44_month_11_approved,
    plus_45_month_11_approved,
    plus_46_month_11_approved,
    plus_47_month_11_approved,
    plus_48_month_11_approved,
    plus_49_month_11_approved,
    plus_50_month_11_approved,
    plus_51_month_11_approved,
    plus_52_month_11_approved,
    plus_53_month_11_approved,
    plus_54_month_11_approved,
    plus_55_month_11_approved,
    plus_56_month_11_approved,
    plus_57_month_11_approved,
    plus_58_month_11_approved,
    plus_59_month_11_approved,
    plus_60_month_11_approved
)
SELECT
    cp.contract_id,
    cp.policy_series,
    cp.policy_number,
    cp.claimnumber,       
    cp.is_capital_insurance,
    cp.new_regionname,
    cp.claim_level_risk,
    cp.claim_ins_type,
    cp.lossdate,
    cp.is_pvu,
    cp.arm_ekis_contractoption,
    cp.arm_ekis_is_partner,
    cp.salechannelfullname_de,
    cp.category_id_final,
    cp.category_id_2020_final,
    cp.regionname_final,
    cp.d1_month,
    cp.accident_month,
    -777 AS is_policy_from_ea,
    -777 AS is_policy_from_e_garant,
    -777 AS is_need_reinsurance,
    -777 AS accepted_for_reinsurance_main,
    -777 AS osago_chain_number,

    -- Резервы (FOR_RESERVE_CUR) до p_indent дня каждого месяца
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '1 month' * 1 + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_1_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '2 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_2_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '3 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_3_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '4 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_4_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '5 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_5_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '6 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_6_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '7 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_7_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '8 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_8_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '9 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_9_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '10 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_10_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '11 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_11_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '12 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_12_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '13 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_13_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '14 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_14_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '15 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_15_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '16 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_16_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '17 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_17_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '18 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_18_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '19 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_19_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '20 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_20_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '21 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_21_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '22 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_22_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '23 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_23_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '24 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_24_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '25 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_25_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '26 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_26_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '27 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_27_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '28 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_28_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '29 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_29_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '30 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_30_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '31 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_31_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '32 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_32_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '33 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_33_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '34 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_34_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '35 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_35_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '36 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_36_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '37 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_37_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '38 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_38_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '39 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_39_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '40 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_40_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '41 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_41_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '42 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_42_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '43 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_43_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '44 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_44_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '45 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_45_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '46 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_46_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '47 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_47_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '48 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_48_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '49 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_49_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '50 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_50_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '51 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_51_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '52 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_52_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '53 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_53_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '54 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_54_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '55 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_55_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '56 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_56_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '57 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_57_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '58 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_58_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '59 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_59_month_11_reserve,
    SUM(CASE WHEN ra.trn_createtime < (date_trunc('month', cp.lossdate) + INTERVAL '60 months' + (p_indent || ' days')::INTERVAL) THEN ra.for_reserve_cur ELSE 0 END) AS plus_60_month_11_reserve,

    -- Одобренные суммы (FOR_APPROVEDSUM) с исключением определённых категорий
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '1 month' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_1_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '2 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_2_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '3 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_3_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '4 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_4_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '5 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_5_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '6 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_6_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '7 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_7_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '8 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_8_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '9 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_9_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '10 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_10_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '11 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_11_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '12 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_12_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '13 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_13_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '14 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_14_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '15 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_15_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '16 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_16_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '17 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_17_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '18 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_18_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '19 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_19_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '20 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_20_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '21 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_21_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '22 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_22_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '23 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_23_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '24 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_24_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '25 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_25_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '26 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_26_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '27 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_27_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '28 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_28_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '29 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_29_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '30 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_30_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '31 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_31_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '32 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_32_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '33 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_33_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '34 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_34_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '35 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_35_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '36 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_36_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '37 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_37_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '38 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_38_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '39 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_39_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '40 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_40_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '41 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_41_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '42 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_42_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '43 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_43_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '44 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_44_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '45 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_45_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '46 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_46_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '47 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_47_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '48 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_48_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '49 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_49_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '50 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_50_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '51 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_51_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '52 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_52_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '53 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_53_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '54 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_54_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '55 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_55_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '56 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_56_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '57 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_57_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '58 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_58_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '59 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_59_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
                 AND ra.trnl_updatetime < (date_trunc('month', cp.lossdate) + INTERVAL '60 months' + (p_indent || ' days')::INTERVAL)
             THEN ra.for_approvedsum ELSE 0 END) AS plus_60_month_11_approved
FROM REP_GURU_OSAGO_TR_CP cp
JOIN VOSIPOV.CC_FOR_RESERVE_AND_APPROVEDSUM ra ON ra.claimid = cp.claimid
                                               AND ra.costtype = 'Стоимость убытка'
                                               -- Ограничение по дате создания транзакции (до p_indent дня текущего месяца)
                                               AND ra.trn_createtime::date <= make_date(EXTRACT(YEAR FROM CURRENT_DATE)::int, EXTRACT(MONTH FROM CURRENT_DATE)::int, p_indent)
                                               AND ra.refundcategory <> 'Выплата по удостоверению ФУ'  -- kms20260227
GROUP BY cp.contract_id,
         cp.policy_series,
         cp.policy_number,
         cp.claimnumber,
         cp.is_capital_insurance,
         cp.new_regionname,
         cp.claim_level_risk,
         cp.claim_ins_type,
         cp.lossdate,
         cp.is_pvu,
         cp.arm_ekis_contractoption,
         cp.arm_ekis_is_partner,
         cp.salechannelfullname_de,
         cp.category_id_final,
         cp.category_id_2020_final,
         cp.regionname_final,
         cp.d1_month,
         cp.accident_month;
