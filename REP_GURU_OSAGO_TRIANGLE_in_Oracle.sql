
PROCEDURE REP_GURU_OSAGO_TRIANGLE(p_indent in integer:=3, p_recalc in integer:=1) IS
-- YYYY-MM-DD - Треугольник урегулирования ОСАГО.sql (понесённых несудебных убытков) 
--- ВНИМАНИЕ!!! запускаем только после того, как посчитаны на ODS и переправлены в таблицу GURU_CLM_CAT_DWH финальные(arm_ekis/guru) атрибуты
  v_proc varchar2(128) := 'REP_GURU_OSAGO_TRIANGLE';
  v_scri varchar2(128) := 'Треугольник урегулирования ОСАГО';
    
  v_ods_sysmoment  timestamp;  
  v_max_updatetime timestamp;  
  v_ods_sysmoment_ra  timestamp;
  v_modified_timestamp timestamp;
    
  v_noemail varchar2(128) := '';

begin
  --ACTUARY.AC_ETL.XLS_EXPOSISION_PREMIUM_OSAGO;
  
if p_recalc = 1 then --<< для обновления без  пересчёта надо сделать p_recalc=0 при запуске
  
  select min(sysmoment) , max(max_updatetime) 
    into v_ods_sysmoment, v_max_updatetime
    from VOSIPOV.CC_CLAIM_POLICY;
    
  select min(sysmoment) ,min(ra.trnl_modified_timestamp)
    into v_ods_sysmoment_ra, v_modified_timestamp
    from VOSIPOV.CC_FOR_RESERVE_AND_APPROVEDSUM ra;
    
utils.logz(v_proc, v_scri, 'START. p_indent = '||p_indent||', ods_sysmoment = '||v_ods_sysmoment ||', v_max_updatetime = '||v_max_updatetime, 'NOEMAIL');
utils.logz(v_proc, v_scri, 'START. p_indent = '||p_indent||', v_ods_sysmoment_ra = '||v_ods_sysmoment_ra ||', v_modified_timestamp = '||v_modified_timestamp, 'NOEMAIL');


execute immediate 'truncate table REP_GURU_OSAGO_TR_IS_PVU';
--create table REP_GURU_OSAGO_TR_IS_PVU as
insert --+ APPEND
  into REP_GURU_OSAGO_TR_IS_PVU
select CLAIMID,
       case when IS_EXISTS_NOT_PVU = 1 and IS_EXISTS_PVU_RESPONSE = 0 and IS_EXISTS_PVU_DIRECT = 0 then 'Не ПВУ'
            when IS_EXISTS_NOT_PVU = 0 and IS_EXISTS_PVU_RESPONSE = 1 and IS_EXISTS_PVU_DIRECT = 0 then 'ПВУ (Ответственный)'
            when IS_EXISTS_NOT_PVU = 0 and IS_EXISTS_PVU_RESPONSE = 0 and IS_EXISTS_PVU_DIRECT = 1 then 'ПВУ (Прямой)'
            when IS_EXISTS_NOT_PVU = 1 and IS_EXISTS_PVU_RESPONSE = 1 and IS_EXISTS_PVU_DIRECT = 0 then 'ПВУ (Ответственный) 2+'
            else 'ПВУ (Микс)'
        end IS_PVU
from (select --+ ordered full(cp) full(ci) parallel(cp 4) parallel(ci 4) use_hash(ci) 
             CI.CLAIMID,
             max(case when CI.DIRECTLOSSPAYMENTRGS!= 10002 or  CI.DIRECTLOSSPAYMENTRGS is null  then 1 else 0 end) IS_EXISTS_NOT_PVU,
             max(case when CI.DIRECTLOSSPAYMENTRGS = 10002 and CI.ISRGSRESPONSIBLEINSURER = '1' then 1 else 0 end) IS_EXISTS_PVU_RESPONSE,
             max(case when CI.DIRECTLOSSPAYMENTRGS = 10002 and CI.ISRGSRESPONSIBLEINSURER = '0' then 1 else 0 end) IS_EXISTS_PVU_DIRECT             
        from VOSIPOV.CC_CLAIM_POLICY cp
             join VOSIPOV.CC_CLAIM_INCIDENT ci on CI.CLAIMID = CP.CLAIMID
       where CP.LOBNAME = 'Авто' and
             CP.POLICYTYPE IN ('ОСАГО', 'РМ ОСАГО') and
             CP.LOSSDATE >= to_date('01.01.2016', 'dd.mm.yyyy') and 
             CI.INCIDENT_TYPE != 'Человек' --kms02082021
       group by CI.CLAIMID);
