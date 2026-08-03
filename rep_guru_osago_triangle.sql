-- DROP PROCEDURE actuary.rep_guru_osago_triangle(int4);

CREATE OR REPLACE PROCEDURE actuary.rep_guru_osago_triangle(p_indent integer)
 LANGUAGE plpgsql
AS $procedure$
--- Kazakov 19.05.2026
--- Полный расчет и транспонирование треугольников развития (понесённых несудебных убытков)  ОСАГО (1-60 мес.)

/*
do $$
begin
	perform actuary.rep_guru_osago_triangle(3);
end $$
 -- select * from actuary.rep_guru_osago_triangle_r
*/

declare
    v_pack_name          varchar := 'rep_guru_osago_triangle';
    v_row_count          integer := 0;
    v_sql                text;
    v_max_accident_month varchar(10) := to_char(current_date, 'YYYYMM');
    v_months_count       integer := 60;
    p_check              integer := 1;
    p____indent          integer := (3+.0)::integer;
begin
-- Логирование общего старта процедуры
perform actuary.logz(v_pack_name, 'rep_guru_osago_triangle', 'started', 'step00', 0);

if 1=1 then

-- ============================================================================
-- ШАГ 1. Расчет признака ПВУ (rep_guru_osago_tr_is_pvu)
-- ============================================================================
DROP TABLE IF EXISTS actuary.rep_guru_osago_tr_is_pvu;

CREATE TABLE actuary.rep_guru_osago_tr_is_pvu AS
SELECT 
    claim_id,
    CASE 
        WHEN IS_EXISTS_NOT_PVU = 1 AND IS_EXISTS_PVU_RESPONSE = 0 AND IS_EXISTS_PVU_DIRECT = 0 THEN 'Не ПВУ'
        WHEN IS_EXISTS_NOT_PVU = 0 AND IS_EXISTS_PVU_RESPONSE = 1 AND IS_EXISTS_PVU_DIRECT = 0 THEN 'ПВУ (Ответственный)'
        WHEN IS_EXISTS_NOT_PVU = 0 AND IS_EXISTS_PVU_RESPONSE = 0 AND IS_EXISTS_PVU_DIRECT = 1 THEN 'ПВУ (Прямой)'
        WHEN IS_EXISTS_NOT_PVU = 1 AND IS_EXISTS_PVU_RESPONSE = 1 AND IS_EXISTS_PVU_DIRECT = 0 THEN 'ПВУ (Ответственный) 2+'
        ELSE 'ПВУ (Микс)'
    END AS IS_PVU
FROM (
    SELECT 
        claim_id,
      /*MAX(CASE WHEN is_direct_payout = 0 AND is_direct_payout_outgo__claim_exposure = 0 THEN 1 ELSE 0 END) AS IS_EXISTS_NOT_PVU,
        MAX(CASE WHEN is_direct_payout = 1 AND is_direct_payout_outgo__claim_exposure = 0 THEN 1 ELSE 0 END) AS IS_EXISTS_PVU_RESPONSE,
        MAX(CASE WHEN is_direct_payout = 0 AND is_direct_payout_outgo__claim_exposure = 1 THEN 1 ELSE 0 END) AS IS_EXISTS_PVU_DIRECT
        */
     -- claim_incident_id, claim_exposure_id, is_direct_payout, is_direct_payout_outgo__claim_exposure,
        max(CASE WHEN coalesce(is_direct_payout, 0) = 0 AND coalesce(is_direct_payout_outgo, 0) = 0 THEN 1 ELSE 0 END) AS IS_EXISTS_NOT_PVU,         
        max(CASE WHEN coalesce(is_direct_payout, 0) = 1 AND coalesce(is_direct_payout_outgo, 0) = 0 THEN 1 ELSE 0 END) AS IS_EXISTS_PVU_RESPONSE,
        max(CASE WHEN coalesce(is_direct_payout, 0) = 0 AND coalesce(is_direct_payout_outgo, 0) = 1 THEN 1 ELSE 0 END) AS IS_EXISTS_PVU_DIRECT
    FROM actuary.ccd_claim_policy_incident_exposure --core.claim_exposure
   WHERE lobcode = 'auto' 
      AND policytype IN ('ОСАГО', 'РМ ОСАГО') 
      AND lossdate >= '2016-01-01'::date 
      AND subtype_name != 'Человек'
     -- and claim_id IN ('guru|18223105', 'guru|18223501')
      and p_check = 1
    GROUP BY claim_id
) t;

