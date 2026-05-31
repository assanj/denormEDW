-- DROP FUNCTION actuary.rebuid_objects_core(int4);

CREATE OR REPLACE FUNCTION actuary.rebuid_objects_core(p_check integer DEFAULT 1)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
--- Kazakov 10.05.2026
 
/*
do $$
begin
	perform actuary.rebuid_objects_core();
end $$
 -- select * from actuary.ccd_claim_policy_incident_exposure_transaction
*/

declare
    v_pack_name	varchar := 'rebuid_objects_core';
    v_ok 		integer := 1;
    v_row_count integer := 0;
 -- p_check integer := 1;
begin
get diagnostics v_row_count := ROW_COUNT;
PERFORM actuary.logz(v_pack_name, 'rebuid_objects_core', 'started', 'step00', v_row_count);
--============================================================================...

--PROMT: строго никогда не меняй названия/последовательность таблиц/полей без моего указания.

/*
 * 1-й Слой среза с ядра актуальных данных для уменьшения размера (actuary.ccc_*)
 *   1.1. Таблица убытков (Claims)
 *   1.2. Таблица полисов убытков (Claim Policies)
 *   1.3. Таблица инцидентов (Claim Incidents)
 *   1.4. Таблица покрытий/заявлений (Claim Exposures)
 *   1.5. Таблица транзакций по убыткам (Claim Transactions)
 */

-- 1.1. Таблица убытков (Claims)
DROP TABLE IF EXISTS actuary.ccc_claim1;
CREATE TABLE actuary.ccc_claim1 AS
SELECT 
    updatetime,
    createtime,
    risk,
    lobcode,
    accidenttype,
    state,
    losscause,
    lossdate::date,
    reporteddate,
    claim_policy_id,
    closedate,
    retired,
    claimnumber,
    claim_id,
    reopendate,
    period_start,
    period_end,
    hash,
    description,
    accidentname,
    "valid",
    is_europrotocol,
    is_reopen,
    is_exists_re_note,
    is_gbdd_documented,
    is_guilty_vehicle_surveyed,
    is_europrotocol_unlim,
    is_differences_exist,
    request_date_from,
    request_date_to,
    dtp_glonass_numb,
    regulation_type_name,
    bordereau_id,
    loss_cause_id,
    writeoff_debt_date,
    writeoff_debt_amt,
    updated_ts,
    payment_cur_code,
    insurant_name,
    writeoff_date,
    writeoff_amt,
    reinsurance_expense_id,
    broker_counterparty_id,
    address_id,
    key_id,
    is_blacklisted,
    CURRENT_TIMESTAMP::TIMESTAMP AS sysmoment__claim
FROM core.claim
WHERE retired = 0 
  AND period_end = '9999-12-31'::date 
  AND p_check = 1;

CREATE INDEX IF NOT EXISTS ccc_claim1_claim_id_idx ON actuary.ccc_claim1 (claim_id);
CREATE INDEX IF NOT EXISTS ccc_claim1_claim_policy_id_idx ON actuary.ccc_claim1 (claim_policy_id);
ANALYZE actuary.ccc_claim1;


DROP TABLE IF EXISTS actuary.ccc_claim_counterparty_proc_insured;
CREATE TABLE actuary.ccc_claim_counterparty_proc_insured AS
select src.*
,CURRENT_TIMESTAMP :: TIMESTAMP         As sysmoment
from (select ap.* 
,  row_number() over (partition by claim_id order by counterparty_type asc NULLS LAST, ap.claim_counterparty_id desc NULLS LAST) rn
from core.claim_counterparty_proc ap
where ap.contactrole = 'insured' 
--AND period_end = '9999-12-31'::date
and p_check = 1
) src where rn=1;
CREATE UNIQUE INDEX ccc_claim_counterparty_proc_insured_claim_id_idx ON actuary.ccc_claim_counterparty_proc_insured USING btree (claim_id);
analyze actuary.ccc_claim_counterparty_proc_insured; 

DROP TABLE IF EXISTS actuary.ccc_claim;
CREATE TABLE actuary.ccc_claim AS
select
	cp.*,
	cpt.counterparty_type,
	case
		when cpt.counterparty_type = 1 then 'Физическое лицо'
		when cpt.counterparty_type = 2 then 'Юридическое лицо'
		when cpt.counterparty_type = 5 then 'Юридическое лицо'
	end as claim_ins_type,
	cl."name" as CLAIM_LEVEL_RISK