utils.logz(v_proc, v_scri, 'step01', 'NOEMAIL');                                      
commit;

execute immediate 'truncate table REP_GURU_OSAGO_TR_CP';
--create table REP_GURU_OSAGO_TR_CP as
insert --+ APPEND
  into REP_GURU_OSAGO_TR_CP
select --+ ordered full(cp) parallel(cp 8) use_hash(is_pvu clmcat) 
       cp.contract_id,
    -- CP.ARM_EKIS_POLICYID,
       CP.POLICY_SERIES,
       CP.POLICY_NUMBER,
       
       CP.CLAIMID,
       CP.CLAIMNUMBER,
       CP.NEW_REGIONNAME,
       CP.CLAIM_LEVEL_RISK,
       CP.CLAIM_INS_TYPE,

       CP.LOSSDATE,
       IS_PVU.IS_PVU,
        
       COALESCE(ATTR_CLM.IS_CAPITAL_INSURANCE_FINAL, 0)   as IS_CAPITAL_INSURANCE,            
       COALESCE(attr_clm.arm_ekis_contractoption,  'нд')  AS arm_ekis_contractoption,
       COALESCE(attr_clm.arm_ekis_is_partner,  'нд')      AS arm_ekis_is_partner,
       COALESCE(attr_clm.salechannelfullname_de,  'нд')   AS salechannelfullname_de,
       COALESCE(ATTR_CLM.CATEGORY_ID_FINAL_cl, 'нд')      as CATEGORY_ID_FINAL,
       COALESCE(ATTR_CLM.CATEGORY_ID_2020_FINAL_CL, 'нд') as CATEGORY_ID_2020_FINAL,    
       COALESCE(attr_clm.regionname_final,  'нд')         AS regionname_final,   
        
       to_char(CP.D1, 'yyyymm') D1_MONTH,
       to_char(CP.LOSSDATE, 'yyyymm') ACCIDENT_MONTH
from VOSIPOV.CC_CLAIM_POLICY CP
     join REP_GURU_OSAGO_TR_IS_PVU is_pvu on IS_PVU.CLAIMID = CP.CLAIMID
left join actuary.GURU_CLM_CAT_DWH ATTR_CLM on ATTR_CLM.CLAIMID = CP.CLAIMID and ATTR_CLM.CLAIM = 1     
where CP.POLICYTYPE IN ('ОСАГО', 'РМ ОСАГО') and
      --IS_PVU.IS_PVU != 'ПВУ (Прямой)' and
      (CP.EXTCOMPANYRGS is null or lower(CP.EXTINSURANCECOMPANYNAME) like '%капитал%страхован%' or CP.ISCAPITALINSURANCERELATED = '1') and
      CP.LOSSDATE >= to_date('01.01.2016', 'dd.mm.yyyy');
utils.logz(v_proc, v_scri, 'step02', 'NOEMAIL');                                      
commit;


execute immediate 'truncate table REP_GURU_OSAGO_TRIANGLE';
--create table REP_GURU_OSAGO_TRIANGLE as
insert --+ APPEND
  into REP_GURU_OSAGO_TRIANGLE
select --+ ordered full(ra) parallel(cp 8) parallel(ra 8) use_hash(ra)
       cp.contract_id,--CP.ARM_EKIS_POLICYID,
       CP.POLICY_SERIES,
       CP.POLICY_NUMBER,
       
       CP.CLAIMNUMBER,       
       CP.IS_CAPITAL_INSURANCE,
       CP.NEW_REGIONNAME,
       CP.CLAIM_LEVEL_RISK,
       CP.CLAIM_INS_TYPE,
       
       CP.LOSSDATE,
       CP.IS_PVU,