CREATE unique INDEX IF NOT EXISTS rep_guru_osago_tr_is_pvu_claim_id_idx ON actuary.rep_guru_osago_tr_is_pvu (claim_id);
ANALYZE actuary.rep_guru_osago_tr_is_pvu;

-- ============================================================================
-- ШАГ 2. Подготовка базовых параметров полисов и убытков (rep_guru_osago_tr_cp)
-- ============================================================================
DROP TABLE IF EXISTS actuary.rep_guru_osago_tr_cp;

CREATE TABLE actuary.rep_guru_osago_tr_cp AS
SELECT 
    cp.contract_id,
    cp.policy_series,
    cp.policy_number,
    cp.claim_id,
    cp.claimnumber,
 --   cp.new_regionname,
    cp.claim_level_risk,
    cp.claim_ins_type,
    cp.lossdate::date,
    
    is_pvu.is_pvu,
    'налл' as is_pvu_repsrv,  -- тестироавния токмо
    
    COALESCE(ort.is_capital_insurance::integer, 0) AS is_capital_insurance,            
    COALESCE(ort.contract_option::text, 'нд') AS contract_option,
    COALESCE(ort.is_partner::text, 'нд') AS is_partner,
    COALESCE(ort.sale_channel_groupmk_name::text, 'нд') AS sale_channel_groupmk_name,
    COALESCE(ort.category_id::text, 'нд') AS category_id,
    COALESCE(ort.category_id_2020::text, 'нд') AS category_id_2020,    
    COALESCE(ort.planning_region_name::text, 'нд') AS planning_region_name,   
    
	COALESCE(ort.is_policy_from_ea::text, 'нд') AS is_policy_from_ea,
	COALESCE(ort.is_policy_from_e_garant::text, 'нд') AS is_policy_from_e_garant,
	COALESCE(ort.is_need_reinsurance::text, 'нд') AS is_need_reinsurance,
	COALESCE(ort.accepted_for_reinsurance_main::text, 'нд') AS accepted_for_reinsurance_main,
    -777 AS osago_chain_number,
    
    TO_CHAR(cp.contractdate, 'YYYYMM') AS d1_month, 
    TO_CHAR(cp.lossdate, 'YYYYMM') AS accident_month
FROM actuary.ccd_claim_policy cp
JOIN actuary.rep_guru_osago_tr_is_pvu is_pvu ON is_pvu.claim_id = cp.claim_id
--LEFT JOIN actuary.guru_clm_cat_dwh attr_clm ON ort.claimid = cp.claim_id AND ort.claim = 1    
LEFT JOIN actuary.contract_ort_dimensions_is_claim_by_contract_id ort on ort.contract_id = cp.contract_id 
    WHERE lobcode = 'auto' 
      AND policytype IN ('ОСАГО', 'РМ ОСАГО') 
      AND lossdate >= '2016-01-01'::date 
      and cp.claim_id like 'guru%' -----!!!!!!!!!!!!!!!
      AND (cp.extcompany IS NULL OR LOWER(cp.extinsurancecompany) LIKE '%капитал%страхован%' OR cp.iscapitalinsurancerelated = 1)
      and p_check = 1
     ;

CREATE unique INDEX IF NOT EXISTS rep_guru_osago_tr_cp_claim_id_idx ON actuary.rep_guru_osago_tr_cp (claim_id);
CREATE INDEX IF NOT EXISTS rep_guru_osago_tr_cp_claimnumber_idx ON actuary.rep_guru_osago_tr_cp (claimnumber);
ANALYZE actuary.rep_guru_osago_tr_cp;