from
	actuary.ccc_claim1 cp
left join actuary.ccc_claim_counterparty_proc_insured cpt on cp.claim_id = cpt.claim_id
left join core.claim_losscause cl on cp.losscause = cl.code and cl.period_end = '9999-12-31'::date
;

CREATE INDEX IF NOT EXISTS ccc_claim_claim_id_idx ON actuary.ccc_claim (claim_id);
CREATE INDEX IF NOT EXISTS ccc_claim_claim_policy_id_idx ON actuary.ccc_claim (claim_policy_id);
ANALYZE actuary.ccc_claim;


-- 1.2. Таблица полисов убытков (Claim Policies)
DROP TABLE IF EXISTS actuary.ccc_claim_policy;
CREATE TABLE actuary.ccc_claim_policy AS
SELECT 
    effectivedate,
    retired,
    dateofcontract,
    policy_number,
    state,
    claim_policy_id,
    policytype as policytype_code,
    status,
    insurer,
    currencyequivalent,
    expirationdate,
    policy_series,
    contract_id,
    extcompany,
    extinsurancecompany,
    currency,
    contractdate,
    policyproduct_id,
    period_start,
    period_end,
    hash,
    cancellationdate,
    branch_code,
    policydocauthortype,
    fixedexchangerate,
    exchangeratetype,
    claimpaymentexchratedate,
    premium_date,
    iscapitalinsurancerelated,
    reinsurance_condition_id,
    replacement_premium_amt,
    base_claim_amt,
    reinsurance_type_code,
    reinsurance_type_name,
    business_line_code,
    business_line_name,
    nsso_claim_number,
    is_reinsurance,
    reinsured_contract_number,
    reinsurance_category_name,
    updated_ts,
    key_id,
    CURRENT_TIMESTAMP::TIMESTAMP AS sysmoment__claim_policy
FROM core.claim_policy
WHERE retired = 0 
  AND period_end = '9999-12-31'::date 
  AND p_check = 1;

CREATE INDEX IF NOT EXISTS ccc_claim_policy_claim_policy_id_idx ON actuary.ccc_claim_policy (claim_policy_id);
ANALYZE actuary.ccc_claim_policy;


-- 1.3. Таблица инцидентов (Claim Incidents)
DROP TABLE IF EXISTS actuary.ccc_claim_incident;
CREATE TABLE actuary.ccc_claim_incident AS
SELECT 
    survey,
    claim_incident_id,
    claim_vehicle_id,
    claim_property_id,
    retired,
    createtime,
    appclosestpoint,
    applicationregion,
    closestpoint,
    vehstolenind,
    burntdown,
    constructdeath,
    repaironstoa,
    surveyestimate,
    description,
    are2detailsdamaged,
    isonlyglassdamaged,
    autorepairshop,
    greencorridoravailable,
    otherinsurerclaimnumber,
    otherinsurerclaim,
    period_start,
    period_end,
    hash,
    claim_id,
    "valid",
    claim_policyexternal_id,
    subtype_name,
    subtype,
    damage_quantity,
    docs_status,
    collect_full_docs_date,
    lossnotice_inc_ex,
    inc_is_direct_payout_outgo,
    business_process_type_name,
    damaged_details_qty,
    updated_ts,
    incident_date,
    key_id,
    is_total_loss,
    CURRENT_TIMESTAMP::TIMESTAMP AS sysmoment__claim_incident
FROM core.claim_incident
WHERE retired = 0 
  AND period_end = '9999-12-31'::date 
  AND p_check = 1;

CREATE INDEX IF NOT EXISTS ccc_claim_incident_claim_id_idx ON actuary.ccc_claim_incident (claim_id);
CREATE INDEX IF NOT EXISTS ccc_claim_incident_claim_incident_id_idx ON actuary.ccc_claim_incident (claim_incident_id);

ANALYZE actuary.ccc_claim_incident;