--     CP.ARM_EKIS_CATEGORY_ID,
--     CP.ARM_EKIS_REGIONNAME,
--     CP.ARM_EKIS_SALECHANNEL2008,
       CP.ARM_EKIS_CONTRACTOPTION,
       CP.ARM_EKIS_IS_PARTNER,
       CP.SALECHANNELFULLNAME_DE,
       CP.CATEGORY_ID_FINAL,
       CP.CATEGORY_ID_2020_FINAL,
       CP.REGIONNAME_FINAL,
       CP.D1_MONTH,
       CP.ACCIDENT_MONTH,
       
       -777 as is_policy_from_ea,
       -777 as is_policy_from_e_garant,
       -777 as IS_NEED_REINSURANCE,
       -777 as accepted_for_reinsurance_main,
       -777 as OSAGO_CHAIN_NUMBER,
       
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 1) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_1_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 2) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_2_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 3) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_3_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 4) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_4_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 5) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_5_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 6) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_6_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 7) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_7_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 8) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_8_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 9) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_9_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 10) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_10_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 11) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_11_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 12) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_12_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 13) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_13_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 14) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_14_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 15) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_15_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 16) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_16_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 17) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_17_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 18) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_18_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 19) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_19_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 20) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_20_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 21) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_21_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 22) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_22_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 23) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_23_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 24) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_24_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 25) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_25_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 26) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_26_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 27) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_27_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 28) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_28_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 29) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_29_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 30) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_30_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 31) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_31_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 32) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_32_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 33) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_33_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 34) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_34_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 35) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_35_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 36) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_36_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 37) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_37_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 38) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_38_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 39) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_39_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 40) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_40_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 41) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_41_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 42) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_42_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 43) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_43_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 44) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_44_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 45) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_45_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 46) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_46_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 47) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_47_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 48) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_48_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 49) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_49_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 50) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_50_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 51) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_51_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 52) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_52_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 53) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_53_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 54) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_54_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 55) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_55_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 56) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_56_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 57) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_57_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 58) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_58_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 59) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_59_MONTH_11_RESERVE,
       sum(case when RA.TRN_CREATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 60) + p_indent then RA.FOR_RESERVE_CUR else 0 end) PLUS_60_MONTH_11_RESERVE,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 1) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_1_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 2) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_2_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 3) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_3_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 4) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_4_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 5) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_5_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 6) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_6_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 7) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_7_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 8) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_8_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 9) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_9_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 10) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_10_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 11) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_11_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 12) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_12_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 13) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_13_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 14) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_14_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 15) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_15_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 16) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_16_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 17) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_17_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 18) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_18_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 19) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_19_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 20) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_20_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 21) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_21_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 22) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_22_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 23) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_23_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 24) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_24_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 25) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_25_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 26) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_26_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 27) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_27_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 28) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_28_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 29) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_29_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 30) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_30_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 31) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_31_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 32) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_32_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 33) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_33_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 34) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_34_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 35) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_35_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 36) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_36_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 37) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_37_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 38) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_38_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 39) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_39_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 40) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_40_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 41) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_41_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 42) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_42_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 43) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_43_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 44) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_44_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 45) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_45_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 46) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_46_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 47) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_47_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 48) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_48_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 49) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_49_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 50) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_50_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 51) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_51_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 52) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_52_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 53) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_53_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 54) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_54_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 55) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_55_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 56) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_56_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 57) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_57_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 58) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_58_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 59) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_59_MONTH_11_APPROVED,
       sum(case when RA.REFUNDCATEGORY not in ('Выплата по исполнительному листу', 'Выплата до решения суда') and
                     RA.TRNL_UPDATETIME < add_months(trunc(CP.LOSSDATE, 'mm'), 60) + p_indent
                then RA.FOR_APPROVEDSUM
                else 0
            end) PLUS_60_MONTH_11_APPROVED