-- апдейтим из первых форм Цепочки:
UPDATE actuary.rep_guru_osago_tr_cp AS dist
SET 
    osago_chain_number  = f1.osago_chain_number/*,
    is_kasko_with_osago = dist.is_kasko_with_osago,
    main_contract_id    = dist.main_contract_id,
    project_code        = dist.project_code,
    program_code        = dist.program_code,
    project_name        = dist.project_name,
    program_name        = dist.program_name*/
FROM (
    SELECT 
        objectid,
     -- main_contract_id,
        osago_chain_number/*,
        is_kasko_with_osago,
        project_code,
        program_code,
        project_name,
        program_name*/
    FROM cdm_analysis_out.ac_osago_form1_h_2604 --_2306 ---------------!!!!!!!!!!!!!!!!!!!!!!!!<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--    where rep_period >= (date_trunc('month', current_date - INTERVAL '1 month'))::date
-- в пентахо стоит фильтр: where rep_period = date('s{p_REPORT_DATE}') --> where rep_period = date('2023-06-01') 
--limit 100
    /*WHERE rep_period >= date_trunc('month', p#end_date)
      AND rep_period < date_trunc('month', p#end_date) + INTERVAL '1 month'*/
) AS f1
WHERE f1.objectid = dist.contract_id;

-- апдейтим данными перекачанными из REPSRV для тестирования:
UPDATE actuary.rep_guru_osago_tr_cp AS dist
SET is_pvu_repsrv  = src.is_pvu
FROM (
    select 'guru|'||claimid as claimid, is_pvu 
      FROM actuary.rep_guru_osago_tr_cp_repsrv    
     ) AS src
WHERE src.claimid = dist.claim_id;

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
 -- cp.new_regionname,
    cp.claim_level_risk,
    cp.claim_ins_type,
    
    cp.lossdate,
    
    cp.is_pvu,
   -- тестироавния токмо cp.is_pvu_repsrv, 
    
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
    
    -- Динамический кумулятивный разворот по 60 месяцам  ( p____indent => (3+.0)::integer)
    
       -- Резервы:
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '1 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_1_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '2 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_2_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '3 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_3_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '4 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_4_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '5 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_5_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '6 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_6_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '7 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_7_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '8 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_8_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '9 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_9_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '10 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_10_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '11 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_11_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '12 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_12_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '13 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_13_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '14 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_14_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '15 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_15_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '16 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_16_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '17 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_17_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '18 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_18_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '19 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_19_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '20 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_20_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '21 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_21_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '22 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_22_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '23 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_23_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '24 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_24_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '25 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_25_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '26 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_26_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '27 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_27_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '28 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_28_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '29 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_29_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '30 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_30_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '31 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_31_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '32 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_32_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '33 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_33_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '34 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_34_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '35 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_35_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '36 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_36_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '37 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_37_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '38 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_38_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '39 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_39_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '40 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_40_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '41 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_41_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '42 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_42_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '43 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_43_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '44 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_44_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '45 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_45_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '46 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_46_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '47 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_47_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '48 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_48_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '49 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_49_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '50 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_50_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '51 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_51_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '52 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_52_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '53 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_53_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '54 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_54_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '55 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_55_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '56 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_56_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '57 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_57_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '58 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_58_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '59 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_59_MONTH_11_RESERVE,
       sum(case when RA.createtime__claim_transaction < DATE_TRUNC('month', cp.lossdate) + INTERVAL '60 month'  + ((3+.0)::integer || ' days')::INTERVAL THEN -RA.value_rub else 0 end *(case when subtype__claim_transaction='Reserve' then -1 else 1 end) ) PLUS_60_MONTH_11_RESERVE,
