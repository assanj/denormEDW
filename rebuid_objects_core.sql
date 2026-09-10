// старая версия

let report_date='31.07.2026';

let vstr_ARM = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (m_arm4)'; ///kms20251210
let vstr_ST  = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (m_ekis)'; ///kms20251210
let vstr_GW  = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (m_else)'; ///kms20251210


if  fmod(month('$(report_date)'),3)=0 then
    vstr_ARM = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (q_arm4)'; ///kms20251210
    vstr_ST  = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (q_ekis)'; ///kms20251210
    vstr_GW  = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (q_else)'; ///kms20251210
else 
	vstr_ARM = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (m_arm4)'; ///kms20251210
    vstr_ST  = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (m_ekis)'; ///kms20251210
    vstr_GW  = 'ACTUARY.KASKO_RESULT_FULL_PARTS Subpartition (m_else)'; ///kms20251210
end if;

if IsPartialReload()=0 then

LIB CONNECT TO 'Oracle_msk-m1-repsrv.rgs.ru_(actuary)'; 

[KASKO_RESULT_FORM_ALL]:
SELECT 
	NEW_REGIONNAME, 
	OBJECTCLASS, 
	PROPERTYFORMNAME, 
	SALECHANNEL2008, 
 	IS_DEAD_POLICY, 
 	FRANCHIZE_TYPE, 
	CONTRACTOPTION, 
	D1MONTH, 
	D1QUARTER, 
	PRODUCT_PROGRAM_TYPE, 
	T1, 
 	PROPERTYLIABILITYEXPOSURE,
	AC_EXPOSURE60, 
	DE_ZPOP60_INITIAL, 
 	POLICYCOUNT, 
 	OBJECTQUANTITY, 
 	LIABILITY, 
 	WRITTENPREMIUM, 
 	WRITTENPREMIUM60, 
	RETURNPREMIUM 
FROM $(vstr_ARM)
///where rownum <= 1000 ///kms20251210
;

NoConcatenate
[КАСКО_исх]:
Load 
	'АРМ' as [База данных],
    NEW_REGIONNAME as [Регион],
    OBJECTCLASS,
    if(OBJECTCLASS='ТС','ТС','Иное') as [Тип объекта],
    PRODUCT_PROGRAM_TYPE,
    if (PROPERTYFORMNAME='Физическое лицо','ФЛ','ЮЛ') as [Тип страхователя],
    PROPERTYFORMNAME,
    SALECHANNEL2008,
    IS_DEAD_POLICY,
    if(CONTRACTOPTION='2','Возобновлённый', 'Первоначальный') as [Признак договора],
    if(isnull(FRANCHIZE_TYPE),'Нет',FRANCHIZE_TYPE) as FRANCHISE_TYPE,
    D1QUARTER as [Квартал начала],
    D1MONTH as [Месяц начала],
    year(T1)&ceil(month(T1)/3) as Квартал,
    year(T1)&if(len(ceil(month(T1)/1))=2,ceil(month(T1)/1),'0'&ceil(month(T1)/1)) as Месяц,
    AC_EXPOSURE60 as EXPOSURE,
   (DE_ZPOP60_INITIAL-RETURNPREMIUM) as EP,
    POLICYCOUNT,
	WRITTENPREMIUM,
    WRITTENPREMIUM60,
    OBJECTQUANTITY,
    PROPERTYLIABILITYEXPOSURE,
    LIABILITY
resident [KASKO_RESULT_FORM_ALL];

drop table [KASKO_RESULT_FORM_ALL];

LIB CONNECT TO 'Oracle_msk-m1-repsrv.rgs.ru_(actuary)'; 

