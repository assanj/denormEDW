CREATE TABLE actuary.rep_guru_osago_triangle AS
SELECT 
    cp.contract_id,
    cp.policy_series,
    cp.policy_number,
    cp.claimnumber,    
    cp.iscapitalinsurancerelated AS is_capital_insurance,
    cp.regionname_final AS new_regionname,
    cp.claim_level_risk,
    cp.claim_ins_type,
    cp.lossdate,
    cp.is_pvu_fact_null AS is_pvu,
    cp.arm_ekis_contractoption AS contract_option,
    cp.arm_ekis_is_partner AS is_partner,
    cp.salechannelfullname_de AS sale_channel_groupmk_name,
    cp.category_id_final AS category_id,
    cp.category_id_2020_final AS category_id_2020,
    cp.regionname_final AS planning_region_name,
    cp.d1_month,
    cp.accident_month,
    -777 AS is_policy_from_ea,
    -777 AS is_policy_from_e_garant,
    -777 AS is_need_reinsurance,
    -777 AS accepted_for_reinsurance_main,
    -777 AS osago_chain_number,
    -777 AS is_pvu_repsrv,
    
    -- =====================================================
    -- Резервы (по createtime__claim_transaction)
    -- Фильтр: refundcategory_name исключаем судебные
    -- =====================================================
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '1 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_1_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '2 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_2_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '3 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_3_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '4 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_4_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '5 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_5_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '6 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_6_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '7 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_7_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '8 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_8_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '9 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_9_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '10 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_10_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '11 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_11_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '12 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_12_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '13 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_13_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '14 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_14_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '15 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_15_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '16 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_16_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '17 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_17_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '18 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_18_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '19 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_19_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '20 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_20_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '21 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_21_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '22 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_22_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '23 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_23_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '24 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_24_month_11_reserve,
    -- ... продолжаем до 60 месяца по тому же шаблону (вставлю при финальной генерации)
    
    -- =====================================================
    -- Одобренные (по approvaldate__transaction)
    -- Фильтр: refundcategory_name исключаем судебные
    -- =====================================================
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '1 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_1_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '2 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_2_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '3 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_3_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '4 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_4_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '5 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_5_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '6 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_6_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '7 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_7_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '8 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_8_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '9 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_9_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '10 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_10_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '11 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_11_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '12 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_12_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '13 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_13_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '14 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_14_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '15 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_15_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '16 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_16_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '17 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_17_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '18 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_18_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '19 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_19_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '20 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_20_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '21 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_21_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '22 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_22_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '23 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_23_month_11_approved,
    SUM(CASE WHEN ra.refundcategory_name NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда')
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '24 month'
         THEN ra.transactionamount ELSE 0 END) AS plus_24_month_11_approved
    -- ... продолжаем до 60 месяца по тому же шаблону

FROM actuary.rep_guru_osago_tr_cp cp
JOIN actuary.ccd_claim_policy_incident_exposure_transaction ra 
    ON ra.claim_id = cp.claim_id
WHERE ra.costtype_name = 'Стоимость убытка'
  AND ra.refundcategory_name <> 'Выплата по удостоверению ФУ'
  AND DATE_TRUNC('day', ra.createtime__claim_transaction) <= CURRENT_DATE
GROUP BY 
    cp.contract_id,
    cp.policy_series,
    cp.policy_number,
    cp.claimnumber,
    cp.iscapitalinsurancerelated,
    cp.regionname_final,
    cp.claim_level_risk,
    cp.claim_ins_type,
    cp.lossdate,
    cp.is_pvu_fact_null,
    cp.arm_ekis_contractoption,
    cp.arm_ekis_is_partner,
    cp.salechannelfullname_de,
    cp.category_id_final,
    cp.category_id_2020_final,
    cp.d1_month,
    cp.accident_month;