--======Вывплаты:
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '1 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_1_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '2 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_2_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '3 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_3_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '4 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_4_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '5 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_5_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '6 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_6_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '7 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_7_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '8 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_8_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '9 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_9_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '10 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_10_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '11 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_11_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '12 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_12_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '13 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_13_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '14 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_14_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '15 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_15_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '16 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_16_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '17 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_17_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '18 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_18_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '19 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_19_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '20 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_20_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '21 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_21_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '22 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_22_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '23 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_23_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '24 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_24_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '25 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_25_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '26 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_26_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '27 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_27_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '28 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_28_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '29 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_29_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '30 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_30_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '31 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_31_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '32 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_32_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '33 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_33_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '34 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_34_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '35 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_35_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '36 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_36_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '37 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_37_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '38 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_38_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '39 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_39_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '40 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_40_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '41 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_41_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '42 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_42_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '43 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_43_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '44 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_44_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '45 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_45_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '46 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_46_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '47 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_47_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '48 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_48_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '49 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_49_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '50 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_50_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '51 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_51_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '52 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_52_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '53 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_53_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '54 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_54_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '55 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_55_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '56 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_56_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '57 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_57_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '58 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_58_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '59 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_59_MONTH_11_APPROVED,
sum(case when subtype__claim_transaction ='Payment' and coalesce(RA.REFUNDCATEGORY_name, 'нд') not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
             RA.updatetime__claim_transaction < date_trunc('month', CP.LOSSDATE) + interval '60 month' + ( (3+.0)::integer  * interval '1 day')
        then RA.value_rub
        else 0
    end) PLUS_60_MONTH_11_APPROVED
----==========
FROM actuary.rep_guru_osago_tr_cp cp
JOIN actuary.ccd_claim_policy_incident_exposure_transaction ra 
    ON ra.claim_id = cp.claim_id
WHERE coalesce(paymentstatus, 'issued') = 'issued' and ra.costtype_name = 'Стоимость убытка'
  AND coalesce(ra.REFUNDCATEGORY_name, 'нд') <> 'Выплата по удостоверению ФУ'
  AND DATE_TRUNC('day', ra.createtime__claim_transaction) <= 
      ( (3+.0)::integer  || '.' || TO_CHAR(CURRENT_DATE, 'MM.YYYY'))::DATE
GROUP BY 
    cp.contract_id, 
    cp.policy_series, 
    cp.policy_number, 
    cp.claimnumber, 
    cp.is_capital_insurance,
 -- cp.new_regionname, 
    cp.claim_level_risk, 
    cp.claim_ins_type, 
    cp.lossdate, 
    
    cp.is_pvu,
    cp.is_pvu_repsrv, -- тестироавния токмо
    
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
    cp.osago_chain_number
 ;

--GET DIAGNOSTICS v_row_count := ROW_COUNT;
--perform actuary.logz(v_pack_name, 'rep_guru_osago_triangle', 'finished', 'step03', v_row_count);

CREATE INDEX IF NOT EXISTS rep_guru_osago_triangle_claimnumber_idx ON actuary.rep_guru_osago_triangle (claimnumber);
ANALYZE actuary.rep_guru_osago_triangle;

end if;
-- ============================================================================
-- ШАГ 4. Создание и транспонирование итоговой витрины (rep_guru_osago_triangle_r)
-- ============================================================================

-- Проверка и пересоздание пустой целевой структуры (DQL часть)

DROP TABLE IF EXISTS actuary.rep_guru_osago_triangle_r;
CREATE TABLE actuary.rep_guru_osago_triangle_r (
    planning_region_name varchar NULL,       -- Раньше было regionname_final
    is_capital_insurance numeric NULL,       -- Полностью удалено/закомментировано в cp
    category_id varchar NULL,                -- Раньше было category_id_final
    category_id_2020 varchar NULL,           -- Раньше было category_id_2020_final
    contract_option varchar NULL,            -- Раньше было arm_ekis_contractoption
    is_partner varchar NULL,                 -- Раньше было arm_ekis_is_partner
    sale_channel_groupmk_name varchar NULL,  -- Раньше было salechannelfullname_de
    is_pvu varchar NULL,
    d1_month varchar(6) NULL,
    accident_month varchar(6) NULL,
    development_month integer NULL,
    
    -- Типы изменены на varchar, так как в cp они стали текстом (::text c дефолтом 'нд')
    is_policy_from_ea varchar NULL,          
    is_policy_from_e_garant varchar NULL,    
    is_need_reinsurance varchar NULL,        
    osago_chain_number integer NULL,         -- Полностью закомментировано в cp
 
    reservesum numeric NULL,
    reservecount integer NULL,
    approvedsum numeric NULL,
    approvedcount integer NULL
);