-- 1.4. Таблица покрытий/заявлений (Claim Exposures)
DROP TABLE IF EXISTS actuary.ccc_claim_exposure;
CREATE TABLE actuary.ccc_claim_exposure AS
SELECT 
    createtime,
    state,
    appsubmissiondate,
    closedate,
    retired,
    claim_id,
    claim_exposure_id,
    claim_coverage_id,
    coveragesubtype,
    claim_incident_id,
    exposuretype,
    applicationnumber,
    period_start,
    period_end,
    hash,
    claimorder,
    claim_exposure_cur,
    claim_exposure_amt,
    claim_exposure_rub,
    is_direct_payout,
    direct_payout_type,
    is_direct_payout_outgo,
    application_status_name,
    updated_ts,
    loss_cause_id,
    CURRENT_TIMESTAMP::TIMESTAMP AS sysmoment__claim_exposure
FROM core.claim_exposure
WHERE retired = 0 
  AND period_end = '9999-12-31'::date 
  AND p_check = 1;

CREATE INDEX IF NOT EXISTS ccc_claim_exposure_claim_id_idx ON actuary.ccc_claim_exposure (claim_id);
CREATE INDEX IF NOT EXISTS ccc_claim_exposure_claim_incident_id_idx ON actuary.ccc_claim_exposure (claim_incident_id);
CREATE INDEX IF NOT EXISTS ccc_claim_exposure_claim_exposure_id_idx ON actuary.ccc_claim_exposure (claim_exposure_id);
ANALYZE actuary.ccc_claim_exposure;


-- 1.5. Таблица транзакций по убыткам (Claim Transactions)
DROP TABLE IF EXISTS actuary.ccc_claim_transaction;
CREATE TABLE actuary.ccc_claim_transaction AS
SELECT 
    status,
    paymenttype,
    claim_check_id,
    updatetime,
    createtime,
    retired,
    costcategory,
    costtype,
    doesnoterodereserves,
    claim_id,
    claim_exposure_id,
    subtype,
    claim_reserveline_id,
    claim_transaction_id,
    reportingforexamount,
    claimforexamount,
    transactionamount,
    approvaldate,
    hash,
    period_start,
    period_end,
    value_cur,
    value_rub,
    value_amt,
    rej_flag,
    value_date,
    is_harm_life_health,
    deductible_amt,
    deductible_rub,
    operation_cur,
    operation_amt,
    linecategory,
    operation_code,
    operation_name,
    updated_ts,
    writeoff_rzu_amt,
    writeoff_rzu_date,
    key_id,
    CURRENT_TIMESTAMP::TIMESTAMP AS sysmoment__claim_transaction
FROM core.claim_transaction
WHERE retired = 0 
  AND period_end = '9999-12-31'::date 
  AND p_check = 1;

CREATE INDEX IF NOT EXISTS ccc_claim_transaction_claim_id_idx ON actuary.ccc_claim_transaction (claim_id);
CREATE INDEX IF NOT EXISTS ccc_claim_transaction_claim_exposure_id_idx ON actuary.ccc_claim_transaction (claim_exposure_id);
ANALYZE actuary.ccc_claim_transaction;


-- 1.7. Таблица чеков/выплат по убыткам (Claim Checks)
DROP TABLE IF EXISTS actuary.ccc_claim_check;
CREATE TABLE actuary.ccc_claim_check AS
SELECT 
    claim_check_id,
    claim_id,
    checknumber,
    paymentstatus,
    approvaldate,
    lastpaymentdate,
    firstpaymentdate,
    retired,
    subrogationavailable,
    beneficiary,
    refundcategory,
    documentdate,
    documentnum,
    totalpaymentamountvalue,
    paymentdetails,
    invoice_id,
    createtime,
    postingdate,
    period_start,
    period_end,
    hash,
    is_pvu_fact_null,
    laydowndate,
    unpaidpremium_cur,
    unpaidpremium_amt,
    unpaidpremium_rub,
    paymentsumfixed,
    is_suit,
    is_court_prepaid,
    valid,
    buh_court_order_date,
    payment_date,
    claim_courtorder_id,
    doubledebiting_date,
    is_doubledebiting,
    claim_matter_id,
    previouschecknumber,
    pvu_payment_operation_date,
    currency_rate_date,
    updated_ts,
    is_ombudsman_resolution,
    key_id,
    CURRENT_TIMESTAMP::TIMESTAMP AS sysmoment__claim_check
FROM core.claim_check
WHERE retired = 0 
  AND period_end = '9999-12-31'::date 
  AND p_check = 1;

CREATE INDEX IF NOT EXISTS ccc_claim_check_claim_id_idx ON actuary.ccc_claim_check (claim_id);
CREATE INDEX IF NOT EXISTS ccc_claim_check_claim_check_id_idx ON actuary.ccc_claim_check (claim_check_id);
ANALYZE actuary.ccc_claim_check;