from REP_GURU_OSAGO_TR_CP cp
     join VOSIPOV.CC_FOR_RESERVE_AND_APPROVEDSUM ra on RA.CLAIMID = CP.CLAIMID and
                                               RA.COSTTYPE = 'Стоимость убытка' and
                                            -- RA.TRN_CREATETIME < to_date('11.'||to_char(sysdate, 'mm.yyyy'), 'dd.mm.yyyy')
                                               trunc(RA.TRN_CREATETIME) <= to_date(to_char(p_indent)||'.'||to_char(sysdate, 'mm.yyyy'), 'dd.mm.yyyy')
                                               and RA.REFUNDCATEGORY <> 'Выплата по удостоверению ФУ'    -- kms20260227 
group by cp.contract_id,--CP.ARM_EKIS_POLICYID,
         CP.POLICY_SERIES,
         CP.POLICY_NUMBER,
         CP.CLAIMNUMBER,
         CP.IS_CAPITAL_INSURANCE,
         CP.NEW_REGIONNAME,
         CP.CLAIM_LEVEL_RISK,
         CP.CLAIM_INS_TYPE,
         
         CP.LOSSDATE,
         CP.IS_PVU,
  --       CP.ARM_EKIS_CATEGORY_ID,
   --      CP.ARM_EKIS_REGIONNAME,
  --       CP.ARM_EKIS_SALECHANNEL2008,
         CP.ARM_EKIS_CONTRACTOPTION,
         CP.ARM_EKIS_IS_PARTNER,
         CP.SALECHANNELFULLNAME_DE,
         CP.CATEGORY_ID_FINAL,
         CP.CATEGORY_ID_2020_FINAL,
         CP.REGIONNAME_FINAL,
         CP.D1_MONTH,
         CP.ACCIDENT_MONTH;
utils.logz(v_proc, v_scri, 'step03', 'NOEMAIL');                                      
commit;
---------------------->>>
    DROP_TABLE_IF_EXISTS('REP_GURU_OSAGO_TRIANGLE_'||to_char(trunc(sysdate, 'mm') - 1, 'yy_mm'), 'ACTUARY');
    execute immediate 'create table REP_GURU_OSAGO_TRIANGLE_'||to_char(trunc(sysdate, 'mm') - 1, 'yy_mm')||' as select * from REP_GURU_OSAGO_TRIANGLE';
    execute immediate 'grant select on REP_GURU_OSAGO_TRIANGLE_'||to_char(trunc(sysdate, 'mm') - 1, 'yy_mm')||' to ac_users';
    utils.logz(v_proc, v_scri, 'Нарезка отчёта REP_GURU_OSAGO_TRIANGLE_'||to_char(trunc(sysdate, 'mm') - 1, 'yy_mm')|| ' закончена');



update REP_GURU_OSAGO_TRIANGLE gs
set GS.ARM_EKIS_CONTRACTOPTION = decode(GS.ARM_EKIS_CONTRACTOPTION,
                                        '1', 'Первоначальный',
                                        '2', 'Возобновлённый',
                                        'нд', 'нд');
utils.logz(v_proc, v_scri, 'step04', 'NOEMAIL');                                      
commit;                                     

end if; --<< для обновления без  пересчёта

    IF trunc(sysdate, 'q') =  trunc(sysdate, 'mm') THEN        
        execute immediate 'create or replace view OSAGO_GW_FqRM1_TR as select * from  OSAGO_GW_FoRM1_Q';
        execute immediate 'create or replace view OSAGO_ST_FqRM1_TR as select * from  OSAGO_ST_FORM1_q';
        execute immediate 'create or replace view OSAGO_FqRM1_TR as select * from OSAGO_FoRM1_Q';

        utils.logz(v_proc, v_scri, 'квартал', v_noemail); 
    ELSE        
        execute immediate 'create or replace view OSAGO_GW_FqRM1_TR as select * from  OSAGO_GW_FoRM1';
        execute immediate 'create or replace view OSAGO_ST_FqRM1_TR as select * from  OSAGO_ST_FORM1';
        execute immediate 'create or replace view OSAGO_FqRM1_TR as select * from OSAGO_FoRM1';

        utils.logz(v_proc, v_scri, 'месяц', v_noemail);
    END IF;
    
