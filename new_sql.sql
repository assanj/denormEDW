-- ============================================================================
-- ШАГ 3. Построение широкого треугольника развития от 1 до 60 месяцев (rep_guru_osago_triangle)
-- ============================================================================
DROP TABLE IF EXISTS actuary.rep_guru_osago_triangle;

CREATE TABLE actuary.rep_guru_osago_triangle AS
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
    cp.is_pvu_repsrv, -- тестирования токмо
    
    cp.contract_option,
    cp.is_partner,
    cp.sale_channel_groupmk_name,
    cp.category_id,
    cp.category_id_2020,
    cp.planning_region_name,
    cp.d1_month,
    cp.accident_month,
    
    cp.is_policy_from_ea,
    cp.is_policy_from_e_garant,
    cp.is_need_reinsurance,
    cp.accepted_for_reinsurance_main,
    cp.osago_chain_number,
    
    -- Резервы (RESERVE) - используем createtime__claim_transaction
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '1 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_1_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '2 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_2_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '3 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_3_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '4 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_4_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '5 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_5_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '6 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_6_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '7 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_7_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '8 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_8_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '9 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_9_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '10 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_10_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '11 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_11_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '12 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_12_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '13 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_13_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '14 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_14_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '15 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_15_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '16 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_16_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '17 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_17_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '18 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_18_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '19 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_19_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '20 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_20_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '21 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_21_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '22 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_22_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '23 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_23_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '24 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_24_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '25 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_25_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '26 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_26_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '27 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_27_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '28 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_28_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '29 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_29_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '30 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_30_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '31 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_31_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '32 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_32_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '33 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_33_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '34 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_34_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '35 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_35_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '36 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_36_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '37 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_37_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '38 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_38_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '39 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_39_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '40 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_40_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '41 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_41_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '42 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_42_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '43 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_43_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '44 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_44_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '45 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_45_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '46 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_46_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '47 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_47_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '48 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_48_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '49 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_49_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '50 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_50_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '51 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_51_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '52 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_52_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '53 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_53_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '54 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_54_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '55 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_55_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '56 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_56_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '57 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_57_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '58 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_58_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '59 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_59_month_11_reserve,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '60 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_60_month_11_reserve,
    
    -- Одобренные выплаты (APPROVED) - используем approvaldate
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '1 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_1_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '2 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_2_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '3 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_3_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '4 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_4_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '5 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_5_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '6 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_6_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '7 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_7_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '8 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_8_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '9 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_9_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '10 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_10_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '11 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_11_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '12 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_12_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '13 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_13_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '14 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_14_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '15 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_15_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '16 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_16_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '17 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_17_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '18 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_18_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '19 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_19_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '20 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_20_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '21 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_21_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '22 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_22_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '23 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_23_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '24 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_24_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '25 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_25_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '26 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_26_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '27 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_27_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '28 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_28_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '29 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_29_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '30 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_30_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '31 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_31_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '32 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_32_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '33 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_33_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '34 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_34_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '35 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_35_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '36 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_36_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '37 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_37_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '38 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_38_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '39 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_39_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '40 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_40_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '41 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_41_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '42 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_42_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '43 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_43_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '44 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_44_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '45 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_45_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '46 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_46_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '47 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_47_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '48 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_48_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '49 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_49_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '50 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_50_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '51 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_51_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '52 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_52_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '53 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_53_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '54 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_54_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '55 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_55_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '56 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_56_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '57 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_57_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '58 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_58_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '59 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_59_month_11_approved,
    SUM(CASE WHEN ra.refundcategory NOT IN ('Выплата по исполнительному листу', 'Выплата до решения суда') 
              AND ra.approvaldate < DATE_TRUNC('month', cp.lossdate) + INTERVAL '60 month' + (p_indent || ' days')::INTERVAL 
         THEN ra.transactionamount ELSE 0 END) AS plus_60_month_11_approved

FROM actuary.rep_guru_osago_tr_cp cp
JOIN actuary.ccd_claim_policy_incident_exposure_transaction ra 
    ON ra.claim_id = cp.claim_id
WHERE ra.costtype = 'claimcost' -- 'Стоимость убытка'
  AND ra.refundcategory <> 'Выплата по удостоверению ФУ'
  AND DATE_TRUNC('day', ra.createtime__claim_transaction) <= 
      (p_indent || '.' || TO_CHAR(CURRENT_DATE, 'MM.YYYY'))::DATE
GROUP BY 
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
    cp.is_pvu_repsrv,
    cp.contract_option,
    cp.is_partner,
    cp.sale_channel_groupmk_name,
    cp.category_id,
    cp.category_id_2020,
    cp.planning_region_name,
    cp.d1_month,
    cp.accident_month,
    cp.is_policy_from_ea,
    cp.is_policy_from_e_garant,
    cp.is_need_reinsurance,
    cp.accepted_for_reinsurance_main,
    cp.osago_chain_number;

CREATE INDEX IF NOT EXISTS rep_guru_osago_triangle_claimnumber_idx ON actuary.rep_guru_osago_triangle (claimnumber);
ANALYZE actuary.rep_guru_osago_triangle;