-- 1.7. Таблица судебных дел/материй (Claim Matters)
DROP TABLE IF EXISTS actuary.ccc_claim_matter;
CREATE TABLE actuary.ccc_claim_matter AS
SELECT 
    claim_matter_id,
    casenumber,
    claim_id,
    claim_incident_id,
    is_subrogation_exists,
    is_subrogation_flag,
    subrogation_type,
    is_zozpp,
    suit_stage,
    pd_suit_stage,
    suit_type,
    courttype,
    courtname,
    courtregion,
    courtrayon,
    courtnaselpunkt,
    representative,
    plaintiff,
    responsible,
    other,
    plaintiff_type,
    responsible_type,
    other_type,
    suit_work_begin_start_date,
    suit_work_begin_end_date,
    before_suit_begin_date,
    suitacceptdate,
    first_suitaccsum_all,
    first_suitaccsum_main,
    first_suitaccsum_penalty,
    first_suitaccsum_other,
    first_suitaccsum_poshlina,
    first_suitaccsum_lawer,
    first_suitaccsum_outlay,
    first_suitaccsum_expcrtsum,
    first_suitaccsum_expplnsum,
    suitacceptedsum_all,
    suitapprovedsum_all,
    suitacceptedsum_main,
    suitapprovedsum_main,
    suitacceptedsum_penalty,
    suitapprovedsum_penalty,
    suitacceptedsum_other,
    suitapprovedsum_other,
    suitacceptedsum_poshlina,
    suitapprovedsum_poshlina,
    suitacceptedsum_lawer,
    suitapprovedsum_lawer,
    suitacceptedsum_outlay,
    suitapprovedsum_outlay,
    suitacceptedsum_expcourtsum,
    suitapprovedsum_expcourtsum,
    suitacceptedsum_expplainsum,
    suitapprovedsum_expplainsum,
    suitapproveddate,
    sittingdate,
    courtsittingresult,
    is_suit_appr_sum_main_not_def,
    appealsenddate,
    appealdeterminationdate,
    isrgsappeal,
    suitappealsum_all,
    suitappealsum_main,
    suitappealsum_penalty,
    suitappealsum_other,
    suitappealsum_poshlina,
    suitappealsum_lawer,
    suitappealsum_outlay,
    suitappealsum_expcourtsum,
    suitappealsum_expplainsum,
    is_suit_apl_sum_main_not_def,
    appealcourtname,
    claim_state_region_id,
    period_start,
    period_end,
    retired,
    createtime_act_prav_poz,
    min_act_pre_reject_date,
    min_act_reject_date,
    min_return_pkd_date,
    pretrial_pretension_date,
    inc_subtype_name,
    arm_ekis_lossdatecode,
    is_incident_id_exists,
    suit_work_end_date1_min,
    suit_work_end_date2_min,
    suit_work_end_date1_max,
    suit_work_end_date2_max,
    updated_ts,
    key_id,
    CURRENT_TIMESTAMP::TIMESTAMP AS sysmoment__claim_matter
FROM core.claim_matter
WHERE retired = 0 
  AND period_end = '9999-12-31'::date 
  AND p_check = 1;

 -- Индексы и статистика для ccc_claim_matter
CREATE INDEX IF NOT EXISTS ccc_claim_matter_claim_id_idx ON actuary.ccc_claim_matter (claim_id);
CREATE INDEX IF NOT EXISTS ccc_claim_matter_claim_incident_id_idx ON actuary.ccc_claim_matter (claim_incident_id);
ANALYZE actuary.ccc_claim_matter;







/*
 * 2-й Слой денормализаций (ассоциаторов) (actuary.ccd_*) строится на первом слое
 *   2.1. Объединение Убыток + Полис
 *   2.2. Добавление Инцидента к предыдущему результату ccd_claim_policy
 *   2.3. Добавление Покрытия к предыдущему результату ccd_claim_policy_incident
 *   2.4. Добавление Транзакций к предыдущему результату ccd_claim_policy_incident_exposure
 */