-------------------------------------------------------------
MERGE --+ use_hash(tri f1)
INTO REP_GURU_OSAGO_TRIANGLE tri
     USING OSAGO_FqRM1_TR f1 ON (tri.contract_id = 'arm4|'||f1.objectid)
WHEN MATCHED THEN UPDATE 
  SET tri.is_policy_from_ea             = f1.is_policy_from_ea,
      tri.is_policy_from_e_garant       = f1.is_policy_from_e_garant,
      tri.is_need_reinsurance           = f1.is_need_reinsurance,
      tri.accepted_for_reinsurance_main = f1.accepted_for_reinsurance_main,
      tri.osago_chain_number            = f1.osago_chain_number
--WHEN NOT MATCHED THEN UPDATE SET tri.is_policy_from_ea = 'нд', tri.is_policy_from_e_garant = = 'нд'
;
utils.logz(v_proc, v_scri, 'step05', 'NOEMAIL');                                      
commit;

MERGE --+ use_hash(tri f1)
INTO REP_GURU_OSAGO_TRIANGLE tri
USING 
(
  select
      con_id,
      WM_CONCAT_DISTINCT(is_policy_from_ea)          as is_policy_from_ea,
      WM_CONCAT_DISTINCT(is_policy_from_e_garant)    as is_policy_from_e_garant,
      WM_CONCAT_DISTINCT(is_need_reinsurance)        as is_need_reinsurance,
      WM_CONCAT_DISTINCT(accepted_for_reinsurance_main)        as accepted_for_reinsurance_main,
      WM_CONCAT_DISTINCT(osago_chain_number)         as osago_chain_number      
   from OSAGO_ST_FqRM1_TR group by con_id
     ) f1 ON (tri.contract_id = 'ekis|'||to_char(f1.con_id))
WHEN MATCHED THEN UPDATE SET tri.is_policy_from_ea       = f1.is_policy_from_ea,
                             tri.is_policy_from_e_garant = f1.is_policy_from_e_garant,
                             tri.is_need_reinsurance     = f1.is_need_reinsurance,
                             tri.accepted_for_reinsurance_main     = f1.accepted_for_reinsurance_main,
                             tri.osago_chain_number      = f1.osago_chain_number
--WHEN NOT MATCHED THEN UPDATE SET tri.is_policy_from_ea = 'нд', tri.is_policy_from_e_garant = = 'нд'
;
utils.logz(v_proc, v_scri, 'step06', 'NOEMAIL');                                      
commit;

MERGE --+ use_hash(tri f1)
INTO REP_GURU_OSAGO_TRIANGLE tri
     USING OSAGO_gw_FqRM1_TR f1 ON (tri.contract_id = f1.objectid)
WHEN MATCHED THEN UPDATE 
  SET tri.is_policy_from_ea       = f1.is_policy_from_ea,
      tri.is_policy_from_e_garant = f1.is_policy_from_e_garant,
      tri.is_need_reinsurance     = f1.is_need_reinsurance, 
      tri.accepted_for_reinsurance_main     = f1.accepted_for_reinsurance_main,      
      tri.osago_chain_number      = f1.osago_chain_number
--WHEN NOT MATCHED THEN UPDATE SET tri.is_policy_from_ea = 'нд', tri.is_policy_from_e_garant = = 'нд'
;
utils.logz(v_proc, v_scri, 'step07', 'NOEMAIL');                                      
commit;

