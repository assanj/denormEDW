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