-- 2.1. Объединение Убыток + Полис
DROP TABLE IF EXISTS actuary.ccd_claim_policy;
CREATE TABLE actuary.ccd_claim_policy AS
SELECT 
    cl.*,
    cp.effectivedate,
    cp.retired AS retired__claim_policy,
    cp.dateofcontract,
    cp.policy_number,
    cp.state AS state__claim_policy,
    cp.policytype_code, ---kms
    cpt."name" as policytype, --kms
    cp.status,
    cp.insurer,
    cp.currencyequivalent,
    cp.expirationdate,
    cp.policy_series,
    cp.contract_id,
    cp.extcompany,
    cp.extinsurancecompany,
    cp.currency,
    cp.contractdate,
    cp.policyproduct_id,
    cp.period_start AS period_start__claim_policy,
    cp.period_end AS period_end__claim_policy,
    cp.hash AS hash__claim_policy,
    cp.cancellationdate,
    cp.branch_code,
    cp.policydocauthortype,
    cp.fixedexchangerate,
    cp.exchangeratetype,
    cp.claimpaymentexchratedate,
    cp.premium_date,
    cp.iscapitalinsurancerelated,
    cp.reinsurance_condition_id,
    cp.replacement_premium_amt,
    cp.base_claim_amt,
    cp.reinsurance_type_code,
    cp.reinsurance_type_name,
    cp.business_line_code,
    cp.business_line_name,
    cp.nsso_claim_number,
    cp.is_reinsurance,
    cp.reinsured_contract_number,
    cp.reinsurance_category_name,
    cp.updated_ts AS updated_ts__claim_policy,
    cp.key_id AS key_id__claim_policy,
    cp.sysmoment__claim_policy
FROM actuary.ccc_claim cl
LEFT JOIN actuary.ccc_claim_policy cp ON cl.claim_policy_id = cp.claim_policy_id
left join core.claim_policytype cpt on cp.policytype_code = cpt.code and cpt.period_end = '9999-12-31'::date;

CREATE INDEX IF NOT EXISTS ccd_claim_policy_claim_id_idx ON actuary.ccd_claim_policy (claim_id);
ANALYZE actuary.ccd_claim_policy;


if 1=1 then
-- 2.2. Добавление Инцидента к предыдущему результату ccd_claim_policy
DROP TABLE IF EXISTS actuary.ccd_claim_policy_incident;
CREATE TABLE actuary.ccd_claim_policy_incident AS
SELECT 
    t1.*, 
    ci.survey,
    ci.claim_incident_id,
    ci.claim_vehicle_id,
    ci.claim_property_id,
    ci.retired AS retired__claim_incident,
    ci.createtime AS createtime__claim_incident,
    ci.appclosestpoint,
    ci.applicationregion,
    ci.closestpoint,
    ci.vehstolenind,
    ci.burntdown,
    ci.constructdeath,
    ci.repaironstoa,
    ci.surveyestimate,
    ci.description AS description__claim_incident,
    ci.are2detailsdamaged,
    ci.isonlyglassdamaged,
    ci.autorepairshop,
    ci.greencorridoravailable,
    ci.otherinsurerclaimnumber,
    ci.otherinsurerclaim,
    ci.period_start AS period_start__claim_incident,
    ci.period_end AS period_end__claim_incident,
    ci.hash AS hash__claim_incident,
    ci."valid" AS valid__claim_incident,
    ci.claim_policyexternal_id,
    ci.subtype_name,
    ci.subtype,
    ci.damage_quantity,
    ci.docs_status,
    ci.collect_full_docs_date,
    ci.lossnotice_inc_ex,
    ci.inc_is_direct_payout_outgo,
    ci.business_process_type_name,
    ci.damaged_details_qty,
    ci.updated_ts AS updated_ts__claim_incident,
    ci.incident_date,
    ci.key_id AS key_id__claim_incident,
    ci.is_total_loss,
    ci.sysmoment__claim_incident
FROM actuary.ccd_claim_policy t1
LEFT JOIN actuary.ccc_claim_incident ci ON t1.claim_id = ci.claim_id;

CREATE INDEX IF NOT EXISTS ccd_claim_policy_incident_claim_id_idx ON actuary.ccd_claim_policy_incident (claim_id);
CREATE INDEX IF NOT EXISTS ccd_claim_policy_incident_claim_incident_id_idx ON actuary.ccd_claim_policy_incident (claim_incident_id);
ANALYZE actuary.ccd_claim_policy_incident;