[KASKO_ST_RESULT_FORM_ALL]:
SELECT 
	NEW_REGIONNAME, 
	OBJECTCLASS,  
	PROPERTYFORMNAME, 
	SALECHANNEL2008, 
 	IS_DEAD_POLICY,  
	FRANCHIZE_TYPE as FRANCHISE_TYPE, ///kms20251210
	CONTRACTOPTION, 
	D1MONTH, 
	D1QUARTER, 
	PRODUCT_PROGRAM_TYPE, 
	T1, 
 	PROPERTYLIABILITYEXPOSURE, 
	AC_EXPOSURE60,
//     AC_EXPOSURE,
	DE_ZPOP60_INITIAL, 
 	POLICYCOUNT, 
 	OBJECTQUANTITY, 
 	LIABILITY, 
 	WRITTENPREMIUM, 
 	WRITTENPREMIUM60, 
	RETURNPREMIUM 
FROM $(vstr_ST)
where Branch_Char_id <> 17701010 /// kms20251210 fil_id
///and  rownum <= 1000 ///kms20251210
; //исключаем РНКБС

Concatenate ([КАСКО_исх])
Load
	if(WildMatch(NEW_REGIONNAME,'ТЭК*'),'КС', 'ЕКИС') as [База данных],
    NEW_REGIONNAME as [Регион],
    OBJECTCLASS,
    if(OBJECTCLASS='ТС','ТС','Иное') as [Тип объекта],
    PRODUCT_PROGRAM_TYPE,
    if (PROPERTYFORMNAME='Физическое лицо','ФЛ','ЮЛ') as [Тип страхователя],
    PROPERTYFORMNAME,
    SALECHANNEL2008,
    IS_DEAD_POLICY,
    if(CONTRACTOPTION='2','Возобновлённый', 'Первоначальный') as [Признак договора],
    if(isnull(FRANCHISE_TYPE),'Нет',FRANCHISE_TYPE) as FRANCHISE_TYPE,
//     BLACK_LIST_COMMENT,
    D1QUARTER as [Квартал начала],
    D1MONTH as [Месяц начала],
    year(T1)&ceil(month(T1)/3) as Квартал,
    year(T1)&if(len(ceil(month(T1)/1))=2,ceil(month(T1)/1),'0'&ceil(month(T1)/1)) as Месяц,
    AC_EXPOSURE60 as EXPOSURE,
//     if(PROPERTYFORMNAME='Юридическое лицо',AC_EXPOSURE,AC_EXPOSURE60) as EXPOSURE,
   (DE_ZPOP60_INITIAL-RETURNPREMIUM) as EP,
    POLICYCOUNT,
	WRITTENPREMIUM,
    WRITTENPREMIUM60,
    OBJECTQUANTITY,
    PROPERTYLIABILITYEXPOSURE,
    LIABILITY
Resident [KASKO_ST_RESULT_FORM_ALL];

drop table [KASKO_ST_RESULT_FORM_ALL];

LIB CONNECT TO 'Oracle_msk-m1-repsrv.rgs.ru_(actuary)'; 

[KASKO_GW_RESULT_FORM_ALL]:
SELECT 
 	NEW_REGIONNAME,
 	OBJECTCLASS,
 	PROPERTYFORMNAME,
 	SALECHANNEL2008,
 	IS_DEAD_POLICY,
 	FRANCHIZE_TYPE,
 	CONTRACTOPTION,
 	D1MONTH,
 	D1QUARTER,
 	PRODUCT_PROGRAM_TYPE,
 	T1,
 	PROPERTYLIABILITYEXPOSURE,
 	AC_EXPOSURE60,
 	DE_ZPOP60_INITIAL,
 	POLICYCOUNT,
 	OBJECTQUANTITY,
 	LIABILITY,
 	WRITTENPREMIUM,
 	WRITTENPREMIUM60,
 	RETURNPREMIUM
FROM $(vstr_GW)
///where rownum <= 1000 ///kms20251210
;