/*
INSERT INTO REP_GURU_OSAGO_TRIANGLE_PR
  SELECT GW.OBJECTID, --GW
         TO_CHAR(GW.is_policy_from_ea) AS is_policy_from_ea,
         TO_CHAR(GW.is_policy_from_e_garant) AS is_policy_from_e_garant,
         TO_CHAR(GW.osago_chain_number) AS osago_chain_number
    FROM OSAGO_gw_FqRM1 GW;
utils.logz(v_proc, v_scri, 'step05', 'NOEMAIL'); 
COMMIT;
INSERT INTO REP_GURU_OSAGO_TRIANGLE_PR
  SELECT 'arm4|' || F1.OBJECTID,
         TO_CHAR(F1.is_policy_from_ea) AS is_policy_from_ea,
         TO_CHAR(F1.is_policy_from_e_garant) AS is_policy_from_e_garant,
         TO_CHAR(F1.osago_chain_number) AS osago_chain_number
    FROM OSAGO_FqRM1 F1;
utils.logz(v_proc, v_scri, 'step06', 'NOEMAIL');  
COMMIT;
INSERT INTO REP_GURU_OSAGO_TRIANGLE_PR
  SELECT 'ekis|' || TO_CHAR(con_id) AS OBJECTID,
         TO_CHAR(is_policy_from_ea) AS is_policy_from_ea,
         TO_CHAR(is_policy_from_e_garant) AS is_policy_from_e_garant,
         TO_CHAR(osago_chain_number) AS osago_chain_number
    FROM OSAGO_ST_FqRM1;
--   GROUP BY con_id
utils.logz(v_proc, v_scri, 'step07', 'NOEMAIL'); 
COMMIT;

update (select -- full(f1) parallel(f1 8) full(gr) use_hash(gr)
             TRI.CONTRACT_ID,
             TRI.IS_POLICY_FROM_EA,
             TRI.IS_POLICY_FROM_E_GARANT,
             TRI.OSAGO_CHAIN_NUMBER,             
             F1.OBJECTID,
             F1.IS_POLICY_FROM_EA AS IS_POLICY_FROM_EA_,
             F1.IS_POLICY_FROM_E_GARANT AS IS_POLICY_FROM_E_GARANT_,
             F1.OSAGO_CHAIN_NUMBER AS OSAGO_CHAIN_NUMBER_         
          from REP_GURU_OSAGO_TRIANGLE TRI
          join REP_GURU_OSAGO_TRIANGLE_PR F1 on f1.OBJECTID = TRI.CONTRACT_ID
        )
   set IS_POLICY_FROM_EA = IS_POLICY_FROM_EA_,
       IS_POLICY_FROM_E_GARANT = IS_POLICY_FROM_E_GARANT_,
       OSAGO_CHAIN_NUMBER = OSAGO_CHAIN_NUMBER_;
utils.logz(v_proc, v_scri, 'step08', 'NOEMAIL');   
COMMIT;

*/
---------------------------------------------------------------------------------------------------------------------

/*
execute immediate 'truncate table REP_GURU_OSAGO_TRIANGLE_R';
--create table REP_GURU_OSAGO_TRIANGLE_R as
insert --+ APPEND
  into REP_GURU_OSAGO_TRIANGLE_R
select distinct REGIONNAME_FINAL,
                IS_CAPITAL_INSURANCE,
                CATEGORY_ID_FINAL,
                ARM_EKIS_CONTRACTOPTION,
                SALECHANNELFULLNAME_DE,
                IS_PVU,
                D1_MONTH,
                ACCIDENT_MONTH,
                cast(null as number) DEVELOPMENT_MONTH,
                is_policy_from_ea,
                is_policy_from_e_garant,
                osago_chain_number, 
                PLUS_1_MONTH_11_RESERVE RESERVESUM,
                cast(null as number) RESERVECOUNT,
                PLUS_1_MONTH_11_APPROVED APPROVEDSUM,
                cast(null as number) APPROVEDCOUNT
from REP_GURU_OSAGO_TRIANGLE
where rownum < 1;
utils.logz(v_proc, v_scri, 'step07', 'NOEMAIL');                                      
commit;

--grant all on REP_GURU_OSAGO_TRIANGLE to ac_users;
--grant all on REP_GURU_OSAGO_TRIANGLE_R to ac_users;
*/



DECLARE

v#SQL VARCHAR2(32000);
v#MAX_ACCIDENT_MONTH VARCHAR2(10):= to_char(sysdate, 'yyyymm');

v#MONTHS_COUNT NUMBER;