-- 2.3. Добавление Покрытия к предыдущему результату ccd_claim_policy_incident
DROP TABLE IF EXISTS actuary.ccd_claim_policy_incident_exposure;
CREATE TABLE actuary.ccd_claim_policy_incident_exposure AS
SELECT 
    t2.*, 
    ce.createtime AS createtime__claim_exposure,
    ce.state AS state__claim_exposure,
    ce.appsubmissiondate,
    ce.closedate AS closedate__claim_exposure,
    ce.retired AS retired__claim_exposure,
    ce.claim_exposure_id,
    ce.claim_coverage_id,
    ce.coveragesubtype,
    ce.exposuretype,
    ce.applicationnumber,
    ce.period_start AS period_start__claim_exposure,
    ce.period_end AS period_end__claim_exposure,
    ce.hash AS hash__claim_exposure,
    ce.claimorder,
    ce.claim_exposure_cur,
    ce.claim_exposure_amt,
    ce.claim_exposure_rub,
    ce.is_direct_payout,
    ce.direct_payout_type,
    ce.is_direct_payout_outgo,-- AS is_direct_payout_outgo__claim_exposure,
    ce.application_status_name,
    ce.updated_ts AS updated_ts__claim_exposure,
    ce.loss_cause_id AS loss_cause_id__claim_exposure,
    ce.sysmoment__claim_exposure
FROM actuary.ccd_claim_policy_incident t2
LEFT JOIN actuary.ccc_claim_exposure ce 
  ON t2.claim_id = ce.claim_id 
 AND t2.claim_incident_id = ce.claim_incident_id;

CREATE INDEX IF NOT EXISTS ccd_claim_policy_incident_exposure_claim_id_idx ON actuary.ccd_claim_policy_incident_exposure (claim_id);
CREATE INDEX IF NOT exists ccd_claim_policy_incident_exposure_claimnumber_idx ON actuary.ccd_claim_policy_incident_exposure (claimnumber);

ANALYZE actuary.ccd_claim_policy_incident_exposure;


-- 2.4. Добавление Transact-ий к предыдущему результату ccd_claim_policy_incident_exposure
DROP TABLE IF EXISTS actuary.ccd_claim_policy_incident_exposure_transaction;
CREATE TABLE actuary.ccd_claim_policy_incident_exposure_transaction AS
SELECT 
    t3.*, 
    ctx.status AS status__claim_transaction,
    ctx.paymenttype,
    ctx.claim_check_id,
    ctx.updatetime AS updatetime__claim_transaction,
    ctx.createtime AS createtime__claim_transaction,
    ctx.retired AS retired__claim_transaction,
    ctx.costcategory,
    ctx.costtype,
    ctx.doesnoterodereserves,
    ctx.subtype AS subtype__claim_transaction,
    ctx.claim_reserveline_id,
    ctx.claim_transaction_id,
    ctx.reportingforexamount,
    ctx.claimforexamount,
    ctx.transactionamount,
    ctx.approvaldate,
    ctx.hash AS hash__claim_transaction,
    ctx.period_start AS period_start__claim_transaction,
    ctx.period_end AS period_end__claim_transaction,
    ctx.value_cur AS value_cur__claim_transaction,
    ctx.value_rub AS value_rub__claim_transaction,
    ctx.value_amt AS value_amt__claim_transaction,
    ctx.rej_flag,
    ctx.value_date AS value_date__claim_transaction,
    ctx.is_harm_life_health,
    ctx.deductible_amt,
    ctx.deductible_rub,
    ctx.operation_cur,
    ctx.operation_amt,
    linecategory,
    operation_code,
    operation_name,
    ctx.updated_ts AS updated_ts__claim_transaction,
    ctx.writeoff_rzu_amt,
    ctx.writeoff_rzu_date,
    ctx.key_id AS key_id__claim_transaction,
    ctx.sysmoment__claim_transaction
FROM actuary.ccd_claim_policy_incident_exposure t3
LEFT JOIN actuary.ccc_claim_transaction ctx 
  ON t3.claim_id = ctx.claim_id 
 AND t3.claim_exposure_id = ctx.claim_exposure_id;

