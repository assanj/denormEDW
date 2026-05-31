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