BEGIN
    execute immediate 'truncate table REP_GURU_OSAGO_TRIANGLE_R';
    v#MONTHS_COUNT := 60;

 -- select max(to_number(ACCIDENT_MONTH))
 -- into v#MAX_ACCIDENT_MONTH
 -- from REP_GURU_OSAGO_TRIANGLE;

    for i in 1..v#MONTHS_COUNT loop

        v#SQL := 'insert into REP_GURU_OSAGO_TRIANGLE_R '||
                 'select /*+ parallel(REP_GURU_OSAGO_TRIANGLE 8) */ '||
                        'REGIONNAME_FINAL, '||
                        'IS_CAPITAL_INSURANCE, '||
                        'CATEGORY_ID_FINAL, '||
                        'CATEGORY_ID_2020_FINAL, '||
                        'ARM_EKIS_CONTRACTOPTION, '||
                        'SALECHANNELFULLNAME_DE, '||
                        'IS_PVU, '||
                        'D1_MONTH, '||
                        'ACCIDENT_MONTH, '||
                        to_char(i)||' DEVELOPMENT_MONTH, '||
                        'is_policy_from_ea, '||
                        'is_policy_from_e_garant, '||
                        'IS_NEED_REINSURANCE, '||
                        'osago_chain_number, '||
                        'SUM(PLUS_'||to_char(i)||'_MONTH_11_RESERVE) RESERVESUM, '||
                        'SUM(CASE WHEN PLUS_'||to_char(i)||'_MONTH_11_RESERVE > 0 and '||
                                      'COALESCE(PLUS_'||to_char(i)||'_MONTH_11_APPROVED, 0) = 0 '||
                                 'THEN 1 '||
                                 'ELSE 0 '||
                             'END) RESERVECOUNT, '||
                        'SUM(PLUS_'||to_char(i)||'_MONTH_11_APPROVED) APPROVEDSUM, '||
                        'SUM(CASE WHEN PLUS_'||to_char(i)||'_MONTH_11_APPROVED > 0 '||
                                 'THEN 1 '||
                                 'ELSE 0 '||
                             'END) APPROVEDCOUNT '||
                 'from REP_GURU_OSAGO_TRIANGLE '||
                 'where TO_NUMBER(ACCIDENT_MONTH) < '||v#MAX_ACCIDENT_MONTH||' '||
                 'group by REGIONNAME_FINAL, '||
                          'IS_CAPITAL_INSURANCE, '||
                          'CATEGORY_ID_FINAL, '||
                          'CATEGORY_ID_2020_FINAL, '||
                          'ARM_EKIS_CONTRACTOPTION, '||
                          'SALECHANNELFULLNAME_DE, '||
                          'IS_PVU, '||
                          'D1_MONTH, '||
                          'ACCIDENT_MONTH, '||
                          'is_policy_from_ea, '||
                          'is_policy_from_e_garant, '||
                          'IS_NEED_REINSURANCE, '||
                          'osago_chain_number '
                          ;

        execute immediate v#SQL;
        commit;

        v#MAX_ACCIDENT_MONTH := to_char(add_months(to_date(v#MAX_ACCIDENT_MONTH, 'yyyymm'), -1), 'yyyymm');

    end loop;

END;

 utils.logz(v_proc, v_scri, 'END. p_indent = '||p_indent||', ods_sysmoment = '||v_ods_sysmoment||', v_max_updatetime = '||v_max_updatetime);

  utils.email(v_proc, v_scri ||', p_indent = '||p_indent||', ods_sysmoment = '||v_ods_sysmoment||', v_max_updatetime = '||v_max_updatetime|| ' - accomplished', 'Anastasiya_Zhukova@rgs.ru');
  utils.email(v_proc, v_scri ||', p_indent = '||p_indent||', ods_sysmoment = '||v_ods_sysmoment||', v_max_updatetime = '||v_max_updatetime|| ' - accomplished', 'Artyom_Sergeev@rgs.ru');

  utils.logz(v_proc, v_scri, 'emailed');
  
EXCEPTION  when others then  utils.logz(v_proc, v_scri, sqlerrm || chr(10) || chr(13) || dbms_utility.format_error_backtrace || chr(10) || chr(13) || DBMS_UTILITY.format_call_stack );
RAISE;
END;