CREATE INDEX IF NOT EXISTS ccd_claim_policy_incident_exposure_transaction_claim_id_idx ON actuary.ccd_claim_policy_incident_exposure_transaction (claim_id);
CREATE INDEX IF NOT EXISTS ccd_claim_policy_incident_exposure_transaction_claim_incident_id_idx ON actuary.ccd_claim_policy_incident_exposure_transaction (claim_incident_id);
CREATE INDEX IF NOT EXISTS ccd_claim_policy_incident_exposure_transaction_exposure_id_idx ON actuary.ccd_claim_policy_incident_exposure_transaction (claim_exposure_id);
--проверка, что мы всё еще в уникальной транзакции:
CREATE unique INDEX IF NOT EXISTS ccd_claim_policy_incident_exposure_transaction_claim_transaction_id_idx ON actuary.ccd_claim_policy_incident_exposure_transaction (claim_transaction_id);

ANALYZE actuary.ccd_claim_policy_incident_exposure_transaction;


-- Шаг 2.5. Добавление судебных дел к предыдущему результату ccd_claim_policy_incident_exposure_transaction
DROP TABLE IF EXISTS actuary.ccd_claim_policy_incident_exposure_transaction_matter;
CREATE TABLE actuary.ccd_claim_policy_incident_exposure_transaction_matter AS
SELECT 
    t4.*, -- Все поля, полученные на Шаге 4 предыдущего уровня
    -- Поля из c_claim_matter (повторяющиеся переименованы через __claim_matter)
    cm.claim_matter_id,
    cm.casenumber,
    cm.is_subrogation_exists,
    cm.is_subrogation_flag,
    cm.subrogation_type,
    cm.is_zozpp,
    cm.suit_stage,
    cm.pd_suit_stage,
    cm.suit_type,
    cm.courttype,
    cm.courtname,
    cm.courtregion,
    cm.courtrayon,
    cm.courtnaselpunkt,
    cm.representative,
    cm.plaintiff,
    cm.responsible,
    cm.other,
    cm.plaintiff_type,
    cm.responsible_type,
    cm.other_type,
    cm.suit_work_begin_start_date,
    cm.suit_work_begin_end_date,
    cm.before_suit_begin_date,
    cm.suitacceptdate,
    cm.first_suitaccsum_all,
    cm.first_suitaccsum_main,
    cm.first_suitaccsum_penalty,
    cm.first_suitaccsum_other,
    cm.first_suitaccsum_poshlina,
    cm.first_suitaccsum_lawer,
    cm.first_suitaccsum_outlay,
    cm.first_suitaccsum_expcrtsum,
    cm.first_suitaccsum_expplnsum,
    cm.suitacceptedsum_all,
    cm.suitapprovedsum_all,
    cm.suitacceptedsum_main,
    cm.suitapprovedsum_main,
    cm.suitacceptedsum_penalty,
    cm.suitapprovedsum_penalty,
    cm.suitacceptedsum_other,
    cm.suitapprovedsum_other,
    cm.suitacceptedsum_poshlina,
    cm.suitapprovedsum_poshlina,
    cm.suitacceptedsum_lawer,
    cm.suitapprovedsum_lawer,
    cm.suitacceptedsum_outlay,
    cm.suitapprovedsum_outlay,
    cm.suitacceptedsum_expcourtsum,
    cm.suitapprovedsum_expcourtsum,
    cm.suitacceptedsum_expplainsum,
    cm.suitapprovedsum_expplainsum,
    cm.suitapproveddate,
    cm.sittingdate,
    cm.courtsittingresult,
    cm.is_suit_appr_sum_main_not_def,
    cm.appealsenddate,
    cm.appealdeterminationdate,
    cm.isrgsappeal,
    cm.suitappealsum_all,
    cm.suitappealsum_main,
    cm.suitappealsum_penalty,
    cm.suitappealsum_other,
    cm.suitappealsum_poshlina,
    cm.suitappealsum_lawer,
    cm.suitappealsum_outlay,
    cm.suitappealsum_expcourtsum,
    cm.suitappealsum_expplainsum,
    cm.is_suit_apl_sum_main_not_def,
    cm.appealcourtname,
    cm.claim_state_region_id,
    cm.period_start AS period_start__claim_matter,
    cm.period_end AS period_end__claim_matter,
    cm.retired AS retired__claim_matter,
    cm.createtime_act_prav_poz,
    cm.min_act_pre_reject_date,
    cm.min_act_reject_date,
    cm.min_return_pkd_date,
    cm.pretrial_pretension_date,
    cm.inc_subtype_name AS inc_subtype_name__claim_matter,
    cm.arm_ekis_lossdatecode,
    cm.is_incident_id_exists,
    cm.suit_work_end_date1_min,
    cm.suit_work_end_date2_min,
    cm.suit_work_end_date1_max,
    cm.suit_work_end_date2_max,
    cm.updated_ts AS updated_ts__claim_matter,
    cm.key_id AS key_id__claim_matter,
    cm.sysmoment__claim_matter