-- Транспонирующий цикл по 60 месяцам с динамическим сдвигом дат
FOR i IN 1..v_months_count LOOP


-- Формирование текста динамического SQL запроса для текущего месяца развития i
        v_sql := 'INSERT INTO actuary.rep_guru_osago_triangle_r (' ||
                 '    planning_region_name,' ||
                 '    is_capital_insurance,' ||
                 '    category_id,' ||
                 '    category_id_2020,' ||
                 '    contract_option,' ||
                 '    is_partner,' ||
                 '    sale_channel_groupmk_name,' ||
                 '    is_pvu,' ||
                 '    d1_month,' ||
                 '    accident_month,' ||
                 '    development_month,' ||
                 '    is_policy_from_ea,' ||
                 '    is_policy_from_e_garant,' ||
                 '    is_need_reinsurance,' ||
                 '    osago_chain_number,' ||
                 '    reservesum,' ||
                 '    reservecount,' ||
                 '    approvedsum,' ||
                 '    approvedcount' ||
                 ') ' ||
                 'SELECT ' ||
                 '    planning_region_name,' ||
                 '    is_capital_insurance,' ||
                 '    category_id,' ||
                 '    category_id_2020,' ||
                 '    contract_option,' ||
                 '    is_partner,' ||
                 '    sale_channel_groupmk_name,' ||
                 '    is_pvu,' ||
                 '    d1_month,' ||
                 '    accident_month,' ||
                 '    ' || i || ' AS development_month,' ||
                 '    is_policy_from_ea,' ||
                 '    is_policy_from_e_garant,' ||
                 '    is_need_reinsurance,' ||
                 '    osago_chain_number,' ||
                 '    SUM(plus_' || i || '_month_11_approved) AS reservesum,' ||
                 '    SUM(CASE WHEN plus_' || i || '_month_11_approved > 0 THEN 1 ELSE 0 END) AS reservecount,' ||
                 '    SUM(plus_' || i || '_month_11_approved) AS approvedsum,' ||
                 '    SUM(CASE WHEN plus_' || i || '_month_11_approved > 0 THEN 1 ELSE 0 END) AS approvedcount ' ||
                 'FROM actuary.rep_guru_osago_triangle ' ||
                 'WHERE CAST(accident_month AS INTEGER) < ' || CAST(v_max_accident_month AS INTEGER) || ' ' ||
                 'GROUP BY ' ||
                 '    planning_region_name,' ||
                 '    is_capital_insurance,' ||
                 '    category_id,' ||
                 '    category_id_2020,' ||
                 '    contract_option,' ||
                 '    is_partner,' ||
                 '    sale_channel_groupmk_name,' ||
                 '    is_pvu,' ||
                 '    d1_month,' ||
                 '    accident_month,' ||
                 '    is_policy_from_ea,' ||
                 '    is_policy_from_e_garant,' ||
                 '    is_need_reinsurance,' ||
                 '    osago_chain_number';

        -- Выполнение сформированного SQL-запроса на текущей итерации
        EXECUTE v_sql;

        -- Сдвиг максимального месяца аварии на 1 месяц назад (аналог oracle add_months(..., -1))
        v_max_accident_month := TO_CHAR(
            TO_DATE(v_max_accident_month, 'YYYYMM') - INTERVAL '1 month', 
            'YYYYMM'
        );

    END LOOP;

    -- Сбор диагностических данных по итоговому количеству строк
    GET DIAGNOSTICS v_row_count := ROW_COUNT;
    PERFORM actuary.logz(v_pack_name, 'rep_guru_osago_triangle_r', 'finished', 'step04', v_row_count);
   
   CREATE INDEX IF NOT EXISTS rep_guru_osago_triangle_r_accident_month_idx ON actuary.rep_guru_osago_triangle_r (accident_month);
   ANALYZE actuary.rep_guru_osago_triangle_r;


    -- Итоговое логирование успешного завершения всей процедуры
    PERFORM actuary.logz(v_pack_name, 'build_osago_triangles', 'finished', 'step100', 0);

END $procedure$
;