Concatenate ([КАСКО_исх])
Load 
	'GWPC' as [База данных],
    NEW_REGIONNAME as [Регион],
    OBJECTCLASS,
    if(OBJECTCLASS='ТС','ТС','Иное') as [Тип объекта],
    PRODUCT_PROGRAM_TYPE,
    if (PROPERTYFORMNAME='Физическое лицо','ФЛ','ЮЛ') as [Тип страхователя],
    PROPERTYFORMNAME,
    SALECHANNEL2008,
    IS_DEAD_POLICY,
    if(CONTRACTOPTION='2','Возобновлённый', 'Первоначальный') as [Признак договора],
    if(isnull(FRANCHIZE_TYPE),'Нет',FRANCHIZE_TYPE) as FRANCHISE_TYPE,
    D1QUARTER as [Квартал начала],
    D1MONTH as [Месяц начала],
    year(T1)&ceil(month(T1)/3) as Квартал,
    year(T1)&if(len(ceil(month(T1)/1))=2,ceil(month(T1)/1),'0'&ceil(month(T1)/1)) as Месяц,
    AC_EXPOSURE60 as EXPOSURE,
   (DE_ZPOP60_INITIAL-RETURNPREMIUM) as EP,
    POLICYCOUNT,
	WRITTENPREMIUM,
    WRITTENPREMIUM60,
    OBJECTQUANTITY,
    PROPERTYLIABILITYEXPOSURE,
    LIABILITY
resident [KASKO_GW_RESULT_FORM_ALL];

drop Table [KASKO_GW_RESULT_FORM_ALL];

NoConcatenate
[КАСКО]:
load *;
Load
	[База данных],
	[Регион],
    [Тип страхователя],
    [Тип объекта],
    PROPERTYFORMNAME,
    SALECHANNEL2008,
    IS_DEAD_POLICY,
    OBJECTCLASS,
    PRODUCT_PROGRAM_TYPE,
    FRANCHISE_TYPE,
    [Признак договора],
    [Квартал начала],
    [Месяц начала],
    Квартал,
    Месяц,
    sum(EXPOSURE) as Экспозиция,
    sum(EP) as [Заработанная премия],
    sum(POLICYCOUNT) as [Количество договоров],
    sum(WRITTENPREMIUM) as [НП],
    sum(OBJECTQUANTITY) as [Количество объектов],
    sum(WRITTENPREMIUM60) as [НПОП60],
    sum(PROPERTYLIABILITYEXPOSURE) as [СС_экспозиция],
    sum(LIABILITY*OBJECTQUANTITY) as [СС_перв]
Resident [КАСКО_исх]
group by 
	[База данных],
	[Регион],
    [Тип страхователя],
    [Тип объекта],
    PROPERTYFORMNAME,
    SALECHANNEL2008,
    IS_DEAD_POLICY,
    OBJECTCLASS,
    PRODUCT_PROGRAM_TYPE,
    FRANCHISE_TYPE,
    [Признак договора],
    [Квартал начала],
    [Месяц начала],
    Квартал,
    Месяц;
  
drop Table [КАСКО_исх];

LIB CONNECT TO 'Oracle_msk-m1-repsrv.rgs.ru_(actuary)'; 

NoConcatenate
[DICTSALECHANNELTYPE2008]:
SELECT 
  SALE_CHANNEL_TYPE2008_ID, 
  PARENT_ID, 
  SALE_CHANNEL_TYPE2008_NAME, 
  SORT_ORDER, 
  START_DATE, 
  END_DATE, 
  REFERABLE, 
  RESERVE_FLAG, 
  IE_SALE_CHANNEL_TYPE2008_NAME, 
  IS_LOWEST_LEVEL, 
  PARENT_SALE_CHANNEL_NAME, 
  SALECHANNELFULLNAME, 
  SMALLSALECHANNELNAME, 
  SALECHANNELFULLNAME_DE 
FROM ACTUARY.DICTSALECHANNELTYPE2008;

left join (КАСКО)
Load
	SALE_CHANNEL_TYPE2008_ID as SALECHANNEL2008,
    SALECHANNELFULLNAME_DE as [Канал продаж]
Resident [DICTSALECHANNELTYPE2008];