FROM actuary.ccd_claim_policy_incident_exposure_transaction t4
LEFT JOIN actuary.ccc_claim_matter cm 
  ON t4.claim_id = cm.claim_id 
 AND t4.claim_incident_id = cm.claim_incident_id;

CREATE INDEX IF NOT EXISTS ccd_claim_policy_incident_exposure_transaction_matter_claim_id_idx ON actuary.ccd_claim_policy_incident_exposure_transaction_matter (claim_id);
ANALYZE actuary.ccd_claim_policy_incident_exposure_transaction_matter;



-- ============================================================================
-- Комментарии для 1-го слоя среза данных (actuary.ccc_*)
-- ============================================================================

COMMENT ON TABLE actuary.ccc_claim IS 
'1.1. Срез актуальных данных по убыткам (Claims). Содержит информацию о дате, причине и статусе закрытия убытка.';

COMMENT ON TABLE actuary.ccc_claim_policy IS 
'1.2. Срез актуальных данных по полисам убытков (Claim Policies). Содержит параметры договоров страхования на момент убытка.';

COMMENT ON TABLE actuary.ccc_claim_incident IS 
'1.3. Срез актуальных данных по инцидентам (Claim Incidents). Описывает обстоятельства происшествия, место и характер повреждений.';

COMMENT ON TABLE actuary.ccc_claim_exposure IS 
'1.4. Срез актуальных данных по покрытиям и заявлениям (Claim Exposures). Фиксирует заявленные суммы в разрезе типов покрытий.';

COMMENT ON TABLE actuary.ccc_claim_transaction IS 
'1.5. Срез актуальных данных по финансовым операциям убытков (Claim Transactions). Содержит проводки по выплатам и резервам.';

COMMENT ON TABLE actuary.ccc_claim_matter IS 
'1.6. Срез актуальных данных по судебным делам и материям (Claim Matters). Фиксирует этапы судов, исковые требования, суммы и результаты заседаний.';


-- ============================================================================
-- Комментарии для 2-го слоя денормализаций (actuary.ccd_*)
-- ============================================================================

COMMENT ON TABLE actuary.ccd_claim_policy IS 
'2.1. Денормализованная сущность: Убыток + Полис. Результат объединения ccc_claim и ccc_claim_policy по ключу claim_policy_id.';

COMMENT ON TABLE actuary.ccd_claim_policy_incident IS 
'2.2. Денормализованная сущность: Убыток + Полис + Инцидент. Построена на базе ccd_claim_policy с добавлением данных ccc_claim_incident по ключу claim_id.';

COMMENT ON TABLE actuary.ccd_claim_policy_incident_exposure IS 
'2.3. Денормализованная сущность: Убыток + Полис + Инцидент + Покрытие. Построена на базе ccd_claim_policy_incident с добавлением данных ccc_claim_exposure по ключам claim_id и claim_incident_id.';

COMMENT ON TABLE actuary.ccd_claim_policy_incident_exposure_transaction IS 
'2.4. Финальный ассоциативный слой: Убыток + Полис + Инцидент + Покрытие + Транзакции. Построена на базе ccd_claim_policy_incident_exposure с добавлением проводок ccc_claim_transaction по ключам claim_id и claim_exposure_id.';

COMMENT ON TABLE actuary.ccd_claim_policy_incident_exposure_transaction_matter IS 
'2.5. Финальный ассоциативный слой: Убыток + Полис + Инцидент + Покрытие + Транзакции + Судебные дела. Построена на базе ccd_claim_policy_incident_exposure_transaction с последовательным добавлением судебных исков ccc_claim_matter по ключам claim_id и claim_incident_id.';


-- Логирование окончания работы
GET DIAGNOSTICS v_row_count = ROW_COUNT;
PERFORM actuary.logz(v_pack_name, 'rebuid_objects_core', 'finished', 'step100', v_row_count);

end if;
raise notice '>> все объекты денормализаций убытков по ядру @EDW успешно пересобраны по скрипту <<';

end $function$
;
