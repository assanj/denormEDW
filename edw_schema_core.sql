CREATE SEQUENCE core.contract_counterparty_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1  NO CYCLE;
CREATE SEQUENCE core.contract_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1  NO CYCLE;
CREATE SEQUENCE core.counterparty_role_counterparty_role_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1  NO CYCLE;
CREATE SEQUENCE core.etl_rnp_daily_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1  NO CYCLE;
CREATE SEQUENCE core.remuneration_map_tab_1_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1  NO CYCLE;
CREATE SEQUENCE core.tr_errorslog_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1  NO CYCLE;
CREATE SEQUENCE core.transaction_audit_transaction_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1  NO CYCLE;
CREATE SEQUENCE core.transaction_back_transaction_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1  NO CYCLE;
CREATE SEQUENCE core.transaction_mngr_transaction_id_seq INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1  NO CYCLE;
CREATE TABLE core.absence (absence_id CHARACTER VARYING(50) NOT NULL, employee_id CHARACTER VARYING(50), start_date DATE, end_date DATE, absence_type_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.absence IS 'Отсутствия (отпуски, больничные, прочие неявки)';
COMMENT ON COLUMN core.absence.absence_id IS 'Идентификатор';
COMMENT ON COLUMN core.absence.employee_id IS 'Идентификатор сотрудника';
COMMENT ON COLUMN core.absence.start_date IS 'Дата начала отсутсвия';
COMMENT ON COLUMN core.absence.end_date IS 'Дата окончания отсутсвия';
COMMENT ON COLUMN core.absence.absence_type_id IS 'Тип отсутствия';
COMMENT ON COLUMN core.absence.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.absence.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.absence.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.absence.key_id IS 'Уникальный ключ';
CREATE TABLE core.acc_broker (fo CHARACTER VARYING(256), sf CHARACTER VARYING(256), reg_num CHARACTER VARYING(8), full_name CHARACTER VARYING(256), address CHARACTER VARYING(256), new_address CHARACTER VARYING(256), contacts CHARACTER VARYING(256), inn CHARACTER VARYING(50) NOT NULL, ogrn NUMERIC(20,0), broker_licence_num CHARACTER VARYING(50), broker_licence_date DATE, vd CHARACTER VARYING(256), licence_end_date DATE, status CHARACTER VARYING(256), vs CHARACTER VARYING(256), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.acc_broker IS 'Справочник: Брокеры';
COMMENT ON COLUMN core.acc_broker.fo IS 'Округ';
COMMENT ON COLUMN core.acc_broker.sf IS 'Регион';
COMMENT ON COLUMN core.acc_broker.reg_num IS 'Регистрационный номер';
COMMENT ON COLUMN core.acc_broker.full_name IS 'Полное наименование';
COMMENT ON COLUMN core.acc_broker.address IS 'Адрес';
COMMENT ON COLUMN core.acc_broker.new_address IS 'Новый адрес';
COMMENT ON COLUMN core.acc_broker.contacts IS 'Контакты';
COMMENT ON COLUMN core.acc_broker.inn IS 'ИНН';
COMMENT ON COLUMN core.acc_broker.ogrn IS 'ОГРН';
COMMENT ON COLUMN core.acc_broker.broker_licence_num IS 'Номер брокерской лицензии';
COMMENT ON COLUMN core.acc_broker.broker_licence_date IS 'Дата брокерской лицензии';
COMMENT ON COLUMN core.acc_broker.vd IS 'Вид деятельности';
COMMENT ON COLUMN core.acc_broker.licence_end_date IS 'Дата окончания лицензии';
COMMENT ON COLUMN core.acc_broker.status IS 'Статус';
COMMENT ON COLUMN core.acc_broker.vs IS 'Вид страхования';
COMMENT ON COLUMN core.acc_broker.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.acc_broker.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.acc_broker.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.acc_counterparty_risk (full_name CHARACTER VARYING(512), inn CHARACTER VARYING(50) NOT NULL, risk CHARACTER VARYING(50) NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.acc_counterparty_risk.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.acc_f162_okato (branch_code CHARACTER VARYING(50) NOT NULL, plan_region CHARACTER VARYING(255), f162_region CHARACTER VARYING(255), f162_okato CHARACTER VARYING(255), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.acc_f162_okato IS 'Справочник: Соответствие подразделения коду ОКАТО субъекта РФ формы 162';
COMMENT ON COLUMN core.acc_f162_okato.branch_code IS 'Код СКК подразделения';
COMMENT ON COLUMN core.acc_f162_okato.plan_region IS 'Наименование планового региона';
COMMENT ON COLUMN core.acc_f162_okato.f162_region IS 'Наименование региона';
COMMENT ON COLUMN core.acc_f162_okato.f162_okato IS 'Код ОКАТО';
COMMENT ON COLUMN core.acc_f162_okato.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.acc_f162_okato.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.acc_f162_okato.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.acc_operation_map (operation_code CHARACTER VARYING(25), operation_code_name CHARACTER VARYING(256), debet_code CHARACTER VARYING(25), debet_code_name CHARACTER VARYING(256), credit_code CHARACTER VARYING(25), credit_code_name CHARACTER VARYING(256), ofr_code CHARACTER VARYING(25), ofr_code_name CHARACTER VARYING(256), start_date DATE, end_date DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.acc_operation_map.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.acc_reserve_group (def_id CHARACTER VARYING(254), dict7gs_id CHARACTER VARYING(7), subject_type_id CHARACTER VARYING(7), reserve_group_id CHARACTER VARYING(254), reserve_group_name CHARACTER VARYING(2000), start_date DATE, end_date DATE, period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.acc_reserve_group IS 'Справочник: Резервные группы АЦ';
COMMENT ON COLUMN core.acc_reserve_group.def_id IS 'Идентификатор';
COMMENT ON COLUMN core.acc_reserve_group.dict7gs_id IS 'Код 7ГС';
COMMENT ON COLUMN core.acc_reserve_group.subject_type_id IS 'Тип субъекта';
COMMENT ON COLUMN core.acc_reserve_group.reserve_group_id IS 'Код резервной группы';
COMMENT ON COLUMN core.acc_reserve_group.reserve_group_name IS 'Наименование резервной группы';
COMMENT ON COLUMN core.acc_reserve_group.start_date IS 'Дата начала';
COMMENT ON COLUMN core.acc_reserve_group.end_date IS 'Дата окончания';
COMMENT ON COLUMN core.acc_reserve_group.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.acc_reserve_group.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.acc_reserve_group.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.account_buh (account_buh_id CHARACTER VARYING(250) NOT NULL, account_operation_id CHARACTER VARYING(250), contract_id CHARACTER VARYING(250), account_buh_date TIMESTAMP(6) WITHOUT TIME ZONE, account_buh_rub NUMERIC(23,2), account_buh_debet_amt NUMERIC(23,2), account_buh_debet_cur CHARACTER VARYING(50), account_buh_credit_amt NUMERIC(23,2), account_buh_credit_cur CHARACTER VARYING(50), debet_code CHARACTER VARYING(50), credit_code CHARACTER VARYING(50), account_doc_id CHARACTER VARYING(50), account_doc1_id CHARACTER VARYING(50), account_doc2_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, debetpersonalaccount CHARACTER VARYING(256), creditpersonalaccount CHARACTER VARYING(256), debet_counterparty_id CHARACTER VARYING(50), credit_counterparty_id CHARACTER VARYING(50), ahd_doc_id CHARACTER VARYING(256), debet_symbol CHARACTER VARYING(40), credit_symbol CHARACTER VARYING(40), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.account_buh IS 'Бухгалтерские операции главной книги';
COMMENT ON COLUMN core.account_buh.account_buh_id IS 'Идентификатор бухгалтерской операций главной книги';
COMMENT ON COLUMN core.account_buh.account_operation_id IS 'Идентификатор бухгалтерской операций';
COMMENT ON COLUMN core.account_buh.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.account_buh.account_buh_date IS 'Дата проводки';
COMMENT ON COLUMN core.account_buh.account_buh_rub IS 'Сумма проводки в рублях';
COMMENT ON COLUMN core.account_buh.account_buh_debet_amt IS 'Сумма в валюте по дебету';
COMMENT ON COLUMN core.account_buh.account_buh_debet_cur IS 'Валюта по дебету';
COMMENT ON COLUMN core.account_buh.account_buh_credit_amt IS 'Сумма в валюте по кредиту';
COMMENT ON COLUMN core.account_buh.account_buh_credit_cur IS 'Валюта по кредиту';
COMMENT ON COLUMN core.account_buh.debet_code IS 'Дебетовый счет';
COMMENT ON COLUMN core.account_buh.credit_code IS 'Кредитовый счет';
COMMENT ON COLUMN core.account_buh.account_doc_id IS 'Документ-основание';
COMMENT ON COLUMN core.account_buh.account_doc1_id IS 'Документ-аналитика 1';
COMMENT ON COLUMN core.account_buh.account_doc2_id IS 'Документ-аналитика 2';
COMMENT ON COLUMN core.account_buh.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.account_buh.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.account_buh.debetpersonalaccount IS 'Дебетовый лицевой счет';
COMMENT ON COLUMN core.account_buh.creditpersonalaccount IS 'Кредитовый лицевой счет';
COMMENT ON COLUMN core.account_buh.debet_counterparty_id IS 'Идентификатор контрагента по дебетовому счёту';
COMMENT ON COLUMN core.account_buh.credit_counterparty_id IS 'Идентификатор контрагента по кредитовому счёту';
COMMENT ON COLUMN core.account_buh.ahd_doc_id IS 'Идентификатор договора с посредником';
COMMENT ON COLUMN core.account_buh.debet_symbol IS 'Символ ОФР дебетового счета';
COMMENT ON COLUMN core.account_buh.credit_symbol IS 'Символ ОФР кредитового счета';
COMMENT ON COLUMN core.account_buh.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.account_buh.key_id IS 'Уникальный ключ';
CREATE TABLE core.account_doc (account_doc_id CHARACTER VARYING(250) NOT NULL, classisn NUMERIC, doc_num CHARACTER VARYING(100), doc_num_ext CHARACTER VARYING(100), account_doc_amt NUMERIC, account_doc_cur CHARACTER VARYING(50), account_doc_rub NUMERIC, period_start DATE, period_end DATE NOT NULL, doc_date TIMESTAMP(6) WITHOUT TIME ZONE, doc_date_beg TIMESTAMP(6) WITHOUT TIME ZONE, doc_date_end TIMESTAMP(6) WITHOUT TIME ZONE, doc_date_reg TIMESTAMP(6) WITHOUT TIME ZONE, doc_date_denounce TIMESTAMP(6) WITHOUT TIME ZONE, doc_num_1c CHARACTER VARYING(40), doc_remark CHARACTER VARYING(4000), counterparty_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.account_doc IS 'Документы по хозяйственной и страховой деятельности';
COMMENT ON COLUMN core.account_doc.account_doc_id IS 'Идентификатор документа';
COMMENT ON COLUMN core.account_doc.classisn IS 'Тип документа';
COMMENT ON COLUMN core.account_doc.doc_num IS 'Номер документа';
COMMENT ON COLUMN core.account_doc.doc_num_ext IS 'Внешний номер документа';
COMMENT ON COLUMN core.account_doc.account_doc_amt IS 'Сумма документа в валюте';
COMMENT ON COLUMN core.account_doc.account_doc_cur IS 'Валюта документа';
COMMENT ON COLUMN core.account_doc.account_doc_rub IS 'Сумма документа';
COMMENT ON COLUMN core.account_doc.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.account_doc.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.account_doc.doc_date IS 'Дата документа';
COMMENT ON COLUMN core.account_doc.doc_date_beg IS 'Дата начала';
COMMENT ON COLUMN core.account_doc.doc_date_end IS 'Дата окончания';
COMMENT ON COLUMN core.account_doc.doc_date_reg IS 'Дата регистрации';
COMMENT ON COLUMN core.account_doc.doc_date_denounce IS 'Дата досрочного прекращения';
COMMENT ON COLUMN core.account_doc.doc_num_1c IS 'Номер документа 1C';
COMMENT ON COLUMN core.account_doc.doc_remark IS 'Ремарка';
COMMENT ON COLUMN core.account_doc.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.account_doc.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.account_doc.key_id IS 'Уникальный ключ';
CREATE TABLE core.account_operation (account_operation_id CHARACTER VARYING(250) NOT NULL, counterparty_id CHARACTER VARYING(250), contract_id CHARACTER VARYING(250), object_risk_id CHARACTER VARYING(250), classisn NUMERIC, classisn2 NUMERIC, discr CHARACTER VARYING(5), insclassisn NUMERIC, deptisn NUMERIC, refdocisn CHARACTER VARYING(50), account_operation_date TIMESTAMP(6) WITHOUT TIME ZONE, account_operation_amt NUMERIC(23,5), account_operation_cur CHARACTER VARYING(50), account_operation_rub NUMERIC(23,5), acc CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, ahd_doc_id CHARACTER VARYING(250), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.account_operation IS 'Начисления и расчеты по договору по БУ и НУ';
COMMENT ON COLUMN core.account_operation.account_operation_id IS 'Идентификатор бухгалтерской операций';
COMMENT ON COLUMN core.account_operation.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.account_operation.contract_id IS 'Идентификатор договора в ядре';
COMMENT ON COLUMN core.account_operation.object_risk_id IS 'Идентификатор риск-объекта';
COMMENT ON COLUMN core.account_operation.classisn IS 'Класс суммы';
COMMENT ON COLUMN core.account_operation.classisn2 IS 'Под класс суммы';
COMMENT ON COLUMN core.account_operation.discr IS 'Тип суммы';
COMMENT ON COLUMN core.account_operation.insclassisn IS 'Код правила для КИАС';
COMMENT ON COLUMN core.account_operation.deptisn IS 'Код подразделения, в котором заключен договор';
COMMENT ON COLUMN core.account_operation.refdocisn IS 'Документ-основание';
COMMENT ON COLUMN core.account_operation.account_operation_date IS 'Дата бухгалтерской проводки';
COMMENT ON COLUMN core.account_operation.account_operation_amt IS 'Сумма в валюте условия договора';
COMMENT ON COLUMN core.account_operation.account_operation_cur IS 'Валюта условия договора';
COMMENT ON COLUMN core.account_operation.account_operation_rub IS 'Сумма проводки в рублях';
COMMENT ON COLUMN core.account_operation.acc IS 'Флаг вида учета: N-налоговый, B-бухгалтерский';
COMMENT ON COLUMN core.account_operation.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.account_operation.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.account_operation.ahd_doc_id IS 'Идентификатор договора с посредником';
COMMENT ON COLUMN core.account_operation.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.account_operation.key_id IS 'Уникальный ключ';
CREATE TABLE core.activity (activity_id CHARACTER VARYING(50) NOT NULL, activity_type_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT now(), key_id UUID NOT NULL, security_review_id CHARACTER VARYING(50), is_not_fraud NUMERIC);
COMMENT ON TABLE core.activity IS 'Таблица задач по убыткам';
COMMENT ON COLUMN core.activity.activity_id IS 'Идентификатор задачи';
COMMENT ON COLUMN core.activity.activity_type_id IS 'Идентификатор типа задачи';
COMMENT ON COLUMN core.activity.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.activity.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.activity.security_review_id IS 'Идентификатор результата проверки департамента по обеспечению безопасности (ссылка на ref_security_review)';
COMMENT ON COLUMN core.activity.is_not_fraud IS 'Признак "Мошенничество не доказано" 1 - да, 0 - нет, -1 - не определено';
CREATE TABLE core.address (address_id CHARACTER VARYING(50) NOT NULL, exact_address CHARACTER VARYING(4000), zip CHARACTER VARYING(50), region_type TEXT, region TEXT, area_type TEXT, area TEXT, city_type TEXT, city TEXT, district_type TEXT, district TEXT, place TEXT, street_type TEXT, street TEXT, house CHARACTER VARYING(50), block CHARACTER VARYING(50), apartment CHARACTER VARYING(120), kladr_code TEXT, okato_code CHARACTER VARYING(50), fias_code TEXT, period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, hash CHARACTER VARYING(32), modify_date TIMESTAMP(6) WITHOUT TIME ZONE, building CHARACTER VARYING(50), room CHARACTER VARYING(40), geo_longitude CHARACTER VARYING(20), geo_latitude CHARACTER VARYING(20), geo_quality_code CHARACTER VARYING(20), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.address IS 'Адрес';
COMMENT ON COLUMN core.address.address_id IS 'Идентификатор адреса';
COMMENT ON COLUMN core.address.exact_address IS 'Строка адреса';
COMMENT ON COLUMN core.address.zip IS 'Почтовый индекс';
COMMENT ON COLUMN core.address.region_type IS 'Тип региона';
COMMENT ON COLUMN core.address.region IS 'Регион';
COMMENT ON COLUMN core.address.area_type IS 'Тип района';
COMMENT ON COLUMN core.address.area IS 'Район';
COMMENT ON COLUMN core.address.city_type IS 'Тип город';
COMMENT ON COLUMN core.address.city IS 'Город';
COMMENT ON COLUMN core.address.district_type IS 'Тип населенный пункт';
COMMENT ON COLUMN core.address.district IS 'Населенный пункт';
COMMENT ON COLUMN core.address.place IS 'Планировочная структура';
COMMENT ON COLUMN core.address.street_type IS 'Тип улицы';
COMMENT ON COLUMN core.address.street IS 'Улица';
COMMENT ON COLUMN core.address.house IS 'Номер дома';
COMMENT ON COLUMN core.address.block IS 'Корпус';
COMMENT ON COLUMN core.address.apartment IS 'Квартира';
COMMENT ON COLUMN core.address.kladr_code IS 'Код КЛАДР';
COMMENT ON COLUMN core.address.okato_code IS 'Код ОКАТО';
COMMENT ON COLUMN core.address.fias_code IS 'Код ФИАС';
COMMENT ON COLUMN core.address.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.address.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.address.hash IS 'Хэш';
COMMENT ON COLUMN core.address.modify_date IS 'Дата модификации';
COMMENT ON COLUMN core.address.building IS 'Строение';
COMMENT ON COLUMN core.address.room IS 'Комната';
COMMENT ON COLUMN core.address.geo_longitude IS 'Долгота';
COMMENT ON COLUMN core.address.geo_latitude IS 'Широта';
COMMENT ON COLUMN core.address.geo_quality_code IS 'Код качества геоданных';
COMMENT ON COLUMN core.address.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.address.key_id IS 'Уникальный ключ';
CREATE TABLE core.address_links (address_links_id BIGSERIAL NOT NULL, address_id CHARACTER VARYING(50), address_type CHARACTER VARYING(50), address_subject_id CHARACTER VARYING(50), address_subject_type CHARACTER VARYING(50), period_start DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, is_main_address NUMERIC(1,0), is_active_address NUMERIC(1,0), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.address_links IS 'Адрес застрахованных';
COMMENT ON COLUMN core.address_links.address_links_id IS 'Уникальный идентификатор записи';
COMMENT ON COLUMN core.address_links.address_id IS 'Идентификатор адреса';
COMMENT ON COLUMN core.address_links.address_type IS 'Тип адреса';
COMMENT ON COLUMN core.address_links.address_subject_id IS 'Идентификатор застрахованного объекта';
COMMENT ON COLUMN core.address_links.address_subject_type IS 'Тип застрахованного объекта';
COMMENT ON COLUMN core.address_links.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.address_links.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.address_links.modify_date IS 'Дата модификации';
COMMENT ON COLUMN core.address_links.is_main_address IS 'Признак адреса «Основной/Дополнительный»: 1 - Основной, 0 – Дополнительный, -1 не определен';
COMMENT ON COLUMN core.address_links.is_active_address IS 'Признак адреса «Активный/Неактивный»: 1 - Активный, 0 – Неактивный, -1 не определен';
COMMENT ON COLUMN core.address_links.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.address_links.key_id IS 'Уникальный ключ';
CREATE TABLE core.address_parsed (address_id CHARACTER VARYING(255) NOT NULL, exact_address CHARACTER VARYING(1100), zip CHARACTER VARYING(20), region_type CHARACTER VARYING(100), region CHARACTER VARYING(100), area_type CHARACTER VARYING(100), area CHARACTER VARYING(100), city_type CHARACTER VARYING(100), city CHARACTER VARYING(100), district_type CHARACTER VARYING(100), district CHARACTER VARYING(250), street_type CHARACTER VARYING(100), street CHARACTER VARYING(150), house CHARACTER VARYING(100), block CHARACTER VARYING(100), building CHARACTER VARYING(100), apartment CHARACTER VARYING(100), room CHARACTER VARYING(100), kladr_code CHARACTER VARYING(100), okato_code CHARACTER VARYING(100), fias_code CHARACTER VARYING(50), geo_longitude CHARACTER VARYING(20), geo_latitude CHARACTER VARYING(20), geo_quality_code CHARACTER VARYING(20), source_period_start DATE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON COLUMN core.address_parsed.address_id IS 'Идентификатор адреса в системе-источнике';
COMMENT ON COLUMN core.address_parsed.exact_address IS 'Исходное значение адреса (одной строкой)';
COMMENT ON COLUMN core.address_parsed.zip IS 'Почтовый индекс';
COMMENT ON COLUMN core.address_parsed.region_type IS 'Тип региона';
COMMENT ON COLUMN core.address_parsed.region IS 'Регион';
COMMENT ON COLUMN core.address_parsed.area_type IS 'Тип района в регионе';
COMMENT ON COLUMN core.address_parsed.area IS 'Район в регионе';
COMMENT ON COLUMN core.address_parsed.city_type IS 'Тип города';
COMMENT ON COLUMN core.address_parsed.city IS 'Город';
COMMENT ON COLUMN core.address_parsed.district_type IS 'Тип населённого пункта';
COMMENT ON COLUMN core.address_parsed.district IS 'Населённый пункт';
COMMENT ON COLUMN core.address_parsed.street_type IS 'Тип улицы';
COMMENT ON COLUMN core.address_parsed.street IS 'Улица';
COMMENT ON COLUMN core.address_parsed.house IS 'Дом';
COMMENT ON COLUMN core.address_parsed.block IS 'Корпус';
COMMENT ON COLUMN core.address_parsed.building IS 'Строение';
COMMENT ON COLUMN core.address_parsed.apartment IS 'Квартира';
COMMENT ON COLUMN core.address_parsed.room IS 'Комната';
COMMENT ON COLUMN core.address_parsed.kladr_code IS 'Код КЛАДР (Классификатор адресов РФ)';
COMMENT ON COLUMN core.address_parsed.okato_code IS 'Код ОКАТО (Общероссийский классификатор административно-территориальных образований)';
COMMENT ON COLUMN core.address_parsed.fias_code IS 'Код ФИАС (Федеральная информационная адресная система)';
COMMENT ON COLUMN core.address_parsed.geo_longitude IS 'Долгота';
COMMENT ON COLUMN core.address_parsed.geo_latitude IS 'Широта';
COMMENT ON COLUMN core.address_parsed.geo_quality_code IS 'Код качества геокодирования (литера)';
COMMENT ON COLUMN core.address_parsed.source_period_start IS 'Дата начала действия записи из core.address';
COMMENT ON COLUMN core.address_parsed.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.address_parsed.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.address_parsed.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.address_parsed.key_id IS 'Уникальный ключ';
CREATE TABLE core.agent_contract (agent_contract_id CHARACTER VARYING(50) NOT NULL, contract_number CHARACTER VARYING(50), contract_start_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_end_date TIMESTAMP(6) WITHOUT TIME ZONE, agent_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), status_code CHARACTER VARYING(80), status_name CHARACTER VARYING(120), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, agent_status_id CHARACTER VARYING(50), agent_status_date DATE);
COMMENT ON TABLE core.agent_contract IS 'Агентский договор';
COMMENT ON COLUMN core.agent_contract.agent_contract_id IS 'Идентификатор договора агента';
COMMENT ON COLUMN core.agent_contract.contract_number IS 'Номер договора';
COMMENT ON COLUMN core.agent_contract.contract_start_date IS 'Дата начала договора';
COMMENT ON COLUMN core.agent_contract.contract_end_date IS 'Дата окончания договора';
COMMENT ON COLUMN core.agent_contract.agent_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.agent_contract.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.agent_contract.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.agent_contract.hash IS 'Хэш';
COMMENT ON COLUMN core.agent_contract.status_code IS 'Код статуса';
COMMENT ON COLUMN core.agent_contract.status_name IS 'Наименование статуса';
COMMENT ON COLUMN core.agent_contract.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.agent_contract.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.agent_contract.agent_status_id IS 'Идентификатор статуса агента';
COMMENT ON COLUMN core.agent_contract.agent_status_date IS 'Дата статуса агента';
CREATE TABLE core.agent_contract_addendum (agent_contract_addendum_id CHARACTER VARYING(50) NOT NULL, agent_contract_id CHARACTER VARYING(50), supervisor_id CHARACTER VARYING(50), addendum_number CHARACTER VARYING(100), addendum_date DATE, addendum_reason_id CHARACTER VARYING(50), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT now(), key_id UUID NOT NULL);
COMMENT ON TABLE core.agent_contract_addendum IS 'Дополнительное соглашение к агентскому договору';
COMMENT ON COLUMN core.agent_contract_addendum.agent_contract_addendum_id IS 'Идентификатор дополнительного соглашения';
COMMENT ON COLUMN core.agent_contract_addendum.agent_contract_id IS 'Идентификатор агентского договора';
COMMENT ON COLUMN core.agent_contract_addendum.supervisor_id IS 'Куратор по договору';
COMMENT ON COLUMN core.agent_contract_addendum.addendum_number IS 'Номер дополнительного соглашения';
COMMENT ON COLUMN core.agent_contract_addendum.addendum_date IS 'Дата подписания агентского соглашения';
COMMENT ON COLUMN core.agent_contract_addendum.addendum_reason_id IS 'Причина создания';
COMMENT ON COLUMN core.agent_contract_addendum.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.agent_contract_addendum.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.agent_contract_addendum.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.agent_contract_addendum.key_id IS 'Уникальный ключ';
CREATE TABLE core.agent_invoice (agent_invoice_id CHARACTER VARYING(50) NOT NULL, agent_invoice_number CHARACTER VARYING(250), creation_date DATE, counterparty_id CHARACTER VARYING(50), agent_contract_id CHARACTER VARYING(50), commission_rub_amt NUMERIC(36,2), payment_rub_amt NUMERIC(36,2), total_sum_amt NUMERIC(36,2), invoice_status_id CHARACTER VARYING(50), is_for_matching INTEGER, branch_scc_id CHARACTER VARYING(50), payment_method_id CHARACTER VARYING(50), matched_rub_amt NUMERIC(36,2), type_name CHARACTER VARYING(50), sale_channel_type_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, agent_report_id CHARACTER VARYING(50));
COMMENT ON TABLE core.agent_invoice IS 'Клиентские и Агентские Счета';
COMMENT ON COLUMN core.agent_invoice.agent_invoice_id IS 'Идентификатор счета';
COMMENT ON COLUMN core.agent_invoice.agent_invoice_number IS 'Номер счета';
COMMENT ON COLUMN core.agent_invoice.creation_date IS 'Дата счета';
COMMENT ON COLUMN core.agent_invoice.counterparty_id IS 'Идентификатор агента (Ссылка на core.counterparty.counterparty_id)';
COMMENT ON COLUMN core.agent_invoice.agent_contract_id IS 'Идентификатор договора агента';
COMMENT ON COLUMN core.agent_invoice.commission_rub_amt IS 'Сумма удержанной комиссии в рублях';
COMMENT ON COLUMN core.agent_invoice.payment_rub_amt IS 'Сумма полученная по счету в рублях';
COMMENT ON COLUMN core.agent_invoice.total_sum_amt IS 'Сумма счета в рублях';
COMMENT ON COLUMN core.agent_invoice.invoice_status_id IS 'Идентификатор статуса счета (Ссылка на справочник core.ref_invoice_status)';
COMMENT ON COLUMN core.agent_invoice.is_for_matching IS 'Статус готовности счета для квитования: 1 - готов к квитованию; 0 - не готов к квитованию';
COMMENT ON COLUMN core.agent_invoice.branch_scc_id IS 'Код подразделения, в котором оформлен счет (Ссылка на ref_branches.scc_id)';
COMMENT ON COLUMN core.agent_invoice.payment_method_id IS 'Идентификатор метода оплаты';
COMMENT ON COLUMN core.agent_invoice.matched_rub_amt IS 'Сумма сквитованная в рублях';
COMMENT ON COLUMN core.agent_invoice.type_name IS 'Тип счета';
COMMENT ON COLUMN core.agent_invoice.sale_channel_type_id IS 'Код канала продаж на счете (ссылка на справочник core.sale_channel_type.sale_channel_type_id)';
COMMENT ON COLUMN core.agent_invoice.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.agent_invoice.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.agent_invoice.agent_report_id IS 'Идентификатор отчёта агента (ссылка на core.agent_report)';
CREATE TABLE core.agent_invoice_link (agent_invoice_link_id CHARACTER VARYING(50) NOT NULL, agent_invoice_id CHARACTER VARYING(50), to_agent_invoice_id CHARACTER VARYING(50), agent_invoice_link_type_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.agent_invoice_link IS 'Связь счетов';
COMMENT ON COLUMN core.agent_invoice_link.agent_invoice_link_id IS 'Идентификатор связи';
COMMENT ON COLUMN core.agent_invoice_link.agent_invoice_id IS 'Идентификатор счета';
COMMENT ON COLUMN core.agent_invoice_link.to_agent_invoice_id IS 'Идентификатор связанного счета (генерального)';
COMMENT ON COLUMN core.agent_invoice_link.agent_invoice_link_type_id IS 'Идентификатор типа связи (ссылка на  core.ref_agent_invoice_link_type)';
COMMENT ON COLUMN core.agent_invoice_link.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.agent_invoice_link.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.agent_invoice_link.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.agent_invoice_link.key_id IS 'Уникальный ключ';
CREATE TABLE core.agent_report (agent_report_id CHARACTER VARYING(50) NOT NULL, report_number CHARACTER VARYING(50), creation_date DATE, counterparty_id CHARACTER VARYING(50), agent_contract_id CHARACTER VARYING(50), commission_rub_amt NUMERIC(36,2), payment_rub_amt NUMERIC(36,2), total_rub_amt NUMERIC(36,2), matched_rub_amt NUMERIC(36,2), file_link CHARACTER VARYING(50), is_for_matching INTEGER, branch_scc_id CHARACTER VARYING(25), payment_method_id CHARACTER VARYING(50), is_digital SMALLINT, tessa_package CHARACTER VARYING(255), sale_channel_type_id CHARACTER VARYING(7), agent_report_status_id CHARACTER VARYING(50), is_with_retention SMALLINT, agent_report_matching_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.agent_report IS 'Отчет агента АПП';
COMMENT ON COLUMN core.agent_report.agent_report_id IS 'Идентификатор отчёта агента';
COMMENT ON COLUMN core.agent_report.report_number IS 'Номер отчёта агента';
COMMENT ON COLUMN core.agent_report.creation_date IS 'Дата создания отчёта агента';
COMMENT ON COLUMN core.agent_report.counterparty_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.agent_report.agent_contract_id IS 'Идентификатор договора агента';
COMMENT ON COLUMN core.agent_report.commission_rub_amt IS 'Сумма удержанной комиссии в рублях';
COMMENT ON COLUMN core.agent_report.payment_rub_amt IS 'Сумма страховой премии, полученная по отчёту агента в рублях';
COMMENT ON COLUMN core.agent_report.total_rub_amt IS 'Сумма отчета агента в рублях';
COMMENT ON COLUMN core.agent_report.matched_rub_amt IS 'Сквитованная сумма';
COMMENT ON COLUMN core.agent_report.file_link IS 'Идентификатор файла скана отчёта агента';
COMMENT ON COLUMN core.agent_report.is_for_matching IS 'Признак готовности статуса отчёта агента к квитованию: 1 - готов; 0 - не готов';
COMMENT ON COLUMN core.agent_report.branch_scc_id IS 'Код подразделения, в котором оформлен отчет агента (core.ref_branches.scc_id)';
COMMENT ON COLUMN core.agent_report.payment_method_id IS 'Идентификатор метода оплаты (core.ref_payment_method)';
COMMENT ON COLUMN core.agent_report.is_digital IS 'Признак цифрового отчета агента: 1 - цифровой; 0 - не цифровой';
COMMENT ON COLUMN core.agent_report.tessa_package IS 'Номер пакета для отчет агента в системе Тесса';
COMMENT ON COLUMN core.agent_report.sale_channel_type_id IS 'Код канала продаж АПП (ОА) (core.sale_channel_type.sale_channel_type_id)';
COMMENT ON COLUMN core.agent_report.agent_report_status_id IS 'Идентификатор статуса отчета агента (core.ref_agent_report_status)';
COMMENT ON COLUMN core.agent_report.is_with_retention IS 'Признак удержания КВ: 0 – без удержания; 1 – с удержанием';
COMMENT ON COLUMN core.agent_report.agent_report_matching_id IS 'Идентификатор истории отправки ОА на квитование (core.agent_report_matching)';
COMMENT ON COLUMN core.agent_report.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.agent_report.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.agent_report.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.agent_report.key_id IS 'Уникальный ключ';
CREATE TABLE core.agent_report_matching (agent_report_matching_id CHARACTER VARYING(50) NOT NULL, send_date TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp(), key_id UUID NOT NULL);
COMMENT ON TABLE core.agent_report_matching IS 'История отправки ОА на квитование';
COMMENT ON COLUMN core.agent_report_matching.agent_report_matching_id IS 'Идентификатор истории отправки ОА на квитование';
COMMENT ON COLUMN core.agent_report_matching.send_date IS 'Дата отправки ОА на квитование';
COMMENT ON COLUMN core.agent_report_matching.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.agent_report_matching.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.agent_report_matching.key_id IS 'Уникальный ключ';
CREATE TABLE core.agent_statement (agent_statement_id CHARACTER VARYING(50) NOT NULL, statement_number CHARACTER VARYING(50), statement_date DATE, agent_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), agent_contract_id CHARACTER VARYING(50), commission_deducted_rub NUMERIC(36,2), payment_sum_rub NUMERIC(36,2), file_id CHARACTER VARYING(50), status INTEGER, bid CHARACTER VARYING(25), app_number CHARACTER VARYING(255), agent_status_name CHARACTER VARYING(512), agent_status_date DATE, payment_method_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, is_digital SMALLINT, tessa_package CHARACTER VARYING(255));
COMMENT ON TABLE core.agent_statement IS 'Отчет агента';
COMMENT ON COLUMN core.agent_statement.agent_statement_id IS 'Идентификатор отчёта агента';
COMMENT ON COLUMN core.agent_statement.statement_number IS 'Номер отчёта агента';
COMMENT ON COLUMN core.agent_statement.statement_date IS 'Дата отчёта агента';
COMMENT ON COLUMN core.agent_statement.agent_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.agent_statement.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.agent_statement.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.agent_statement.hash IS 'Хэш';
COMMENT ON COLUMN core.agent_statement.agent_contract_id IS 'Идентификатор договора агента';
COMMENT ON COLUMN core.agent_statement.commission_deducted_rub IS 'Сумма удержанной комиссии в рублях';
COMMENT ON COLUMN core.agent_statement.payment_sum_rub IS 'Сумма полученная по отчёту агента в рублях';
COMMENT ON COLUMN core.agent_statement.file_id IS 'Идентификатор файла скана отчёта агента';
COMMENT ON COLUMN core.agent_statement.status IS 'Статус отчёта агента: 1 - готов к квитованию; 0 - не готов к квитованию.';
COMMENT ON COLUMN core.agent_statement.bid IS 'Код подразделения, в котором оформлен отчет агента';
COMMENT ON COLUMN core.agent_statement.app_number IS 'Номер акта приема-передачи';
COMMENT ON COLUMN core.agent_statement.agent_status_name IS 'Статус агента';
COMMENT ON COLUMN core.agent_statement.agent_status_date IS 'Дата статуса агента';
COMMENT ON COLUMN core.agent_statement.payment_method_id IS 'Идентификатор метода оплаты';
COMMENT ON COLUMN core.agent_statement.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.agent_statement.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.agent_statement.is_digital IS 'Признак цифрового отчета агента: (1 - отчет агента цифровой, 0 - отчет агента не цифровой)';
COMMENT ON COLUMN core.agent_statement.tessa_package IS 'Номер пакета для отчет агента в системе Тесса';
CREATE TABLE core.agreement (agreement_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), agent_id CHARACTER VARYING(50), agent_statement_id CHARACTER VARYING(50), agreement_series CHARACTER VARYING(50), agreement_number CHARACTER VARYING(250), agreement_date TIMESTAMP(6) WITHOUT TIME ZONE, agreement_start_date TIMESTAMP(6) WITHOUT TIME ZONE, agreement_end_date TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), agreement_type CHARACTER VARYING(100), agreement_reason CHARACTER VARYING(2048), insert_date TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.agreement IS 'Дополнительное соглашение';
COMMENT ON COLUMN core.agreement.agreement_id IS 'Идентификатор дополнительного соглашения';
COMMENT ON COLUMN core.agreement.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.agreement.agent_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.agreement.agent_statement_id IS 'Идентификатор отчёта агента';
COMMENT ON COLUMN core.agreement.agreement_series IS 'Серия дополнительного соглашения';
COMMENT ON COLUMN core.agreement.agreement_number IS 'Номер дополнительного соглашения';
COMMENT ON COLUMN core.agreement.agreement_date IS 'Дата дополнительного соглашения';
COMMENT ON COLUMN core.agreement.agreement_start_date IS 'Дата начала действия дополнительного соглашения';
COMMENT ON COLUMN core.agreement.agreement_end_date IS 'Дата окончания действия дополнительного соглашения';
COMMENT ON COLUMN core.agreement.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.agreement.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.agreement.hash IS 'Хэш';
COMMENT ON COLUMN core.agreement.agreement_type IS 'Тип дополнительного соглашения';
COMMENT ON COLUMN core.agreement.agreement_reason IS 'Причина заключения дополнительного соглашения';
COMMENT ON COLUMN core.agreement.insert_date IS 'Дата/время добавления записи в исходную систему';
COMMENT ON COLUMN core.agreement.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.agreement.key_id IS 'Уникальный ключ';
CREATE TABLE core.alarmguard_insured_vehicle (alarmguard_insured_vehicle_id CHARACTER VARYING(50) NOT NULL, insured_vehicle_id CHARACTER VARYING(50), alarm_guard_id CHARACTER VARYING(7), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.alarmguard_insured_vehicle IS 'Противоугонные устройства (ПУС) застрахованных транспортных средств';
COMMENT ON COLUMN core.alarmguard_insured_vehicle.alarmguard_insured_vehicle_id IS 'Идентификатор ПУС застрахованных ТС';
COMMENT ON COLUMN core.alarmguard_insured_vehicle.insured_vehicle_id IS 'Идентификатор застрахованного транспортного средства';
COMMENT ON COLUMN core.alarmguard_insured_vehicle.alarm_guard_id IS 'Идентификатор противоугонного устройства (ПУС)';
COMMENT ON COLUMN core.alarmguard_insured_vehicle.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.alarmguard_insured_vehicle.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.alarmguard_insured_vehicle.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.alarmguard_insured_vehicle.key_id IS 'Уникальный ключ';
CREATE TABLE core.auto_dealer (scc_id NUMERIC(38,0), auto_dealer_id CHARACTER VARYING(7) NOT NULL, auto_dealer_name CHARACTER VARYING(255), federal_partner_name CHARACTER VARYING(255), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.auto_dealer IS 'Cправочник Автодилеры (СКК 7.4.20)';
COMMENT ON COLUMN core.auto_dealer.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.auto_dealer.auto_dealer_id IS 'Код автодилера';
COMMENT ON COLUMN core.auto_dealer.auto_dealer_name IS 'Наименование автодилера';
COMMENT ON COLUMN core.auto_dealer.federal_partner_name IS 'Федеральный партнер';
COMMENT ON COLUMN core.auto_dealer.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.auto_dealer.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.auto_dealer.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.avto_usage (contract_id CHARACTER VARYING(50) NOT NULL, start_date1 DATE, end_date1 DATE, start_date2 DATE, end_date2 DATE, start_date3 DATE, end_date3 DATE, period_start DATE NOT NULL, period_end DATE NOT NULL, hash CHARACTER VARYING(32), avto_usage_id BIGINT NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.avto_usage IS 'Период использования ТС';
COMMENT ON COLUMN core.avto_usage.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.avto_usage.start_date1 IS 'Дата начала 1-го периода использования';
COMMENT ON COLUMN core.avto_usage.end_date1 IS 'Дата окончания 1-го периода использования';
COMMENT ON COLUMN core.avto_usage.start_date2 IS 'Дата начала 2-го периода использования';
COMMENT ON COLUMN core.avto_usage.end_date2 IS 'Дата окончания 2-го периода использования';
COMMENT ON COLUMN core.avto_usage.start_date3 IS 'Дата начала 3-го периода использования';
COMMENT ON COLUMN core.avto_usage.end_date3 IS 'Дата окончания 3-го периода использования';
COMMENT ON COLUMN core.avto_usage.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.avto_usage.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.avto_usage.hash IS 'Хэш';
COMMENT ON COLUMN core.avto_usage.avto_usage_id IS 'Идентификатор периода использования';
COMMENT ON COLUMN core.avto_usage.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.avto_usage.key_id IS 'Уникальный ключ';
CREATE TABLE core.bank (scc_id NUMERIC(38,0), bank_code CHARACTER VARYING(5) NOT NULL, bank_name CHARACTER VARYING(255), bank_name_full CHARACTER VARYING(1000), bank_adress CHARACTER VARYING(1000), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.bank IS 'Справочник Банки (СКК 7.6.37)';
COMMENT ON COLUMN core.bank.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.bank.bank_code IS 'Код банка';
COMMENT ON COLUMN core.bank.bank_name IS 'Краткое наименование банка';
COMMENT ON COLUMN core.bank.bank_name_full IS 'Полное наименование банка';
COMMENT ON COLUMN core.bank.bank_adress IS 'Адрес';
COMMENT ON COLUMN core.bank.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.bank.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.bank.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.bank_account (bank_account_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), modify_date TIMESTAMP(6) WITHOUT TIME ZONE, account_number CHARACTER VARYING(50), bik CHARACTER VARYING(50), bank CHARACTER VARYING(512), personal_account CHARACTER VARYING(100), correspondent_account CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.bank_account IS 'Расчетный счет';
COMMENT ON COLUMN core.bank_account.bank_account_id IS 'Идентификатор расчетного счета';
COMMENT ON COLUMN core.bank_account.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.bank_account.modify_date IS 'Дата актуальности';
COMMENT ON COLUMN core.bank_account.account_number IS 'Номер расчетного счета';
COMMENT ON COLUMN core.bank_account.bik IS 'БИК банка';
COMMENT ON COLUMN core.bank_account.bank IS 'Наименование банка';
COMMENT ON COLUMN core.bank_account.personal_account IS 'Номер лицевого счета';
COMMENT ON COLUMN core.bank_account.correspondent_account IS 'Корреспондентский счет';
COMMENT ON COLUMN core.bank_account.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.bank_account.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.bank_account.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.bank_account.key_id IS 'Уникальный ключ';
CREATE TABLE core.bordereau (bordereau_id CHARACTER VARYING(50) NOT NULL, bordereau_number CHARACTER VARYING(100), paper_id CHARACTER VARYING(50), bordereau_type_id CHARACTER VARYING(150), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.bordereau IS 'Разделы бордеро';
COMMENT ON COLUMN core.bordereau.bordereau_id IS 'ID бордеро (первичный ключ)';
COMMENT ON COLUMN core.bordereau.bordereau_number IS 'Номер бордеро';
COMMENT ON COLUMN core.bordereau.paper_id IS 'ID акта взаиморасчетов (внешний ключ на табл. paper)';
COMMENT ON COLUMN core.bordereau.bordereau_type_id IS 'Тип бордеро';
COMMENT ON COLUMN core.bordereau.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.bordereau.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.bordereau.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.bordereau.key_id IS 'Уникальный ключ';
CREATE TABLE core.branch_organization_type (scc_id NUMERIC(38,0), full_name CHARACTER VARYING(165), short_name CHARACTER VARYING(254), code CHARACTER VARYING(2), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.branch_organization_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.branches (scc_id NUMERIC(38,0) NOT NULL, email CHARACTER VARYING(100), bid CHARACTER VARYING(5), phones CHARACTER VARYING(200), full_name CHARACTER VARYING(2000), branch_code CHARACTER VARYING(8), address CHARACTER VARYING(200), subject_federation_code CHARACTER VARYING(2), organization_type_code CHARACTER VARYING(2), federal_district_code CHARACTER VARYING(1), parent_scc_id NUMERIC(38,0), filial_code CHARACTER VARYING(8), filial_name CHARACTER VARYING(2000), holding_company_code CHARACTER VARYING(8), holding_company_name CHARACTER VARYING(2000), planning_region_name CHARACTER VARYING(2000), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.branches IS 'Подразделения';
COMMENT ON COLUMN core.branches.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.branches.email IS 'Электронная почта';
COMMENT ON COLUMN core.branches.bid IS 'Код МП';
COMMENT ON COLUMN core.branches.phones IS 'Телефон';
COMMENT ON COLUMN core.branches.full_name IS 'Наименование';
COMMENT ON COLUMN core.branches.branch_code IS 'Код СКК подразделения';
COMMENT ON COLUMN core.branches.address IS 'Адрес';
COMMENT ON COLUMN core.branches.subject_federation_code IS 'Код субъекта';
COMMENT ON COLUMN core.branches.organization_type_code IS 'Код организационной формы';
COMMENT ON COLUMN core.branches.federal_district_code IS 'Код района';
COMMENT ON COLUMN core.branches.parent_scc_id IS 'Идентификатор родителя';
COMMENT ON COLUMN core.branches.filial_code IS 'Код СКК филиала';
COMMENT ON COLUMN core.branches.filial_name IS 'Наименование филиала';
COMMENT ON COLUMN core.branches.holding_company_code IS 'Код СКК компании';
COMMENT ON COLUMN core.branches.holding_company_name IS 'Наименование компании';
COMMENT ON COLUMN core.branches.planning_region_name IS 'Наименование планового региона';
COMMENT ON COLUMN core.branches.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.branches.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.branches.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.business_act (business_act_id CHARACTER VARYING(50) NOT NULL, business_act_number CHARACTER VARYING(100), creation_type_id CHARACTER VARYING(50), user_creator_log CHARACTER VARYING(50), creation_ts TIMESTAMP(6) WITHOUT TIME ZONE, lock_ts TIMESTAMP(6) WITHOUT TIME ZONE, approval_ts TIMESTAMP(6) WITHOUT TIME ZONE, external_act_number CHARACTER VARYING(100), is_with_retention INTEGER, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp(), key_id UUID NOT NULL);
COMMENT ON TABLE core.business_act IS 'Акты выполненных работ';
COMMENT ON COLUMN core.business_act.business_act_id IS 'Идентификатор бизнес акта';
COMMENT ON COLUMN core.business_act.business_act_number IS 'Номер бизнес акта';
COMMENT ON COLUMN core.business_act.creation_type_id IS 'Тип создания  бизнес акта (Ссылка на справочник ref_creation_type)';
COMMENT ON COLUMN core.business_act.user_creator_log IS 'Логин пользователя создателя бизнес акта';
COMMENT ON COLUMN core.business_act.creation_ts IS 'Дата создания';
COMMENT ON COLUMN core.business_act.lock_ts IS 'Дата блокировки';
COMMENT ON COLUMN core.business_act.approval_ts IS 'Дата утверждения';
COMMENT ON COLUMN core.business_act.external_act_number IS 'Внешний номер бизнес акта';
COMMENT ON COLUMN core.business_act.is_with_retention IS 'Признак удержания комиссии агентом из страховой премии';
COMMENT ON COLUMN core.business_act.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.business_act.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.business_act.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.business_act.key_id IS 'Уникальный ключ';
CREATE TABLE core.calendar (calendar_date TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, is_day_off SMALLINT, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.calendar IS 'Справочник: Производственный календарь';
COMMENT ON COLUMN core.calendar.calendar_date IS 'Дата';
COMMENT ON COLUMN core.calendar.is_day_off IS 'Признак выходного/праздничного дня';
COMMENT ON COLUMN core.calendar.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.calendar.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.calendar.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.cancel_storno (cancel_storno_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), cancel_date TIMESTAMP(6) WITHOUT TIME ZONE, cancel_cntr_amt NUMERIC(38,2), cancel_cntr_cur CHARACTER VARYING(7), cancel_cntr_rub NUMERIC(38,2), cancel_amt NUMERIC(38,2), cancel_cur CHARACTER VARYING(7), cancel_rub NUMERIC(38,2), cur_rate_date DATE, cur_rate NUMERIC(38,4), hash CHARACTER VARYING(32), period_start DATE, period_end DATE NOT NULL, is_10601 INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, storno_date TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.cancel_storno IS 'Сторнирование по расторжению';
COMMENT ON COLUMN core.cancel_storno.cancel_storno_id IS 'Идентификатор сторнирования по расторжению';
COMMENT ON COLUMN core.cancel_storno.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.cancel_storno.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.cancel_storno.cancel_date IS 'Дата расторжения';
COMMENT ON COLUMN core.cancel_storno.cancel_cntr_amt IS 'Сумма сторнирования по договору';
COMMENT ON COLUMN core.cancel_storno.cancel_cntr_cur IS 'Код валюты';
COMMENT ON COLUMN core.cancel_storno.cancel_cntr_rub IS 'Сумма сторнирования по договору в рублях';
COMMENT ON COLUMN core.cancel_storno.cancel_amt IS 'Сумма сторнирования по риску';
COMMENT ON COLUMN core.cancel_storno.cancel_cur IS 'Код валюты';
COMMENT ON COLUMN core.cancel_storno.cancel_rub IS 'Сумма сторнирования по риску в рублях';
COMMENT ON COLUMN core.cancel_storno.cur_rate_date IS 'Дата определения курса';
COMMENT ON COLUMN core.cancel_storno.hash IS 'Хэш';
COMMENT ON COLUMN core.cancel_storno.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.cancel_storno.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.cancel_storno.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.cancel_storno.key_id IS 'Уникальный ключ';
CREATE TABLE core.cancel_storno_long (cancel_storno_long_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), cancel_date DATE, cancel_cntr_amt NUMERIC(36,2), cancel_cntr_cur CHARACTER VARYING(7), cancel_cntr_rub NUMERIC(36,2), cancel_amt NUMERIC(36,2), cancel_cur CHARACTER VARYING(7), cancel_rub NUMERIC(36,2), cur_rate_date DATE, period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), contract_long_id CHARACTER VARYING(50), object_risk_long_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.cancel_storno_long IS 'Сторнирование по расторжению для многолетних договоров';
COMMENT ON COLUMN core.cancel_storno_long.cancel_storno_long_id IS 'Идентификатор сторнирования по расторжению многолетнего договора';
COMMENT ON COLUMN core.cancel_storno_long.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.cancel_storno_long.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.cancel_storno_long.cancel_date IS 'Дата расторжения';
COMMENT ON COLUMN core.cancel_storno_long.cancel_cntr_amt IS 'Сумма сторнирования по договору';
COMMENT ON COLUMN core.cancel_storno_long.cancel_cntr_cur IS 'Код валюты';
COMMENT ON COLUMN core.cancel_storno_long.cancel_cntr_rub IS 'Сумма сторнирования по договору в рублях';
COMMENT ON COLUMN core.cancel_storno_long.cancel_amt IS 'Сумма сторнирования по риску';
COMMENT ON COLUMN core.cancel_storno_long.cancel_cur IS 'Код валюты';
COMMENT ON COLUMN core.cancel_storno_long.cancel_rub IS 'Сумма сторнирования по риску в рублях';
COMMENT ON COLUMN core.cancel_storno_long.cur_rate_date IS 'Дата определения курса';
COMMENT ON COLUMN core.cancel_storno_long.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.cancel_storno_long.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.cancel_storno_long.hash IS 'Хэш';
COMMENT ON COLUMN core.cancel_storno_long.contract_long_id IS 'Идентификатор многолетнего условного договора';
COMMENT ON COLUMN core.cancel_storno_long.object_risk_long_id IS 'Идентификатор риска по объекту для многолетнего условного договора';
COMMENT ON COLUMN core.cancel_storno_long.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.cancel_storno_long.key_id IS 'Уникальный ключ';
CREATE TABLE core.cdi_address_quality (validation_code CHARACTER VARYING(50), quality_code CHARACTER VARYING(50), period_start DATE, period_end DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.cdi_address_quality.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.cdi_address_quality.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.cdi_address_quality.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.cdi_blacklist (counterparty_id CHARACTER VARYING(100) NOT NULL, rgs_id CHARACTER VARYING(100) NOT NULL, blacklist_name CHARACTER VARYING(256) NOT NULL, blacklist_id CHARACTER VARYING(256) NOT NULL, blacklist_rule CHARACTER VARYING(256) NOT NULL, confirmation_status SMALLINT, actuality_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_class_id SMALLINT, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, period_start DATE, period_end DATE NOT NULL);
COMMENT ON TABLE core.cdi_blacklist IS 'Данные по черным спискам';
COMMENT ON COLUMN core.cdi_blacklist.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.cdi_blacklist.rgs_id IS 'РГС ID';
COMMENT ON COLUMN core.cdi_blacklist.blacklist_name IS 'Название черного списка (литера)';
COMMENT ON COLUMN core.cdi_blacklist.blacklist_id IS 'Идентификатор записи в черном списке';
COMMENT ON COLUMN core.cdi_blacklist.blacklist_rule IS 'Правило совпадения с черным списком';
COMMENT ON COLUMN core.cdi_blacklist.confirmation_status IS 'Статус подтверждения связи';
COMMENT ON COLUMN core.cdi_blacklist.actuality_date IS 'Дата актуальности';
COMMENT ON COLUMN core.cdi_blacklist.contract_class_id IS 'Класс договора';
COMMENT ON COLUMN core.cdi_blacklist.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.cdi_blacklist.key_id IS 'Уникальный ключ';
CREATE TABLE core.cdi_counterparty (counterparty_id CHARACTER VARYING(50) NOT NULL, cdi_id CHARACTER VARYING(50), rgs_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, party_type CHARACTER VARYING(50) DEFAULT 'PHYSICAL'::character varying NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.cdi_counterparty IS 'Связь контрагентов с золотыми карточками (объединенными контрагентами)';
COMMENT ON COLUMN core.cdi_counterparty.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.cdi_counterparty.cdi_id IS 'Идентификатор золотой карточки CDI';
COMMENT ON COLUMN core.cdi_counterparty.rgs_id IS 'РГС id';
COMMENT ON COLUMN core.cdi_counterparty.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.cdi_counterparty.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.cdi_counterparty.party_type IS 'Тип контрагента';
COMMENT ON COLUMN core.cdi_counterparty.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.cdi_counterparty.key_id IS 'Уникальный ключ';
CREATE TABLE core.cdi_counterparty_united (counterparty_id CHARACTER VARYING(50) NOT NULL, rgs_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, party_type CHARACTER VARYING(50) NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.cdi_counterparty_united IS 'Связь контрагентов с золотыми карточками (объединенными контрагентами)';
COMMENT ON COLUMN core.cdi_counterparty_united.counterparty_id IS 'Идентификатор контрагента в исходной системе';
COMMENT ON COLUMN core.cdi_counterparty_united.rgs_id IS 'РГС id';
COMMENT ON COLUMN core.cdi_counterparty_united.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.cdi_counterparty_united.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.cdi_counterparty_united.party_type IS 'Тип контрагента';
COMMENT ON COLUMN core.cdi_counterparty_united.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.cdi_counterparty_united.key_id IS 'Уникальный ключ';
CREATE TABLE core.cdi_mappings (mapping_type CHARACTER VARYING(50) NOT NULL, cdi_value CHARACTER VARYING(100) NOT NULL, dwh_value CHARACTER VARYING(100), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.cdi_mappings IS 'Справочник типов признаков';
COMMENT ON COLUMN core.cdi_mappings.mapping_type IS 'Тип признака';
COMMENT ON COLUMN core.cdi_mappings.cdi_value IS 'Код/Наименование признака';
COMMENT ON COLUMN core.cdi_mappings.dwh_value IS 'Значение признака';
COMMENT ON COLUMN core.cdi_mappings.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.cdi_ph_full_name_quality (surname_qc CHARACTER VARYING(50), firstname_qc CHARACTER VARYING(50), patronymic_qc CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.cdi_ph_full_name_quality IS 'c 13/02/2023 не используется для определения качества ФИО, только хардкод';
COMMENT ON COLUMN core.cdi_ph_full_name_quality.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.cdi_vehicle (vehicle_id CHARACTER VARYING(50) NOT NULL, cdi_id CHARACTER VARYING(50), rgs_id CHARACTER VARYING(50), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.cdi_vehicle IS 'Соответствие исходных ТС объединенным ТС';
COMMENT ON COLUMN core.cdi_vehicle.vehicle_id IS 'Идентификатор транспортного средства';
COMMENT ON COLUMN core.cdi_vehicle.cdi_id IS 'Идентификатор транспортного средства CDI (HID_VEHICLE)';
COMMENT ON COLUMN core.cdi_vehicle.rgs_id IS 'РГС id';
COMMENT ON COLUMN core.cdi_vehicle.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.cdi_vehicle.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.cdi_vehicle.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.cdi_vehicle.key_id IS 'Уникальный ключ';
CREATE TABLE core.cdi_vehicle_united (vehicle_id CHARACTER VARYING(50) NOT NULL, rgs_id CHARACTER VARYING(50) NOT NULL, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.cdi_vehicle_united IS 'Соответствие исходных ТС объединенным ТС';
COMMENT ON COLUMN core.cdi_vehicle_united.vehicle_id IS 'Идентификатор транспортного средства';
COMMENT ON COLUMN core.cdi_vehicle_united.rgs_id IS 'РГС id';
COMMENT ON COLUMN core.cdi_vehicle_united.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.cdi_vehicle_united.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.cdi_vehicle_united.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.cdi_vehicle_united.key_id IS 'Уникальный ключ';
CREATE TABLE core.check_log (check_date DATE, check_object CHARACTER VARYING(50), check_period_from TIMESTAMP(6) WITHOUT TIME ZONE, check_period_to TIMESTAMP(6) WITHOUT TIME ZONE, check_description TEXT, check_count NUMERIC, created_timestamp TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
CREATE TABLE core.claim (updatetime TIMESTAMP(6) WITHOUT TIME ZONE, createtime TIMESTAMP(6) WITHOUT TIME ZONE, risk CHARACTER VARYING(50) COLLATE "C", lobcode CHARACTER VARYING(50) COLLATE "C", accidenttype CHARACTER VARYING(50) COLLATE "C", state CHARACTER VARYING(50) COLLATE "C", losscause CHARACTER VARYING(50) COLLATE "C", lossdate TIMESTAMP(6) WITHOUT TIME ZONE, reporteddate TIMESTAMP(6) WITHOUT TIME ZONE, claim_policy_id TEXT, closedate TIMESTAMP(6) WITHOUT TIME ZONE, retired NUMERIC, claimnumber CHARACTER VARYING(150), claim_id TEXT NOT NULL, reopendate TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, hash TEXT COLLATE "C", description CHARACTER VARYING, accidentname TEXT, valid NUMERIC, is_europrotocol CHARACTER VARYING(10), is_reopen NUMERIC, is_exists_re_note NUMERIC, is_gbdd_documented NUMERIC, is_guilty_vehicle_surveyed NUMERIC, is_europrotocol_unlim NUMERIC, is_differences_exist NUMERIC, request_date_from DATE, request_date_to DATE, dtp_glonass_numb CHARACTER VARYING(255), regulation_type_name CHARACTER VARYING(256), bordereau_id CHARACTER VARYING(50), loss_cause_id CHARACTER VARYING(50), writeoff_debt_date DATE, writeoff_debt_amt NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, payment_cur_code CHARACTER VARYING(50), insurant_name CHARACTER VARYING(1000), writeoff_date DATE, writeoff_amt NUMERIC, reinsurance_expense_id CHARACTER VARYING(50), broker_counterparty_id CHARACTER VARYING(50), address_id CHARACTER VARYING(50), key_id UUID NOT NULL, is_blacklisted NUMERIC);
COMMENT ON TABLE core.claim IS 'Убытки договоров страхования и перестрахования';
COMMENT ON COLUMN core.claim.updatetime IS 'Дата изменения убытка';
COMMENT ON COLUMN core.claim.createtime IS 'Дата создания убытка';
COMMENT ON COLUMN core.claim.risk IS 'Код риска';
COMMENT ON COLUMN core.claim.lobcode IS 'Линия бизнеса';
COMMENT ON COLUMN core.claim.accidenttype IS 'Код убытка';
COMMENT ON COLUMN core.claim.state IS 'Состояние убытка';
COMMENT ON COLUMN core.claim.losscause IS 'Причина убытка';
COMMENT ON COLUMN core.claim.lossdate IS 'Дата страхового события';
COMMENT ON COLUMN core.claim.reporteddate IS 'Дата заявления об убытке';
COMMENT ON COLUMN core.claim.claim_policy_id IS 'Ссылка на полис';
COMMENT ON COLUMN core.claim.closedate IS 'Дата урегулирования прямого убытка';
COMMENT ON COLUMN core.claim.retired IS '0-если объект активен';
COMMENT ON COLUMN core.claim.claimnumber IS 'Номер убытка';
COMMENT ON COLUMN core.claim.claim_id IS 'PK';
COMMENT ON COLUMN core.claim.reopendate IS 'Дата повторного открытия убытка';
COMMENT ON COLUMN core.claim.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim.hash IS 'Хэш';
COMMENT ON COLUMN core.claim.description IS 'Описание события';
COMMENT ON COLUMN core.claim.accidentname IS 'Характер убытка';
COMMENT ON COLUMN core.claim.valid IS 'Признак актуальности записи';
COMMENT ON COLUMN core.claim.is_europrotocol IS 'Признак использования европротокола';
COMMENT ON COLUMN core.claim.is_reopen IS 'Признак повторного рассмотрения (переоткрытие)';
COMMENT ON COLUMN core.claim.is_exists_re_note IS 'Признак повторного примечания';
COMMENT ON COLUMN core.claim.is_gbdd_documented IS 'Признак ДТП, оформленного в ГИБДД: 1 - Да, 0 - Нет (это европротокол), -1 - Нет данных';
COMMENT ON COLUMN core.claim.is_guilty_vehicle_surveyed IS 'Признак предоставления ТС виновника на осмотр: 1 - Да, 0 - Нет, -1 - Нет данных';
COMMENT ON COLUMN core.claim.is_europrotocol_unlim IS 'Признак безлимитного европротокола: 1 - Да, 0 - Нет, -1 - Нет данных';
COMMENT ON COLUMN core.claim.is_differences_exist IS 'Признак наличия разногласий у участников ДТП: 1 - Да, 0 - Нет, -1 - Нет данных';
COMMENT ON COLUMN core.claim.request_date_from IS 'Интервал запроса с (по европротоколу)';
COMMENT ON COLUMN core.claim.request_date_to IS 'Интервал запроса по (по европротоколу)';
COMMENT ON COLUMN core.claim.dtp_glonass_numb IS 'Номер ДТП в СТ-ГЛОНАСС';
COMMENT ON COLUMN core.claim.regulation_type_name IS 'Тип урегулирования: ДТП с участием страхователя РГС на территории др. Государства, ДТП с участием иностранного гражданина на территории РФ';
COMMENT ON COLUMN core.claim.bordereau_id IS 'ID бордеро (табл. bordereau)';
COMMENT ON COLUMN core.claim.loss_cause_id IS 'Идентификатор типа риска по убытку. СКК 3.1.11 Справочник «Типы рисков на уровне убытка»';
COMMENT ON COLUMN core.claim.writeoff_debt_date IS 'Дата списания задолженности по убытку';
COMMENT ON COLUMN core.claim.writeoff_debt_amt IS 'Сумма списания задолженности по убытку в валюте убытка';
COMMENT ON COLUMN core.claim.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim.payment_cur_code IS 'Валюта расчетов по убытку. Данные заполняются для убытков по договорам перестрахования';
COMMENT ON COLUMN core.claim.insurant_name IS 'Страхователь. Данные заполняются для убытков по договорам перестрахования';
COMMENT ON COLUMN core.claim.writeoff_date IS 'Дата списания';
COMMENT ON COLUMN core.claim.writeoff_amt IS 'Списано, вал.';
COMMENT ON COLUMN core.claim.reinsurance_expense_id IS 'Связанное Обязательство ( выход на табл. reinsurance_expense). Данные заполняются для убытков по договорам перестрахования';
COMMENT ON COLUMN core.claim.broker_counterparty_id IS 'Брокер (выход на табл. counterparty). Данные заполняются для убытков по договорам перестрахования';
COMMENT ON COLUMN core.claim.address_id IS 'Идентификатор адреса места происшествия.';
COMMENT ON COLUMN core.claim.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_accidenttype (id NUMERIC(38,0), code CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(256), engname CHARACTER VARYING(256), retired NUMERIC(1,0), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_accidenttype IS 'Типы события ГУРУ';
COMMENT ON COLUMN core.claim_accidenttype.id IS 'Идентификатор';
COMMENT ON COLUMN core.claim_accidenttype.code IS 'Код события ГУРУ';
COMMENT ON COLUMN core.claim_accidenttype.name IS 'Наименование события ГУРУ';
COMMENT ON COLUMN core.claim_accidenttype.engname IS 'Наименование события ГУРУ на латинице';
COMMENT ON COLUMN core.claim_accidenttype.retired IS 'Признак актуальности: 0 - актуально';
COMMENT ON COLUMN core.claim_accidenttype.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_accidenttype.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_accidenttype.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_activity (claim_activity_id BIGINT NOT NULL, claim_id CHARACTER VARYING(50), activity_id CHARACTER VARYING(50) NOT NULL, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT now(), key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_activity IS 'Таблица связи задач с убытком';
COMMENT ON COLUMN core.claim_activity.claim_activity_id IS 'Уникальный идентификатор записи';
COMMENT ON COLUMN core.claim_activity.claim_id IS 'Идентификатор задачи';
COMMENT ON COLUMN core.claim_activity.activity_id IS 'Идентификатор типа задачи';
COMMENT ON COLUMN core.claim_activity.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_activity.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.claim_appeal (claim_appeal_id CHARACTER VARYING(50) NOT NULL, sequence_number NUMERIC, claim_id CHARACTER VARYING(50) NOT NULL, claim_incident_id CHARACTER VARYING(50), registration_date DATE, close_date DATE, receipt_channel_id CHARACTER VARYING(50), description CHARACTER VARYING, claim_appeal_status_id CHARACTER VARYING(50), claim_appeal_type_id INTEGER, period_start DATE, period_end DATE NOT NULL, retired NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT now(), key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_appeal IS 'Обращений клиентов по урегулированным страховым случаям';
COMMENT ON COLUMN core.claim_appeal.claim_appeal_id IS 'Идентификатор обращения';
COMMENT ON COLUMN core.claim_appeal.sequence_number IS 'Порядковый номер обращения';
COMMENT ON COLUMN core.claim_appeal.claim_id IS 'Идентификатор убытка';
COMMENT ON COLUMN core.claim_appeal.claim_incident_id IS 'Идентификатор инцидента';
COMMENT ON COLUMN core.claim_appeal.registration_date IS 'Дата регистрации обращения';
COMMENT ON COLUMN core.claim_appeal.close_date IS 'Дата урегулирования обращения';
COMMENT ON COLUMN core.claim_appeal.receipt_channel_id IS 'Идентификатор канала получения обращения (ссылка на ref_receipt_channel)';
COMMENT ON COLUMN core.claim_appeal.description IS 'Тематика обращения';
COMMENT ON COLUMN core.claim_appeal.claim_appeal_status_id IS 'Идентификатор статуса обращения (ссылка на ref_claim_appeal_status)';
COMMENT ON COLUMN core.claim_appeal.claim_appeal_type_id IS 'Тип обращения (ссылка на ref_claim_appeal_type)';
COMMENT ON COLUMN core.claim_appeal.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_appeal.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_appeal.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_appeal.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_appeal_requirement_type (claim_appeal_requirement_type_id CHARACTER VARYING(50) NOT NULL, claim_appeal_id CHARACTER VARYING(50), claim_requirement_type_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, retired NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_appeal_requirement_type IS 'Связи справочника типа требования и обращения по урегулированному убытку';
COMMENT ON COLUMN core.claim_appeal_requirement_type.claim_appeal_requirement_type_id IS 'Идентификатор связи';
COMMENT ON COLUMN core.claim_appeal_requirement_type.claim_appeal_id IS 'Идентификатор обращения';
COMMENT ON COLUMN core.claim_appeal_requirement_type.claim_requirement_type_id IS 'Идентификатор типа требования (ссылка на ref_claim_requirement_type)';
COMMENT ON COLUMN core.claim_appeal_requirement_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_appeal_requirement_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_appeal_requirement_type.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_appeal_requirement_type.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_check (claim_check_id CHARACTER VARYING(50) NOT NULL, claim_id CHARACTER VARYING(50), checknumber CHARACTER VARYING(255) COLLATE "C", paymentstatus CHARACTER VARYING(50) COLLATE "C", approvaldate TIMESTAMP(6) WITHOUT TIME ZONE, lastpaymentdate TIMESTAMP(6) WITHOUT TIME ZONE, firstpaymentdate TIMESTAMP(6) WITHOUT TIME ZONE, retired NUMERIC, subrogationavailable CHARACTER VARYING(1) COLLATE "C", beneficiary TEXT, refundcategory CHARACTER VARYING(50) COLLATE "C", documentdate TIMESTAMP(6) WITHOUT TIME ZONE, documentnum CHARACTER VARYING(30) COLLATE "C", totalpaymentamountvalue CHARACTER VARYING(255) COLLATE "C", paymentdetails NUMERIC, invoice_id NUMERIC, createtime TIMESTAMP(6) WITHOUT TIME ZONE, postingdate TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, hash TEXT COLLATE "C", is_pvu_fact_null INTEGER, laydowndate DATE, unpaidpremium_cur CHARACTER VARYING(50), unpaidpremium_amt NUMERIC, unpaidpremium_rub NUMERIC, paymentsumfixed NUMERIC, is_suit NUMERIC, is_court_prepaid NUMERIC, valid NUMERIC, buh_court_order_date DATE, payment_date DATE, claim_courtorder_id CHARACTER VARYING(50), doubledebiting_date DATE, is_doubledebiting NUMERIC, claim_matter_id CHARACTER VARYING(50), previouschecknumber CHARACTER VARYING(50), pvu_payment_operation_date DATE, currency_rate_date TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, is_ombudsman_resolution NUMERIC, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_check IS 'Страховой акт';
COMMENT ON COLUMN core.claim_check.claim_check_id IS 'Идентификатор страхового акта (PK)';
COMMENT ON COLUMN core.claim_check.claim_id IS 'Идентификатор убытка (FK - core.claim)';
COMMENT ON COLUMN core.claim_check.checknumber IS 'Номер акта';
COMMENT ON COLUMN core.claim_check.paymentstatus IS 'Статус акта (СКК 3.4.4) (FK - cctl_transactionstatus.id)';
COMMENT ON COLUMN core.claim_check.approvaldate IS 'Дата, когда акт был окончательно одобрен или отклонен.';
COMMENT ON COLUMN core.claim_check.lastpaymentdate IS 'Дата последнего платежа';
COMMENT ON COLUMN core.claim_check.firstpaymentdate IS 'Дата первого платежа';
COMMENT ON COLUMN core.claim_check.retired IS '0-если объект активен, id-если объект убрали из активного использования. Извлекаемые объекты не удаляются из таблицы базы данных, вместо этого они убираются путем установки столбца retried = ID объекта.';
COMMENT ON COLUMN core.claim_check.subrogationavailable IS 'Наличие суброгации';
COMMENT ON COLUMN core.claim_check.beneficiary IS 'Контрагент по убытку (claim_counterparty.counterparty_id)';
COMMENT ON COLUMN core.claim_check.refundcategory IS 'Тип категории возврата (СКК 3.4.13) (FK - cctl_refundcategoryrgs.ID)';
COMMENT ON COLUMN core.claim_check.documentdate IS 'Дата доп. документа к акту';
COMMENT ON COLUMN core.claim_check.documentnum IS 'Номер доп. документа к акту';
COMMENT ON COLUMN core.claim_check.totalpaymentamountvalue IS 'Сумма всей выплаты по акту';
COMMENT ON COLUMN core.claim_check.paymentdetails IS 'Детали оплаты';
COMMENT ON COLUMN core.claim_check.invoice_id IS 'Ссылка на статус счета СТО по оплате запчастей';
COMMENT ON COLUMN core.claim_check.createtime IS 'Дата создания объекта по системе-источнику';
COMMENT ON COLUMN core.claim_check.postingdate IS 'Дата 22 счета';
COMMENT ON COLUMN core.claim_check.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_check.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_check.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_check.is_pvu_fact_null IS 'Признак нулевого требования о возмещении.';
COMMENT ON COLUMN core.claim_check.laydowndate IS 'Дата НЕ нулевого требования о возмещении.';
COMMENT ON COLUMN core.claim_check.unpaidpremium_cur IS 'Премия, неоплаченная страхователем - валюта полиса.';
COMMENT ON COLUMN core.claim_check.unpaidpremium_amt IS 'Премия, неоплаченная страхователем - в валют.';
COMMENT ON COLUMN core.claim_check.unpaidpremium_rub IS 'Премия, неоплаченная страхователем - руб. экв.';
COMMENT ON COLUMN core.claim_check.paymentsumfixed IS 'Размер средней выплаты по ОСАГО в рамках ПВУ';
COMMENT ON COLUMN core.claim_check.is_suit IS 'Исполнительный документ. 1 - да, 0 - нет.';
COMMENT ON COLUMN core.claim_check.is_court_prepaid IS 'Безакцептное списание (судебный приказ предоплаченный). 1 - да, 0 - нет.';
COMMENT ON COLUMN core.claim_check.buh_court_order_date IS 'Дата отражения в бух. учёте суммы по исполнительному листу.';
COMMENT ON COLUMN core.claim_check.payment_date IS 'Дата выплаты';
COMMENT ON COLUMN core.claim_check.claim_courtorder_id IS 'Ссылка на судебный приказ по иску (FK - ccx_courtorderrgs.ID)';
COMMENT ON COLUMN core.claim_check.doubledebiting_date IS 'Дата события - Проверить на наличие двойного списания.';
COMMENT ON COLUMN core.claim_check.is_doubledebiting IS 'Наличие двойного списания';
COMMENT ON COLUMN core.claim_check.claim_matter_id IS 'Ссылка на Судебные дела';
COMMENT ON COLUMN core.claim_check.previouschecknumber IS 'Номер предыдущего связанного акта (если тот был отменен)';
COMMENT ON COLUMN core.claim_check.pvu_payment_operation_date IS 'Дата исполнения операции оплаты НЕ нулевого требования о возмещении.';
COMMENT ON COLUMN core.claim_check.currency_rate_date IS 'Дата обменного курса';
COMMENT ON COLUMN core.claim_check.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_check.is_ombudsman_resolution IS 'Признак произведена ли страховая выплата или безакцептное списание по решению финансового уполномоченного: 1 - Да, 0 - Нет, -1 - Не определен';
COMMENT ON COLUMN core.claim_check.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_compensationrecipient (claim_compensationrecipient_id CHARACTER VARYING(50) NOT NULL, claim_compensationrequest_id CHARACTER VARYING(50), claim_check_id CHARACTER VARYING(50), createtime TIMESTAMP(6) WITHOUT TIME ZONE, updatetime TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, hash TEXT, retired NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_compensationrecipient IS 'Получатель денежных средств по прямому ОСАГО';
COMMENT ON COLUMN core.claim_compensationrecipient.claim_compensationrecipient_id IS 'Идентификатор получателя денежных средств ПВУ (PK)';
COMMENT ON COLUMN core.claim_compensationrecipient.claim_compensationrequest_id IS 'Идентификатор запроса в рамках ПВУ (FK – core.claim_compensationrequest_id)';
COMMENT ON COLUMN core.claim_compensationrecipient.claim_check_id IS 'Идентификатор страхового акта (FK - core.claim_check)';
COMMENT ON COLUMN core.claim_compensationrecipient.createtime IS 'Дата создания объекта по системе-источнику';
COMMENT ON COLUMN core.claim_compensationrecipient.updatetime IS 'Дата последнего обновления объекта по системе-источнику';
COMMENT ON COLUMN core.claim_compensationrecipient.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_compensationrecipient.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_compensationrecipient.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_compensationrecipient.retired IS '0-если объект активен, id-если объект убрали из активного использования. Извлекаемые объекты не удаляются из таблицы базы данных, вместо этого они убираются путем установки столбца retried = ID объекта.';
COMMENT ON COLUMN core.claim_compensationrecipient.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_compensationrecipient.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_compensationrequest (claim_compensationrequest_id CHARACTER VARYING NOT NULL, claim_id CHARACTER VARYING, laydowndate DATE, paymentsumfixed NUMERIC(18,2), createtime TIMESTAMP(6) WITHOUT TIME ZONE, updatetime TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, close_record_date DATE, period_end DATE NOT NULL, hash TEXT, valid NUMERIC, senderreferenceid CHARACTER VARYING(40), ircstatus CHARACTER VARYING(50), paymentsumfactual NUMERIC, retired NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_compensationrequest IS 'Запрос о компенсации за прямое урегулирование ОСАГО';
COMMENT ON COLUMN core.claim_compensationrequest.claim_compensationrequest_id IS 'Идентификатор запроса в рамках ПВУ (PK)';
COMMENT ON COLUMN core.claim_compensationrequest.claim_id IS 'Идентификатор убытка (FK - core.claim)';
COMMENT ON COLUMN core.claim_compensationrequest.laydowndate IS 'Дата запроса';
COMMENT ON COLUMN core.claim_compensationrequest.paymentsumfixed IS 'Сумма выплаты (фиксированная)';
COMMENT ON COLUMN core.claim_compensationrequest.createtime IS 'Дата создания объекта по системе-источнику';
COMMENT ON COLUMN core.claim_compensationrequest.updatetime IS 'Дата последнего обновления объекта по системе-источнику';
COMMENT ON COLUMN core.claim_compensationrequest.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_compensationrequest.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_compensationrequest.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_compensationrequest.senderreferenceid IS 'Идентификатор направленной заявки';
COMMENT ON COLUMN core.claim_compensationrequest.ircstatus IS 'Статус IRC документа';
COMMENT ON COLUMN core.claim_compensationrequest.paymentsumfactual IS 'Сумма выплаты (фактическая)';
COMMENT ON COLUMN core.claim_compensationrequest.retired IS '0-если объект активен, id-если объект убрали из активного использования. Извлекаемые объекты не удаляются из таблицы базы данных, вместо этого они убираются путем установки столбца retried = ID объекта.';
COMMENT ON COLUMN core.claim_compensationrequest.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_compensationrequest.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_contract (contract_id CHARACTER VARYING(50) NOT NULL, parent_contract_id CHARACTER VARYING(50), main_contract_id CHARACTER VARYING(50), premium_cur CHARACTER VARYING(3), liability_cur CHARACTER VARYING(3), currency_type CHARACTER VARYING(3), contract_series CHARACTER VARYING(50), contract_number CHARACTER VARYING(50), policy_series CHARACTER VARYING(50), policy_number CHARACTER VARYING(50), premium_date TIMESTAMP(6) WITHOUT TIME ZONE, premium_add_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_start_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_end_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_cancel_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_option CHARACTER VARYING(7), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), is_service NUMERIC(1,0), sale_channel_type CHARACTER VARYING(100), product CHARACTER VARYING(512), bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), bid CHARACTER VARYING(25), office_id CHARACTER VARYING(7), insert_date TIMESTAMP(6) WITHOUT TIME ZONE, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, prev_contract_id TEXT, prev_contract_series CHARACTER VARYING(50), prev_contract_number CHARACTER VARYING(50), period_start DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, hash CHARACTER VARYING(32), is_active NUMERIC(1,0), agent_statement_id CHARACTER VARYING(50), statement_number CHARACTER VARYING(50), statement_date DATE, department_code CHARACTER VARYING(25), insurance_company CHARACTER VARYING(7), debit_writeoff_date TIMESTAMP(6) WITHOUT TIME ZONE, kias_product_id INTEGER, main_liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, co_insurance_calc CHARACTER VARYING(1), is_life NUMERIC(1,0), kbm NUMERIC(36,2), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
CREATE TABLE core.claim_costcategory (id NUMERIC, code CHARACTER VARYING(50), name CHARACTER VARYING(256), engname CHARACTER VARYING(256), retired NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_costcategory IS 'Пользовательские категории затрат в финансовых операциях';
COMMENT ON COLUMN core.claim_costcategory.id IS 'Идентификатор категории стоимости (PK)';
COMMENT ON COLUMN core.claim_costcategory.code IS 'Код категории стоимости';
COMMENT ON COLUMN core.claim_costcategory.name IS 'Наименование категории стоимости на русском языке';
COMMENT ON COLUMN core.claim_costcategory.engname IS 'Наименование категории стоимости на английскомязыке';
COMMENT ON COLUMN core.claim_costcategory.retired IS '0-если объект активен, id-если объект убрали из активного использования.';
COMMENT ON COLUMN core.claim_costcategory.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_costtype (id NUMERIC, code CHARACTER VARYING(50), name CHARACTER VARYING(256), engname CHARACTER VARYING(256), retired NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_costtype IS 'Тип расходов';
COMMENT ON COLUMN core.claim_costtype.id IS 'Идентификатор расхода (PK)';
COMMENT ON COLUMN core.claim_costtype.code IS 'Код расхода';
COMMENT ON COLUMN core.claim_costtype.name IS 'Наименование расхода на русском языке';
COMMENT ON COLUMN core.claim_costtype.engname IS 'Наименование расхода на английском языке';
COMMENT ON COLUMN core.claim_costtype.retired IS '0-если объект активен, id-если объект убрали из активного использования.';
COMMENT ON COLUMN core.claim_costtype.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_counterparty (claim_counterparty_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), claim_exposure_id CHARACTER VARYING(50), claim_incident_id CHARACTER VARYING(50), claim_policy_id CHARACTER VARYING(50), claim_id CHARACTER VARYING(50), contactrole CHARACTER VARYING(50), claim_matter_id TEXT, period_start DATE, period_end DATE NOT NULL, hash TEXT, valid NUMERIC, retired NUMERIC DEFAULT 0, contact_subtype CHARACTER VARYING(50), check_min_attributes NUMERIC, collect_pkd_claim NUMERIC, collect_pkd_role NUMERIC, counterparty_role_id NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_counterparty IS 'Контрагенты по убыткам';
COMMENT ON COLUMN core.claim_counterparty.claim_counterparty_id IS 'Идентификатор контрагента по убытку';
COMMENT ON COLUMN core.claim_counterparty.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.claim_counterparty.claim_exposure_id IS 'Идентификатор ущерба';
COMMENT ON COLUMN core.claim_counterparty.claim_incident_id IS 'Идентификатор инцидента';
COMMENT ON COLUMN core.claim_counterparty.claim_policy_id IS 'Идентификатор связи договора с убытком';
COMMENT ON COLUMN core.claim_counterparty.claim_id IS 'Идентификатор убытка';
COMMENT ON COLUMN core.claim_counterparty.contactrole IS 'Роль';
COMMENT ON COLUMN core.claim_counterparty.claim_matter_id IS 'Идентификатор судебного дела';
COMMENT ON COLUMN core.claim_counterparty.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_counterparty.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_counterparty.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_counterparty.contact_subtype IS 'Подтип контакта (справочник cctl_contact)';
COMMENT ON COLUMN core.claim_counterparty.check_min_attributes IS 'Проверка на наличие минимального количества атрибутов контакта (1 - проверка пройдена)';
COMMENT ON COLUMN core.claim_counterparty.collect_pkd_claim IS 'Принят полный комплект документов (ПКД) по убытку в целом (1 - принят)';
COMMENT ON COLUMN core.claim_counterparty.collect_pkd_role IS 'Принят полный комплект документов (ПКД) по роли контакта (1 - принят)';
COMMENT ON COLUMN core.claim_counterparty.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_counterparty.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_counterparty_proc (claim_counterparty_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), claim_exposure_id CHARACTER VARYING(50), claim_id CHARACTER VARYING(50), contactrole CHARACTER VARYING(50), is_resident INTEGER, counterparty_type INTEGER, name CHARACTER VARYING(512), last_name CHARACTER VARYING(512), first_name CHARACTER VARYING(512), middle_name CHARACTER VARYING(512), inn CHARACTER VARYING(50), claim_policy_id CHARACTER VARYING(50), dwh_date DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.claim_counterparty_proc.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_courtorder (claim_id CHARACTER VARYING(50), createtime TIMESTAMP(6) WITHOUT TIME ZONE, updatetime TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, hash TEXT, claim_courtorder_id CHARACTER VARYING(50) NOT NULL, lossvehiclesum NUMERIC(20,2), losspeoplesum NUMERIC(20,2), lossequipmentsum NUMERIC(20,2), losspropertysum NUMERIC(20,2), lossothersum NUMERIC(20,2), docnumber CHARACTER VARYING(50), docdate DATE, comments CHARACTER VARYING(2000), retired NUMERIC, claim_matter_id CHARACTER VARYING(50), isprepaid NUMERIC(1,0), claim_payment_type_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_courtorder IS 'Судебные приказы по иску';
COMMENT ON COLUMN core.claim_courtorder.claim_id IS 'Идентификатор убытка (FK - core.claim)';
COMMENT ON COLUMN core.claim_courtorder.createtime IS 'Дата создания объекта по системе-источнику';
COMMENT ON COLUMN core.claim_courtorder.updatetime IS 'Дата последнего обновления объекта по системе-источнику';
COMMENT ON COLUMN core.claim_courtorder.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_courtorder.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_courtorder.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_courtorder.claim_courtorder_id IS 'Идентификатор судебного приказа (РK)';
COMMENT ON COLUMN core.claim_courtorder.lossvehiclesum IS 'Сумма ущерба транспортного средства по решению суда по данному убытку';
COMMENT ON COLUMN core.claim_courtorder.losspeoplesum IS 'Сумма потерь ФЛ по решению суда по данному убытку';
COMMENT ON COLUMN core.claim_courtorder.lossequipmentsum IS 'Сумма ущерба добавлена к оборудованию по решению суда по данному убытку';
COMMENT ON COLUMN core.claim_courtorder.losspropertysum IS 'Сумма утраты имущества по решению суда по данному убытку';
COMMENT ON COLUMN core.claim_courtorder.lossothersum IS 'Сумма убытков, иных по решению суда по данному убытку';
COMMENT ON COLUMN core.claim_courtorder.docnumber IS 'Номер документа постановления суда по данному убытку';
COMMENT ON COLUMN core.claim_courtorder.docdate IS 'Дата документа для судебного постановления по данному убытку';
COMMENT ON COLUMN core.claim_courtorder.comments IS 'Комментарии к решению суда';
COMMENT ON COLUMN core.claim_courtorder.claim_matter_id IS 'Идентификатор судебного дела (FK - core.claim_matter)';
COMMENT ON COLUMN core.claim_courtorder.claim_payment_type_id IS 'Идентификатор типа оплаты судебного требования';
COMMENT ON COLUMN core.claim_courtorder.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_courtorder.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_coverage (claim_coverage_id CHARACTER VARYING(50) NOT NULL, retired NUMERIC, createtime TIMESTAMP(6) WITHOUT TIME ZONE, effectivedate TIMESTAMP(6) WITHOUT TIME ZONE, expirationdate TIMESTAMP(6) WITHOUT TIME ZONE, state CHARACTER VARYING(50), type CHARACTER VARYING(50), subtype NUMERIC, notes CHARACTER VARYING(255), extpolicycoverage_id NUMERIC, contract_object_id CHARACTER VARYING(50), object_risk_type_id CHARACTER VARYING(50), claim_policy_id CHARACTER VARYING(50), claim_vehicle_id CHARACTER VARYING(50), period_start DATE, close_record_date DATE, period_end DATE NOT NULL, is_new INTEGER, hash TEXT, riskobjecttype_id NUMERIC, object_risk_id CHARACTER VARYING(50), incidentlimit_amt NUMERIC, incidentlimit_cur CHARACTER VARYING(50), incidentlimit_rub NUMERIC, exposurelimit_amt NUMERIC, exposurelimit_cur CHARACTER VARYING(50), exposurelimit_rub NUMERIC, premium_amt NUMERIC, premium_cur CHARACTER VARYING(50), premium_rub NUMERIC, accounting_group_source CHARACTER VARYING(50), accounting_group CHARACTER VARYING(50), accounting_risk CHARACTER VARYING(50), dict7gs CHARACTER VARYING(50), form162 CHARACTER VARYING(50), insurance_rule CHARACTER VARYING(300), valid NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_coverage IS 'Страховое покрытие по убытку договора страхования';
COMMENT ON COLUMN core.claim_coverage.claim_coverage_id IS 'Идентификатор страхового покрытия (PK)';
COMMENT ON COLUMN core.claim_coverage.retired IS '0-если объект активен, id-если объект убрали из активного использования. Извлекаемые объекты не удаляются из таблицы базы данных, вместо этого они убираются путем установки столбца retried = ID объекта.';
COMMENT ON COLUMN core.claim_coverage.createtime IS 'Дата создания объекта по системе-источнику';
COMMENT ON COLUMN core.claim_coverage.effectivedate IS 'Дата вступления в силу покрытия';
COMMENT ON COLUMN core.claim_coverage.expirationdate IS 'Дата окончания покрытия';
COMMENT ON COLUMN core.claim_coverage.state IS 'Код субъекта федерации (регионов). 4.1.4 Классификатор субъектов Российской Федерации (FK - cctl_ state.id)';
COMMENT ON COLUMN core.claim_coverage.type IS 'Код типа покрытия (FK - cctl_ coveragetype.id) 3.1.7 Справочник «Типы покрытий на уровне договора»';
COMMENT ON COLUMN core.claim_coverage.subtype IS 'Подтип покрытия';
COMMENT ON COLUMN core.claim_coverage.notes IS 'Примечания к покрытию';
COMMENT ON COLUMN core.claim_coverage.extpolicycoverage_id IS 'Идентификатор объектов покрытия (FK - ccx_ExtPolicyCoverageRgs.id)';
COMMENT ON COLUMN core.claim_coverage.contract_object_id IS 'Идентификатор объекта (FK - core.contract_object)';
COMMENT ON COLUMN core.claim_coverage.object_risk_type_id IS 'Идентификатор типа риска (FK - core.object_risk_type)';
COMMENT ON COLUMN core.claim_coverage.claim_policy_id IS 'Идентификатор связи договора страхования с убытком (FK - core.Claim_Policy)';
COMMENT ON COLUMN core.claim_coverage.claim_vehicle_id IS 'Идентификатор пострадавшего транспортного средства по убытку';
COMMENT ON COLUMN core.claim_coverage.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_coverage.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_coverage.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_coverage.riskobjecttype_id IS 'Идентификатор типа риск-объекта по системе-источнику (FK - ccx_RiskObjectTypeRgs.id)';
COMMENT ON COLUMN core.claim_coverage.object_risk_id IS 'Идентификатор риска (FK - core.object_risk)';
COMMENT ON COLUMN core.claim_coverage.incidentlimit_amt IS 'Сумма ограничения на инцидент в валюте';
COMMENT ON COLUMN core.claim_coverage.incidentlimit_cur IS 'Код валюты инцидента (FK - cctl_currencyrgs.id )';
COMMENT ON COLUMN core.claim_coverage.incidentlimit_rub IS 'Сумма ограничения на инцидент в рублях';
COMMENT ON COLUMN core.claim_coverage.exposurelimit_amt IS 'Сумма ограничения на ущерб в валюте';
COMMENT ON COLUMN core.claim_coverage.exposurelimit_cur IS 'Код валюты ущерба (FK - cctl_currencyrgs.id )';
COMMENT ON COLUMN core.claim_coverage.exposurelimit_rub IS 'Сумма ограничения на ущерб в рублях.';
COMMENT ON COLUMN core.claim_coverage.premium_amt IS 'Сумма премии в валюте';
COMMENT ON COLUMN core.claim_coverage.premium_cur IS 'Код валюты премии (FK - cctl_currencyrgs.id )';
COMMENT ON COLUMN core.claim_coverage.premium_rub IS 'Сумма премии в рублях';
COMMENT ON COLUMN core.claim_coverage.accounting_group_source IS 'Код учетной группы исходный (заполнения соотв. полей на object_risk см. 02.99 Договоры (архив))';
COMMENT ON COLUMN core.claim_coverage.accounting_group IS 'Код учетной группы после перекодировки';
COMMENT ON COLUMN core.claim_coverage.accounting_risk IS 'Код УВС';
COMMENT ON COLUMN core.claim_coverage.dict7gs IS '7ГС';
COMMENT ON COLUMN core.claim_coverage.form162 IS 'Код вида формы 162';
COMMENT ON COLUMN core.claim_coverage.insurance_rule IS 'Наименование правил страхования';
COMMENT ON COLUMN core.claim_coverage.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_coverage.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_coveragetype (scc_id NUMERIC(38,0) NOT NULL, code CHARACTER VARYING(4) NOT NULL, name CHARACTER VARYING(256), engname CHARACTER VARYING(256), retired NUMERIC(1,0), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_coveragetype IS 'Справочник: Типы покрытий ГУРУ';
COMMENT ON COLUMN core.claim_coveragetype.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.claim_coveragetype.code IS 'Код покрытия ГУРУ';
COMMENT ON COLUMN core.claim_coveragetype.name IS 'Наименование покрытия ГУРУ';
COMMENT ON COLUMN core.claim_coveragetype.engname IS 'Наименование покрытия ГУРУ на латинице';
COMMENT ON COLUMN core.claim_coveragetype.retired IS 'Признак актуальности: 0 - актуально';
COMMENT ON COLUMN core.claim_coveragetype.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_coveragetype.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_coveragetype.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_exception (id NUMERIC, description TEXT, laod_date DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_exception IS 'Исключения для загрузки ограничения в ядро';
COMMENT ON COLUMN core.claim_exception.id IS 'ID исключения если он числовой (см. text_id если id символьный)';
COMMENT ON COLUMN core.claim_exception.description IS 'Причина добавления исключения (ссылка на задачу).';
COMMENT ON COLUMN core.claim_exception.laod_date IS 'Дата добавления записи';
COMMENT ON COLUMN core.claim_exception.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_exposure (createtime TIMESTAMP(6) WITHOUT TIME ZONE, state CHARACTER VARYING(50) COLLATE "C", appsubmissiondate TIMESTAMP(6) WITHOUT TIME ZONE, closedate TIMESTAMP(6) WITHOUT TIME ZONE, retired NUMERIC, claim_id TEXT, claim_exposure_id CHARACTER VARYING(50) NOT NULL, claim_coverage_id CHARACTER VARYING(50), coveragesubtype CHARACTER VARYING(50) COLLATE "C", claim_incident_id TEXT, exposuretype CHARACTER VARYING(50) COLLATE "C", applicationnumber TEXT, period_start DATE, period_end DATE NOT NULL, hash TEXT COLLATE "C", claimorder NUMERIC, claim_exposure_cur TEXT, claim_exposure_amt NUMERIC, claim_exposure_rub NUMERIC, is_direct_payout NUMERIC, direct_payout_type CHARACTER VARYING(50), is_direct_payout_outgo NUMERIC, application_status_name CHARACTER VARYING(256), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, loss_cause_id CHARACTER VARYING(50), key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_exposure IS 'Ущерб договоров страхования и перестрахования';
COMMENT ON COLUMN core.claim_exposure.createtime IS 'Дата создания убытка';
COMMENT ON COLUMN core.claim_exposure.state IS 'Состояние убытка';
COMMENT ON COLUMN core.claim_exposure.appsubmissiondate IS 'Дата начисления убытка';
COMMENT ON COLUMN core.claim_exposure.closedate IS 'Дата урегулирования прямого убытка';
COMMENT ON COLUMN core.claim_exposure.retired IS '0-если объект активен';
COMMENT ON COLUMN core.claim_exposure.claim_id IS 'Ссылка на убыток';
COMMENT ON COLUMN core.claim_exposure.claim_exposure_id IS 'Идентификатор ущерба (PK)';
COMMENT ON COLUMN core.claim_exposure.claim_coverage_id IS 'Ссылка на покрытие';
COMMENT ON COLUMN core.claim_exposure.coveragesubtype IS 'Подтип покрытия';
COMMENT ON COLUMN core.claim_exposure.claim_incident_id IS 'Ссылка на инцидент';
COMMENT ON COLUMN core.claim_exposure.exposuretype IS 'Тип ущерба';
COMMENT ON COLUMN core.claim_exposure.applicationnumber IS 'Номер заявления';
COMMENT ON COLUMN core.claim_exposure.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_exposure.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_exposure.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_exposure.claimorder IS 'Номер ущерба';
COMMENT ON COLUMN core.claim_exposure.claim_exposure_cur IS 'Заявленный ущерб – валюта.';
COMMENT ON COLUMN core.claim_exposure.claim_exposure_amt IS 'Заявленный ущерб – значение.';
COMMENT ON COLUMN core.claim_exposure.claim_exposure_rub IS 'Заявленный ущерб – руб. экв.';
COMMENT ON COLUMN core.claim_exposure.is_direct_payout IS 'Прямое возмещение убытков входящее (ПВУ): 1-ПВУ, 0-не ПВУ';
COMMENT ON COLUMN core.claim_exposure.direct_payout_type IS 'Тип урегулирования ПВУ';
COMMENT ON COLUMN core.claim_exposure.is_direct_payout_outgo IS 'Прямое возмещение убытков исходящее (исходящее ПВУ): 1-исходящее ПВУ, 0-не исходящее ПВУ';
COMMENT ON COLUMN core.claim_exposure.application_status_name IS 'Статус заявления (наименование). СКК 3.1.26 Статусов заявлений (Урегулирование убытков)';
COMMENT ON COLUMN core.claim_exposure.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_exposure.loss_cause_id IS 'Идентификатор типа риска по инциденту, ссылка на REF_LOSS_CAUSE. СКК 3.1.11 Справочник «Типы рисков на уровне убытка»';
COMMENT ON COLUMN core.claim_exposure.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_incident (survey CHARACTER VARYING(1) COLLATE "C", claim_incident_id CHARACTER VARYING(50) NOT NULL, claim_vehicle_id CHARACTER VARYING(50), claim_property_id CHARACTER VARYING(50), retired NUMERIC, createtime TIMESTAMP(6) WITHOUT TIME ZONE, appclosestpoint CHARACTER VARYING(50) COLLATE "C", applicationregion CHARACTER VARYING(50) COLLATE "C", closestpoint CHARACTER VARYING(50) COLLATE "C", vehstolenind CHARACTER VARYING(1) COLLATE "C", burntdown CHARACTER VARYING(1) COLLATE "C", constructdeath CHARACTER VARYING(1) COLLATE "C", repaironstoa CHARACTER VARYING(1) COLLATE "C", surveyestimate NUMERIC(18,2), description CHARACTER VARYING(2000) COLLATE "C", are2detailsdamaged CHARACTER VARYING(1) COLLATE "C", isonlyglassdamaged CHARACTER VARYING(1) COLLATE "C", autorepairshop TEXT, greencorridoravailable CHARACTER VARYING(1) COLLATE "C", otherinsurerclaimnumber CHARACTER VARYING(30) COLLATE "C", otherinsurerclaim CHARACTER VARYING(1) COLLATE "C", period_start DATE, period_end DATE NOT NULL, hash TEXT COLLATE "C", claim_id CHARACTER VARYING(50), valid NUMERIC, claim_policyexternal_id CHARACTER VARYING(50), subtype_name CHARACTER VARYING(256), subtype CHARACTER VARYING(50), damage_quantity NUMERIC, docs_status TEXT, collect_full_docs_date DATE, lossnotice_inc_ex NUMERIC, inc_is_direct_payout_outgo NUMERIC, business_process_type_name CHARACTER VARYING(256), damaged_details_qty NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, incident_date DATE, key_id UUID NOT NULL, is_total_loss INTEGER, address_id CHARACTER VARYING(50));
COMMENT ON TABLE core.claim_incident IS 'Инцидент по претензии';
COMMENT ON COLUMN core.claim_incident.survey IS 'Признак наличия сюрвея по убытку';
COMMENT ON COLUMN core.claim_incident.claim_incident_id IS 'Идентификатор инцидента (PK)';
COMMENT ON COLUMN core.claim_incident.claim_vehicle_id IS 'Идентификатор пострадавшего транспортного средства (FK - cc_vehicle.id )';
COMMENT ON COLUMN core.claim_incident.claim_property_id IS 'Идентификатор поврежденного имущества (FK - cc_policylocation.id)';
COMMENT ON COLUMN core.claim_incident.retired IS '0-если объект активен, id-если объект убрали из активного использования.';
COMMENT ON COLUMN core.claim_incident.createtime IS 'Дата создания объекта по системе-источнику';
COMMENT ON COLUMN core.claim_incident.appclosestpoint IS 'Код точки РГС (FK - cctl_businessunitrgs.id) место подачи документов (СКК 4.2.4) подразделений обществ Системы Росгосстраха';
COMMENT ON COLUMN core.claim_incident.applicationregion IS 'Код субъекта РФ места подачи документов (FK - cctl_state.id)';
COMMENT ON COLUMN core.claim_incident.closestpoint IS 'Код места урегулирования (FK - cctl_businessunitrgs.id)';
COMMENT ON COLUMN core.claim_incident.vehstolenind IS 'Признак угнанного транспортного средства';
COMMENT ON COLUMN core.claim_incident.burntdown IS 'Признак пожара';
COMMENT ON COLUMN core.claim_incident.constructdeath IS 'Признак подозрения на тотал (конструктивная гибель) транспортного средства: 1 - да, 0 - нет';
COMMENT ON COLUMN core.claim_incident.repaironstoa IS 'Признак ремонта на СТОА транспортного средства';
COMMENT ON COLUMN core.claim_incident.surveyestimate IS 'Оценка стоимости ремонта';
COMMENT ON COLUMN core.claim_incident.description IS 'Описание происшествия';
COMMENT ON COLUMN core.claim_incident.are2detailsdamaged IS 'Признак повреждения только двух деталей';
COMMENT ON COLUMN core.claim_incident.isonlyglassdamaged IS 'Признак повреждения только стекла ТС';
COMMENT ON COLUMN core.claim_incident.autorepairshop IS 'Данные о месте ремонта ТС (FK - cc_contact.ID)';
COMMENT ON COLUMN core.claim_incident.greencorridoravailable IS 'Признак зеленого коридора для инцидента';
COMMENT ON COLUMN core.claim_incident.otherinsurerclaimnumber IS 'Связанный номер убытка пострадавшего';
COMMENT ON COLUMN core.claim_incident.otherinsurerclaim IS 'Убыток от страховщика пострадавшего';
COMMENT ON COLUMN core.claim_incident.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_incident.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_incident.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_incident.claim_id IS 'Идентификатор убытка (FK - core.claim)';
COMMENT ON COLUMN core.claim_incident.claim_policyexternal_id IS 'Ссылка на полис сторонней СК (FK - ccx_PolicyExternalRgs.ID)';
COMMENT ON COLUMN core.claim_incident.subtype_name IS 'Наименование типа инцидента (СКК 3.4.9)';
COMMENT ON COLUMN core.claim_incident.subtype IS 'Внутренний код типа инцидента (СКК 3.4.9)';
COMMENT ON COLUMN core.claim_incident.damage_quantity IS 'Кол-во поврежденных элементов';
COMMENT ON COLUMN core.claim_incident.docs_status IS 'Статус документов по инциденту';
COMMENT ON COLUMN core.claim_incident.collect_full_docs_date IS 'Дата получения полного комплекта документов';
COMMENT ON COLUMN core.claim_incident.lossnotice_inc_ex IS 'Наличие входящего уведомления о потере (1 - есть, 0 - нет)';
COMMENT ON COLUMN core.claim_incident.inc_is_direct_payout_outgo IS 'Прямое возмещение убытков исходящее (исходящее ПВУ): 1-исходящее ПВУ, 0-не исходящее ПВУ';
COMMENT ON COLUMN core.claim_incident.business_process_type_name IS 'Тип бизнес-процесса';
COMMENT ON COLUMN core.claim_incident.damaged_details_qty IS 'Количество поврежденных деталей ТС';
COMMENT ON COLUMN core.claim_incident.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_incident.incident_date IS 'Дата страхового случая по инциденту';
COMMENT ON COLUMN core.claim_incident.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.claim_incident.is_total_loss IS 'Признак тотала (конструктивная гибель) транспортного средства: 1 - да, 0 - нет, -1 - не определен';
COMMENT ON COLUMN core.claim_incident.address_id IS 'Идентификатор адреса места происшествия';
CREATE TABLE core.claim_linecategory (claim_linecategory_id CHARACTER VARYING(50) NOT NULL, typecode CHARACTER VARYING(50), description CHARACTER VARYING(512), priority NUMERIC, name CHARACTER VARYING(256), engname CHARACTER VARYING(256), s_ru_ru NUMERIC, s_en_us NUMERIC, period_start DATE, period_end DATE NOT NULL, retired NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_linecategory IS 'Cправочник категорий';
COMMENT ON COLUMN core.claim_linecategory.claim_linecategory_id IS 'Идентификатор категории (PK)';
COMMENT ON COLUMN core.claim_linecategory.typecode IS 'Код категории';
COMMENT ON COLUMN core.claim_linecategory.description IS 'Описание элемента справочника (транслит)';
COMMENT ON COLUMN core.claim_linecategory.priority IS 'Приоритет';
COMMENT ON COLUMN core.claim_linecategory.name IS 'Название элемента справочника (транслит)';
COMMENT ON COLUMN core.claim_linecategory.engname IS 'Наименование категории на английском языке';
COMMENT ON COLUMN core.claim_linecategory.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_linecategory.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_linecategory.retired IS 'Признак активности записи';
COMMENT ON COLUMN core.claim_linecategory.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_losscause (scc_id NUMERIC(38,0) NOT NULL, code CHARACTER VARYING(4) NOT NULL, name CHARACTER VARYING(256), engname CHARACTER VARYING(256), retired NUMERIC(1,0), period_start DATE DEFAULT '1990-01-01'::date NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_losscause IS 'Справочник: Типы рисков ГУРУ';
COMMENT ON COLUMN core.claim_losscause.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.claim_losscause.code IS 'Код типа риска ГУРУ';
COMMENT ON COLUMN core.claim_losscause.name IS 'Наименование типа риска ГУРУ';
COMMENT ON COLUMN core.claim_losscause.engname IS 'Наименование типа риска ГУРУ на латинице';
COMMENT ON COLUMN core.claim_losscause.retired IS 'Признак актуальности: 0 - актуально';
COMMENT ON COLUMN core.claim_losscause.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_losscause.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_losscause.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_matter (claim_matter_id CHARACTER VARYING(50) NOT NULL, casenumber CHARACTER VARYING(128), claim_id CHARACTER VARYING(50), claim_incident_id CHARACTER VARYING(50), is_subrogation_exists CHARACTER VARYING, is_subrogation_flag CHARACTER VARYING, subrogation_type CHARACTER VARYING(256), is_zozpp CHARACTER VARYING, suit_stage CHARACTER VARYING(256), pd_suit_stage CHARACTER VARYING, suit_type CHARACTER VARYING(256), courttype CHARACTER VARYING, courtname CHARACTER VARYING, courtregion CHARACTER VARYING, courtrayon CHARACTER VARYING, courtnaselpunkt CHARACTER VARYING, representative CHARACTER VARYING(128), plaintiff CHARACTER VARYING, responsible CHARACTER VARYING, other CHARACTER VARYING, plaintiff_type CHARACTER VARYING, responsible_type CHARACTER VARYING, other_type CHARACTER VARYING, suit_work_begin_start_date DATE, suit_work_begin_end_date DATE, before_suit_begin_date DATE, suitacceptdate DATE, first_suitaccsum_all NUMERIC, first_suitaccsum_main NUMERIC, first_suitaccsum_penalty NUMERIC, first_suitaccsum_other NUMERIC, first_suitaccsum_poshlina NUMERIC, first_suitaccsum_lawer NUMERIC, first_suitaccsum_outlay NUMERIC, first_suitaccsum_expcrtsum NUMERIC, first_suitaccsum_expplnsum NUMERIC, suitacceptedsum_all NUMERIC, suitapprovedsum_all NUMERIC, suitacceptedsum_main NUMERIC, suitapprovedsum_main NUMERIC, suitacceptedsum_penalty NUMERIC, suitapprovedsum_penalty NUMERIC, suitacceptedsum_other NUMERIC, suitapprovedsum_other NUMERIC, suitacceptedsum_poshlina NUMERIC, suitapprovedsum_poshlina NUMERIC, suitacceptedsum_lawer NUMERIC, suitapprovedsum_lawer NUMERIC, suitacceptedsum_outlay NUMERIC, suitapprovedsum_outlay NUMERIC, suitacceptedsum_expcourtsum NUMERIC, suitapprovedsum_expcourtsum NUMERIC, suitacceptedsum_expplainsum NUMERIC, suitapprovedsum_expplainsum NUMERIC, suitapproveddate DATE, sittingdate DATE, courtsittingresult CHARACTER VARYING(256), is_suit_appr_sum_main_not_def INTEGER, appealsenddate DATE, appealdeterminationdate DATE, isrgsappeal CHARACTER VARYING(1), suitappealsum_all NUMERIC, suitappealsum_main NUMERIC, suitappealsum_penalty NUMERIC, suitappealsum_other NUMERIC, suitappealsum_poshlina NUMERIC, suitappealsum_lawer NUMERIC, suitappealsum_outlay NUMERIC, suitappealsum_expcourtsum NUMERIC, suitappealsum_expplainsum NUMERIC, is_suit_apl_sum_main_not_def INTEGER, appealcourtname TEXT, claim_state_region_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, retired NUMERIC, createtime_act_prav_poz DATE, min_act_pre_reject_date DATE, min_act_reject_date DATE, min_return_pkd_date DATE, pretrial_pretension_date DATE, inc_subtype_name CHARACTER VARYING(50), arm_ekis_lossdatecode CHARACTER VARYING(250), is_incident_id_exists NUMERIC, suit_work_end_date1_min DATE, suit_work_end_date2_min DATE, suit_work_end_date1_max DATE, suit_work_end_date2_max DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_matter IS 'Судебные дела (процессы)';
COMMENT ON COLUMN core.claim_matter.claim_matter_id IS 'Идентификатор судебного дела (PK)';
COMMENT ON COLUMN core.claim_matter.casenumber IS 'Номер судебного дела';
COMMENT ON COLUMN core.claim_matter.claim_id IS 'Идентификатор убытка (FK - core.claim)';
COMMENT ON COLUMN core.claim_matter.claim_incident_id IS 'Идентификатор инцидента по претензии (FK - core.claim_incident)';
COMMENT ON COLUMN core.claim_matter.is_subrogation_exists IS 'Признак суброгации по убытку';
COMMENT ON COLUMN core.claim_matter.is_subrogation_flag IS 'Признак связи с суброгацией';
COMMENT ON COLUMN core.claim_matter.subrogation_type IS 'Тип суброгации';
COMMENT ON COLUMN core.claim_matter.is_zozpp IS 'Признак попадания разбирательства под закон о защите прав потребителя';
COMMENT ON COLUMN core.claim_matter.suit_stage IS 'Статус судебного дела';
COMMENT ON COLUMN core.claim_matter.pd_suit_stage IS 'Cостояние судебного дела';
COMMENT ON COLUMN core.claim_matter.suit_type IS 'Причина судебного дела';
COMMENT ON COLUMN core.claim_matter.courttype IS 'Уровень суда';
COMMENT ON COLUMN core.claim_matter.courtname IS 'Название суда';
COMMENT ON COLUMN core.claim_matter.courtrayon IS 'Район (город) суда';
COMMENT ON COLUMN core.claim_matter.courtnaselpunkt IS 'Населенный пункт суда';
COMMENT ON COLUMN core.claim_matter.representative IS 'Представитель';
COMMENT ON COLUMN core.claim_matter.plaintiff IS 'Истец (ФИО/название)';
COMMENT ON COLUMN core.claim_matter.responsible IS 'Ответчик (ФИО/название)';
COMMENT ON COLUMN core.claim_matter.other IS 'Другой участник дела (ФИО/название)';
COMMENT ON COLUMN core.claim_matter.plaintiff_type IS 'Тип истца (ФЛ/ЮЛ)';
COMMENT ON COLUMN core.claim_matter.responsible_type IS 'Тип ответчика (ФЛ/ЮЛ)';
COMMENT ON COLUMN core.claim_matter.other_type IS 'Тип другого участника дела (ФЛ/ЮЛ)';
COMMENT ON COLUMN core.claim_matter.suit_work_begin_start_date IS 'Дата начала судебного дела v.1';
COMMENT ON COLUMN core.claim_matter.suit_work_begin_end_date IS 'Дата начала судебного дела v.2';
COMMENT ON COLUMN core.claim_matter.before_suit_begin_date IS 'Дата причины начала судебного разбирательства';
COMMENT ON COLUMN core.claim_matter.suitacceptdate IS 'Дата решения судебного дела';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_all IS 'Полная заявленная сумма убытка по делу';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_main IS 'Основная заявленная сумма убытка по делу';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_penalty IS 'Заявленная сумма штрафа по делу';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_other IS 'Заявленная сумма иных расходов по делу';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_poshlina IS 'Заявленная сумма пошлины по делу';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_lawer IS 'Заявленная сумма на адвоката по делу';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_outlay IS 'Заявленная сумма доп. расходов по делу';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_expcrtsum IS 'Заявленная сумма штрафа по делу';
COMMENT ON COLUMN core.claim_matter.first_suitaccsum_expplnsum IS 'Заявленная сумма по суброгации';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_all IS 'Заявленная сумма по суброгации';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_all IS 'Полная сумма убытка выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_main IS 'Основная сумма убытка по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_main IS 'Основная сумма убытка выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_penalty IS 'Сумма штрафа по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_penalty IS 'Сумма штрафа выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_other IS 'Сумма иных расходов по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_other IS 'Сумма иных расходов выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_poshlina IS 'Сумма пошлины по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_poshlina IS 'Сумма пошлины выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_lawer IS 'Сумма на адвоката по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_lawer IS 'Сумма на адвоката выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_outlay IS 'Сумма доп. расходов по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_outlay IS 'Сумма доп. расходов выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_expcourtsum IS 'Сумма по суброгации по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_expcourtsum IS 'Сумма по суброгации выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitacceptedsum_expplainsum IS 'Сумма по суброгации по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapprovedsum_expplainsum IS 'Сумма по суброгации выплаченная по решению суда';
COMMENT ON COLUMN core.claim_matter.suitapproveddate IS 'Дата выплаты по решению суда';
COMMENT ON COLUMN core.claim_matter.sittingdate IS 'Дата заседания';
COMMENT ON COLUMN core.claim_matter.courtsittingresult IS 'Результаты заседания';
COMMENT ON COLUMN core.claim_matter.is_suit_appr_sum_main_not_def IS 'Cумма иных выплат не попавших в дело';
COMMENT ON COLUMN core.claim_matter.appealsenddate IS 'Дата апелляции';
COMMENT ON COLUMN core.claim_matter.appealdeterminationdate IS 'Дата решения по апелляции';
COMMENT ON COLUMN core.claim_matter.isrgsappeal IS 'Признак (0,1)';
COMMENT ON COLUMN core.claim_matter.suitappealsum_all IS 'Полная сумма убытка по апелляции';
COMMENT ON COLUMN core.claim_matter.suitappealsum_main IS 'Основная сумма убытка по апелляции';
COMMENT ON COLUMN core.claim_matter.suitappealsum_penalty IS 'Сумма штрафа выплаченная по апелляции';
COMMENT ON COLUMN core.claim_matter.suitappealsum_other IS 'Сумма иных расходов выплаченная по апелляции';
COMMENT ON COLUMN core.claim_matter.suitappealsum_poshlina IS 'Сумма пошлины выплаченная по апелляции';
COMMENT ON COLUMN core.claim_matter.suitappealsum_lawer IS 'Сумма на адвоката выплаченная по апелляции';
COMMENT ON COLUMN core.claim_matter.suitappealsum_outlay IS 'Сумма доп. расходов выплаченная по апелляции';
COMMENT ON COLUMN core.claim_matter.suitappealsum_expcourtsum IS 'Сумма по суброгации выплаченная по апелляции';
COMMENT ON COLUMN core.claim_matter.suitappealsum_expplainsum IS 'Сумма по суброгации выплаченная по апелляции';
COMMENT ON COLUMN core.claim_matter.is_suit_apl_sum_main_not_def IS 'Cумма иных выплат не попавших в апелляцию';
COMMENT ON COLUMN core.claim_matter.appealcourtname IS 'Название апелляционного суда';
COMMENT ON COLUMN core.claim_matter.claim_state_region_id IS 'Код субъекта РФ (FK - claim_state_region.claim_state_region_id)';
COMMENT ON COLUMN core.claim_matter.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_matter.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_matter.createtime_act_prav_poz IS 'Дата создания задачи «Согласовать правовую позицию»';
COMMENT ON COLUMN core.claim_matter.min_act_pre_reject_date IS 'Первая дата отправки письма о предварительном отказе';
COMMENT ON COLUMN core.claim_matter.min_act_reject_date IS 'Первая дата отправки письма об отказе';
COMMENT ON COLUMN core.claim_matter.min_return_pkd_date IS 'Первая дата полученного письма о возврате документов';
COMMENT ON COLUMN core.claim_matter.pretrial_pretension_date IS 'Первая дата досудебной претензии';
COMMENT ON COLUMN core.claim_matter.inc_subtype_name IS 'Тип инцидента';
COMMENT ON COLUMN core.claim_matter.arm_ekis_lossdatecode IS 'Дата наступления страхового события по системам АРМ и ЕКИС в формате перечисления дат';
COMMENT ON COLUMN core.claim_matter.is_incident_id_exists IS 'Признак наличия инцидента в судебном деле';
COMMENT ON COLUMN core.claim_matter.suit_work_end_date1_min IS 'Дата создания первой задачи Получить решение суда';
COMMENT ON COLUMN core.claim_matter.suit_work_end_date2_min IS 'Дата закрытия первой задачи Получить решение суда';
COMMENT ON COLUMN core.claim_matter.suit_work_end_date1_max IS 'Дата создания последней задачи Получить решение суда';
COMMENT ON COLUMN core.claim_matter.suit_work_end_date2_max IS 'Дата закрытия последней задачи Получить решение суда';
COMMENT ON COLUMN core.claim_matter.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_matter.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_object_risk (object_risk_id CHARACTER VARYING(50) NOT NULL, contract_object_id CHARACTER VARYING(50), object_risk_type_id CHARACTER VARYING(50), premium_amt NUMERIC(38,2), premium_cur CHARACTER VARYING(7), premium_source_rub NUMERIC(38,2), premium_rub NUMERIC(38,2), premium_date TIMESTAMP(6) WITHOUT TIME ZONE, cur_rate_date DATE, cur_rate NUMERIC(38,4), liability_amt NUMERIC(38,2), liability_cur CHARACTER VARYING(7), liability_rub NUMERIC(38,2), accounting_group_source CHARACTER VARYING(25), accounting_group CHARACTER VARYING(25), accounting_risk CHARACTER VARYING(100), dict7gs CHARACTER VARYING(25), form162 CHARACTER VARYING(254), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), bid CHARACTER VARYING(25), period_start DATE, period_end DATE NOT NULL, insurance_rule CHARACTER VARYING(300), contract_id CHARACTER VARYING(50), is_active NUMERIC(1,0), agreement_id CHARACTER VARYING(50), liability_delta_amt NUMERIC(36,2), source_id NUMERIC NOT NULL, dwh_date DATE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.claim_object_risk.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.claim_object_risk.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.claim_object_risk.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_policy (effectivedate TIMESTAMP(6) WITHOUT TIME ZONE, retired NUMERIC, dateofcontract TIMESTAMP(6) WITHOUT TIME ZONE, policy_number CHARACTER VARYING(50) COLLATE "C", state CHARACTER VARYING(50) COLLATE "C", claim_policy_id TEXT NOT NULL, policytype CHARACTER VARYING(50) COLLATE "C", status CHARACTER VARYING(50) COLLATE "C", insurer CHARACTER VARYING(50) COLLATE "C", currencyequivalent CHARACTER VARYING(1) COLLATE "C", expirationdate TIMESTAMP(6) WITHOUT TIME ZONE, policy_series CHARACTER VARYING(50) COLLATE "C", contract_id CHARACTER VARYING(50), extcompany CHARACTER VARYING(50) COLLATE "C", extinsurancecompany CHARACTER VARYING(50), currency CHARACTER VARYING(50) COLLATE "C", contractdate TIMESTAMP(6) WITHOUT TIME ZONE, policyproduct_id CHARACTER VARYING(50) COLLATE "C", period_start DATE, period_end DATE NOT NULL, hash TEXT COLLATE "C", cancellationdate DATE, branch_code CHARACTER VARYING, policydocauthortype CHARACTER VARYING(50), fixedexchangerate NUMERIC, exchangeratetype CHARACTER VARYING(50), claimpaymentexchratedate CHARACTER VARYING(50), premium_date DATE, iscapitalinsurancerelated NUMERIC, reinsurance_condition_id CHARACTER VARYING(50), replacement_premium_amt NUMERIC, base_claim_amt NUMERIC, reinsurance_type_code CHARACTER VARYING(50), reinsurance_type_name CHARACTER VARYING(250), business_line_code CHARACTER VARYING(50), business_line_name CHARACTER VARYING(250), nsso_claim_number CHARACTER VARYING(2000), is_reinsurance NUMERIC, reinsured_contract_number CHARACTER VARYING(1000), reinsurance_category_name CHARACTER VARYING(100), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_policy IS 'Полисы';
COMMENT ON COLUMN core.claim_policy.effectivedate IS 'Дата вступления в силу объекта';
COMMENT ON COLUMN core.claim_policy.retired IS '0-если объект активен, id-если объект убрали из активного использования. Извлекаемые объекты не удаляются из таблицы базы данных, вместо этого они убираются путем установки столбца retried = ID объекта.';
COMMENT ON COLUMN core.claim_policy.dateofcontract IS 'Дата договора';
COMMENT ON COLUMN core.claim_policy.policy_number IS 'Номер договора';
COMMENT ON COLUMN core.claim_policy.state IS 'Код субъекта РФ в котором реализован договор, в котором находится страховое подразделение (СКК 4.1.4) (FK - cctl_ state.ID)';
COMMENT ON COLUMN core.claim_policy.claim_policy_id IS 'Идентификатор связи договора страхования с убытком (PK)';
COMMENT ON COLUMN core.claim_policy.policytype IS 'Код типа договора (код справочных значений правил страхования, FK - cctl_ policytype.ID)';
COMMENT ON COLUMN core.claim_policy.status IS 'Статус договора (FK - cctl_ policystatus.ID)';
COMMENT ON COLUMN core.claim_policy.insurer IS 'Страховое подразделение, реализовавшее договор (СКК 4.2.4) (FK - cctl_ businessunitrgs.ID)';
COMMENT ON COLUMN core.claim_policy.currencyequivalent IS 'Признак валютного договора: 1 - ин валюта, 0 рубли.';
COMMENT ON COLUMN core.claim_policy.expirationdate IS 'Дата окончания действия договора';
COMMENT ON COLUMN core.claim_policy.policy_series IS 'Серия договора';
COMMENT ON COLUMN core.claim_policy.contract_id IS 'Идентификатор догвора (FK - core.contract)';
COMMENT ON COLUMN core.claim_policy.extcompany IS 'Название связанной внешней страховой компании (FK - cctl_extcompanyrgs.ID)';
COMMENT ON COLUMN core.claim_policy.extinsurancecompany IS 'Ссылка на внешнюю страховую компанию (FK - cc_contact.ID)';
COMMENT ON COLUMN core.claim_policy.currency IS 'Валюта договора (FK - cctl_ currency.ID)';
COMMENT ON COLUMN core.claim_policy.contractdate IS 'Дата договора';
COMMENT ON COLUMN core.claim_policy.policyproduct_id IS 'Идентификатор программы договора (СКК 7.4.8) (FK - ccx_policyprogramrgs.ID)';
COMMENT ON COLUMN core.claim_policy.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_policy.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_policy.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_policy.cancellationdate IS 'Дата досрочного прекращения договора.';
COMMENT ON COLUMN core.claim_policy.branch_code IS 'Код СКК подразделения (СКК 4.2.4)';
COMMENT ON COLUMN core.claim_policy.policydocauthortype IS 'Признак авторизации полиса';
COMMENT ON COLUMN core.claim_policy.fixedexchangerate IS 'Уточненный курс валюты выплаты, если договор валютный';
COMMENT ON COLUMN core.claim_policy.exchangeratetype IS 'Тип используемого обменного курса (СКК 3.4.15)';
COMMENT ON COLUMN core.claim_policy.claimpaymentexchratedate IS 'Тип определения курса валюты выплаты (На дату выплаты, На дату заключения договора и т.д.).';
COMMENT ON COLUMN core.claim_policy.premium_date IS 'Целевая дата начисления премии по основному договору';
COMMENT ON COLUMN core.claim_policy.iscapitalinsurancerelated IS 'Признак наличия связи догвора страхования с "Капитал страхование"';
COMMENT ON COLUMN core.claim_policy.is_reinsurance IS 'Признак перестрахования: 1 - Да, 0 - Нет, null - Нет данных';
COMMENT ON COLUMN core.claim_policy.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_policy.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_policyexternal (claim_policyexternal_id CHARACTER VARYING(50) NOT NULL, claim_id CHARACTER VARYING(50), extinsurancecompany TEXT, policy_series CHARACTER VARYING(50), policy_number CHARACTER VARYING(50), createtime TIMESTAMP(6) WITHOUT TIME ZONE, updatetime TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, hash TEXT, retired NUMERIC, claim_incident_id CHARACTER VARYING(50), insured_id CHARACTER VARYING(50), claim_vehicle_id CHARACTER VARYING(50), effectivedate DATE, expirationdate DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_policyexternal IS 'Полис сторонней СК по инциденту';
COMMENT ON COLUMN core.claim_policyexternal.claim_policyexternal_id IS 'Идентификатор связи с договором сторонней СК (PK)';
COMMENT ON COLUMN core.claim_policyexternal.claim_id IS 'Идентификатор убытка (FK - core.claim)';
COMMENT ON COLUMN core.claim_policyexternal.extinsurancecompany IS 'Идентификатор договора внешней страховой компании (FK – cc_contact.ID)';
COMMENT ON COLUMN core.claim_policyexternal.policy_series IS 'Серия договора виновника';
COMMENT ON COLUMN core.claim_policyexternal.policy_number IS 'Номер договора виновника';
COMMENT ON COLUMN core.claim_policyexternal.createtime IS 'Дата создания объекта по системе-источнику';
COMMENT ON COLUMN core.claim_policyexternal.updatetime IS 'Дата последнего обновления объекта по системе-источнику';
COMMENT ON COLUMN core.claim_policyexternal.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_policyexternal.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_policyexternal.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_policyexternal.claim_incident_id IS 'FK - core.claim_incident';
COMMENT ON COLUMN core.claim_policyexternal.insured_id IS 'FK - core.counterparty_id';
COMMENT ON COLUMN core.claim_policyexternal.claim_vehicle_id IS 'Идентификатор ТС виновника (FK core.vehicle)';
COMMENT ON COLUMN core.claim_policyexternal.effectivedate IS 'Дата начала действия договора';
COMMENT ON COLUMN core.claim_policyexternal.expirationdate IS 'Дата окончания действия договора';
COMMENT ON COLUMN core.claim_policyexternal.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_policyexternal.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_policytype (scc_id NUMERIC(38,0), code CHARACTER VARYING(3) NOT NULL, name CHARACTER VARYING(256), engname CHARACTER VARYING(256), retired NUMERIC(1,0), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_policytype IS 'Справочник: Типы продуктов ГУРУ';
COMMENT ON COLUMN core.claim_policytype.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.claim_policytype.code IS 'Код продукта ГУРУ';
COMMENT ON COLUMN core.claim_policytype.name IS 'Наименование продукта ГУРУ';
COMMENT ON COLUMN core.claim_policytype.engname IS 'Наименование продукта ГУРУ на латинице';
COMMENT ON COLUMN core.claim_policytype.retired IS 'Признак актуальности: 0 - актуально';
COMMENT ON COLUMN core.claim_policytype.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_policytype.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_policytype.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_refundcategory (id NUMERIC(38,0), code CHARACTER VARYING(50), name CHARACTER VARYING(256), engname CHARACTER VARYING(256), retired NUMERIC(1,0), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.claim_refundcategory.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_rep_proc (claim_exposure_id TEXT, object_risk_id TEXT COLLATE "C", object_risk_type_id TEXT COLLATE "C", claimorder NUMERIC, claim_id TEXT, is_direct_payout NUMERIC, exp_appsubmissiondate DATE, exp_state CHARACTER VARYING(50) COLLATE "C", contract_id TEXT COLLATE "C", lobcode CHARACTER VARYING(50) COLLATE "C", policytype CHARACTER VARYING(50) COLLATE "C", expcovsubtype CHARACTER VARYING(50) COLLATE "C", claimnumber CHARACTER VARYING(512), lossdate TIMESTAMP(6) WITHOUT TIME ZONE, closedate TIMESTAMP(6) WITHOUT TIME ZONE, description CHARACTER VARYING(2000), branch_code CHARACTER VARYING, branch_char_id CHARACTER VARYING, holding_company CHARACTER VARYING(8), contract_series CHARACTER VARYING(50) COLLATE "C", contract_number CHARACTER VARYING(50) COLLATE "C", policy_start_date TIMESTAMP(6) WITHOUT TIME ZONE, policy_end_date TIMESTAMP(6) WITHOUT TIME ZONE, cancel_date TIMESTAMP(6) WITHOUT TIME ZONE, currency CHARACTER VARYING(50) COLLATE "C", counterparty_type INTEGER, is_resident INTEGER, ct_contract_id CHARACTER VARYING(50), applicationnumber TEXT, last_name CHARACTER VARYING(512), middle_name CHARACTER VARYING(512), first_name CHARACTER VARYING(512), name CHARACTER VARYING(512), sale_channel_type CHARACTER VARYING(100), partner INTEGER, is_pvu_fact_null NUMERIC, claim_check_id TEXT, refundcategory CHARACTER VARYING(50) COLLATE "C", checknumber CHARACTER VARYING(255) COLLATE "C", chk_postingdate TIMESTAMP(6) WITHOUT TIME ZONE, chk_lastpaymentdate TIMESTAMP(6) WITHOUT TIME ZONE, tr_amountrur NUMERIC, tr_amountcurr NUMERIC, subtype CHARACTER VARYING(50), costtype CHARACTER VARYING(50), paymentstatus CHARACTER VARYING(50) COLLATE "C", postingdate TIMESTAMP(6) WITHOUT TIME ZONE, cl_state CHARACTER VARYING(50) COLLATE "C", accidenttype TEXT, rn NUMERIC, res_value_rur NUMERIC, claim_reserverejection_id TEXT, tr_approvaldate TIMESTAMP(6) WITHOUT TIME ZONE, tr_createtime TIMESTAMP(6) WITHOUT TIME ZONE, chk_claim_id CHARACTER VARYING(50), claim_policy_id CHARACTER VARYING(50), missed_subject_id CHARACTER VARYING(50), insurance_rule CHARACTER VARYING(300), contractoption CHARACTER VARYING(7), acceptedsum NUMERIC, acceptedsum_cur NUMERIC, sumfrompremium NUMERIC, res_value_amt NUMERIC, akt_claimnumber TEXT, contract_department_id TEXT, rejection_date TIMESTAMP(6) WITHOUT TIME ZONE, reserverejectionstatus CHARACTER VARYING(50), closure_date TIMESTAMP(6) WITHOUT TIME ZONE, is_auto_integration INTEGER, policy_series CHARACTER VARYING(50), policy_number CHARACTER VARYING(50), premium_charge_date TIMESTAMP(6) WITHOUT TIME ZONE, d1 TIMESTAMP(6) WITHOUT TIME ZONE, d2 TIMESTAMP(6) WITHOUT TIME ZONE, dc TIMESTAMP(6) WITHOUT TIME ZONE, claim_insert_date TIMESTAMP(6) WITHOUT TIME ZONE, dict7gs_id CHARACTER VARYING(50), salechannel2008 CHARACTER VARYING(100), bank_posrednik CHARACTER VARYING(100), leasing_company_id CHARACTER VARYING(100), auto_dealer_id CHARACTER VARYING(100), other_partner_id CHARACTER VARYING(100), c_accounting_group_id CHARACTER VARYING(50), guru_incident_id CHARACTER VARYING(50), guru_exposure_id CHARACTER VARYING(50), guru_vehicle_id CHARACTER VARYING(50), vin CHARACTER VARYING(50), code_162_id CHARACTER VARYING(50), incidentlimit_rub NUMERIC, premium_rub NUMERIC, counterparty_id CHARACTER VARYING(50), value_date TIMESTAMP(6) WITHOUT TIME ZONE, paymenttype CHARACTER VARYING(50), pol_contract_id CHARACTER VARYING(50), policydocauthortype CHARACTER VARYING(50), appsubmissiondate TIMESTAMP(6) WITHOUT TIME ZONE, fixedexchangerate NUMERIC, currencyequivalent CHARACTER VARYING(1), claimpaymentexchratedate CHARACTER VARYING(50), loss_adjustment_id CHARACTER VARYING(50), is_suit NUMERIC, paymentsumfixed NUMERIC, laydowndate TIMESTAMP(6) WITHOUT TIME ZONE, beneficiary CHARACTER VARYING(50), inn CHARACTER VARYING(50), author_type CHARACTER VARYING(50), is_court_prepaid NUMERIC, chk_approvaldate DATE, is_direct_payout_outgo NUMERIC, holding_company_name CHARACTER VARYING(2000), is_pvu_fact_null_payment NUMERIC, payment_date DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
CREATE TABLE core.claim_reserverejection (claim_reserverejection_id CHARACTER VARYING(50) NOT NULL, claim_id CHARACTER VARYING(50), claim_exposure_id CHARACTER VARYING(50), claim_reserveline_id CHARACTER VARYING(50), reserverejectionstatus CHARACTER VARYING(50), value_cur TEXT, value_amt NUMERIC, value_rub NUMERIC, createtime TIMESTAMP(6) WITHOUT TIME ZONE, updatetime TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, close_record_date DATE, period_end DATE NOT NULL, hash TEXT, rejection_date DATE, retired NUMERIC, rejectionreason_name CHARACTER VARYING(4000), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_reserverejection IS 'Отказ от резервов';
COMMENT ON COLUMN core.claim_reserverejection.claim_reserverejection_id IS 'Идентификатор отказа от резервов (PK)';
COMMENT ON COLUMN core.claim_reserverejection.claim_id IS 'Идентификатор убытка (FK - core.claim)';
COMMENT ON COLUMN core.claim_reserverejection.claim_exposure_id IS 'Идентификатор ущерба (FK - core.claim_exposure)';
COMMENT ON COLUMN core.claim_reserverejection.claim_reserveline_id IS 'Идентификатор резервной линии по убытку (FK – CC_reserveline.ID)';
COMMENT ON COLUMN core.claim_reserverejection.reserverejectionstatus IS 'Статус транзакции (FK – cctl_reserverejectionstatusrgs.ID)';
COMMENT ON COLUMN core.claim_reserverejection.value_cur IS 'Код валюты ISO3. Значение валюты по полису. (FK - cctl_currency.id )';
COMMENT ON COLUMN core.claim_reserverejection.value_amt IS 'Сумма транзакции в валюте';
COMMENT ON COLUMN core.claim_reserverejection.value_rub IS 'Сумма транзакции в рублях';
COMMENT ON COLUMN core.claim_reserverejection.createtime IS 'Дата создания объекта по системе-источнику';
COMMENT ON COLUMN core.claim_reserverejection.updatetime IS 'Дата дата последнего обновления объекта по системе-источнику';
COMMENT ON COLUMN core.claim_reserverejection.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_reserverejection.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_reserverejection.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_reserverejection.rejection_date IS 'Дата отказа в страховой выплате';
COMMENT ON COLUMN core.claim_reserverejection.rejectionreason_name IS 'Причина отказа (невыплаты страхового возмещения)';
COMMENT ON COLUMN core.claim_reserverejection.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_reserverejection.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_state_region (claim_state_region_id CHARACTER VARYING(50) COLLATE "C" NOT NULL, ab_state_id NUMERIC, cc_state_id NUMERIC, claim_state_ru CHARACTER VARYING(256) COLLATE "C", claim_state_en CHARACTER VARYING(256) COLLATE "C", priority NUMERIC, new_regionnumber DOUBLE PRECISION, regionnumber DOUBLE PRECISION, char_new_regionnumber CHARACTER VARYING(40), char_regionnumber CHARACTER VARYING(40), char2_new_regionnumber CHARACTER VARYING(41), char2_regionnumber CHARACTER VARYING(41), regionname CHARACTER VARYING(150), new_regionname CHARACTER VARYING(150), federalterritory CHARACTER VARYING(150), transdekra_regionnumber DOUBLE PRECISION, transdekra_regionname CHARACTER VARYING(150), report10_territory_id CHARACTER VARYING(7), is_osago_ea DOUBLE PRECISION, is_osago_plan DOUBLE PRECISION, period_start DATE, period_end DATE NOT NULL, retired NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.claim_state_region IS 'Справочник регионов';
COMMENT ON COLUMN core.claim_state_region.claim_state_region_id IS 'Код субъекта РФ';
COMMENT ON COLUMN core.claim_state_region.ab_state_id IS 'Идентификатор субъекта';
COMMENT ON COLUMN core.claim_state_region.cc_state_id IS 'Идентификатор субъекта';
COMMENT ON COLUMN core.claim_state_region.claim_state_ru IS 'Наименование субъекта РФ на русском языке';
COMMENT ON COLUMN core.claim_state_region.claim_state_en IS 'Наименование субъекта РФ на английском языке';
COMMENT ON COLUMN core.claim_state_region.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_state_region.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_state_region.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.claim_subroadverseparty (claim_subroadverseparty_id CHARACTER VARYING(50) NOT NULL, claim_id CHARACTER VARYING(50), is_chargedoff NUMERIC(10,0), totaltorecovery NUMERIC(18,2), subrogationbegin_date DATE, subro_all_approvedsum NUMERIC, subro_wout_suit_approvedsum NUMERIC, subrogation_max_approved_date DATE, actpaymentsum NUMERIC, actsubropayment_date DATE, retired NUMERIC, period_start DATE, period_end DATE NOT NULL, arm_ekis_lossdatecode CHARACTER VARYING(250), counterparty_id CHARACTER VARYING(50), commoncount_name CHARACTER VARYING(256), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_subroadverseparty IS 'Суброгации противоборствующий сторон';
COMMENT ON COLUMN core.claim_subroadverseparty.claim_subroadverseparty_id IS 'Идентификатор субброгации (PK)';
COMMENT ON COLUMN core.claim_subroadverseparty.claim_id IS 'Идентификатор убытка (FK - core.claim)';
COMMENT ON COLUMN core.claim_subroadverseparty.is_chargedoff IS 'Признак списания денежных средств (1/0)';
COMMENT ON COLUMN core.claim_subroadverseparty.totaltorecovery IS 'Сумма требования (суброгации)';
COMMENT ON COLUMN core.claim_subroadverseparty.subrogationbegin_date IS 'Дата начисления задолженности по суброгации';
COMMENT ON COLUMN core.claim_subroadverseparty.subro_all_approvedsum IS 'Вся согласованная сумма выплаты по суброгации';
COMMENT ON COLUMN core.claim_subroadverseparty.subro_wout_suit_approvedsum IS 'Согласованная сумма выплаты по суброгации без судебного разбирательства (добровольная выплата)';
COMMENT ON COLUMN core.claim_subroadverseparty.subrogation_max_approved_date IS 'Наибольшая дата выплаты';
COMMENT ON COLUMN core.claim_subroadverseparty.actpaymentsum IS 'Сумма выплаты по акту';
COMMENT ON COLUMN core.claim_subroadverseparty.actsubropayment_date IS 'Дата выплаты по акту';
COMMENT ON COLUMN core.claim_subroadverseparty.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_subroadverseparty.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_subroadverseparty.arm_ekis_lossdatecode IS 'Дата наступления страхового события по системам АРМ и ЕКИС в формате перечисления дат';
COMMENT ON COLUMN core.claim_subroadverseparty.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.claim_subroadverseparty.commoncount_name IS 'Основание требования (суброгации) в формате описания';
COMMENT ON COLUMN core.claim_subroadverseparty.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_subroadverseparty.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_subrogation_approvedsum (claim_subrogation_approvedsum_id TEXT NOT NULL, claim_subroadverseparty_id TEXT, actpaymentsum NUMERIC(18,2), actsubropayment_date DATE, activity_create_date DATE, activity_close_date DATE, is_suit INTEGER, retired NUMERIC, period_start DATE, period_end DATE NOT NULL, subropaymentnumber CHARACTER VARYING(20), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_subrogation_approvedsum IS 'Полученные суброгации и по исполнительному листу';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.claim_subrogation_approvedsum_id IS 'Идентификатор полученной суброгации (PK)';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.claim_subroadverseparty_id IS 'Идентификатор суброгации (FK - core.claim_subroadverseparty)';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.actpaymentsum IS 'Сумма убытка по акту';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.actsubropayment_date IS 'Дата платежного документа по суброгации';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.activity_create_date IS 'Дата создания акта по суброгации';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.activity_close_date IS 'Дата закрытия акта по суброгации';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.is_suit IS 'Признак выплаты по суду';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.subropaymentnumber IS 'Номер платежного документа по суброгации';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_subrogation_approvedsum.key_id IS 'Уникальный ключ';
CREATE TABLE core.claim_transaction (status CHARACTER VARYING(50), paymenttype CHARACTER VARYING(50), claim_check_id CHARACTER VARYING(50), updatetime TIMESTAMP(6) WITHOUT TIME ZONE, createtime TIMESTAMP(6) WITHOUT TIME ZONE, retired NUMERIC, costcategory CHARACTER VARYING(50), costtype CHARACTER VARYING(50), doesnoterodereserves CHARACTER VARYING(1), claim_id CHARACTER VARYING(50), claim_exposure_id CHARACTER VARYING(50), subtype CHARACTER VARYING(50), claim_reserveline_id TEXT, claim_transaction_id TEXT NOT NULL, reportingforexamount NUMERIC, claimforexamount NUMERIC, transactionamount NUMERIC, approvaldate TIMESTAMP(6) WITHOUT TIME ZONE, hash TEXT, period_start DATE, period_end DATE NOT NULL, value_cur CHARACTER VARYING(50), value_rub NUMERIC, value_amt NUMERIC, rej_flag CHARACTER VARYING(1), value_date DATE, is_harm_life_health NUMERIC, deductible_amt NUMERIC, deductible_rub NUMERIC, operation_cur CHARACTER VARYING(50), operation_amt NUMERIC, linecategory CHARACTER VARYING(50), operation_code CHARACTER VARYING(40), operation_name CHARACTER VARYING(4000), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, writeoff_rzu_amt NUMERIC, writeoff_rzu_date DATE, key_id UUID NOT NULL);
COMMENT ON TABLE core.claim_transaction IS 'Транзакции по убыткам договоров страхования и перестрахования';
COMMENT ON COLUMN core.claim_transaction.status IS 'Код статуса транзакции';
COMMENT ON COLUMN core.claim_transaction.paymenttype IS 'Тип платежа';
COMMENT ON COLUMN core.claim_transaction.claim_check_id IS 'Ссылка на чек';
COMMENT ON COLUMN core.claim_transaction.updatetime IS 'Дата изменения объекта';
COMMENT ON COLUMN core.claim_transaction.createtime IS 'Дата создания объекта';
COMMENT ON COLUMN core.claim_transaction.retired IS '0-если объект активен';
COMMENT ON COLUMN core.claim_transaction.costcategory IS 'Код категории затрат';
COMMENT ON COLUMN core.claim_transaction.costtype IS 'Доля в Убытке / Доля в Расходе';
COMMENT ON COLUMN core.claim_transaction.doesnoterodereserves IS 'Не участвует в резерве.';
COMMENT ON COLUMN core.claim_transaction.claim_id IS 'Ссылка на убыток';
COMMENT ON COLUMN core.claim_transaction.claim_exposure_id IS 'Ссылка на ущерб';
COMMENT ON COLUMN core.claim_transaction.subtype IS 'Резерв или Платеж';
COMMENT ON COLUMN core.claim_transaction.claim_reserveline_id IS 'Ссылка на линию резервов';
COMMENT ON COLUMN core.claim_transaction.claim_transaction_id IS 'Идентификатор транзакции (PK)';
COMMENT ON COLUMN core.claim_transaction.reportingforexamount IS 'Курсовая корректировка транзакции в валюте отчетности. Здесь сохраняется сумма, на которую текущее значение ReportingAmount превышает исходное значение';
COMMENT ON COLUMN core.claim_transaction.claimforexamount IS 'Курсовая корректировка транзакции в валюте убытка. Здесь сохраняется сумма, на которую текущее значение ClaimAmount превышает исходное значение.';
COMMENT ON COLUMN core.claim_transaction.transactionamount IS 'Сумма этой транзакции в валюте транзакции.';
COMMENT ON COLUMN core.claim_transaction.approvaldate IS 'Дата оплаты при расчетах рег.';
COMMENT ON COLUMN core.claim_transaction.hash IS 'Хэш';
COMMENT ON COLUMN core.claim_transaction.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.claim_transaction.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.claim_transaction.value_cur IS 'Код валюты ISO3. Значение валюты по полису.';
COMMENT ON COLUMN core.claim_transaction.value_rub IS 'Сумма транзакции в рублях.';
COMMENT ON COLUMN core.claim_transaction.value_amt IS 'Сумма транзакции в валюте.';
COMMENT ON COLUMN core.claim_transaction.rej_flag IS 'Техническое поле. Признак формирования транзакции отказа в страховой выплате.';
COMMENT ON COLUMN core.claim_transaction.value_date IS 'Дата начисления';
COMMENT ON COLUMN core.claim_transaction.is_harm_life_health IS 'Признак claim_transaction_id содержит хотя бы одну linecategory - смерть, Вред жизни, то 1 иначе 0.';
COMMENT ON COLUMN core.claim_transaction.deductible_amt IS 'Франшиза, валюта.';
COMMENT ON COLUMN core.claim_transaction.deductible_rub IS 'Франшиза, руб. экв.';
COMMENT ON COLUMN core.claim_transaction.operation_cur IS 'Код валюты';
COMMENT ON COLUMN core.claim_transaction.operation_amt IS 'Сумма операции в валюте транзакции';
COMMENT ON COLUMN core.claim_transaction.linecategory IS 'Типовая операция';
COMMENT ON COLUMN core.claim_transaction.operation_code IS 'Операция - Код';
COMMENT ON COLUMN core.claim_transaction.operation_name IS 'Операция - Наименование';
COMMENT ON COLUMN core.claim_transaction.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.claim_transaction.writeoff_rzu_amt IS 'Списано РЗУ, вал.';
COMMENT ON COLUMN core.claim_transaction.writeoff_rzu_date IS 'Дата списания РЗУ';
COMMENT ON COLUMN core.claim_transaction.key_id IS 'Уникальный ключ';
CREATE TABLE core.comission_discount (comission_discounts_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50) NOT NULL, contract_object_id CHARACTER VARYING(50), discount NUMERIC, period_start DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.comission_discount IS 'Скидка за счёт комиссии';
COMMENT ON COLUMN core.comission_discount.comission_discounts_id IS 'Идентификатор скидки';
COMMENT ON COLUMN core.comission_discount.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.comission_discount.contract_object_id IS 'Идентификатор объекта договора';
COMMENT ON COLUMN core.comission_discount.discount IS 'Значение скидки по договору страхования в процентах от страховой премии';
COMMENT ON COLUMN core.comission_discount.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.comission_discount.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.comission_discount.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.comission_discount.key_id IS 'Уникальный ключ';
CREATE TABLE core.commission_risk (commission_risk_id CHARACTER VARYING(50) NOT NULL, payment_risk_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), commission_date TIMESTAMP(6) WITHOUT TIME ZONE, commission_amt NUMERIC(36,2), commission_cur CHARACTER VARYING(7), commission_rub NUMERIC(36,2), commission_4reserv_amt NUMERIC(36,2), commission_4reserv_cur CHARACTER VARYING(7), commission_4reserv_rub NUMERIC(36,2), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), counterparty_id CHARACTER VARYING(50), commission_type_code CHARACTER VARYING(10), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.commission_risk IS 'Комиссионные вознаграждения по рискам по объектам (по данным полисных систем)';
COMMENT ON COLUMN core.commission_risk.commission_risk_id IS 'Идентификатор комиссии';
COMMENT ON COLUMN core.commission_risk.payment_risk_id IS 'Идентификатор оплаты по риску по объекту';
COMMENT ON COLUMN core.commission_risk.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.commission_risk.commission_date IS 'Дата комиссии';
COMMENT ON COLUMN core.commission_risk.commission_amt IS 'Сумма комиссии в валюте';
COMMENT ON COLUMN core.commission_risk.commission_cur IS 'Код валюты премии';
COMMENT ON COLUMN core.commission_risk.commission_rub IS 'Сумма комиссии в рублях';
COMMENT ON COLUMN core.commission_risk.commission_4reserv_amt IS 'Сумма комиссии для резервов в валюте';
COMMENT ON COLUMN core.commission_risk.commission_4reserv_cur IS 'Код валюты премии';
COMMENT ON COLUMN core.commission_risk.commission_4reserv_rub IS 'Сумма комиссии в рублях';
COMMENT ON COLUMN core.commission_risk.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.commission_risk.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.commission_risk.hash IS 'Хэш';
COMMENT ON COLUMN core.commission_risk.counterparty_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.commission_risk.commission_type_code IS 'Тип комиссионного вознаграждения';
COMMENT ON COLUMN core.commission_risk.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.commission_risk.key_id IS 'Уникальный ключ';
CREATE TABLE core.commission_risk_sap_approv (commission_risk_id CHARACTER VARYING(250) NOT NULL, contract_id CHARACTER VARYING(50), payment_risk_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), commission_date DATE, approval_date DATE, commission_rub NUMERIC, counterparty_id CHARACTER VARYING(50), commission_type_code INTEGER, remuneration CHARACTER VARYING(50), rate NUMERIC, agentsystemcode INTEGER, participant_id CHARACTER VARYING(50), hire_type INTEGER, project_ip CHARACTER VARYING(50), broker_licence CHARACTER VARYING(50), period_start DATE NOT NULL, period_end DATE NOT NULL, counterparty_role_id BIGINT, ctr_tech_id CHARACTER VARYING(75) COLLATE "C", updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.commission_risk_sap_approv IS 'Комиссионные вознаграждения SAP (утвержденные) по рискам по объектам';
COMMENT ON COLUMN core.commission_risk_sap_approv.commission_risk_id IS 'Идентификатор комиссии';
COMMENT ON COLUMN core.commission_risk_sap_approv.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.commission_risk_sap_approv.payment_risk_id IS 'Идентификатор оплаты по риску по объекту (для утвержденного. и выплаченного КВ)';
COMMENT ON COLUMN core.commission_risk_sap_approv.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.commission_risk_sap_approv.commission_date IS 'Дата комиссии';
COMMENT ON COLUMN core.commission_risk_sap_approv.approval_date IS 'Дата утверждения КВ';
COMMENT ON COLUMN core.commission_risk_sap_approv.commission_rub IS 'Сумма комиссии в рублях';
COMMENT ON COLUMN core.commission_risk_sap_approv.counterparty_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.commission_risk_sap_approv.commission_type_code IS 'Базовый тип комиссионного вознаграждения';
COMMENT ON COLUMN core.commission_risk_sap_approv.remuneration IS 'Тип вознаграждения SAP';
COMMENT ON COLUMN core.commission_risk_sap_approv.rate IS 'Ставка вознаграждения';
COMMENT ON COLUMN core.commission_risk_sap_approv.agentsystemcode IS 'Код внешней системы продавца - (код из справочника 6.1.27)';
COMMENT ON COLUMN core.commission_risk_sap_approv.participant_id IS 'ID агента ФЛ из БК или код СКК для ЮЛ';
COMMENT ON COLUMN core.commission_risk_sap_approv.hire_type IS 'Вид приема';
COMMENT ON COLUMN core.commission_risk_sap_approv.project_ip IS 'Проект ИП';
COMMENT ON COLUMN core.commission_risk_sap_approv.broker_licence IS 'Номер брокерской лицензии';
COMMENT ON COLUMN core.commission_risk_sap_approv.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.commission_risk_sap_approv.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.commission_risk_sap_approv.counterparty_role_id IS 'Код роли агента на комиссии (ссылка на core.ref_counterparty_role)';
COMMENT ON COLUMN core.commission_risk_sap_approv.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.commission_risk_sap_approv.key_id IS 'Уникальный ключ';
CREATE TABLE core.commission_risk_sap_paid (commission_risk_id CHARACTER VARYING(250) NOT NULL, contract_id CHARACTER VARYING(50), payment_risk_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), commission_date DATE, approval_date DATE, payout_date DATE, commission_rub NUMERIC, counterparty_id CHARACTER VARYING(50), commission_type_code INTEGER, remuneration CHARACTER VARYING(50), rate NUMERIC, agentsystemcode INTEGER, participant_id CHARACTER VARYING(50), hire_type INTEGER, project_ip CHARACTER VARYING(50), broker_licence CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, ctr_tech_id CHARACTER VARYING(75), doc_id CHARACTER VARYING(70), risk_obj_id CHARACTER VARYING(78), ins_object_id CHARACTER VARYING(39), ba_id CHARACTER VARYING(45), ba_id_ext CHARACTER VARYING(45), counterparty_role_id BIGINT, is_retained_from_premium SMALLINT, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, business_act_id CHARACTER VARYING(50));
COMMENT ON TABLE core.commission_risk_sap_paid IS 'Комиссионные вознаграждения SAP (выплаченные) по рискам по объектам';
COMMENT ON COLUMN core.commission_risk_sap_paid.commission_risk_id IS 'Идентификатор комиссии';
COMMENT ON COLUMN core.commission_risk_sap_paid.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.commission_risk_sap_paid.payment_risk_id IS 'Идентификатор оплаты по риску по объекту (для утвержденного. и выплаченного КВ)';
COMMENT ON COLUMN core.commission_risk_sap_paid.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.commission_risk_sap_paid.commission_date IS 'Дата комиссии';
COMMENT ON COLUMN core.commission_risk_sap_paid.approval_date IS 'Дата утверждения КВ';
COMMENT ON COLUMN core.commission_risk_sap_paid.payout_date IS 'Дата выплаты КВ';
COMMENT ON COLUMN core.commission_risk_sap_paid.commission_rub IS 'Сумма комиссии в рублях';
COMMENT ON COLUMN core.commission_risk_sap_paid.counterparty_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.commission_risk_sap_paid.commission_type_code IS 'Базовый тип комиссионного вознаграждения';
COMMENT ON COLUMN core.commission_risk_sap_paid.remuneration IS 'Тип вознаграждения SAP';
COMMENT ON COLUMN core.commission_risk_sap_paid.rate IS 'Ставка вознаграждения';
COMMENT ON COLUMN core.commission_risk_sap_paid.agentsystemcode IS 'Код внешней системы продавца - (код из справочника 6.1.27)';
COMMENT ON COLUMN core.commission_risk_sap_paid.participant_id IS 'ЛНР агента ФЛ из БК или код СКК для ЮЛ';
COMMENT ON COLUMN core.commission_risk_sap_paid.hire_type IS 'Вид приема';
COMMENT ON COLUMN core.commission_risk_sap_paid.project_ip IS 'Проект ИП';
COMMENT ON COLUMN core.commission_risk_sap_paid.broker_licence IS 'Номер брокерской лицензии';
COMMENT ON COLUMN core.commission_risk_sap_paid.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.commission_risk_sap_paid.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.commission_risk_sap_paid.ctr_tech_id IS 'Идентификатор договора учётной системы в SAP';
COMMENT ON COLUMN core.commission_risk_sap_paid.doc_id IS 'Идентификатор документа в SAP';
COMMENT ON COLUMN core.commission_risk_sap_paid.risk_obj_id IS 'Идентификатор покрытия учётной системы в SAP';
COMMENT ON COLUMN core.commission_risk_sap_paid.ins_object_id IS 'Идентификатор объекта учётной системы в SAP';
COMMENT ON COLUMN core.commission_risk_sap_paid.ba_id IS 'Идентификатор акта в SAP';
COMMENT ON COLUMN core.commission_risk_sap_paid.ba_id_ext IS 'Идентификатор (внешний) акта в SAP';
COMMENT ON COLUMN core.commission_risk_sap_paid.counterparty_role_id IS 'Код роли агента на комиссии (ссылка на core.ref_counterparty_role)';
COMMENT ON COLUMN core.commission_risk_sap_paid.is_retained_from_premium IS 'Признак удержания комиссии агентом из страховой премии: 1 - Да, с удержанием; 0 - Нет, без удержания; -1 - Не определено';
COMMENT ON COLUMN core.commission_risk_sap_paid.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.commission_risk_sap_paid.key_id IS 'Уникальный ключ';
CREATE TABLE core.commission_risk_sap_progn (commission_risk_id CHARACTER VARYING(250) NOT NULL, contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), commission_date DATE, counterparty_id CHARACTER VARYING(50), commission_type_code INTEGER, remuneration CHARACTER VARYING(50), agentsystemcode INTEGER, participant_id CHARACTER VARYING(50), hire_type INTEGER, project_ip CHARACTER VARYING(50), broker_licence CHARACTER VARYING(50), period_start DATE NOT NULL, period_end DATE NOT NULL, commission_rub NUMERIC(15,2), rate NUMERIC(8,3), sales_code CHARACTER VARYING(105), ctr_tech_id CHARACTER VARYING(75), risk_obj_id CHARACTER VARYING(78), ins_object_id CHARACTER VARYING(39), doc_id CHARACTER VARYING(70), counterparty_role_id BIGINT, agent_agr_isn CHARACTER VARYING(105), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.commission_risk_sap_progn IS 'Комиссионные вознаграждения SAP (прогнозные) по рискам по объектам';
COMMENT ON COLUMN core.commission_risk_sap_progn.commission_risk_id IS 'Идентификатор комиссии';
COMMENT ON COLUMN core.commission_risk_sap_progn.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.commission_risk_sap_progn.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.commission_risk_sap_progn.commission_date IS 'Дата комиссии';
COMMENT ON COLUMN core.commission_risk_sap_progn.counterparty_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.commission_risk_sap_progn.commission_type_code IS 'Базовый тип комиссионного вознаграждения. СКК 7.10.28 Базовые типы вознаграждений';
COMMENT ON COLUMN core.commission_risk_sap_progn.remuneration IS 'Тип вознаграждения SAP';
COMMENT ON COLUMN core.commission_risk_sap_progn.agentsystemcode IS 'Код внешней системы продавца - (код из справочника 6.1.27)';
COMMENT ON COLUMN core.commission_risk_sap_progn.participant_id IS 'ЛНР агента ФЛ из БК или код СКК для ЮЛ';
COMMENT ON COLUMN core.commission_risk_sap_progn.hire_type IS 'Вид приема. СКК 6.1.28 Справочник «Виды приема»';
COMMENT ON COLUMN core.commission_risk_sap_progn.project_ip IS 'Проект ИП';
COMMENT ON COLUMN core.commission_risk_sap_progn.broker_licence IS 'Номер брокерской лицензии';
COMMENT ON COLUMN core.commission_risk_sap_progn.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.commission_risk_sap_progn.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.commission_risk_sap_progn.commission_rub IS 'Сумма комиссии в рублях';
COMMENT ON COLUMN core.commission_risk_sap_progn.rate IS 'Ставка вознаграждения';
COMMENT ON COLUMN core.commission_risk_sap_progn.sales_code IS 'Номер договора с посредником';
COMMENT ON COLUMN core.commission_risk_sap_progn.ctr_tech_id IS 'Идентификатор договора учётной системы в SAP';
COMMENT ON COLUMN core.commission_risk_sap_progn.risk_obj_id IS 'Идентификатор покрытия учётной системы в SAP';
COMMENT ON COLUMN core.commission_risk_sap_progn.ins_object_id IS 'Идентификатор объекта учётной системы в SAP';
COMMENT ON COLUMN core.commission_risk_sap_progn.doc_id IS 'Идентификатор документа в SAP. Идентификатор документа на выплату КВ';
COMMENT ON COLUMN core.commission_risk_sap_progn.counterparty_role_id IS 'Код роли агента на комиссии (ссылка на core.ref_counterparty_role)';
COMMENT ON COLUMN core.commission_risk_sap_progn.agent_agr_isn IS 'ISN договора с посредником';
COMMENT ON COLUMN core.commission_risk_sap_progn.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.commission_risk_sap_progn.key_id IS 'Уникальный ключ';
CREATE TABLE core.commission_risk_sap_progn_long (commission_risk_long_id CHARACTER VARYING(250) NOT NULL, object_risk_long_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), commission_risk_id CHARACTER VARYING(250), is_kredit_risk SMALLINT, commission_type_code INTEGER, remuneration CHARACTER VARYING(50), commission_rub NUMERIC(36,2), counterparty_id CHARACTER VARYING(50), commission_date TIMESTAMP(6) WITHOUT TIME ZONE, broker_licence CHARACTER VARYING(50), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.commission_risk_sap_progn_long IS 'ПАР для многолетнего договора с кредитным риском';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.commission_risk_long_id IS 'Идентификатор комиссии по риску по объекту для многолетнего условного договора';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.object_risk_long_id IS 'Идентификатор риска по объекту для многолетнего условного договора';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.contract_long_id IS 'Идентификатор многолетнего условного договора';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.commission_risk_id IS 'Идентификатор комиссии';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.is_kredit_risk IS 'Признак наличия кредитного риска';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.commission_type_code IS 'Базовый тип комиссионного вознаграждения';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.remuneration IS 'Тип вознаграждения SAP';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.commission_rub IS 'Начисленная комиссия для многолетнего условного договора в валюте';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.counterparty_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.commission_date IS 'Дата комиссии';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.broker_licence IS 'Номер брокерской лицензии';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.commission_risk_sap_progn_long.key_id IS 'Уникальный ключ';
CREATE TABLE core.consent (consent_id CHARACTER VARYING(100) NOT NULL, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, counterparty_id CHARACTER VARYING(50), consent_type CHARACTER VARYING(512), consent_value CHARACTER VARYING(100), consent_startdate DATE, consent_enddate DATE, period_start DATE, period_end DATE NOT NULL, contract_id CHARACTER VARYING(100), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.consent IS 'Согласия';
COMMENT ON COLUMN core.consent.consent_id IS 'Исторический ИД согласия';
COMMENT ON COLUMN core.consent.modify_date IS 'Дата актуальности';
COMMENT ON COLUMN core.consent.counterparty_id IS 'ИД контрагента';
COMMENT ON COLUMN core.consent.consent_type IS 'Тип согласия';
COMMENT ON COLUMN core.consent.consent_value IS 'Значение согласия';
COMMENT ON COLUMN core.consent.consent_startdate IS 'Дата начала согласия';
COMMENT ON COLUMN core.consent.consent_enddate IS 'Дата окончания согласия';
COMMENT ON COLUMN core.consent.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.consent.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.consent.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.consent.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.consent.key_id IS 'Уникальный ключ';
CREATE TABLE core.contact (contact_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), contact_type CHARACTER VARYING(512), contact_number TEXT, is_valid_contact NUMERIC(1,0), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), rank INTEGER, is_verified_contact INTEGER, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, contact_status CHARACTER VARYING(50), is_main BOOLEAN, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contact IS 'Контакты';
COMMENT ON COLUMN core.contact.contact_id IS 'Идентификатор контакта';
COMMENT ON COLUMN core.contact.counterparty_id IS 'Идентификатор персоны';
COMMENT ON COLUMN core.contact.contact_type IS 'Тип контакта';
COMMENT ON COLUMN core.contact.contact_number IS 'Номер телефона, email, сайт';
COMMENT ON COLUMN core.contact.is_valid_contact IS 'Валидный контакт';
COMMENT ON COLUMN core.contact.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contact.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contact.hash IS 'Хэш';
COMMENT ON COLUMN core.contact.rank IS 'Скоринговый балл контакта';
COMMENT ON COLUMN core.contact.is_verified_contact IS 'Признак подтвержденного контакта';
COMMENT ON COLUMN core.contact.modify_date IS 'Дата модификации';
COMMENT ON COLUMN core.contact.contact_status IS 'Статус контактности';
COMMENT ON COLUMN core.contact.is_main IS 'Признак основного контакта';
COMMENT ON COLUMN core.contact.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contact.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract (contract_id CHARACTER VARYING(50) NOT NULL, parent_contract_id CHARACTER VARYING(50), main_contract_id CHARACTER VARYING(50), premium_cur CHARACTER VARYING(3), liability_cur CHARACTER VARYING(3), currency_type CHARACTER VARYING(3), contract_series CHARACTER VARYING(50), contract_number CHARACTER VARYING(100), policy_series CHARACTER VARYING(50), policy_number CHARACTER VARYING(50), premium_date TIMESTAMP(6) WITHOUT TIME ZONE, premium_add_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_start_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_end_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_cancel_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_option CHARACTER VARYING(7), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), is_service NUMERIC(1,0), sale_channel_type CHARACTER VARYING(100), product CHARACTER VARYING(512), bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), bid CHARACTER VARYING(25), office_id CHARACTER VARYING(7), insert_date TIMESTAMP(6) WITHOUT TIME ZONE, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, prev_contract_id TEXT, prev_contract_series CHARACTER VARYING(50), prev_contract_number CHARACTER VARYING(100), period_start DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, hash CHARACTER VARYING(32), is_active NUMERIC(1,0), agent_statement_id CHARACTER VARYING(50), statement_number CHARACTER VARYING(255), statement_date DATE, department_code CHARACTER VARYING(25), insurance_company CHARACTER VARYING(7), debit_writeoff_date TIMESTAMP(6) WITHOUT TIME ZONE, kias_product_id INTEGER, main_liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, co_insurance_calc CHARACTER VARYING(1), is_life NUMERIC(1,0), kbm NUMERIC(36,2), is_pledge INTEGER, leaser CHARACTER VARYING(100), product_variant CHARACTER VARYING(100), payment_method CHARACTER VARYING(100), scoring_form CHARACTER VARYING(10), is_privilege_prolongation NUMERIC(1,0), rate_percent NUMERIC, check_sum CHARACTER VARYING(50), main_premium_charge_date DATE, premium_charge_date DATE, creation_type CHARACTER VARYING(7), is_ea INTEGER, is_egarant INTEGER, rsa_previous_insurance_company CHARACTER VARYING(100), contract_cancel_reason CHARACTER VARYING(512), is_not_office_prolongation NUMERIC(1,0), activation_date TIMESTAMP(6) WITHOUT TIME ZONE, activation_status_code CHARACTER VARYING(50), is_process_pers_info NUMERIC(1,0), rsa_pre_pre_insurance_company CHARACTER VARYING(100), external_system_code CHARACTER VARYING(50), is_state_procurement NUMERIC(1,0), leader_insurance_company CHARACTER VARYING(100), is_ekasko NUMERIC, act_number CHARACTER VARYING(255), product_type CHARACTER VARYING(50), is_need_reinsurance SMALLINT, blank_type CHARACTER VARYING(512), is_annulated SMALLINT, longterm_start_date TIMESTAMP(6) WITHOUT TIME ZONE, longterm_end_date TIMESTAMP(6) WITHOUT TIME ZONE, is_autocanceled SMALLINT, canceling_user CHARACTER VARYING(64), is_auto_canceling SMALLINT, autocancel_period INTEGER, base_contract_id CHARACTER VARYING(50), collective_contract_id CHARACTER VARYING(50), comy NUMERIC(30,0), is_intercept SMALLINT, previous_insurer_name CHARACTER VARYING(4000), longterm_contract_number CHARACTER VARYING(50), conditions_descr CHARACTER VARYING(2000), appraiser_approved_date DATE, promo_code CHARACTER VARYING(256), pledge_contract_number CHARACTER VARYING(255), pledge_contract_date DATE, credit_contract_number CHARACTER VARYING(255), credit_contract_date DATE, underwriter_discount_rate CHARACTER VARYING(50), is_autocancel_started SMALLINT, is_new_model SMALLINT, contract_type_id INTEGER, mvs_discount_rate NUMERIC(12,2), payment_frequency_id CHARACTER VARYING(50), is_reinsured NUMERIC(1,0) DEFAULT '-1'::integer, reinsurance_type_name CHARACTER VARYING(50), reinsurance_limit_amt NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, product_version_id CHARACTER VARYING(37), intermediary_channel_id CHARACTER VARYING(50), key_id UUID NOT NULL, nsis_code CHARACTER VARYING, quote_timestamp TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.contract IS 'Договоры';
COMMENT ON COLUMN core.contract.contract_id IS 'Идентификатор договора (первичный ключ)';
COMMENT ON COLUMN core.contract.parent_contract_id IS 'Идентификатор родительского договора';
COMMENT ON COLUMN core.contract.main_contract_id IS 'Идентификатор основного договора';
COMMENT ON COLUMN core.contract.premium_cur IS 'Код валюты премии';
COMMENT ON COLUMN core.contract.liability_cur IS 'Код валюты страховой суммы';
COMMENT ON COLUMN core.contract.currency_type IS 'Тип валюты договора: RUB - расчеты производятся в рублях; CUR - расчеты производятся в валюте; EQV - договор по условиям валютный, но расчеты производятся в рублях';
COMMENT ON COLUMN core.contract.contract_series IS 'Серия договора';
COMMENT ON COLUMN core.contract.contract_number IS 'Номер договора';
COMMENT ON COLUMN core.contract.policy_series IS 'Серия полиса';
COMMENT ON COLUMN core.contract.policy_number IS 'Номер полиса';
COMMENT ON COLUMN core.contract.premium_date IS 'Целевая дата начисления премии по основному договору';
COMMENT ON COLUMN core.contract.premium_add_date IS 'Целевая дата начисления премии';
COMMENT ON COLUMN core.contract.contract_date IS 'Дата заключения договора';
COMMENT ON COLUMN core.contract.contract_start_date IS 'Дата начала договора';
COMMENT ON COLUMN core.contract.contract_end_date IS 'Дата окончания договора';
COMMENT ON COLUMN core.contract.liability_start_date IS 'Дата начала ответственности по договору';
COMMENT ON COLUMN core.contract.liability_end_date IS 'Дата окончания ответственности по договору';
COMMENT ON COLUMN core.contract.contract_cancel_date IS 'Дата расторжения договора';
COMMENT ON COLUMN core.contract.contract_option IS 'Признак договора. 1 – первоначальный, 2 – возобновленный, 3 – дополнительный, 4 – переоформленный.';
COMMENT ON COLUMN core.contract.is_co_insurance IS 'Признак сострахования. 1 – договор сострахования.';
COMMENT ON COLUMN core.contract.co_insurance_role IS 'Роль в состраховании. 1 – страховщик лидер, 2 – страховщик участник.';
COMMENT ON COLUMN core.contract.is_service IS 'Признак сервисного договора. 1 – договор сервисный.';
COMMENT ON COLUMN core.contract.sale_channel_type IS 'Тип канала продаж в договоре';
COMMENT ON COLUMN core.contract.product IS 'Страховой продукт (текстовое наименование)';
COMMENT ON COLUMN core.contract.bank IS 'Банк-посредник';
COMMENT ON COLUMN core.contract.leasing_company IS 'Лизинговая компания';
COMMENT ON COLUMN core.contract.auto_dealer IS 'Автодилер';
COMMENT ON COLUMN core.contract.other_partner IS 'Прочий партнер';
COMMENT ON COLUMN core.contract.bid IS 'Код подразделения, в котором учтен договор';
COMMENT ON COLUMN core.contract.office_id IS 'Идентификатор точки продаж';
COMMENT ON COLUMN core.contract.insert_date IS 'Дата ввода в полисную систему';
COMMENT ON COLUMN core.contract.modify_date IS 'Дата изменения в полисной системе';
COMMENT ON COLUMN core.contract.prev_contract_id IS 'Идентификатор предыдущего договора';
COMMENT ON COLUMN core.contract.prev_contract_series IS 'Серия предыдущего договора';
COMMENT ON COLUMN core.contract.prev_contract_number IS 'Номер предыдущего договора';
COMMENT ON COLUMN core.contract.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract.hash IS 'Хэш';
COMMENT ON COLUMN core.contract.is_active IS 'Признак активного договора: 0 – договор не активный, 1 – договор активный, 2 - "технические" записи, null - не определено';
COMMENT ON COLUMN core.contract.agent_statement_id IS 'Идентификатор отчёта агента (по договору)';
COMMENT ON COLUMN core.contract.statement_number IS 'Номер отчёта агента (по договору)';
COMMENT ON COLUMN core.contract.statement_date IS 'Дата отчёта агента (по договору)';
COMMENT ON COLUMN core.contract.department_code IS 'Код подразделения, в котором заключен договор';
COMMENT ON COLUMN core.contract.insurance_company IS 'Код предыдущей страховой компании';
COMMENT ON COLUMN core.contract.debit_writeoff_date IS 'Дата списания дебиторской задолженности';
COMMENT ON COLUMN core.contract.kias_product_id IS 'Идентификатор продукта КИАС';
COMMENT ON COLUMN core.contract.main_liability_start_date IS 'Дата начала ответственности по основному договору';
COMMENT ON COLUMN core.contract.co_insurance_calc IS 'Порядок расчетов между участниками сострахования. L – расчёт через лидера, D – расчёт напрямую.';
COMMENT ON COLUMN core.contract.is_life IS 'Признак договора страхования жизни. 1 – договор относится к страхованию жизни, 0 – договор не относится к страхованию жизни.';
COMMENT ON COLUMN core.contract.kbm IS 'Значение КБМ по договору';
COMMENT ON COLUMN core.contract.is_pledge IS 'Признак имущества в залоге: 1 – Имущество находится в залоге.';
COMMENT ON COLUMN core.contract.leaser IS 'Лизингодатель';
COMMENT ON COLUMN core.contract.product_variant IS 'Вариант продукта';
COMMENT ON COLUMN core.contract.payment_method IS 'Способ возмещения';
COMMENT ON COLUMN core.contract.scoring_form IS 'Номер скоринговой анкеты';
COMMENT ON COLUMN core.contract.is_privilege_prolongation IS 'Признак льготной пролонгации: 1 – Да.';
COMMENT ON COLUMN core.contract.rate_percent IS 'Особые условия валютного договора - отклонение курса оплаты от курса ЦБ';
COMMENT ON COLUMN core.contract.check_sum IS 'Контрольная сумма';
COMMENT ON COLUMN core.contract.main_premium_charge_date IS 'Дата начисления премии по основному договору';
COMMENT ON COLUMN core.contract.premium_charge_date IS 'Дата начисления премии';
COMMENT ON COLUMN core.contract.creation_type IS 'Тип создания договора';
COMMENT ON COLUMN core.contract.is_ea IS 'Признак РСА-Агент (Единый агент)';
COMMENT ON COLUMN core.contract.is_egarant IS 'Признак Е-Гарант';
COMMENT ON COLUMN core.contract.rsa_previous_insurance_company IS 'Предыдущая страховая компания по данным РСА';
COMMENT ON COLUMN core.contract.contract_cancel_reason IS 'Причина расторжения договора';
COMMENT ON COLUMN core.contract.is_not_office_prolongation IS 'Не подлежит пролонгации в офисном канале';
COMMENT ON COLUMN core.contract.activation_date IS 'Дата активации Коробки';
COMMENT ON COLUMN core.contract.activation_status_code IS 'Статус активации Коробки';
COMMENT ON COLUMN core.contract.is_process_pers_info IS 'Согласие на обработку персональных данных: 1 – Да.';
COMMENT ON COLUMN core.contract.rsa_pre_pre_insurance_company IS 'Позапрошлая страховая компания по данным РСА';
COMMENT ON COLUMN core.contract.external_system_code IS 'Код системы источника';
COMMENT ON COLUMN core.contract.is_state_procurement IS 'Признак госзакупки';
COMMENT ON COLUMN core.contract.leader_insurance_company IS 'Код компании лидера в состраховании';
COMMENT ON COLUMN core.contract.is_ekasko IS 'Признак электронного КАСКО: 1 – Да';
COMMENT ON COLUMN core.contract.act_number IS 'Номер акта';
COMMENT ON COLUMN core.contract.product_type IS 'Тип продукта';
COMMENT ON COLUMN core.contract.is_need_reinsurance IS 'Признак необходимости перестрахования договора ОСАГО: 1 - Да';
COMMENT ON COLUMN core.contract.blank_type IS 'Тип бланка БСО';
COMMENT ON COLUMN core.contract.is_annulated IS 'Аннулирован: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.contract.longterm_start_date IS 'Дата начала многолетнего договора';
COMMENT ON COLUMN core.contract.longterm_end_date IS 'Дата окончания многолетнего договора';
COMMENT ON COLUMN core.contract.is_autocanceled IS 'Признак автоматического расторжения: 1 - Да';
COMMENT ON COLUMN core.contract.canceling_user IS 'Логин пользователя, расторгнувшего договор';
COMMENT ON COLUMN core.contract.is_auto_canceling IS 'Подлежит автоматическому расторжению: 1 - Договор подлежит автоматическому расторжению';
COMMENT ON COLUMN core.contract.autocancel_period IS 'Период автоматического расторжения в днях';
COMMENT ON COLUMN core.contract.base_contract_id IS 'Идентификатор первого договора в цепочке многолетних договоров';
COMMENT ON COLUMN core.contract.collective_contract_id IS 'ID КДС';
COMMENT ON COLUMN core.contract.comy IS 'Признак, указывающий, что договор является многолетним';
COMMENT ON COLUMN core.contract.is_intercept IS 'Признак перехвата клиента (1/0)';
COMMENT ON COLUMN core.contract.previous_insurer_name IS 'Предыдущая страховая компания по ОСАГО (по Данным автокода)';
COMMENT ON COLUMN core.contract.longterm_contract_number IS 'Номер многолетнего договора';
COMMENT ON COLUMN core.contract.conditions_descr IS 'Дополнительные условия по договору';
COMMENT ON COLUMN core.contract.appraiser_approved_date IS 'Дата согласования экспертом-оценщиком';
COMMENT ON COLUMN core.contract.promo_code IS 'Промо-код для получения скидки';
COMMENT ON COLUMN core.contract.pledge_contract_number IS 'Номер договора залога';
COMMENT ON COLUMN core.contract.pledge_contract_date IS 'Дата договора залога';
COMMENT ON COLUMN core.contract.credit_contract_number IS 'Номер кредитного договора';
COMMENT ON COLUMN core.contract.credit_contract_date IS 'Дата кредитного договора';
COMMENT ON COLUMN core.contract.underwriter_discount_rate IS 'Скидка андеррайтера';
COMMENT ON COLUMN core.contract.is_autocancel_started IS 'Договор находится в процессе авторасторжения (1-Да, 0 - Нет)';
COMMENT ON COLUMN core.contract.is_new_model IS 'Признак договора введённого в новой модели (1 - новая модель, 0 - старая модель)';
COMMENT ON COLUMN core.contract.contract_type_id IS 'Идентификатор типа договора';
COMMENT ON COLUMN core.contract.mvs_discount_rate IS 'Скидка сотрудника МВС';
COMMENT ON COLUMN core.contract.payment_frequency_id IS 'Идентификатор количества и частоты оплат';
COMMENT ON COLUMN core.contract.is_reinsured IS 'Признак перестрахования договора страхования: 1 - Да, 0 - Нет, -1 - Не определен';
COMMENT ON COLUMN core.contract.reinsurance_type_name IS 'Тип перестрахования';
COMMENT ON COLUMN core.contract.reinsurance_limit_amt IS 'Лимит ответственности (размер ответственности РГС по договору страхования в случае его перестрахования)';
COMMENT ON COLUMN core.contract.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract.product_version_id IS 'Версия продукта';
COMMENT ON COLUMN core.contract.intermediary_channel_id IS 'Канал привлечения';
COMMENT ON COLUMN core.contract.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.contract.nsis_code IS 'Код НСИС';
COMMENT ON COLUMN core.contract.quote_timestamp IS 'Дата котировки, от которой был создан договор';
CREATE TABLE core.contract_add (contract_id CHARACTER VARYING(50) NOT NULL, product_id CHARACTER VARYING(254), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_add IS 'Дополнительные атрибуты договора';
COMMENT ON COLUMN core.contract_add.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_add.product_id IS 'Id продукта из СКК 7.13.55 "Реестр продуктов"';
COMMENT ON COLUMN core.contract_add.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_add.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_add.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_add.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_add_coverage (contract_add_coverage_id CHARACTER VARYING(70) NOT NULL, contract_id CHARACTER VARYING(70), add_coverage_id NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_add_coverage IS 'Дополнительное покрытие на договоре';
COMMENT ON COLUMN core.contract_add_coverage.contract_add_coverage_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.contract_add_coverage.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_add_coverage.add_coverage_id IS 'Идентификатор дополнительного покрытия';
COMMENT ON COLUMN core.contract_add_coverage.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_add_coverage.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_add_coverage.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_add_coverage.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_address_hist (contract_address_hist_id CHARACTER VARYING(100) NOT NULL, contract_id CHARACTER VARYING(50), counterparty_id CHARACTER VARYING(50), address_id CHARACTER VARYING(50), effective_start TIMESTAMP(6) WITHOUT TIME ZONE, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_address_hist IS 'Историческая таблица связей между договором и адресом';
COMMENT ON COLUMN core.contract_address_hist.contract_address_hist_id IS 'Идентификатор адреса в связке с договором (ПК)';
COMMENT ON COLUMN core.contract_address_hist.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_address_hist.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.contract_address_hist.address_id IS 'Идентификатор адреса';
COMMENT ON COLUMN core.contract_address_hist.effective_start IS 'Дата начала действия записи на источнике (бизнес-дата)';
COMMENT ON COLUMN core.contract_address_hist.effective_end IS 'Дата окончания действия записи на источнике (бизнес-дата)';
COMMENT ON COLUMN core.contract_address_hist.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_address_hist.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_address_hist.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_address_hist.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_contact_hist (contract_contact_hist_id CHARACTER VARYING(100) NOT NULL, contract_id CHARACTER VARYING(50), counterparty_id CHARACTER VARYING(50), contact_id CHARACTER VARYING(50), effective_start TIMESTAMP(6) WITHOUT TIME ZONE, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_contact_hist IS 'Историческая таблица связей между договором и контактом';
COMMENT ON COLUMN core.contract_contact_hist.contract_contact_hist_id IS 'Идентификатор контакта в связке с договором (ПК)';
COMMENT ON COLUMN core.contract_contact_hist.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_contact_hist.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.contract_contact_hist.contact_id IS 'Идентификатор контакта';
COMMENT ON COLUMN core.contract_contact_hist.effective_start IS 'Дата начала действия записи на источнике (бизнес-дата)';
COMMENT ON COLUMN core.contract_contact_hist.effective_end IS 'Дата окончания действия записи на источнике (бизнес-дата)';
COMMENT ON COLUMN core.contract_contact_hist.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_contact_hist.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_contact_hist.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_contact_hist.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_counterparty (contract_counterparty_id BIGINT NOT NULL, contract_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50) NOT NULL, contract_counterparty_role NUMERIC, is_primary NUMERIC, period_start DATE, period_end DATE DEFAULT '9999-12-31'::date, hash CHARACTER VARYING(32), vehicle_id CHARACTER VARYING(50), kbm NUMERIC(36,2), top400 CHARACTER VARYING(25), beneficiary_share NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, agent_code CHARACTER VARYING(150), key_id UUID NOT NULL) PARTITION BY RANGE (contract_counterparty_role);
CREATE TABLE db_edw.core.contract_counterparty1 PARTITION OF core.contract_counterparty FOR VALUES FROM ('1') TO ('2');
CREATE TABLE db_edw.core.contract_counterparty10 PARTITION OF core.contract_counterparty FOR VALUES FROM ('10') TO ('11');
CREATE TABLE db_edw.core.contract_counterparty11 PARTITION OF core.contract_counterparty FOR VALUES FROM ('11') TO ('12');
CREATE TABLE db_edw.core.contract_counterparty12 PARTITION OF core.contract_counterparty FOR VALUES FROM ('12') TO ('13');
CREATE TABLE db_edw.core.contract_counterparty13 PARTITION OF core.contract_counterparty FOR VALUES FROM ('13') TO ('14');
CREATE TABLE db_edw.core.contract_counterparty15 PARTITION OF core.contract_counterparty FOR VALUES FROM ('15') TO ('16');
CREATE TABLE db_edw.core.contract_counterparty1617 PARTITION OF core.contract_counterparty FOR VALUES FROM ('16') TO ('18');
CREATE TABLE db_edw.core.contract_counterparty2 PARTITION OF core.contract_counterparty FOR VALUES FROM ('2') TO ('3');
CREATE TABLE db_edw.core.contract_counterparty27 PARTITION OF core.contract_counterparty FOR VALUES FROM ('27') TO ('28');
CREATE TABLE db_edw.core.contract_counterparty28 PARTITION OF core.contract_counterparty FOR VALUES FROM ('28') TO ('29');
CREATE TABLE db_edw.core.contract_counterparty29 PARTITION OF core.contract_counterparty FOR VALUES FROM ('29') TO ('30');
CREATE TABLE db_edw.core.contract_counterparty3 PARTITION OF core.contract_counterparty FOR VALUES FROM ('3') TO ('4');
CREATE TABLE db_edw.core.contract_counterparty4 PARTITION OF core.contract_counterparty FOR VALUES FROM ('4') TO ('5');
CREATE TABLE db_edw.core.contract_counterparty5 PARTITION OF core.contract_counterparty FOR VALUES FROM ('5') TO ('6');
CREATE TABLE db_edw.core.contract_counterparty6 PARTITION OF core.contract_counterparty FOR VALUES FROM ('6') TO ('7');
CREATE TABLE db_edw.core.contract_counterparty7 PARTITION OF core.contract_counterparty FOR VALUES FROM ('7') TO ('8');
CREATE TABLE db_edw.core.contract_counterparty8 PARTITION OF core.contract_counterparty FOR VALUES FROM ('8') TO ('9');
CREATE TABLE db_edw.core.contract_counterparty9 PARTITION OF core.contract_counterparty FOR VALUES FROM ('9') TO ('10');
COMMENT ON TABLE core.contract_counterparty IS 'Контрагенты по договору';
COMMENT ON COLUMN core.contract_counterparty.contract_counterparty_id IS 'Уникальный идентификатор записи (первичный ключ)';
COMMENT ON COLUMN core.contract_counterparty.contract_id IS 'Идентификатор договора (внешний ключ на табл. contract)';
COMMENT ON COLUMN core.contract_counterparty.counterparty_id IS 'Идентификатор контрагента (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.contract_counterparty.contract_counterparty_role IS 'Роль контрагента';
COMMENT ON COLUMN core.contract_counterparty.is_primary IS 'Признак основного контрагента: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.contract_counterparty.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_counterparty.period_end IS 'Дата окончания действия записи (первичный ключ)';
COMMENT ON COLUMN core.contract_counterparty.hash IS 'Хэш';
COMMENT ON COLUMN core.contract_counterparty.vehicle_id IS 'Идентификатор транспортного средства (внешний ключ на табл. vehicle)';
COMMENT ON COLUMN core.contract_counterparty.kbm IS 'Значение КБМ';
COMMENT ON COLUMN core.contract_counterparty.top400 IS 'Ключевой клиент';
COMMENT ON COLUMN core.contract_counterparty.beneficiary_share IS 'Доля выгодоприобретателя';
COMMENT ON COLUMN core.contract_counterparty.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_counterparty.agent_code IS 'Личный номер работника / Код агента';
COMMENT ON COLUMN core.contract_counterparty.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_document_hist (contract_document_hist_id CHARACTER VARYING(100) NOT NULL, contract_id CHARACTER VARYING(50), counterparty_id CHARACTER VARYING(50), document_id CHARACTER VARYING(50), effective_start TIMESTAMP(6) WITHOUT TIME ZONE, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_document_hist IS 'Историческая таблица между договором и документом';
COMMENT ON COLUMN core.contract_document_hist.contract_document_hist_id IS 'Идентификатор документа в связке с договором (ПК)';
COMMENT ON COLUMN core.contract_document_hist.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_document_hist.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.contract_document_hist.document_id IS 'Идентификатор документа';
COMMENT ON COLUMN core.contract_document_hist.effective_start IS 'Дата начала действия записи на источнике (бизнес-дата)';
COMMENT ON COLUMN core.contract_document_hist.effective_end IS 'Дата окончания действия записи на источнике (бизнес-дата)';
COMMENT ON COLUMN core.contract_document_hist.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_document_hist.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_document_hist.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_document_hist.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_expense (contract_expense_id CHARACTER VARYING(50) NOT NULL, insurance_contract_id CHARACTER VARYING(50), payment_date TIMESTAMP(6) WITHOUT TIME ZONE, payment_amt NUMERIC, counterparty_id CHARACTER VARYING(50), assistance_contract_id CHARACTER VARYING(50), invoice_number CHARACTER VARYING(50), invoice_date TIMESTAMP(6) WITHOUT TIME ZONE, is_payed INTEGER, contract_expense_type_id INTEGER, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_expense IS 'Расходы по договору страхования';
COMMENT ON COLUMN core.contract_expense.contract_expense_id IS 'Идентификатор расхода';
COMMENT ON COLUMN core.contract_expense.insurance_contract_id IS 'Идентификатор договора страхования';
COMMENT ON COLUMN core.contract_expense.payment_date IS 'Дата оплаты расходов';
COMMENT ON COLUMN core.contract_expense.payment_amt IS 'Сумма расходов';
COMMENT ON COLUMN core.contract_expense.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.contract_expense.assistance_contract_id IS 'Идентификатор договора с ассистансом';
COMMENT ON COLUMN core.contract_expense.invoice_number IS 'Внутренний номер счета или номер счета, выставленный контрагентом';
COMMENT ON COLUMN core.contract_expense.invoice_date IS 'Дата счета, выставленного контрагентом';
COMMENT ON COLUMN core.contract_expense.is_payed IS 'Статус оплаты расходов: 1 – оплачен, 0 – не оплачен, -1 – не определен.';
COMMENT ON COLUMN core.contract_expense.contract_expense_type_id IS 'Тип расходов';
COMMENT ON COLUMN core.contract_expense.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_expense.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_expense.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_expense.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_ins_type_monitor (contract_id CHARACTER VARYING(50) NOT NULL, contract_series CHARACTER VARYING(50), contract_number CHARACTER VARYING(50), policy_series CHARACTER VARYING(50), policy_number CHARACTER VARYING(50), contract_date TIMESTAMP(6) WITHOUT TIME ZONE, insurance_type CHARACTER VARYING(254), liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, cnt_ins_type NUMERIC, dwh_date DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON COLUMN core.contract_ins_type_monitor.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_ins_type_monitor.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_link (contract_link_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), to_contract_id CHARACTER VARYING(50), contract_link_type_id NUMERIC, period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
CREATE TABLE core.contract_loan (contract_id CHARACTER VARYING(50) NOT NULL, interest_rate NUMERIC(20,8), period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
CREATE TABLE core.contract_long (contract_long_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), is_kredit_risk NUMERIC(1,0), premium_date DATE, liability_start_date DATE, liability_end_date DATE, period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), full_year NUMERIC(4,0), main_liability_start_date DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_long IS 'Многолетний договор';
COMMENT ON COLUMN core.contract_long.contract_long_id IS 'Идентификатор многолетнего условного договора';
COMMENT ON COLUMN core.contract_long.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_long.is_kredit_risk IS 'Признак наличия кредитного риска';
COMMENT ON COLUMN core.contract_long.premium_date IS 'Целевая дата начисления премии многолетнего условного договора';
COMMENT ON COLUMN core.contract_long.liability_start_date IS 'Дата начала ответственности многолетнего условного договора';
COMMENT ON COLUMN core.contract_long.liability_end_date IS 'Дата окончания ответственности многолетнего условного договора';
COMMENT ON COLUMN core.contract_long.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_long.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_long.hash IS 'Хэш';
COMMENT ON COLUMN core.contract_long.main_liability_start_date IS 'Дата начала ответственности по основному многолетнему договору';
COMMENT ON COLUMN core.contract_long.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_long.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_object (contract_object_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), period_start DATE NOT NULL, period_end DATE NOT NULL, insured_quantity NUMERIC, hash CHARACTER VARYING(32), casco_discount_coeff NUMERIC, contract_object_type_name CHARACTER VARYING(600), contract_object_сost NUMERIC(36,2), calculation CHARACTER VARYING(50), attribute1 CHARACTER VARYING(50), k5 NUMERIC, k6 NUMERIC, base_tariff NUMERIC, transport_type CHARACTER VARYING(100), amount_of_passengers NUMERIC, main_contract_object_id CHARACTER VARYING(50), building_contract_object_id CHARACTER VARYING(50), cadastral_code CHARACTER VARYING(255), total_area CHARACTER VARYING(50), floor CHARACTER VARYING(50), total_floor CHARACTER VARYING(50), total_room CHARACTER VARYING(50), build_year CHARACTER VARYING(1024), major_repair_year CHARACTER VARYING(1024), is_redevelopment_approved SMALLINT, ownership_denominator NUMERIC(36,4), ownership_numerator NUMERIC(36,4), ownership_share NUMERIC(36,4), is_townhouse SMALLINT, is_cellar SMALLINT, is_mansard SMALLINT, is_fence SMALLINT, is_rented SMALLINT, adjustment_rate NUMERIC(36,4), conditions_descr CHARACTER VARYING(2000), is_unfinished SMALLINT, is_foundation SMALLINT, is_walls SMALLINT, is_walls_interior_finishing SMALLINT, is_floor SMALLINT, is_ceiling SMALLINT, is_roof SMALLINT, partition_construction_condition_id CHARACTER VARYING(50), overlap_construction_condition_id CHARACTER VARYING(50), int_stairs_construction_condition_id CHARACTER VARYING(50), windows_construction_condition_id CHARACTER VARYING(50), entrance_door_construction_condition_id CHARACTER VARYING(50), ext_finishing_construction_condition_id CHARACTER VARYING(50), electricity_construction_condition_id CHARACTER VARYING(50), heating_construction_condition_id CHARACTER VARYING(50), water_construction_condition_id CHARACTER VARYING(50), gas_construction_condition_id CHARACTER VARYING(50), sewerage_construction_condition_id CHARACTER VARYING(50), plumbing_construction_condition_id CHARACTER VARYING(50), is_interior_door SMALLINT, is_draft_floor SMALLINT, is_mansard_overlap SMALLINT, is_mansard_int_walls SMALLINT, is_contractor SMALLINT, is_acceptance_act SMALLINT, is_in_settlement SMALLINT, is_title_document SMALLINT, is_mansard_planning SMALLINT, purchase_year INTEGER, finished_total_area NUMERIC(36,4), immovable_property_id INTEGER, ext_finishing1_coverage_area_id INTEGER, ext_finishing2_coverage_area_id INTEGER, ext_finishing1_material_id INTEGER, ext_finishing2_material_id INTEGER, parking_detail_location_id INTEGER, build_part_id INTEGER, slabs_material_id INTEGER, building_material_id INTEGER, roof_material_id INTEGER, walls_material_id INTEGER, total_flat_qty INTEGER, foundation_material_id INTEGER, wear NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, nsis_code CHARACTER VARYING(50));
COMMENT ON TABLE core.contract_object IS 'Объекты договора';
COMMENT ON COLUMN core.contract_object.contract_object_id IS 'Идентификатор объекта договора';
COMMENT ON COLUMN core.contract_object.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_object.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_object.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_object.insured_quantity IS 'Количество застрахованных';
COMMENT ON COLUMN core.contract_object.hash IS 'Хэш';
COMMENT ON COLUMN core.contract_object.casco_discount_coeff IS 'Коэффициент скидки за счет КВ';
COMMENT ON COLUMN core.contract_object.contract_object_type_name IS 'Наименование типа (и/или подтипа) объекта';
COMMENT ON COLUMN core.contract_object.contract_object_сost IS 'Стоимость объекта';
COMMENT ON COLUMN core.contract_object.calculation IS 'Идентификатор калькуляции';
COMMENT ON COLUMN core.contract_object.attribute1 IS 'Атрибут 1';
COMMENT ON COLUMN core.contract_object.k5 IS 'Коэффициент К5';
COMMENT ON COLUMN core.contract_object.k6 IS 'Коэффициент К6';
COMMENT ON COLUMN core.contract_object.base_tariff IS 'Базовый тариф по ОСАГО';
COMMENT ON COLUMN core.contract_object.transport_type IS 'Вид транспорта и вид перевозок';
COMMENT ON COLUMN core.contract_object.amount_of_passengers IS 'Количество перевезенных пассажиров';
COMMENT ON COLUMN core.contract_object.main_contract_object_id IS 'Идентификатор объекта основного договора';
COMMENT ON COLUMN core.contract_object.building_contract_object_id IS 'Только для пристроек - ссылка на объект, к которому относится пристройка';
COMMENT ON COLUMN core.contract_object.cadastral_code IS 'Кадастровый номер';
COMMENT ON COLUMN core.contract_object.total_area IS 'Общая площадь объекта, м2';
COMMENT ON COLUMN core.contract_object.floor IS 'Номер этажа в многоквартирном доме';
COMMENT ON COLUMN core.contract_object.total_floor IS 'Количество этажей в доме';
COMMENT ON COLUMN core.contract_object.total_room IS 'Количество комнат';
COMMENT ON COLUMN core.contract_object.build_year IS 'Год постройки';
COMMENT ON COLUMN core.contract_object.major_repair_year IS 'Год последнего капитального ремонта';
COMMENT ON COLUMN core.contract_object.is_redevelopment_approved IS 'Признак, что переоборудование (перепланировка) объекта произведено после получения соответствующих разрешений в установленном порядке: 1 - Да';
COMMENT ON COLUMN core.contract_object.ownership_denominator IS 'Значение знаменателя доли владения объектом в случае страхования части строения в варианте Доля в строении';
COMMENT ON COLUMN core.contract_object.ownership_numerator IS 'Значение числителя доли владения объектом в случае страхования части строения в варианте Доля в строении';
COMMENT ON COLUMN core.contract_object.ownership_share IS 'Значение в процентах доли владения объектом в случае страхования части строения в варианте Доля в строении';
COMMENT ON COLUMN core.contract_object.is_townhouse IS 'Признак, что объект является таунхаусом: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_cellar IS 'Признак, что у строения есть подвал/цокольный этаж: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_mansard IS 'Признак, что у строения есть мансарда: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_fence IS 'Признак наличия забора по периметру: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_rented IS 'Признак, что объект в аренде: 1 - Да';
COMMENT ON COLUMN core.contract_object.adjustment_rate IS 'Значение размера корректировки рассчитанной страховой стоимости объекта, %';
COMMENT ON COLUMN core.contract_object.conditions_descr IS 'Дополнительная информация/Примечание по объекту';
COMMENT ON COLUMN core.contract_object.is_unfinished IS 'Признак, что это Объект незавершенного строительства (ОНС): 1 - Да';
COMMENT ON COLUMN core.contract_object.is_foundation IS 'Признак , что работы по созданию фундамента завершены: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_walls IS 'Признак, что стены завершены: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_walls_interior_finishing IS 'Признак завершенности внутренней отделки стен: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_floor IS 'Признак завершённости полов: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_ceiling IS 'Признак завершённости потолков: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_roof IS 'Признак завершённости конструктивного элемента Крыша/кровля: 1 - Да';
COMMENT ON COLUMN core.contract_object.partition_construction_condition_id IS 'Идентификатор состояния постройки перегородки (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.overlap_construction_condition_id IS 'Идентификатор состояния постройки перекрытий (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.int_stairs_construction_condition_id IS 'Идентификатор состояния постройки внутренних лестниц (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.windows_construction_condition_id IS 'Идентификатор состояния постройки окон (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.entrance_door_construction_condition_id IS 'Идентификатор состояния постройки входной двери (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.ext_finishing_construction_condition_id IS 'Идентификатор состояния проведения внешней отделки (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.electricity_construction_condition_id IS 'Идентификатор состояния подключения электроснабжения (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.heating_construction_condition_id IS 'Идентификатор состояния подключения отопления (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.water_construction_condition_id IS 'Идентификатор состояния подключения водоснабжения (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.gas_construction_condition_id IS 'Идентификатор состояния подключения газоснабжения (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.sewerage_construction_condition_id IS 'Идентификатор состояния подключения канализации (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.plumbing_construction_condition_id IS 'Идентификатор состояния установки сантехники (Ссылка на справочник core.ref_construction_condition)';
COMMENT ON COLUMN core.contract_object.is_interior_door IS 'Признак наличия межкомнатных дверей: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_draft_floor IS 'Признак наличия черновых полов: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_mansard_overlap IS 'Признак наличия у мансарды перекрытий: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_mansard_int_walls IS 'Признак наличия внутренних стен у мансарды: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_contractor IS 'Признак того, что строительство ведет/вела подрядная организация: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_acceptance_act IS 'Признак наличия подписанного акта приёма-передач: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_in_settlement IS 'Признак нахождения строения в границах населённого пункта: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_title_document IS 'Признак наличия правоустанавливающих документов на объект: 1 - Да';
COMMENT ON COLUMN core.contract_object.is_mansard_planning IS 'Признак, что планируется мансарда: 1 - Да';
COMMENT ON COLUMN core.contract_object.purchase_year IS 'Год приобретения/заключения договора купли-продажи/договора строительного подряда';
COMMENT ON COLUMN core.contract_object.finished_total_area IS 'Общая площадь объекта с завершенной чистовой отделкой';
COMMENT ON COLUMN core.contract_object.immovable_property_id IS 'Идентификатор объекта недвижимости (Ссылка на core.ref_immovable_property)';
COMMENT ON COLUMN core.contract_object.ext_finishing1_coverage_area_id IS 'Идентификатор площади покрытия внешней отделки материалом 1 (Ссылка на справочник core.ref_coverage_area)';
COMMENT ON COLUMN core.contract_object.ext_finishing2_coverage_area_id IS 'Идентификатор площади покрытия внешней отделки материалом 2 (Ссылка на справочник core.ref_coverage_area)';
COMMENT ON COLUMN core.contract_object.ext_finishing1_material_id IS 'Идентификатор первого материала внешней отделки (Ссылка на справочник core.ref_material)';
COMMENT ON COLUMN core.contract_object.ext_finishing2_material_id IS 'Идентификатор второго материала внешней отделки (Ссылка на справочник core.ref_material)';
COMMENT ON COLUMN core.contract_object.parking_detail_location_id IS 'Уточнение местоположения машиноместа (Ссылка на справочник core.ref_detail_location)';
COMMENT ON COLUMN core.contract_object.build_part_id IS 'Идентификатор части строения, которая страхуется (Ссылка на справочник core.ref_build_part)';
COMMENT ON COLUMN core.contract_object.slabs_material_id IS 'Идентификатор материала перекрытий строения (Ссылка на справочник core.ref_material)';
COMMENT ON COLUMN core.contract_object.building_material_id IS 'Идентификатор материала, из которого построено здание (Ссылка на справочник core.ref_material)';
COMMENT ON COLUMN core.contract_object.roof_material_id IS 'Идентификатор материала крыши (Ссылка на справочник core.ref_material)';
COMMENT ON COLUMN core.contract_object.walls_material_id IS 'Идентификатор материала стен (Ссылка на справочник core.ref_material)';
COMMENT ON COLUMN core.contract_object.total_flat_qty IS 'Количество квартир в доме при страховании МКД';
COMMENT ON COLUMN core.contract_object.foundation_material_id IS 'Идентификатор материала фундамента (Ссылка на справочник core.ref_material)';
COMMENT ON COLUMN core.contract_object.wear IS 'Степень изношенности';
COMMENT ON COLUMN core.contract_object.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_object.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.contract_object.nsis_code IS 'Идентификатор объекта страхования в системе НСИС';
CREATE TABLE core.contract_object_counterparty (contract_object_counterparty_id CHARACTER VARYING(50) NOT NULL, contract_object_id CHARACTER VARYING(50), counterparty_id CHARACTER VARYING(50), counterparty_role_id BIGINT, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_object_counterparty IS 'Связь Объекта договора с Контрагентом';
COMMENT ON COLUMN core.contract_object_counterparty.contract_object_counterparty_id IS 'Идентификатор контрагента по объекту договора';
COMMENT ON COLUMN core.contract_object_counterparty.contract_object_id IS 'Идентификатор объекта договора';
COMMENT ON COLUMN core.contract_object_counterparty.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.contract_object_counterparty.counterparty_role_id IS 'Роль контрагента (справочник core.ref_counterparty_role)';
COMMENT ON COLUMN core.contract_object_counterparty.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_object_counterparty.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_object_counterparty.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_object_counterparty.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_object_element (contract_object_element_id CHARACTER VARYING(50) NOT NULL, contract_object_id CHARACTER VARYING(50), name CHARACTER VARYING(2000), type_name CHARACTER VARYING(256), insured_quantity NUMERIC(36,4), total_area NUMERIC(14,2), inner_area NUMERIC(14,2), outer_area NUMERIC(14,2), floor CHARACTER VARYING(50), build_year CHARACTER VARYING(50), install_year CHARACTER VARYING(50), repair_year CHARACTER VARYING(50), issue_year CHARACTER VARYING(50), install_date TIMESTAMP(6) WITHOUT TIME ZONE, square_meter_cost_norm NUMERIC(20,2), cost NUMERIC(36,4), adjustment_rate NUMERIC(14,2), conditions_descr CHARACTER VARYING(1333), is_natural_disaster SMALLINT, is_construction SMALLINT, is_drainage SMALLINT, is_pumping SMALLINT, is_complex_relief SMALLINT, is_complex_soil SMALLINT, is_landscape_majority_wood SMALLINT, is_exotic_plant SMALLINT, is_contractor SMALLINT, landscape_id CHARACTER VARYING(50), soil_type_id INTEGER, movable_property_id INTEGER, walls_material_id INTEGER, structural_element_id INTEGER, nonstandard_criteria_id INTEGER, premise_id INTEGER, finishing_type_id INTEGER, additional_equipment_id INTEGER, external_equipment_id INTEGER, period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, wear CHARACTER VARYING(256), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_object_element IS 'Элементы объекта на договоре';
COMMENT ON COLUMN core.contract_object_element.contract_object_element_id IS 'Идентификатор элемента объекта на договоре';
COMMENT ON COLUMN core.contract_object_element.contract_object_id IS 'Идентификатор объекта договора (ссылка на core.contract_object)';
COMMENT ON COLUMN core.contract_object_element.name IS 'Наименование элемента объекта на договоре';
COMMENT ON COLUMN core.contract_object_element.type_name IS 'Наименование типа элемента объекта на договоре';
COMMENT ON COLUMN core.contract_object_element.insured_quantity IS 'Количество элементов данного типа в описи. Например, для ландшафтного дизайна может быть в описи дерево. В данном поле будет количество таких деревьев в описи.';
COMMENT ON COLUMN core.contract_object_element.total_area IS 'Общая площадь, м2';
COMMENT ON COLUMN core.contract_object_element.inner_area IS 'Площадь внутренняя';
COMMENT ON COLUMN core.contract_object_element.outer_area IS 'Площадь наружная (по наружным обмерам)';
COMMENT ON COLUMN core.contract_object_element.floor IS 'Номер этажа';
COMMENT ON COLUMN core.contract_object_element.build_year IS 'Год постройки объекта';
COMMENT ON COLUMN core.contract_object_element.install_year IS 'Год установки';
COMMENT ON COLUMN core.contract_object_element.repair_year IS 'Год ВОиИО (последнего ремонта)';
COMMENT ON COLUMN core.contract_object_element.issue_year IS 'Год выпуска';
COMMENT ON COLUMN core.contract_object_element.install_date IS 'Дата установки';
COMMENT ON COLUMN core.contract_object_element.square_meter_cost_norm IS 'Норма стоимости 1м2';
COMMENT ON COLUMN core.contract_object_element.cost IS 'Стоимость по документам, фактическая стоимость';
COMMENT ON COLUMN core.contract_object_element.adjustment_rate IS 'Значение размера корректировки рассчитанной страховой стоимости объекта, %';
COMMENT ON COLUMN core.contract_object_element.conditions_descr IS 'Дополнительная информация/Примечание по элементу объекта';
COMMENT ON COLUMN core.contract_object_element.is_natural_disaster IS 'Признак стихийных бедствий на территории страхования: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.is_construction IS 'Признак, что на объекте ведется / планируется стройка в период страхования: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.is_drainage IS 'Признак наличия дренажной системы: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.is_pumping IS 'Признак наличия системы откачки: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.is_complex_relief IS 'Признак, что рельеф является сложным: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.is_complex_soil IS 'Признак , что уплотненная и плохо иссушаемая почва/ заболоченность отдельных частей территории страхования/ уровень грунтовых вод на территории страхования высокий: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.is_landscape_majority_wood IS 'Признак , что большинство объектов ландшафтного дизайна выполнены из дерева: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.is_exotic_plant IS 'Признак наличия экзотических растений/ несоответствия, высаженных растений, местным климатическим условиям: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.is_contractor IS 'Признак, что работы выполнены профильной фирмой/подрядной организацией: 1 - Да';
COMMENT ON COLUMN core.contract_object_element.landscape_id IS 'Идентификатор объекта ландшафтного дизайна (Ссылка на справочник core.ref_landscape)';
COMMENT ON COLUMN core.contract_object_element.soil_type_id IS 'Идентификатор типа почвы (Ссылка на справочник core.ref_soil_type)';
COMMENT ON COLUMN core.contract_object_element.movable_property_id IS 'Идентификатор домашнего имущества (Ссылка на справочник core.ref_movable_property)';
COMMENT ON COLUMN core.contract_object_element.walls_material_id IS 'Идентификатор материала стен (Ссылка на справочник core.ref_material)';
COMMENT ON COLUMN core.contract_object_element.structural_element_id IS 'Идентификатор нового/замененного конструктивного элемента (Ссылка на справочник core.ref_structural_element)';
COMMENT ON COLUMN core.contract_object_element.nonstandard_criteria_id IS 'Идентификатор критерия нестандартности (Ссылка на справочник core.ref_nonstandard_criteria)';
COMMENT ON COLUMN core.contract_object_element.premise_id IS 'Идентификатор помещения (Ссылка на справочник core.ref_premise)';
COMMENT ON COLUMN core.contract_object_element.finishing_type_id IS 'Идентификатор типа ВОиИО (Ссылка на справочник core.ref_finishing_type)';
COMMENT ON COLUMN core.contract_object_element.additional_equipment_id IS 'Идентификатор дополнительного инженерного оборудования (ИО) (Ссылка на справочник core.ref_additional_equipment)';
COMMENT ON COLUMN core.contract_object_element.external_equipment_id IS 'Идентификатор внешнего оборудования (Ссылка на справочник core.ref_external_equipment)';
COMMENT ON COLUMN core.contract_object_element.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_object_element.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_object_element.wear IS 'Степень изношенности';
COMMENT ON COLUMN core.contract_object_element.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_object_element.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_object_reservation (contract_object_reservation_id CHARACTER VARYING(100) NOT NULL, contract_object_id CHARACTER VARYING(50), reservation_id CHARACTER VARYING(25), reservation_value_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_object_reservation IS 'Оговорки объекта на договоре';
COMMENT ON COLUMN core.contract_object_reservation.contract_object_reservation_id IS 'Идентификатор значения оговорки объекта';
COMMENT ON COLUMN core.contract_object_reservation.contract_object_id IS 'Идентификатор объекта договора';
COMMENT ON COLUMN core.contract_object_reservation.reservation_id IS 'Идентификатор оговорки';
COMMENT ON COLUMN core.contract_object_reservation.reservation_value_id IS 'Идентификатор значения оговорки';
COMMENT ON COLUMN core.contract_object_reservation.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_object_reservation.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_object_reservation.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_object_reservation.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_project (contract_project_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), contract_project_type INTEGER, contract_project_code CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_project IS 'Проекты и программы';
COMMENT ON COLUMN core.contract_project.contract_project_id IS 'Идентификатор проекта/программы';
COMMENT ON COLUMN core.contract_project.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_project.contract_project_type IS 'Тип: 1 – Проект; 2 – Программа.';
COMMENT ON COLUMN core.contract_project.contract_project_code IS 'Код проекта/программы';
COMMENT ON COLUMN core.contract_project.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_project.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_project.hash IS 'Хэш';
COMMENT ON COLUMN core.contract_project.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_project.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_reason_change (contract_reason_change_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), change_type INTEGER, change_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_reason_change IS 'Причины изменения договора';
COMMENT ON COLUMN core.contract_reason_change.contract_reason_change_id IS 'Идентификатор причины изменения';
COMMENT ON COLUMN core.contract_reason_change.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_reason_change.change_type IS 'Код типа изменения. 1 – новый договор, 2 – переоформление, 3 – исправление ошибки, 4 – расторжение, 5 – другие изменения по договору.';
COMMENT ON COLUMN core.contract_reason_change.change_timestamp IS 'Дата и время изменения';
COMMENT ON COLUMN core.contract_reason_change.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_reason_change.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_reinsurance (contract_id CHARACTER VARYING(50) NOT NULL, type_name CHARACTER VARYING(4000), subtype_name CHARACTER VARYING(4000), payment_cur_code CHARACTER VARYING(7), account_code CHARACTER VARYING(255), market_name CHARACTER VARYING(4000), segment_name CHARACTER VARYING(4000), broker_contract_number CHARACTER VARYING(100), is_significance_test_pass SMALLINT, is_onerous_contract SMALLINT, possible_extension_days DOUBLE PRECISION, coverage_base CHARACTER VARYING(255), reinsurance_limit CHARACTER VARYING(1000), priority_description CHARACTER VARYING(1000), applicable_law CHARACTER VARYING(255), is_strict_liability SMALLINT, is_netting_possible SMALLINT, reinsurer_payment_conditions CHARACTER VARYING(1000), invest_component_amt NUMERIC(40,10), premium_payment_frequency CHARACTER VARYING(255), commission_payment_frequency CHARACTER VARYING(255), registration_date DATE, period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, accept_date TIMESTAMP(6) WITHOUT TIME ZONE, effective_date TIMESTAMP(6) WITHOUT TIME ZONE, schema_descr CHARACTER VARYING(1000), original_coverage_descr CHARACTER VARYING(1000), accounting_type_name CHARACTER VARYING(1000), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_reinsurance IS 'Договоры перестрахования';
COMMENT ON COLUMN core.contract_reinsurance.contract_id IS 'Идентификатор договора (первичный ключ, внешний ключ на табл. contract)';
COMMENT ON COLUMN core.contract_reinsurance.type_name IS 'Типа договора - Наименование';
COMMENT ON COLUMN core.contract_reinsurance.subtype_name IS 'Подтип договора - Наименование';
COMMENT ON COLUMN core.contract_reinsurance.payment_cur_code IS 'Валюта расчетов - Код';
COMMENT ON COLUMN core.contract_reinsurance.account_code IS 'Бухгалтерский код договора';
COMMENT ON COLUMN core.contract_reinsurance.market_name IS 'Рынок - Наименование';
COMMENT ON COLUMN core.contract_reinsurance.segment_name IS 'Сегментация договора для отчетности - Наименование';
COMMENT ON COLUMN core.contract_reinsurance.broker_contract_number IS 'Номер договора с брокером';
COMMENT ON COLUMN core.contract_reinsurance.is_significance_test_pass IS 'Признак прохождения тест на значительность: 1 - Да, 0 - Нет, -1 - Не определен';
COMMENT ON COLUMN core.contract_reinsurance.is_onerous_contract IS 'Признак являются ли базовые договоры страхования обременительными: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.contract_reinsurance.possible_extension_days IS 'Оценка возможного увеличения срока ответственности договора перестрахования';
COMMENT ON COLUMN core.contract_reinsurance.coverage_base IS 'База покрытия';
COMMENT ON COLUMN core.contract_reinsurance.reinsurance_limit IS 'Емкость (лимит перестрахования)';
COMMENT ON COLUMN core.contract_reinsurance.priority_description IS 'Приоритет';
COMMENT ON COLUMN core.contract_reinsurance.applicable_law IS 'Применяемое право/юрисдикция';
COMMENT ON COLUMN core.contract_reinsurance.is_strict_liability IS 'Признак является ли безусловным обязательством: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.contract_reinsurance.is_netting_possible IS 'Признак возможности взаимозачета: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.contract_reinsurance.reinsurer_payment_conditions IS 'Условия расчетов/оплат с перестраховщиком';
COMMENT ON COLUMN core.contract_reinsurance.invest_component_amt IS 'Величина невыделяемой инвестиционной составляющей (при наличии) (для МСФО 17)';
COMMENT ON COLUMN core.contract_reinsurance.premium_payment_frequency IS 'Периодичность оплаты премии, переданной в перестрахование (по договору)';
COMMENT ON COLUMN core.contract_reinsurance.commission_payment_frequency IS 'Периодичность оплаты комиссии брокеру (по договору)';
COMMENT ON COLUMN core.contract_reinsurance.registration_date IS 'Дата регистрации';
COMMENT ON COLUMN core.contract_reinsurance.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_reinsurance.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_reinsurance.accept_date IS 'Дата акцепта';
COMMENT ON COLUMN core.contract_reinsurance.effective_date IS 'Дата вступления в силу';
COMMENT ON COLUMN core.contract_reinsurance.schema_descr IS 'Описание схемы перестрахования';
COMMENT ON COLUMN core.contract_reinsurance.original_coverage_descr IS 'Покрываемые виды страхования';
COMMENT ON COLUMN core.contract_reinsurance.accounting_type_name IS 'Вид учета';
COMMENT ON COLUMN core.contract_reinsurance.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_reinsurance.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_risk_factor (contract_risk_factor_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), risk_factor_id INTEGER, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_risk_factor IS 'Факторы риска на договоре';
COMMENT ON COLUMN core.contract_risk_factor.contract_risk_factor_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.contract_risk_factor.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.contract_risk_factor.risk_factor_id IS 'Идентификатор фактора риска';
COMMENT ON COLUMN core.contract_risk_factor.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_risk_factor.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_risk_factor.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_risk_factor.key_id IS 'Уникальный ключ';
CREATE TABLE core.contract_source_user (contract_source_user_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50) NOT NULL, source_user_id CHARACTER VARYING(50) NOT NULL, contract_source_user_type_id CHARACTER VARYING(50) NOT NULL, period_start DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT now(), key_id UUID NOT NULL);
COMMENT ON TABLE core.contract_source_user IS 'Связь пользователя с контрактом';
COMMENT ON COLUMN core.contract_source_user.contract_source_user_id IS 'Уникальный идентификатор строки';
COMMENT ON COLUMN core.contract_source_user.contract_id IS 'Идентификатор контракта';
COMMENT ON COLUMN core.contract_source_user.source_user_id IS 'Идентификатор пользователя';
COMMENT ON COLUMN core.contract_source_user.contract_source_user_type_id IS 'Идентификатор типа связи пользователя с контрактом';
COMMENT ON COLUMN core.contract_source_user.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.contract_source_user.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.contract_source_user.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.contract_source_user.key_id IS 'Уникальный ключ';
CREATE TABLE core.counterparty (counterparty_id CHARACTER VARYING(50) NOT NULL, counterparty_type INTEGER, is_resident INTEGER, country_reg CHARACTER VARYING(7), inn CHARACTER VARYING(50), okpo CHARACTER VARYING(50), ogrn CHARACTER VARYING(50), kpp CHARACTER VARYING(50), vip_code CHARACTER VARYING(50), last_name CHARACTER VARYING(512), first_name CHARACTER VARYING(512), middle_name CHARACTER VARYING(512), birth_date DATE, sex CHARACTER VARYING(1), snils CHARACTER VARYING(50), birth_place CHARACTER VARYING(512), driving_start_date DATE, name CHARACTER VARYING(512), agent_code CHARACTER VARYING(150), is_active_agent NUMERIC(1,0), agent_date_start TIMESTAMP(6) WITHOUT TIME ZONE, agent_date_end TIMESTAMP(6) WITHOUT TIME ZONE, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), agent_manager_id CHARACTER VARYING(50), card_id CHARACTER VARYING(50), is_not_prolongation NUMERIC(1,0), opf CHARACTER VARYING(512), short_name CHARACTER VARYING(512), last_name_lat CHARACTER VARYING(512), first_name_lat CHARACTER VARYING(512), agent_level CHARACTER VARYING(512), agent_category CHARACTER VARYING(100), agent_code_source CHARACTER VARYING(50), sale_group CHARACTER VARYING(2000), sitizenship_code CHARACTER VARYING(7), jur_code CHARACTER VARYING(255), intermediary_status CHARACTER VARYING(4000), counterparty_category CHARACTER VARYING(4000), login CHARACTER VARYING(255), emp_relation_type SMALLINT, is_material SMALLINT, dp_code CHARACTER VARYING(300), is_license_broker SMALLINT, manual_okved_code CHARACTER VARYING(255), interfax_code CHARACTER VARYING(300), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, liquidation_date DATE, is_lk_registered SMALLINT, auth_channel_code CHARACTER VARYING(50), key_id UUID NOT NULL, service_start_date TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.counterparty IS 'Контрагент';
COMMENT ON COLUMN core.counterparty.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.counterparty.counterparty_type IS 'Тип контрагента. 1 – Физическое лицо, 2 – Юридическое лицо, 5 – ИП';
COMMENT ON COLUMN core.counterparty.is_resident IS 'Признак резидента';
COMMENT ON COLUMN core.counterparty.country_reg IS 'Страна регистрации';
COMMENT ON COLUMN core.counterparty.inn IS 'ИНН';
COMMENT ON COLUMN core.counterparty.okpo IS 'Код ОКПО';
COMMENT ON COLUMN core.counterparty.ogrn IS 'Код ОГРН';
COMMENT ON COLUMN core.counterparty.kpp IS 'КПП';
COMMENT ON COLUMN core.counterparty.vip_code IS 'Код ключевого контрагента';
COMMENT ON COLUMN core.counterparty.last_name IS 'Фамилия';
COMMENT ON COLUMN core.counterparty.first_name IS 'Имя';
COMMENT ON COLUMN core.counterparty.middle_name IS 'Отчество';
COMMENT ON COLUMN core.counterparty.birth_date IS 'Дата рождения';
COMMENT ON COLUMN core.counterparty.sex IS 'Пол';
COMMENT ON COLUMN core.counterparty.snils IS 'СНИЛС';
COMMENT ON COLUMN core.counterparty.birth_place IS 'Место рождения';
COMMENT ON COLUMN core.counterparty.driving_start_date IS 'Дата начала водительского стажа';
COMMENT ON COLUMN core.counterparty.name IS 'Наименование юридического лица';
COMMENT ON COLUMN core.counterparty.agent_code IS 'Личный номер работника / Код агента';
COMMENT ON COLUMN core.counterparty.is_active_agent IS 'Флаг действующего агента: 0 - не действующий, 1 - действующий';
COMMENT ON COLUMN core.counterparty.agent_date_start IS 'Дата агентского соглашения/приема на работу';
COMMENT ON COLUMN core.counterparty.agent_date_end IS 'Дата увольнения';
COMMENT ON COLUMN core.counterparty.modify_date IS 'Дата модификации';
COMMENT ON COLUMN core.counterparty.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.counterparty.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.counterparty.hash IS 'Хэш';
COMMENT ON COLUMN core.counterparty.agent_manager_id IS 'Идентификатор менеджера агента';
COMMENT ON COLUMN core.counterparty.card_id IS 'Идентификатор агента в системе БОСС-кадровик';
COMMENT ON COLUMN core.counterparty.is_not_prolongation IS 'Не подлежит пролонгации в офисном канале';
COMMENT ON COLUMN core.counterparty.opf IS 'Организационно-правовая форма';
COMMENT ON COLUMN core.counterparty.short_name IS 'Краткое наименование';
COMMENT ON COLUMN core.counterparty.last_name_lat IS 'Фамилия на латинице';
COMMENT ON COLUMN core.counterparty.first_name_lat IS 'Имя на латинице';
COMMENT ON COLUMN core.counterparty.agent_level IS 'Уровень агента';
COMMENT ON COLUMN core.counterparty.agent_category IS 'Категория агента';
COMMENT ON COLUMN core.counterparty.agent_code_source IS 'Личный номер работника / Код агента (не преобразованный)';
COMMENT ON COLUMN core.counterparty.sale_group IS 'Группа продавцов';
COMMENT ON COLUMN core.counterparty.sitizenship_code IS 'Гражданство (код страны)';
COMMENT ON COLUMN core.counterparty.jur_code IS 'ID СКК ЮЛ (в СКК 7.1.40)';
COMMENT ON COLUMN core.counterparty.intermediary_status IS 'Статус посредника';
COMMENT ON COLUMN core.counterparty.counterparty_category IS 'Категория контрагента';
COMMENT ON COLUMN core.counterparty.login IS 'Имя пользователя в системе авторизации';
COMMENT ON COLUMN core.counterparty.emp_relation_type IS 'Форма/тип трудовых отношений: 1 - Трудовой договор, 2 - Агент, 3 - ГПХ';
COMMENT ON COLUMN core.counterparty.is_material IS 'Признак МОЛ (материально ответственное лицо) по БСО (бланкам строгой отчетности) : 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.counterparty.dp_code IS 'Код департамента перестрахования (ДП) контрагента';
COMMENT ON COLUMN core.counterparty.is_license_broker IS 'Признак наличия у контрагента лицензии брокера: 1 - Да';
COMMENT ON COLUMN core.counterparty.manual_okved_code IS 'ОКВЭД - Общероссийский классификатор видов экономической деятельности';
COMMENT ON COLUMN core.counterparty.interfax_code IS 'Код системы Интерфакс';
COMMENT ON COLUMN core.counterparty.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.counterparty.liquidation_date IS 'Дата ликвидации юридического лица';
COMMENT ON COLUMN core.counterparty.is_lk_registered IS 'Признак регистрации клиента в ЛКК';
COMMENT ON COLUMN core.counterparty.auth_channel_code IS 'Канал авторизации клиента в системе ОФР';
COMMENT ON COLUMN core.counterparty.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.counterparty.service_start_date IS 'Дата начала обслуживания контрагента';
CREATE TABLE core.counterparty_course (counterparty_course_id CHARACTER VARYING(50) NOT NULL, status_name CHARACTER VARYING(50), appointment_date DATE, start_date DATE, end_date DATE, counterparty_id CHARACTER VARYING(50), achieved_score DOUBLE PRECISION, is_active SMALLINT, course_id CHARACTER VARYING(50), is_self_appointed SMALLINT, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.counterparty_course IS 'Данные о назначенном курсе онлайн обучения сотрудниками РГС';
COMMENT ON COLUMN core.counterparty_course.counterparty_course_id IS 'Идентификатор назначенного курса';
COMMENT ON COLUMN core.counterparty_course.status_name IS 'Наименование статуса курса';
COMMENT ON COLUMN core.counterparty_course.appointment_date IS 'Дата назначения курса';
COMMENT ON COLUMN core.counterparty_course.start_date IS 'Дата начала курса';
COMMENT ON COLUMN core.counterparty_course.end_date IS 'Дата завершения курса';
COMMENT ON COLUMN core.counterparty_course.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.counterparty_course.achieved_score IS 'Набранный балл по курсу';
COMMENT ON COLUMN core.counterparty_course.is_active IS 'Признак активности курса (1 – да, 0 - нет)';
COMMENT ON COLUMN core.counterparty_course.course_id IS 'Идентификатор курса (ссылка на COURSE)';
COMMENT ON COLUMN core.counterparty_course.is_self_appointed IS 'Признак назначения курса самостоятельно';
COMMENT ON COLUMN core.counterparty_course.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.counterparty_course.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.counterparty_course.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.counterparty_course.key_id IS 'Уникальный ключ';
CREATE TABLE core.counterparty_link (counterparty_link_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), to_counterparty_id CHARACTER VARYING(50), counterparty_link_type_id CHARACTER VARYING(50), effective_start TIMESTAMP(6) WITHOUT TIME ZONE, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, _fkey CHARACTER VARYING(256), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.counterparty_link IS 'Связи контрагентов';
COMMENT ON COLUMN core.counterparty_link.counterparty_link_id IS 'Идентификатор связи';
COMMENT ON COLUMN core.counterparty_link.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.counterparty_link.to_counterparty_id IS 'Идентификатор связанного контрагента';
COMMENT ON COLUMN core.counterparty_link.counterparty_link_type_id IS 'Идентификатор типа связи Ссылка на core.ref_counterparty_link_type';
COMMENT ON COLUMN core.counterparty_link.effective_start IS 'Дата начала действия связи';
COMMENT ON COLUMN core.counterparty_link.effective_end IS 'Дата окончания действия связи';
COMMENT ON COLUMN core.counterparty_link.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.counterparty_link.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.counterparty_link.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.counterparty_link.key_id IS 'Уникальный ключ';
CREATE TABLE core.counterparty_operator (counterparty_operator_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), operator_id CHARACTER VARYING(50), period_start DATE NOT NULL, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.counterparty_operator IS 'Связь контрагента (персоны) с оператором';
COMMENT ON COLUMN core.counterparty_operator.counterparty_operator_id IS 'Идентификатор связи';
COMMENT ON COLUMN core.counterparty_operator.counterparty_id IS 'Идентификатор персоны';
COMMENT ON COLUMN core.counterparty_operator.operator_id IS 'Идентификатор оператора';
COMMENT ON COLUMN core.counterparty_operator.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.counterparty_operator.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.counterparty_operator.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.counterparty_operator.key_id IS 'Уникальный ключ';
CREATE TABLE core.counterparty_role (counterparty_role_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), role_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.counterparty_role IS 'Связь контрагента с ролью';
COMMENT ON COLUMN core.counterparty_role.counterparty_role_id IS 'Идентификатор связи';
COMMENT ON COLUMN core.counterparty_role.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.counterparty_role.role_id IS 'Идентификатор роли';
COMMENT ON COLUMN core.counterparty_role.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.counterparty_role.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.counterparty_role.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.counterparty_role.key_id IS 'Уникальный ключ';
CREATE TABLE core.course (course_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(250), passing_score DOUBLE PRECISION, maximum_score DOUBLE PRECISION, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.course IS 'Данные об онлайн курсах обучения сотрудников РГС';
COMMENT ON COLUMN core.course.course_id IS 'Идентификатор курса';
COMMENT ON COLUMN core.course.name IS 'Наименование курса';
COMMENT ON COLUMN core.course.passing_score IS 'Проходной балл по курсу';
COMMENT ON COLUMN core.course.maximum_score IS 'Максимальный балл по курсу';
COMMENT ON COLUMN core.course.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.course.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.course.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.course.key_id IS 'Уникальный ключ';
CREATE TABLE core.de_map_arm_plan (arm_code CHARACTER VARYING(2) NOT NULL, code_plan_id NUMERIC(3,0) NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.de_map_arm_plan.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.de_plan_region (code_plan_id NUMERIC(3,0) NOT NULL, code_plan_name CHARACTER VARYING(255), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.de_plan_region.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.de_terr_group (arm_code CHARACTER VARYING(2), file_code CHARACTER VARYING(10), file_code_name CHARACTER VARYING(50), code_name CHARACTER VARYING(50), code_plan_name CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.de_terr_group.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.de_terr_group_bkp (arm_code CHARACTER VARYING(2), file_code CHARACTER VARYING(10), file_code_name CHARACTER VARYING(50), code_name CHARACTER VARYING(50), code_plan_name CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
CREATE TABLE core.de_terr_group_fresh (arm_code CHARACTER VARYING(2), file_code CHARACTER VARYING(10), file_code_name CHARACTER VARYING(50), code_name CHARACTER VARYING(50), code_plan_name CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
CREATE TABLE core.debt_agent (debt_agent_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), agent_id CHARACTER VARYING(50), agent_statement_id CHARACTER VARYING(50), payment_id CHARACTER VARYING(50), is_offset_unpaid_premium NUMERIC(1,0), is_return_premium NUMERIC(1,0), premium_cur CHARACTER VARYING(7), get_premium_amt NUMERIC, get_premium_rub NUMERIC, adz_date TIMESTAMP(6) WITHOUT TIME ZONE, adz_amt NUMERIC, adz_rub NUMERIC, debit_writeoff_date TIMESTAMP(6) WITHOUT TIME ZONE, debit_writeoff_reason CHARACTER VARYING(7), next_collection_date TIMESTAMP(6) WITHOUT TIME ZONE, hash CHARACTER VARYING(32), period_start DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, is_kv_retention CHARACTER VARYING(1), kv_amt NUMERIC, agentreport_number CHARACTER VARYING(255), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.debt_agent IS 'Задолженность агента (АДЗ)';
COMMENT ON COLUMN core.debt_agent.debt_agent_id IS 'Идентификатор задолженности агента';
COMMENT ON COLUMN core.debt_agent.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.debt_agent.agent_id IS 'Идентификатор агента, принявшего платеж';
COMMENT ON COLUMN core.debt_agent.agent_statement_id IS 'Идентификатор отчёта агента, принявшего платеж';
COMMENT ON COLUMN core.debt_agent.payment_id IS 'Идентификатор оплаты по договору';
COMMENT ON COLUMN core.debt_agent.is_offset_unpaid_premium IS 'Платеж c типом «Зачет убытка в части неоплаченной премии»';
COMMENT ON COLUMN core.debt_agent.is_return_premium IS 'Тип документа «Расчет на возврат части страховой премии»';
COMMENT ON COLUMN core.debt_agent.premium_cur IS 'Валюта договора';
COMMENT ON COLUMN core.debt_agent.get_premium_amt IS 'Сумма полученной премии в валюте договора';
COMMENT ON COLUMN core.debt_agent.get_premium_rub IS 'Сумма полученной премии в рублях';
COMMENT ON COLUMN core.debt_agent.adz_date IS 'Дата оплаты страхователем';
COMMENT ON COLUMN core.debt_agent.adz_amt IS 'Сумма АДЗ в валюте';
COMMENT ON COLUMN core.debt_agent.adz_rub IS 'Сумма АДЗ в рублях';
COMMENT ON COLUMN core.debt_agent.debit_writeoff_date IS 'Дата списания дебиторской задолженности агента';
COMMENT ON COLUMN core.debt_agent.debit_writeoff_reason IS 'Причина списания АДЗ';
COMMENT ON COLUMN core.debt_agent.next_collection_date IS 'Будущая дата получения платежа';
COMMENT ON COLUMN core.debt_agent.hash IS 'Хэш';
COMMENT ON COLUMN core.debt_agent.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.debt_agent.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.debt_agent.is_kv_retention IS 'Признак удержания партнеров КВ (комиссионное вознаграждение) при осуществлении платежа';
COMMENT ON COLUMN core.debt_agent.kv_amt IS 'Сумма КВ в валюте';
COMMENT ON COLUMN core.debt_agent.agentreport_number IS 'Номер агентского/партнерского счёта';
COMMENT ON COLUMN core.debt_agent.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.debt_client (debt_client_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), main_contract_id CHARACTER VARYING(50), parent_contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), next_expected_date TIMESTAMP(6) WITHOUT TIME ZONE, next_payment_date TIMESTAMP(6) WITHOUT TIME ZONE, kdz_amt NUMERIC, premium_cur CHARACTER VARYING(7), kdz_rub NUMERIC, kdz_all_amt NUMERIC, kdz_all_rub NUMERIC, kdz_contr_amt NUMERIC, kdz_contr_all_amt NUMERIC, debit_writeoff_date TIMESTAMP(6) WITHOUT TIME ZONE, debit_writeoff_reason CHARACTER VARYING(7), contract_cancel_date TIMESTAMP(6) WITHOUT TIME ZONE, hash CHARACTER VARYING(32), period_start DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.debt_client IS 'Задолженность клиента (КДЗ)';
COMMENT ON COLUMN core.debt_client.debt_client_id IS 'Идентификатор задолженности клиента';
COMMENT ON COLUMN core.debt_client.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.debt_client.main_contract_id IS 'Идентификатор основного договора';
COMMENT ON COLUMN core.debt_client.parent_contract_id IS 'Идентификатор родительского договора';
COMMENT ON COLUMN core.debt_client.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.debt_client.next_expected_date IS 'Дата следующего платежа по графику';
COMMENT ON COLUMN core.debt_client.next_payment_date IS 'Дата первой будущей оплаты';
COMMENT ON COLUMN core.debt_client.kdz_amt IS 'Сумма КДЗ в валюте на текущую дату';
COMMENT ON COLUMN core.debt_client.premium_cur IS 'Валюта договора';
COMMENT ON COLUMN core.debt_client.kdz_rub IS 'Сумма КДЗ в рублях на текущую дату';
COMMENT ON COLUMN core.debt_client.kdz_all_amt IS 'Сумма КДЗ в валюте, все оплаты';
COMMENT ON COLUMN core.debt_client.kdz_all_rub IS 'Сумма КДЗ в рублях, все оплаты';
COMMENT ON COLUMN core.debt_client.kdz_contr_amt IS 'Сумма КДЗ по договору в валюте, оплаты до текущей даты';
COMMENT ON COLUMN core.debt_client.kdz_contr_all_amt IS 'Сумма КДЗ по договору в валюте, все оплаты';
COMMENT ON COLUMN core.debt_client.debit_writeoff_date IS 'Дата списания КДЗ';
COMMENT ON COLUMN core.debt_client.debit_writeoff_reason IS 'Причина списания КДЗ';
COMMENT ON COLUMN core.debt_client.contract_cancel_date IS 'Дата расторжения договора';
COMMENT ON COLUMN core.debt_client.hash IS 'Хэш';
COMMENT ON COLUMN core.debt_client.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.debt_client.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.debt_client.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.declared_return (declared_return_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50) NOT NULL, object_risk_id CHARACTER VARYING(50) NOT NULL, application_date TIMESTAMP(6) WITHOUT TIME ZONE, return_amt NUMERIC(38,2), return_cur CHARACTER VARYING(7), return_source_rub NUMERIC(38,2), return_rub NUMERIC(38,2), cur_rate_date DATE, cur_rate NUMERIC(38,4), return_type NUMERIC(1,0), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), application_number CHARACTER VARYING(256), order_date TIMESTAMP(6) WITHOUT TIME ZONE, is_main INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.declared_return IS 'Заявленный возврат';
COMMENT ON COLUMN core.declared_return.declared_return_id IS 'Идентификатор заявленного возврата';
COMMENT ON COLUMN core.declared_return.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.declared_return.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.declared_return.application_date IS 'Дата заявления о возврате';
COMMENT ON COLUMN core.declared_return.return_amt IS 'Сумма заявленного возврата в валюте';
COMMENT ON COLUMN core.declared_return.return_cur IS 'Код валюты';
COMMENT ON COLUMN core.declared_return.return_source_rub IS 'Сумма заявленного возврата в рублях';
COMMENT ON COLUMN core.declared_return.return_rub IS 'Сумма заявленного возврата в рублях расчётная';
COMMENT ON COLUMN core.declared_return.cur_rate_date IS 'Дата определения курса';
COMMENT ON COLUMN core.declared_return.cur_rate IS 'Курс валюты';
COMMENT ON COLUMN core.declared_return.return_type IS 'Тип возврата: 1 – возврат при расторжении, 2 – обычный возврат';
COMMENT ON COLUMN core.declared_return.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.declared_return.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.declared_return.hash IS 'Хэш';
COMMENT ON COLUMN core.declared_return.application_number IS 'Номер заявления о возврате';
COMMENT ON COLUMN core.declared_return.order_date IS 'Дата распоряжения на возврат части страховой премии';
COMMENT ON COLUMN core.declared_return.is_main IS 'Признак основного возврата: 1 - основной возврат, 0 - дополнительный возврат, -1 - не определено';
COMMENT ON COLUMN core.declared_return.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.declared_return.key_id IS 'Уникальный ключ';
CREATE TABLE core.declared_return_long (declared_return_long_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), application_date DATE, return_amt NUMERIC(36,2), return_cur CHARACTER VARYING(7), return_rub NUMERIC(36,2), cur_rate_date DATE, cur_rate NUMERIC(42,4), return_type SMALLINT, period_start DATE, period_end DATE NOT NULL, object_risk_long_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.declared_return_long IS 'Заявленный возврат при расторжении многолетних договоров';
COMMENT ON COLUMN core.declared_return_long.declared_return_long_id IS 'Идентификатор заявленного возврата';
COMMENT ON COLUMN core.declared_return_long.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.declared_return_long.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.declared_return_long.application_date IS 'Дата заявления о возврате';
COMMENT ON COLUMN core.declared_return_long.return_amt IS 'Сумма заявленного возврата в валюте';
COMMENT ON COLUMN core.declared_return_long.return_cur IS 'Код валюты';
COMMENT ON COLUMN core.declared_return_long.return_rub IS 'Сумма заявленного возврата в рублях расчётная';
COMMENT ON COLUMN core.declared_return_long.cur_rate_date IS 'Дата определения курса';
COMMENT ON COLUMN core.declared_return_long.cur_rate IS 'Курс валюты';
COMMENT ON COLUMN core.declared_return_long.return_type IS 'Тип возврата: 1 – возврат при расторжении, 2 – обычный возврат.';
COMMENT ON COLUMN core.declared_return_long.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.declared_return_long.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.declared_return_long.object_risk_long_id IS 'Идентификатор риска по объекту для многолетнего условного договора';
COMMENT ON COLUMN core.declared_return_long.contract_long_id IS 'Идентификатор многолетнего условного договора';
COMMENT ON COLUMN core.declared_return_long.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.declared_return_long.key_id IS 'Уникальный ключ';
CREATE TABLE core.deferred_payment (deferred_payment_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), deferred_payment_type_id INTEGER, payment_date TIMESTAMP(6) WITHOUT TIME ZONE, cur_code CHARACTER VARYING(7), payment_amt NUMERIC(36,10), payment_rub NUMERIC(36,10), is_paid INTEGER, counterparty_id CHARACTER VARYING(50), liability_share NUMERIC(36,10), insurance_type_code CHARACTER VARYING(40), insurance_type_name CHARACTER VARYING(4000), note CHARACTER VARYING(4000), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, insurance_contract_id CHARACTER VARYING(50), billing_start_date DATE, billing_end_date DATE, billing_rub_amt NUMERIC(36,10), object_risk_type_id TEXT, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, calculation_date DATE, adjustment_type_name CHARACTER VARYING(1000), key_id UUID NOT NULL);
COMMENT ON TABLE core.deferred_payment IS 'Оплаты будущих периодов';
COMMENT ON COLUMN core.deferred_payment.deferred_payment_id IS 'Идентификатор будущих доходов (первичный ключ)';
COMMENT ON COLUMN core.deferred_payment.contract_id IS 'Идентификатор основного/ипотечного договора (внешний ключ на табл. contract)/Идентификатор договора перестрахования';
COMMENT ON COLUMN core.deferred_payment.deferred_payment_type_id IS 'Тип графика оплат (внешний ключ на справочник ref_deferred_payment_type)';
COMMENT ON COLUMN core.deferred_payment.payment_date IS 'Ожидаемая дата оплаты';
COMMENT ON COLUMN core.deferred_payment.cur_code IS 'Код валюты';
COMMENT ON COLUMN core.deferred_payment.payment_amt IS 'Ожидаемая сумма оплаты в валюте';
COMMENT ON COLUMN core.deferred_payment.payment_rub IS 'Ожидаемая сумма оплаты в рублях';
COMMENT ON COLUMN core.deferred_payment.is_paid IS 'Признак оплаты: 1 - Оплачен, 0 - Не оплачен';
COMMENT ON COLUMN core.deferred_payment.counterparty_id IS 'Идентификатор контрагента (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.deferred_payment.liability_share IS 'Доля ответственности';
COMMENT ON COLUMN core.deferred_payment.insurance_type_code IS 'Тип страхования - Код';
COMMENT ON COLUMN core.deferred_payment.insurance_type_name IS 'Тип страхования - Наименование';
COMMENT ON COLUMN core.deferred_payment.note IS 'Примечание';
COMMENT ON COLUMN core.deferred_payment.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.deferred_payment.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.deferred_payment.insurance_contract_id IS 'Идентификатор договора страхования (внешний ключ на табл. contract)';
COMMENT ON COLUMN core.deferred_payment.billing_start_date IS 'Ожидаемая дата начала, за которой происходит оплата - мы платим или нам платят в зависимости от входящего или исходящего договора';
COMMENT ON COLUMN core.deferred_payment.billing_end_date IS 'Ожидаемая дата окончания, за которой происходит оплата - мы платим или нам платят в зависимости от входящего или исходящего договора';
COMMENT ON COLUMN core.deferred_payment.billing_rub_amt IS 'Ожидаемая страховая сумма в рублях';
COMMENT ON COLUMN core.deferred_payment.object_risk_type_id IS 'Идентификатор типа риска по объекту';
COMMENT ON COLUMN core.deferred_payment.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.deferred_payment.calculation_date IS 'Дата начисления премии или комиссии';
COMMENT ON COLUMN core.deferred_payment.adjustment_type_name IS 'Вид корректировки';
COMMENT ON COLUMN core.deferred_payment.key_id IS 'Уникальный ключ';
CREATE TABLE core.department (dept_code CHARACTER VARYING(50) NOT NULL, dept_name CHARACTER VARYING(100), branch_code CHARACTER VARYING(32), dept_start_date TIMESTAMP(6) WITHOUT TIME ZONE, dept_end_date TIMESTAMP(6) WITHOUT TIME ZONE, boss_code CHARACTER VARYING(50), dept_rep_code CHARACTER VARYING(50), dept_top_rep_code CHARACTER VARYING(50), firm_code CHARACTER VARYING(50), dept_hobby_name CHARACTER VARYING(80), sort_num INTEGER, dept_lev SMALLINT, dept_boss_id CHARACTER VARYING(50), dept_kias_id CHARACTER VARYING(50), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.department IS 'Справочник подразделений штатной структуры';
COMMENT ON COLUMN core.department.dept_code IS 'Идентификатор подразделения в 1С ЗУП';
COMMENT ON COLUMN core.department.dept_name IS 'Наименование';
COMMENT ON COLUMN core.department.branch_code IS 'Ссылка на core.branches.branch_code';
COMMENT ON COLUMN core.department.dept_start_date IS 'Дата создания';
COMMENT ON COLUMN core.department.dept_end_date IS 'Дата расформирования';
COMMENT ON COLUMN core.department.boss_code IS 'Начальник (Ссылка на core.employee)';
COMMENT ON COLUMN core.department.dept_rep_code IS 'Родительское подразделение';
COMMENT ON COLUMN core.department.dept_top_rep_code IS 'Высшее в иерархии родительское подразделение';
COMMENT ON COLUMN core.department.firm_code IS 'Предприятие';
COMMENT ON COLUMN core.department.dept_hobby_name IS 'Род занятий';
COMMENT ON COLUMN core.department.sort_num IS 'Номер для сортировки';
COMMENT ON COLUMN core.department.dept_lev IS 'Уровень';
COMMENT ON COLUMN core.department.dept_boss_id IS 'Идентификатор подразделения из системы Босс-Кадровик (Ссылка на hr_prod.hr_dept0)';
COMMENT ON COLUMN core.department.dept_kias_id IS 'Идентификатор подразделения из системы КИАС (Ссылка на inslab.subdept)';
COMMENT ON COLUMN core.department.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.department.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.department.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.department.key_id IS 'Уникальный ключ';
CREATE TABLE core.dict_acc_group_limit_period (central_accounting_group_id CHARACTER VARYING(25) NOT NULL, limit_period NUMERIC NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.dict_acc_group_limit_period.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.dict_actuary_mon_channel_map (dict7gs_id CHARACTER VARYING(7), ins_type CHARACTER VARYING(7), sale_channel_type2008_id CHARACTER VARYING(7), big_sale_channel_name CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.dict_actuary_mon_channel_map.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.dict_actuary_mon_channel_map_new (dict7gs_id CHARACTER VARYING(7), ins_type CHARACTER VARYING(254), sale_channel_type2008_id CHARACTER VARYING(7), big_sale_channel_name CHARACTER VARYING(2000), sysdate TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.dict_actuary_mon_channel_map_new.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.dict_agent_rgs_group (agent_rgs_group_id CHARACTER VARYING(50), agent_id CHARACTER VARYING(50), agent_name CHARACTER VARYING(2000), agent_code CHARACTER VARYING(50), group_feature CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.dict_agent_rgs_group IS 'Справочник посредников с признаком компании группы БКФО';
COMMENT ON COLUMN core.dict_agent_rgs_group.agent_rgs_group_id IS '№ п/п';
COMMENT ON COLUMN core.dict_agent_rgs_group.agent_id IS 'Идентификатор посредника';
COMMENT ON COLUMN core.dict_agent_rgs_group.agent_name IS 'Наименование посредника';
COMMENT ON COLUMN core.dict_agent_rgs_group.agent_code IS 'Код посредника';
COMMENT ON COLUMN core.dict_agent_rgs_group.group_feature IS 'Компания группы';
COMMENT ON COLUMN core.dict_agent_rgs_group.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.dict_insured_rgs_group (insured_rgs_group_id CHARACTER VARYING(25), source_insured_id CHARACTER VARYING(25), insured_id CHARACTER VARYING(50) NOT NULL, name_ CHARACTER VARYING(256), full_name CHARACTER VARYING(512), inn CHARACTER VARYING(50), rgs_group NUMERIC(1,0), group_feature CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.dict_insured_rgs_group IS 'Справочник страхователей с признаком компании группы БКФО';
COMMENT ON COLUMN core.dict_insured_rgs_group.insured_rgs_group_id IS '№ п/п';
COMMENT ON COLUMN core.dict_insured_rgs_group.source_insured_id IS 'Идентификатор страхователя в системе-источнике';
COMMENT ON COLUMN core.dict_insured_rgs_group.insured_id IS 'Идентификатор страхователя';
COMMENT ON COLUMN core.dict_insured_rgs_group.name_ IS 'Наименование страхователя';
COMMENT ON COLUMN core.dict_insured_rgs_group.full_name IS 'Полное наименование страхователя';
COMMENT ON COLUMN core.dict_insured_rgs_group.inn IS 'ИНН';
COMMENT ON COLUMN core.dict_insured_rgs_group.rgs_group IS '1 - Признак компании группы, 2 - Связанная сторона';
COMMENT ON COLUMN core.dict_insured_rgs_group.group_feature IS 'Компания группы';
COMMENT ON COLUMN core.dict_insured_rgs_group.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.dict_kk_region_vip (code_plan_id NUMERIC(3,0), vip_id CHARACTER VARYING(10), full_name CHARACTER VARYING(512), group_code CHARACTER VARYING(25) NOT NULL, group_name CHARACTER VARYING(512), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.dict_kk_region_vip.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.dict_kv_tariff_rate (object_risk_type_id CHARACTER VARYING(50) NOT NULL, kv_rate NUMERIC, period_start DATE DEFAULT '2018-08-01'::date, period_end DATE DEFAULT '9999-01-01'::date, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.dict_kv_tariff_rate IS 'Справочник связей типа объект-риска с тарифной ставкой КВ';
COMMENT ON COLUMN core.dict_kv_tariff_rate.object_risk_type_id IS 'Идентификатор типа объект-риска';
COMMENT ON COLUMN core.dict_kv_tariff_rate.kv_rate IS 'Тарифная ставка КВ';
COMMENT ON COLUMN core.dict_kv_tariff_rate.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.dict_kv_tariff_rate.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.dict_kv_tariff_rate.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.dict_tax_rates (tax_rate_id NUMERIC, rate NUMERIC, ondate DATE, todate DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.dict_tax_rates IS 'Справочник ставок налога';
COMMENT ON COLUMN core.dict_tax_rates.tax_rate_id IS 'Идентификатор';
COMMENT ON COLUMN core.dict_tax_rates.rate IS 'Ставка налога (в долях)';
COMMENT ON COLUMN core.dict_tax_rates.ondate IS 'Дата начала действия';
COMMENT ON COLUMN core.dict_tax_rates.todate IS 'Дата окончания действия';
COMMENT ON COLUMN core.dict_tax_rates.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.dmm_log (dmm_log_id BIGINT DEFAULT nextval('common_seq'::regclass) NOT NULL, mart_code CHARACTER VARYING(50), begin_timestamp TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP, end_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, status CHARACTER VARYING(50) DEFAULT 'running'::character varying, created_timestamp TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP, modified_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, description CHARACTER VARYING(2000), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.dmm_log IS 'Журнал загрузки витрины дельты витрины';
COMMENT ON COLUMN core.dmm_log.dmm_log_id IS 'Идентификатор процесса загрузки';
COMMENT ON COLUMN core.dmm_log.mart_code IS 'Код витрины';
COMMENT ON COLUMN core.dmm_log.begin_timestamp IS 'Время запуска загрузки инкремента витрины';
COMMENT ON COLUMN core.dmm_log.end_timestamp IS 'Время завершения загрузки инкремента витрины';
COMMENT ON COLUMN core.dmm_log.status IS 'Статус загрузки инкремента витрины (running / finished / error)';
COMMENT ON COLUMN core.dmm_log.created_timestamp IS 'Время создания записи';
COMMENT ON COLUMN core.dmm_log.modified_timestamp IS 'Время изменения записи';
CREATE TABLE core.dmm_mart (mart_code CHARACTER VARYING(50) NOT NULL, email_list TEXT, delta_period CHARACTER VARYING(50), load_start_time TIME(6) WITHOUT TIME ZONE, load_end_time TIME(6) WITHOUT TIME ZONE, delta_table_allocation SMALLINT, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.dmm_mart IS 'Витрина (заголовок)';
COMMENT ON COLUMN core.dmm_mart.mart_code IS 'Код витрины';
COMMENT ON COLUMN core.dmm_mart.email_list IS 'Список адресов рассылки, разделенных запятой';
COMMENT ON COLUMN core.dmm_mart.delta_period IS 'Периодичность загрузки инкремента (''1 day'', ''1 month'', ''15 minute'')';
COMMENT ON COLUMN core.dmm_mart.load_start_time IS 'Плановое время запуска загрузки витрины';
COMMENT ON COLUMN core.dmm_mart.load_end_time IS 'Плановое время завершения загрузки витрины';
COMMENT ON COLUMN core.dmm_mart.delta_table_allocation IS 'Возможное распределение инкремента по таблицам витрины (0 - инкремент д/б во всех таблицах, 1 - инкремент д/б хотя бы в одной таблице)';
CREATE TABLE core.dmm_table (mart_code CHARACTER VARYING(50) NOT NULL, pdi_conn_name CHARACTER VARYING(50), table_schema CHARACTER VARYING(150), table_name CHARACTER VARYING(150) NOT NULL, min_row_count INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.dmm_table IS 'Таблица витрины';
COMMENT ON COLUMN core.dmm_table.mart_code IS 'Код витрины';
COMMENT ON COLUMN core.dmm_table.pdi_conn_name IS 'JNDI соединение в Pentaho Data Inegration';
COMMENT ON COLUMN core.dmm_table.table_schema IS 'Схема где находится таблица';
COMMENT ON COLUMN core.dmm_table.table_name IS 'Название таблицы';
COMMENT ON COLUMN core.dmm_table.min_row_count IS 'Минимальное поличество записей за одну загрузку';
CREATE TABLE core.document (document_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), document_type CHARACTER VARYING(512), document_series CHARACTER VARYING(50), document_number CHARACTER VARYING(50), issue_date DATE, issue_organization CHARACTER VARYING(1000), issue_organization_code CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), object_id CHARACTER VARYING(50) NOT NULL, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, subject_type CHARACTER VARYING(150) DEFAULT 'counterparty'::character varying NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.document IS 'Документы';
COMMENT ON COLUMN core.document.document_id IS 'Идентификатор документа';
COMMENT ON COLUMN core.document.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.document.document_type IS 'Тип документа';
COMMENT ON COLUMN core.document.document_series IS 'Серия документа';
COMMENT ON COLUMN core.document.document_number IS 'Номер документа';
COMMENT ON COLUMN core.document.issue_date IS 'Дата выдачи';
COMMENT ON COLUMN core.document.issue_organization IS 'Организация, выдавшая документ';
COMMENT ON COLUMN core.document.issue_organization_code IS 'Код организации, выдавшей документ';
COMMENT ON COLUMN core.document.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.document.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.document.hash IS 'Хэш';
COMMENT ON COLUMN core.document.object_id IS 'Идентификатор объекта';
COMMENT ON COLUMN core.document.modify_date IS 'Дата модификации';
COMMENT ON COLUMN core.document.subject_type IS 'Тип объекта';
COMMENT ON COLUMN core.document.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.document.key_id IS 'Уникальный ключ';
CREATE TABLE core.driver_license_category (doc_cat_id BIGSERIAL NOT NULL, document_id CHARACTER VARYING(50), category CHARACTER VARYING(50), startdatecategory DATE, period_start DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.driver_license_category IS 'Категории водительских удостоверений';
COMMENT ON COLUMN core.driver_license_category.doc_cat_id IS 'Уникальный идентификатор строки';
COMMENT ON COLUMN core.driver_license_category.document_id IS 'Идентификатор документа';
COMMENT ON COLUMN core.driver_license_category.category IS 'Категория';
COMMENT ON COLUMN core.driver_license_category.startdatecategory IS 'Дата начала действия категории';
COMMENT ON COLUMN core.driver_license_category.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.driver_license_category.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.driver_license_category.modify_date IS 'Дата модификации';
COMMENT ON COLUMN core.driver_license_category.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.driver_license_category.key_id IS 'Уникальный ключ';
CREATE TABLE core.employee (counterparty_id CHARACTER VARYING(50) NOT NULL, rgs_id CHARACTER VARYING(50), appointment_type_code CHARACTER VARYING(50), department_code CHARACTER VARYING(50), department_name CHARACTER VARYING(512), branch_code CHARACTER VARYING(20), department_full_name CHARACTER VARYING(2000), filial_code CHARACTER VARYING(50), filial_name CHARACTER VARYING(512), appointment_name CHARACTER VARYING(512), employee_type_code CHARACTER VARYING(50), employee_type_name CHARACTER VARYING(512), employee_group_code CHARACTER VARYING(50), firm_code CHARACTER VARYING(50), firm_name CHARACTER VARYING(512), wage_rate_qty NUMERIC, kfn_code CHARACTER VARYING(50), kfn_descr CHARACTER VARYING(512), estaff_code CHARACTER VARYING(50), is_sas SMALLINT, is_eco SMALLINT, specialization_code CHARACTER VARYING(50), is_agent SMALLINT, effective_start TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, effective_end TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, period_start TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, period_end TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, employee_id CHARACTER VARYING(50) NOT NULL, lnr_code CHARACTER VARYING(100), emp_status_code SMALLINT, emp_start_date DATE, emp_end_date DATE, partner_type_id CHARACTER VARYING(50), partner_id CHARACTER VARYING(50), sale_channel_type_id CHARACTER VARYING(40), contract_number CHARACTER VARYING(100), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, agent_payment_type_id CHARACTER VARYING(100));
COMMENT ON TABLE core.employee IS 'Сотрудники';
COMMENT ON COLUMN core.employee.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.employee.rgs_id IS 'Идентификатор РГС';
COMMENT ON COLUMN core.employee.appointment_type_code IS 'Тип записи назначения';
COMMENT ON COLUMN core.employee.department_code IS 'Код подразделения';
COMMENT ON COLUMN core.employee.department_name IS 'Название подразделения';
COMMENT ON COLUMN core.employee.branch_code IS 'Код подразделения в СКК';
COMMENT ON COLUMN core.employee.department_full_name IS 'Полное название подразделения';
COMMENT ON COLUMN core.employee.filial_code IS 'Код филиала';
COMMENT ON COLUMN core.employee.filial_name IS 'Название филиала';
COMMENT ON COLUMN core.employee.appointment_name IS 'Должность';
COMMENT ON COLUMN core.employee.employee_type_code IS 'Вид приема код';
COMMENT ON COLUMN core.employee.employee_type_name IS 'Вид приема наименование';
COMMENT ON COLUMN core.employee.employee_group_code IS 'Вид приема статус';
COMMENT ON COLUMN core.employee.firm_code IS 'Организация код';
COMMENT ON COLUMN core.employee.firm_name IS 'Организация наименование';
COMMENT ON COLUMN core.employee.wage_rate_qty IS 'Количество ставок';
COMMENT ON COLUMN core.employee.kfn_code IS 'Код КФН';
COMMENT ON COLUMN core.employee.kfn_descr IS 'Описание КФН';
COMMENT ON COLUMN core.employee.estaff_code IS 'Код e-staff';
COMMENT ON COLUMN core.employee.is_sas IS 'Агент специальной агентской сети';
COMMENT ON COLUMN core.employee.is_eco IS 'Оказание сервиса ЕЦО';
COMMENT ON COLUMN core.employee.specialization_code IS 'СК - специализация';
COMMENT ON COLUMN core.employee.is_agent IS 'Является агентом';
COMMENT ON COLUMN core.employee.effective_start IS 'Дата начала действия бизнес-периода';
COMMENT ON COLUMN core.employee.effective_end IS 'Дата окончания действия бизнес-периода';
COMMENT ON COLUMN core.employee.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.employee.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.employee.employee_id IS 'Идентификатор сотрудника';
COMMENT ON COLUMN core.employee.lnr_code IS 'Личный номер работника';
COMMENT ON COLUMN core.employee.emp_status_code IS 'Статус сотрудника: 0 - не действующий, 1 - действующий, 2 - декрет';
COMMENT ON COLUMN core.employee.emp_start_date IS 'Дата начала работы сотрудника';
COMMENT ON COLUMN core.employee.emp_end_date IS 'Дата окончания работы сотрудника';
COMMENT ON COLUMN core.employee.partner_type_id IS 'Идентификатор типа партнера';
COMMENT ON COLUMN core.employee.partner_id IS 'Идентификатор партнера';
COMMENT ON COLUMN core.employee.sale_channel_type_id IS 'Канал продаж';
COMMENT ON COLUMN core.employee.contract_number IS 'Номер агентского договора';
COMMENT ON COLUMN core.employee.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.employee.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.employee.agent_payment_type_id IS 'Идентификатор значения с удержанием или без удержания КВ (ссылка на справочник core.ref_agent_payment_type)';
CREATE TABLE core.employee_department (employee_department_id CHARACTER VARYING(50) NOT NULL, employee_id CHARACTER VARYING(50), department_id CHARACTER VARYING(50), effective_start TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, employee_department_type_id INTEGER);
COMMENT ON TABLE core.employee_department IS 'Связь сотрудника с подразделением';
COMMENT ON COLUMN core.employee_department.employee_department_id IS 'Идентификатор связи сотрудника с подразделением';
COMMENT ON COLUMN core.employee_department.employee_id IS 'Идентификатор сотрудника/агента';
COMMENT ON COLUMN core.employee_department.department_id IS 'Идентификатор подразделения';
COMMENT ON COLUMN core.employee_department.effective_start IS 'Дата начала действия связи';
COMMENT ON COLUMN core.employee_department.effective_end IS 'Дата окончания действия связи';
COMMENT ON COLUMN core.employee_department.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.employee_department.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.employee_department.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.employee_department.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.employee_department.employee_department_type_id IS 'Идентификатор типа привязки сотрудника к подразделению';
CREATE TABLE core.employee_insurance_type (employee_id CHARACTER VARYING(50) NOT NULL, insurance_type_id NUMERIC NOT NULL, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.employee_insurance_type IS 'Агенты и их виды страхования';
COMMENT ON COLUMN core.employee_insurance_type.employee_id IS 'Идентификатор сотрудника';
COMMENT ON COLUMN core.employee_insurance_type.insurance_type_id IS 'Идентификатор вида страхования';
COMMENT ON COLUMN core.employee_insurance_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.employee_insurance_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.employee_insurance_type.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.employee_insurance_type.key_id IS 'Уникальный ключ';
CREATE TABLE core.employee_link (employee_link_id CHARACTER VARYING(50) NOT NULL, employee_id CHARACTER VARYING(50), to_employee_id CHARACTER VARYING(50), employee_link_type_id CHARACTER VARYING(50), effective_start TIMESTAMP(6) WITHOUT TIME ZONE, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, _fkey CHARACTER VARYING(256), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.employee_link IS 'Связи сотрудников';
COMMENT ON COLUMN core.employee_link.employee_link_id IS 'Идентификатор связи';
COMMENT ON COLUMN core.employee_link.employee_id IS 'Идентификатор сотрудника';
COMMENT ON COLUMN core.employee_link.to_employee_id IS 'Идентификатор связанного сотрудника';
COMMENT ON COLUMN core.employee_link.employee_link_type_id IS 'Идентификатор типа связи';
COMMENT ON COLUMN core.employee_link.effective_start IS 'Дата начала действия связи';
COMMENT ON COLUMN core.employee_link.effective_end IS 'Дата окончания действия связи';
COMMENT ON COLUMN core.employee_link.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.employee_link.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.employee_link._fkey IS 'Техническое поле для обновления';
COMMENT ON COLUMN core.employee_link.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.employee_link.key_id IS 'Уникальный ключ';
CREATE TABLE core.federal_district (scc_id NUMERIC(38,0), federal_district_name CHARACTER VARYING(50), federal_district_code CHARACTER VARYING(1), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.federal_district.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.file (file_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), filestore_uuid CHARACTER VARYING(255), name CHARACTER VARYING(512), extension CHARACTER VARYING(100), file_type_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.file IS 'Сканы документов, прикрепленных к договору страхования';
COMMENT ON COLUMN core.file.file_id IS 'Идентификатор документа';
COMMENT ON COLUMN core.file.contract_id IS 'Идентификатор договора страхования';
COMMENT ON COLUMN core.file.filestore_uuid IS 'Идентификатор документа в filestore';
COMMENT ON COLUMN core.file.name IS 'Наименование документа';
COMMENT ON COLUMN core.file.extension IS 'Расширение документа';
COMMENT ON COLUMN core.file.file_type_id IS 'Идентификатор типа документа';
COMMENT ON COLUMN core.file.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.file.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.file.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.file.key_id IS 'Уникальный ключ';
CREATE TABLE core.group (counterparty_id CHARACTER VARYING(50) NOT NULL, group_type CHARACTER VARYING(50) NOT NULL, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.group IS 'Группа';
COMMENT ON COLUMN core.group.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.group.group_type IS 'Группа, куда контрагент входит';
COMMENT ON COLUMN core.group.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.group.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.group.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.group.key_id IS 'Уникальный ключ';
CREATE TABLE core.households (rgs_id_1 CHARACTER VARYING(50) NOT NULL, rgs_id_2 CHARACTER VARYING(50) NOT NULL, relation_type_id INTEGER NOT NULL, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.households IS 'Домохозяйства';
COMMENT ON COLUMN core.households.rgs_id_1 IS 'Идентификатор первого контрагента';
COMMENT ON COLUMN core.households.rgs_id_2 IS 'Идентификатор второго контрагента';
COMMENT ON COLUMN core.households.relation_type_id IS 'Идентификатор типа связи';
COMMENT ON COLUMN core.households.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.households.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.households.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.households.key_id IS 'Уникальный ключ';
CREATE TABLE core.incident_vehicle (incident_vehicle_id CHARACTER VARYING(50) NOT NULL, contract_object_id CHARACTER VARYING(50), vehicle_id CHARACTER VARYING(50), counterparty_id CHARACTER VARYING(50), contract_id CHARACTER VARYING(50), registration_mark CHARACTER VARYING(50), registration_series CHARACTER VARYING(50), registration_number CHARACTER VARYING(50), registration_date DATE, usage_purpose_id CHARACTER VARYING(512), bonus_malus_id CHARACTER VARYING(7), categ CHARACTER VARYING(512), race_km NUMERIC, color CHARACTER VARYING(500), cost NUMERIC(17,2), is_new_vehicle SMALLINT, limited_driver INTEGER, casco_territory CHARACTER VARYING(100), seats_quantity INTEGER, limit_sum NUMERIC, is_used_trailer SMALLINT, vehicle_group CHARACTER VARYING(7), attribute2 CHARACTER VARYING(512), modify_date TIMESTAMP(6) WITHOUT TIME ZONE, kladr_territory_code CHARACTER VARYING(100), is_grave_violation INTEGER, is_follow_place INTEGER, alarm_system CHARACTER VARYING(500), gots_sum NUMERIC(17,2), gots_date_max DATE, gots_date_min DATE, period_start DATE, period_end DATE NOT NULL, retired NUMERIC, gots_activity_count NUMERIC, gots_accepted_value_rub NUMERIC, gots_accepted_date DATE, reg_country_code CHARACTER VARYING(255), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.incident_vehicle IS 'Пострадавшие транспортные средства';
COMMENT ON COLUMN core.incident_vehicle.incident_vehicle_id IS 'Идентификатор пострадавшего транспортного средства';
COMMENT ON COLUMN core.incident_vehicle.contract_object_id IS 'Идентификатор объекта договора';
COMMENT ON COLUMN core.incident_vehicle.vehicle_id IS 'Идентификатор пострадавшего транспортного средства';
COMMENT ON COLUMN core.incident_vehicle.counterparty_id IS 'Идентификатор владельца ТС в учетной системе';
COMMENT ON COLUMN core.incident_vehicle.contract_id IS 'Идентификатор контракта';
COMMENT ON COLUMN core.incident_vehicle.registration_mark IS 'Государственный регистрационный знак';
COMMENT ON COLUMN core.incident_vehicle.registration_series IS 'Серия регистрационного документа';
COMMENT ON COLUMN core.incident_vehicle.registration_number IS 'Номер регистрационного документа';
COMMENT ON COLUMN core.incident_vehicle.registration_date IS 'Дата регистрации';
COMMENT ON COLUMN core.incident_vehicle.usage_purpose_id IS 'Идентификатор цели использования';
COMMENT ON COLUMN core.incident_vehicle.bonus_malus_id IS 'Идентификатор класса бонус-малуса';
COMMENT ON COLUMN core.incident_vehicle.categ IS 'Категория ТС';
COMMENT ON COLUMN core.incident_vehicle.race_km IS 'Пробег автомобиля (км)';
COMMENT ON COLUMN core.incident_vehicle.color IS 'Цвет';
COMMENT ON COLUMN core.incident_vehicle.cost IS 'Стоимость застрахованного ТС';
COMMENT ON COLUMN core.incident_vehicle.is_new_vehicle IS 'Признак нового ТС: 1 – Новый';
COMMENT ON COLUMN core.incident_vehicle.limited_driver IS 'Допущенные к управлению: 0 – Без ограничения возраста и стажа допущенных к управлению ТС; 1 – Ограниченный список допущенных к управлению ТС; 2 – У всех водителей возраст от 25 лет и стаж от 5 лет; 3 – У всех водителей возраст от 30 лет и стаж от 10 лет; 4 – У всех водителей возраст от 40 лет и стаж от 10 лет.';
COMMENT ON COLUMN core.incident_vehicle.casco_territory IS 'Территория заключения договора КАСКО';
COMMENT ON COLUMN core.incident_vehicle.seats_quantity IS 'Количество застрахованных посадочных мест';
COMMENT ON COLUMN core.incident_vehicle.limit_sum IS 'Лимит ответственности';
COMMENT ON COLUMN core.incident_vehicle.is_used_trailer IS 'Разрешено использование прицепа: 1 – Да';
COMMENT ON COLUMN core.incident_vehicle.vehicle_group IS 'Группа ТС (справочное значение СКК 7.2.9 кода группы ТС для расчета тарифа КАСКО)';
COMMENT ON COLUMN core.incident_vehicle.attribute2 IS 'Атрибут 2 (справочное значение СКК 7.2.9 наименования группы ТС для расчета тарифа КАСКО)';
COMMENT ON COLUMN core.incident_vehicle.modify_date IS 'Дата модификации';
COMMENT ON COLUMN core.incident_vehicle.kladr_territory_code IS 'Код территории преимущественного использования';
COMMENT ON COLUMN core.incident_vehicle.is_grave_violation IS 'Грубые нарушения: 1 - Да';
COMMENT ON COLUMN core.incident_vehicle.is_follow_place IS 'ТС следует к месту регистрации: 1 - Да';
COMMENT ON COLUMN core.incident_vehicle.alarm_system IS 'Противоугонная система';
COMMENT ON COLUMN core.incident_vehicle.gots_sum IS 'Сумма реализованных ГОТС, руб.';
COMMENT ON COLUMN core.incident_vehicle.gots_date_max IS 'Дата реализации ГОТС максимальная';
COMMENT ON COLUMN core.incident_vehicle.gots_date_min IS 'Дата реализации ГОТС минимальная';
COMMENT ON COLUMN core.incident_vehicle.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.incident_vehicle.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.incident_vehicle.gots_activity_count IS 'Количество задач типа "Отразить реализацию ГОТС в бухгалтерском учете"';
COMMENT ON COLUMN core.incident_vehicle.gots_accepted_value_rub IS 'Cумма по которой ГОТСы приняты в компанию';
COMMENT ON COLUMN core.incident_vehicle.gots_accepted_date IS 'Дата принятия ГОТСов в компанию';
COMMENT ON COLUMN core.incident_vehicle.reg_country_code IS 'Страна регистрации ТС';
COMMENT ON COLUMN core.incident_vehicle.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.incident_vehicle.key_id IS 'Уникальный ключ';
CREATE TABLE core.insurance_union_agreement (agreement_id CHARACTER VARYING(50) NOT NULL, policy_series CHARACTER VARYING(50), policy_number CHARACTER VARYING(50), load_datetime TIMESTAMP(6) WITHOUT TIME ZONE, respond_datetime TIMESTAMP(6) WITHOUT TIME ZONE, status_code CHARACTER VARYING(50), status_message CHARACTER VARYING(4000), first_load_date DATE, first_success_date DATE, insurance_type CHARACTER VARYING(50), source_is CHARACTER VARYING(50), retired INTEGER, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON COLUMN core.insurance_union_agreement.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.insurance_union_agreement.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.insurance_union_agreement.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.insurance_union_agreement.key_id IS 'Уникальный ключ';
CREATE TABLE core.insurance_union_blank (blank_id CHARACTER VARYING(50) NOT NULL, blank_series CHARACTER VARYING(50), blank_number CHARACTER VARYING(50), load_datetime TIMESTAMP(6) WITHOUT TIME ZONE, respond_datetime TIMESTAMP(6) WITHOUT TIME ZONE, status_code CHARACTER VARYING(50), status_message CHARACTER VARYING(4000), first_load_date DATE, first_success_date DATE, insurance_type CHARACTER VARYING(50), source_is CHARACTER VARYING(50), retired INTEGER, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON COLUMN core.insurance_union_blank.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.insurance_union_blank.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.insurance_union_blank.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.insurance_union_blank.key_id IS 'Уникальный ключ';
CREATE TABLE core.insurance_union_contract (contract_id CHARACTER VARYING(100) NOT NULL, policy_series CHARACTER VARYING(50), policy_number CHARACTER VARYING(50), load_datetime TIMESTAMP(6) WITHOUT TIME ZONE, respond_datetime TIMESTAMP(6) WITHOUT TIME ZONE, status_code CHARACTER VARYING(50), status_message CHARACTER VARYING(4000), first_load_date DATE, first_success_date DATE, insurance_type CHARACTER VARYING(50), source_is CHARACTER VARYING(50), retired INTEGER, period_start DATE, period_end DATE NOT NULL, mistake_description CHARACTER VARYING(4000), business_operation_name TEXT, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON COLUMN core.insurance_union_contract.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.insurance_union_contract.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.insurance_union_contract.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.insurance_union_contract.key_id IS 'Уникальный ключ';
CREATE TABLE core.insured_vehicle (insured_vehicle_id CHARACTER VARYING(50) NOT NULL, contract_object_id CHARACTER VARYING(50), vehicle_id CHARACTER VARYING(50), counterparty_id CHARACTER VARYING(50), contract_id CHARACTER VARYING(50), registration_mark CHARACTER VARYING(50), registration_series CHARACTER VARYING(50), registration_number CHARACTER VARYING(50), registration_date DATE, usage_purpose_id CHARACTER VARYING(512), bonus_malus_id CHARACTER VARYING(7), categ CHARACTER VARYING(512), type CHARACTER VARYING(512), race_km NUMERIC, color CHARACTER VARYING(50), hash CHARACTER VARYING(32), period_start DATE, period_end DATE NOT NULL, cost NUMERIC(17,2), is_new_vehicle SMALLINT, limited_driver INTEGER, casco_territory CHARACTER VARYING(100), seats_quantity INTEGER, is_used_trailer SMALLINT, vehicle_group CHARACTER VARYING(7), limit_sum NUMERIC, modify_date TIMESTAMP(6) WITHOUT TIME ZONE, reg_doc_type CHARACTER VARYING(512), kladr_territory_code CHARACTER VARYING(100), attribute2 CHARACTER VARYING(512), is_grave_violation INTEGER, is_follow_place INTEGER, alarm_system CHARACTER VARYING(2000), tb NUMERIC, kt NUMERIC, kbm NUMERIC, ko NUMERIC, kvs NUMERIC, km NUMERIC, ks NUMERIC, kp NUMERIC, kn NUMERIC, kpr NUMERIC, tb_max NUMERIC, reg_country_code CHARACTER VARYING(255), is_foreign_registration INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, alarm_system_installed_type_id CHARACTER VARYING(50), printed_brand_name CHARACTER VARYING(512), printed_model_name CHARACTER VARYING(512));
COMMENT ON TABLE core.insured_vehicle IS 'Застрахованные транспортные средства';
COMMENT ON COLUMN core.insured_vehicle.insured_vehicle_id IS 'Идентификатор застрахованного транспортного средства';
COMMENT ON COLUMN core.insured_vehicle.contract_object_id IS 'Идентификатор объекта договора';
COMMENT ON COLUMN core.insured_vehicle.vehicle_id IS 'Идентификатор транспортного средства';
COMMENT ON COLUMN core.insured_vehicle.counterparty_id IS 'Идентификатор владельца ТС в учетной системе';
COMMENT ON COLUMN core.insured_vehicle.contract_id IS 'Идентификатор контракта';
COMMENT ON COLUMN core.insured_vehicle.registration_mark IS 'Государственный регистрационный знак';
COMMENT ON COLUMN core.insured_vehicle.registration_series IS 'Серия регистрационного документа';
COMMENT ON COLUMN core.insured_vehicle.registration_number IS 'Номер регистрационного документа';
COMMENT ON COLUMN core.insured_vehicle.registration_date IS 'Дата регистрации';
COMMENT ON COLUMN core.insured_vehicle.usage_purpose_id IS 'Идентификатор цели использования';
COMMENT ON COLUMN core.insured_vehicle.bonus_malus_id IS 'Идентификатор класса бонус-малуса';
COMMENT ON COLUMN core.insured_vehicle.categ IS 'Категория ТС';
COMMENT ON COLUMN core.insured_vehicle.type IS 'Тип транспортного средства';
COMMENT ON COLUMN core.insured_vehicle.race_km IS 'Пробег автомобиля (км)';
COMMENT ON COLUMN core.insured_vehicle.color IS 'Цвет';
COMMENT ON COLUMN core.insured_vehicle.hash IS 'Хэш';
COMMENT ON COLUMN core.insured_vehicle.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.insured_vehicle.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.insured_vehicle.cost IS 'Стоимость застрахованного ТС';
COMMENT ON COLUMN core.insured_vehicle.is_new_vehicle IS 'Признак нового ТС: 1 – Новый';
COMMENT ON COLUMN core.insured_vehicle.limited_driver IS 'Допущенные к управлению: 0 – Без ограничения возраста и стажа допущенных к управлению ТС; 1 – Ограниченный список допущенных к управлению ТС; 2 – У всех водителей возраст от 25 лет и стаж от 5 лет; 3 – У всех водителей возраст от 30 лет и стаж от 10 лет; 4 – У всех водителей возраст от 40 лет и стаж от 10 лет.';
COMMENT ON COLUMN core.insured_vehicle.casco_territory IS 'Территория заключения договора КАСКО';
COMMENT ON COLUMN core.insured_vehicle.seats_quantity IS 'Количество застрахованных пассажирских посадочных мест';
COMMENT ON COLUMN core.insured_vehicle.is_used_trailer IS 'ТС застраховано с прицепом: 1 – Да, 0 - Нет';
COMMENT ON COLUMN core.insured_vehicle.vehicle_group IS 'Группа ТС (справочное значение СКК 7.2.9 кода группы ТС для расчета тарифа КАСКО)';
COMMENT ON COLUMN core.insured_vehicle.limit_sum IS 'Лимит ответственности';
COMMENT ON COLUMN core.insured_vehicle.modify_date IS 'Дата модификации';
COMMENT ON COLUMN core.insured_vehicle.reg_doc_type IS 'Тип документа';
COMMENT ON COLUMN core.insured_vehicle.kladr_territory_code IS 'Код территории преимущественного использования';
COMMENT ON COLUMN core.insured_vehicle.attribute2 IS 'Атрибут 2 (справочное значение СКК 7.2.9 наименования группы ТС для расчета тарифа КАСКО)';
COMMENT ON COLUMN core.insured_vehicle.is_grave_violation IS 'Грубые нарушения: 1 - Да';
COMMENT ON COLUMN core.insured_vehicle.is_follow_place IS 'ТС следует к месту регистрации: 1 - Да';
COMMENT ON COLUMN core.insured_vehicle.alarm_system IS 'Противоугонная система';
COMMENT ON COLUMN core.insured_vehicle.tb IS 'Базовая ставка (ТБ)';
COMMENT ON COLUMN core.insured_vehicle.kt IS 'Территориальный коэффициент (КТ)';
COMMENT ON COLUMN core.insured_vehicle.kbm IS 'Коэффициент безаварийной езды (КБМ)';
COMMENT ON COLUMN core.insured_vehicle.ko IS 'Коэффициент ограничения кол-ва водителей (КО)';
COMMENT ON COLUMN core.insured_vehicle.kvs IS 'Коэффициент возраста/стажа (КВС)';
COMMENT ON COLUMN core.insured_vehicle.km IS 'Коэффициент мощности (КМ)';
COMMENT ON COLUMN core.insured_vehicle.ks IS 'Коэффициент сезонности (КС)';
COMMENT ON COLUMN core.insured_vehicle.kp IS 'Коэффициент длительности страховки для зарубежных граждан (КП)';
COMMENT ON COLUMN core.insured_vehicle.kn IS 'Коэффициент нарушений (КН)';
COMMENT ON COLUMN core.insured_vehicle.kpr IS 'Управление транспортным средством с прицепом (КПр)';
COMMENT ON COLUMN core.insured_vehicle.tb_max IS 'Базовая ставка (ТБ) максимальная';
COMMENT ON COLUMN core.insured_vehicle.reg_country_code IS 'Страна регистрации ТС';
COMMENT ON COLUMN core.insured_vehicle.is_foreign_registration IS 'Флаг ТС зарегистрировано на территории иностранного государства: 1 – ТС зарегистрировано в иностранном государстве; 0 – ТС зарегистрировано в РФ; -1 – не определено';
COMMENT ON COLUMN core.insured_vehicle.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.insured_vehicle.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.insured_vehicle.alarm_system_installed_type_id IS 'Идентификатор типа установки противоугонной системы';
COMMENT ON COLUMN core.insured_vehicle.printed_brand_name IS 'Название марки (справочное значение)';
COMMENT ON COLUMN core.insured_vehicle.printed_model_name IS 'Название марки (внесенное вручную)';
CREATE TABLE core.jb_log (id_job INTEGER, channel_id CHARACTER VARYING(255), jobname CHARACTER VARYING(255), status CHARACTER VARYING(15), lines_read BIGINT, lines_written BIGINT, lines_updated BIGINT, lines_input BIGINT, lines_output BIGINT, lines_rejected BIGINT, errors BIGINT, startdate TIMESTAMP(6) WITHOUT TIME ZONE, enddate TIMESTAMP(6) WITHOUT TIME ZONE, logdate TIMESTAMP(6) WITHOUT TIME ZONE, depdate TIMESTAMP(6) WITHOUT TIME ZONE, replaydate TIMESTAMP(6) WITHOUT TIME ZONE, log_field TEXT);
CREATE TABLE core.kias_product (kias_product_id INTEGER, kias_product_code CHARACTER VARYING(13), kias_product_name CHARACTER VARYING(512) COLLATE "C", kias_product_line_id INTEGER, kias_product_type_id INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.kias_product.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.leasing_company (scc_id NUMERIC(38,0), leasing_company_id CHARACTER VARYING(7) NOT NULL, leasing_company_name CHARACTER VARYING(255), federal_partner_name CHARACTER VARYING(255), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.leasing_company IS 'Справочник Лизинговые компании (СКК 7.4.22)';
COMMENT ON COLUMN core.leasing_company.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.leasing_company.leasing_company_id IS 'Код лизинговой компании';
COMMENT ON COLUMN core.leasing_company.leasing_company_name IS 'Наименование лизинговой компании';
COMMENT ON COLUMN core.leasing_company.federal_partner_name IS 'Федеральный партнер';
COMMENT ON COLUMN core.leasing_company.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.leasing_company.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.leasing_company.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.liability_allocation (liability_allocation_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), allocation_type_id NUMERIC(36,0), allocation_element_id NUMERIC(36,0), share NUMERIC(36,0), is_standard SMALLINT, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.liability_allocation IS 'Процентное распределение страховой суммы';
COMMENT ON COLUMN core.liability_allocation.liability_allocation_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.liability_allocation.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.liability_allocation.object_risk_id IS 'Идентификатор объект-риска';
COMMENT ON COLUMN core.liability_allocation.allocation_type_id IS 'Идентификатор типа процентного распределения';
COMMENT ON COLUMN core.liability_allocation.allocation_element_id IS 'Идентификатор элемента, на который распределяется страховая сумма';
COMMENT ON COLUMN core.liability_allocation.share IS 'Процент распределения';
COMMENT ON COLUMN core.liability_allocation.is_standard IS 'Признак стандартного распределения: 1 - Стандартное, 0 - Индивидуальное, -1 - Не определен';
COMMENT ON COLUMN core.liability_allocation.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.liability_allocation.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.liability_allocation.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.liability_allocation.key_id IS 'Уникальный ключ';
CREATE TABLE core.loading_stats (entity TEXT, source_id TEXT, created_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, checked_timestamp TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT '1990-01-01 00:00:00'::timestamp without time zone, trn_created_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, edw_updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.loading_stats.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.metrics (Step name TEXT, Step id CHARACTER VARYING(255), Lines input BIGINT, Lines output BIGINT, Lines read BIGINT, Lines updated BIGINT, Lines written BIGINT, Lines rejected BIGINT, duration DOUBLE PRECISION, create_timestamp TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP, SaldoErrors INTEGER);
CREATE TABLE core.month_close_calendar (begin_rep_period DATE, start_date DATE, end_date DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.month_close_calendar IS 'Справочник периодов закрытия';
COMMENT ON COLUMN core.month_close_calendar.begin_rep_period IS 'Период закрытия (месяц и год)';
COMMENT ON COLUMN core.month_close_calendar.start_date IS 'Дата начала периода закрытия';
COMMENT ON COLUMN core.month_close_calendar.end_date IS 'Дата окончания периода закрытия';
COMMENT ON COLUMN core.month_close_calendar.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.mr_7gs_instype_cat (rep_group NUMERIC(4,0) DEFAULT 6000 NOT NULL, dict7gs_id CHARACTER VARYING(7) NOT NULL, ins_type CHARACTER VARYING(7) NOT NULL, category_id CHARACTER VARYING(10) NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.mr_7gs_instype_cat.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.non_insurance_reserve (non_insurance_reserve_id CHARACTER VARYING(50) NOT NULL, object_risk_id CHARACTER VARYING(50), reserve_type CHARACTER VARYING(7), reserve_amt NUMERIC(36,2), reserve_cur CHARACTER VARYING(7), reserve_rub NUMERIC(36,2), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.non_insurance_reserve IS 'Нестраховые резервы';
COMMENT ON COLUMN core.non_insurance_reserve.non_insurance_reserve_id IS 'Идентификатор резерва';
COMMENT ON COLUMN core.non_insurance_reserve.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.non_insurance_reserve.reserve_type IS 'Тип резерва: 1 – Резерв компенсационных выплат по ОПО (РКВ); 2 – Резерв предупредительных мероприятий (РПМ); 3 – Резерв гарантий по ОСАГО (РГ); 5 – Резерв текущих компенсационных выплат по ОСАГО (РТКВ); 7 – Резерв компенсационных выплат по сельскому хозяйству (РКВ СХ); 8 – Резерв противопожарных мероприятий; 9 – Другие резервы.';
COMMENT ON COLUMN core.non_insurance_reserve.reserve_amt IS 'Сумма резерва в валюте';
COMMENT ON COLUMN core.non_insurance_reserve.reserve_cur IS 'Код валюты резерва';
COMMENT ON COLUMN core.non_insurance_reserve.reserve_rub IS 'Сумма резерва в рублях';
COMMENT ON COLUMN core.non_insurance_reserve.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.non_insurance_reserve.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.non_insurance_reserve.hash IS 'Хэш';
COMMENT ON COLUMN core.non_insurance_reserve.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.non_insurance_reserve.key_id IS 'Уникальный ключ';
CREATE TABLE core.notifications (notification_id CHARACTER VARYING(75) NOT NULL, contract_id CHARACTER VARYING(75), subject CHARACTER VARYING(255), registration_date DATE, message TEXT, registration_number CHARACTER VARYING(255), delivery_date DATE, sender_name CHARACTER VARYING(255), recipient_name CHARACTER VARYING(255), communication_type_id CHARACTER VARYING(254), postal_barcode CHARACTER VARYING(255), communication_status_id CHARACTER VARYING(50), modify_date TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.notifications IS 'Уведомления по договору';
COMMENT ON COLUMN core.notifications.notification_id IS 'Идентификатор уведомления';
COMMENT ON COLUMN core.notifications.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.notifications.subject IS 'Тип уведомления для отправки';
COMMENT ON COLUMN core.notifications.registration_date IS 'Дата отправки уведомления';
COMMENT ON COLUMN core.notifications.message IS 'Уведомление';
COMMENT ON COLUMN core.notifications.registration_number IS 'Номер уведомления';
COMMENT ON COLUMN core.notifications.delivery_date IS 'Дата доставки (Почта России)';
COMMENT ON COLUMN core.notifications.sender_name IS 'Отправитель';
COMMENT ON COLUMN core.notifications.recipient_name IS 'Получатель';
COMMENT ON COLUMN core.notifications.communication_type_id IS 'Тип отправки';
COMMENT ON COLUMN core.notifications.postal_barcode IS 'Код ШПИ';
COMMENT ON COLUMN core.notifications.communication_status_id IS 'Статус';
COMMENT ON COLUMN core.notifications.modify_date IS 'Дата изменения в полисной системе';
COMMENT ON COLUMN core.notifications.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.notifications.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.notifications.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.notifications.key_id IS 'Уникальный ключ';
CREATE TABLE core.object_risk (object_risk_id CHARACTER VARYING(50) NOT NULL, contract_object_id CHARACTER VARYING(50) NOT NULL, object_risk_type_id CHARACTER VARYING(50), premium_amt NUMERIC(38,2), premium_cur CHARACTER VARYING(7), premium_source_rub NUMERIC(38,2), premium_rub NUMERIC(38,2), premium_date TIMESTAMP(6) WITHOUT TIME ZONE, cur_rate_date DATE, cur_rate NUMERIC(38,4), liability_amt NUMERIC(38,2), liability_cur CHARACTER VARYING(7), liability_rub NUMERIC(38,2), accounting_group_source CHARACTER VARYING(25), accounting_group CHARACTER VARYING(25), accounting_risk CHARACTER VARYING(100), dict7gs CHARACTER VARYING(25), form162 CHARACTER VARYING(254), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), bid CHARACTER VARYING(25), period_start DATE NOT NULL, period_end DATE NOT NULL, hash CHARACTER VARYING(32), insurance_rule CHARACTER VARYING(300), contract_id CHARACTER VARYING(50), is_active NUMERIC(1,0), agreement_id CHARACTER VARYING(50), liability_delta_amt NUMERIC(36,2), is_life INTEGER, franchise NUMERIC, franchise_unit CHARACTER VARYING(7), franchise_type CHARACTER VARYING(256), franchise_as_k1 SMALLINT, liability_type CHARACTER VARYING(7), order_reimbursment CHARACTER VARYING(7), franchise_min NUMERIC(36,2), government_assist INTEGER, liability_delta_rub NUMERIC(36,2), product_id CHARACTER VARYING(50), premium_coef NUMERIC, liability_coef NUMERIC, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, insurance_rule_id CHARACTER VARYING(50), rule_number CHARACTER VARYING(50), main_liability_start_date DATE, premium_charge_date DATE, coveragecode CHARACTER VARYING(255), offeringcode CHARACTER VARYING(100), main_object_risk_id CHARACTER VARYING(50), risk_package_id INTEGER, liability_limit_amt NUMERIC(36,2), liability_limit_rub_amt NUMERIC(36,2), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, total_premium_amt NUMERIC, key_id UUID NOT NULL, nsis_code CHARACTER VARYING(50));
COMMENT ON TABLE core.object_risk IS 'Риски по объекту договора';
COMMENT ON COLUMN core.object_risk.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.object_risk.contract_object_id IS 'Идентификатор объекта договора';
COMMENT ON COLUMN core.object_risk.object_risk_type_id IS 'Идентификатор типа риска по объекту';
COMMENT ON COLUMN core.object_risk.premium_amt IS 'Начисленная премия в валюте';
COMMENT ON COLUMN core.object_risk.premium_cur IS 'Код валюты премии';
COMMENT ON COLUMN core.object_risk.premium_source_rub IS 'Начисленная премия в рублях';
COMMENT ON COLUMN core.object_risk.premium_rub IS 'Начисленная премия в рублях расчётная';
COMMENT ON COLUMN core.object_risk.premium_date IS 'Целевая дата начисления премии по договору';
COMMENT ON COLUMN core.object_risk.cur_rate_date IS 'Дата определения курса начисленной премии';
COMMENT ON COLUMN core.object_risk.cur_rate IS 'Курс валюты начисленной премии';
COMMENT ON COLUMN core.object_risk.liability_amt IS 'Страховая сумма в валюте';
COMMENT ON COLUMN core.object_risk.liability_cur IS 'Код валюты страховой суммы';
COMMENT ON COLUMN core.object_risk.liability_rub IS 'Страховая сумма в рублях';
COMMENT ON COLUMN core.object_risk.accounting_group_source IS 'Код учетной группы исходный';
COMMENT ON COLUMN core.object_risk.accounting_group IS 'Код учетной группы после перекодировки';
COMMENT ON COLUMN core.object_risk.accounting_risk IS 'Код УВС';
COMMENT ON COLUMN core.object_risk.dict7gs IS '7ГС';
COMMENT ON COLUMN core.object_risk.form162 IS 'Код вида формы 162';
COMMENT ON COLUMN core.object_risk.is_co_insurance IS 'Признак сострахования. 1 – договор сострахования.';
COMMENT ON COLUMN core.object_risk.co_insurance_role IS 'Роль в состраховании. 1 – страховщик лидер, 2 – страховщик участник.';
COMMENT ON COLUMN core.object_risk.bid IS 'Подразделение, в котором заключен договор';
COMMENT ON COLUMN core.object_risk.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.object_risk.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.object_risk.hash IS 'Хэш';
COMMENT ON COLUMN core.object_risk.insurance_rule IS 'Наименование правила';
COMMENT ON COLUMN core.object_risk.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.object_risk.is_active IS 'Признак активного договора: 0 – договор не активный, 1 – договор активный, 2 - "технические" записи, null - не определено';
COMMENT ON COLUMN core.object_risk.agreement_id IS 'Идентификатор дополнительного соглашения';
COMMENT ON COLUMN core.object_risk.liability_delta_amt IS 'Разница страховой суммы в валюте текущего объект-риска и родительского.';
COMMENT ON COLUMN core.object_risk.is_life IS 'Признак договора страхования жизни. 1 – договор относится к страхованию жизни, 0 – договор не относится к страхованию жизни.';
COMMENT ON COLUMN core.object_risk.franchise IS 'Значение франшизы';
COMMENT ON COLUMN core.object_risk.franchise_unit IS 'Единица измерения франшизы: 0 – Валюта договора; 1 – Дни; 2 – Процент от страховой суммы; 3 – Процентах от размера ущерба; 4 – Часы.';
COMMENT ON COLUMN core.object_risk.franchise_type IS 'Тип франшизы: 0 – Условная; 1 – Безусловная; 2 – Условная временная; 3 – Безусловная временная; 4 – Динамическая; 5 – Безусловная со второго случая; 6 – В размере лимита по ОСАГО; 7 - Безусловная агрегатная';
COMMENT ON COLUMN core.object_risk.franchise_as_k1 IS 'Франшиза вместо повышающего коэффициента К1: 1 – Да.';
COMMENT ON COLUMN core.object_risk.liability_type IS 'Тип страховой суммы: 1 – агрегатная.';
COMMENT ON COLUMN core.object_risk.order_reimbursment IS 'Порядок возмещения: 1 – Пропорция, с износом; 2 – Пропорция, без износа; 3 – Пропорция; 4 – Первый риск, с износом; 5 – Первый риск, без износа; 6 – Первый риск; 7 – С учетом износа; 8 – Без учета износа.';
COMMENT ON COLUMN core.object_risk.franchise_min IS 'Ограничение на минимальный размер франшизы';
COMMENT ON COLUMN core.object_risk.government_assist IS 'Признак господдержки: 1 – с господдержкой.';
COMMENT ON COLUMN core.object_risk.liability_delta_rub IS 'Разница страховой суммы в рублях текущего объект-риска и родительского.';
COMMENT ON COLUMN core.object_risk.product_id IS 'Идентификатор страхового продукта/правила страхования';
COMMENT ON COLUMN core.object_risk.premium_coef IS 'Коэффициент премии по риску объекта';
COMMENT ON COLUMN core.object_risk.liability_coef IS 'Коэффициент страховой суммы по риску';
COMMENT ON COLUMN core.object_risk.liability_start_date IS 'Дата начала ответственности риска по объекту';
COMMENT ON COLUMN core.object_risk.liability_end_date IS 'Дата окончания ответственности риска по объекту';
COMMENT ON COLUMN core.object_risk.insurance_rule_id IS 'Идентификатор правила страхования';
COMMENT ON COLUMN core.object_risk.rule_number IS 'Номер правила страхования';
COMMENT ON COLUMN core.object_risk.main_liability_start_date IS 'Дата начала ответственности риска по объекту по основному договору';
COMMENT ON COLUMN core.object_risk.premium_charge_date IS 'Дата начисления премии';
COMMENT ON COLUMN core.object_risk.coveragecode IS 'Код страхового покрытия';
COMMENT ON COLUMN core.object_risk.offeringcode IS 'Наименование предложений';
COMMENT ON COLUMN core.object_risk.main_object_risk_id IS 'Идентификатор риска по объекту основного договора';
COMMENT ON COLUMN core.object_risk.risk_package_id IS 'Идентификатор пакета рисков (Ссылка на справочник core.ref_risk_package)';
COMMENT ON COLUMN core.object_risk.liability_limit_amt IS 'Лимит страховой суммы в валюте';
COMMENT ON COLUMN core.object_risk.liability_limit_rub_amt IS 'Лимит страховой суммы в рублях';
COMMENT ON COLUMN core.object_risk.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.object_risk.total_premium_amt IS 'Полная страховая премия в валюте';
COMMENT ON COLUMN core.object_risk.key_id IS 'Уникальный ключ';
CREATE TABLE core.object_risk_elementary_risk (trigger_sys CHARACTER VARYING(8) NOT NULL, object_risk_elementary_risk_id CHARACTER VARYING(50) NOT NULL, object_risk_id CHARACTER VARYING(50) NOT NULL, elementary_risk_id CHARACTER VARYING(50) NOT NULL, period_start DATE NOT NULL, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL) PARTITION BY LIST (trigger_sys);
CREATE TABLE db_edw.core.object_risk_elementary_risk_arm4 PARTITION OF core.object_risk_elementary_risk FOR VALUES IN ('arm4');
CREATE TABLE db_edw.core.object_risk_elementary_risk_ekis PARTITION OF core.object_risk_elementary_risk FOR VALUES IN ('ekis');
CREATE TABLE db_edw.core.object_risk_elementary_risk_gwpc PARTITION OF core.object_risk_elementary_risk FOR VALUES IN ('gwpc');
CREATE TABLE core.object_risk_elementary_risk_arm4_old (trigger_sys CHARACTER VARYING(8) NOT NULL, object_risk_elementary_risk_id CHARACTER VARYING(50) NOT NULL, object_risk_id CHARACTER VARYING(50) NOT NULL, elementary_risk_id CHARACTER VARYING(50) NOT NULL, period_start DATE NOT NULL, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, CONSTRAINT object_risk_elementary_risk_arm4_pk PRIMARY KEY (object_risk_elementary_risk_id, period_end));
CREATE TABLE core.object_risk_info (object_risk_info_id CHARACTER VARYING(50) NOT NULL, object_risk_id CHARACTER VARYING(50), insurance_territory CHARACTER VARYING(2000), object_name CHARACTER VARYING(2000), sown_area CHARACTER VARYING(2000), weight CHARACTER VARYING(2000), aggregate_deductible INTEGER, period_start DATE, period_end DATE NOT NULL, insurance_value CHARACTER VARYING(2000), yielding CHARACTER VARYING(2000), average_sale_price CHARACTER VARYING(2000), credit_contract_number CHARACTER VARYING(2000), virtu_product_name CHARACTER VARYING(2000), host_country CHARACTER VARYING(2000), is_multiple_trip CHARACTER VARYING(2000), document_vet CHARACTER VARYING(2000), breed_animal CHARACTER VARYING(2000), name_animal CHARACTER VARYING(2000), birth_date_animal CHARACTER VARYING(2000), pet_type_name CHARACTER VARYING(2000), special_version_name CHARACTER VARYING(2000), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.object_risk_info IS 'Дополнительные атрибуты риска по объекту';
COMMENT ON COLUMN core.object_risk_info.object_risk_info_id IS 'Идентификатор проекта/программы';
COMMENT ON COLUMN core.object_risk_info.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.object_risk_info.insurance_territory IS 'Территория страхования';
COMMENT ON COLUMN core.object_risk_info.object_name IS 'Наименование объекта страхования';
COMMENT ON COLUMN core.object_risk_info.sown_area IS 'Посевная площадь';
COMMENT ON COLUMN core.object_risk_info.weight IS 'Количество застрахованных объектов аквакультуры';
COMMENT ON COLUMN core.object_risk_info.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.object_risk_info.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.object_risk_info.insurance_value IS 'Страховая стоимость';
COMMENT ON COLUMN core.object_risk_info.yielding IS 'Урожайность, ц/га';
COMMENT ON COLUMN core.object_risk_info.average_sale_price IS 'Средняя цена реализации, руб/ц';
COMMENT ON COLUMN core.object_risk_info.credit_contract_number IS 'Номер кредитного договора';
COMMENT ON COLUMN core.object_risk_info.virtu_product_name IS 'Тарифное руководство (продукт)';
COMMENT ON COLUMN core.object_risk_info.host_country IS 'Страна пребывания (для ВЗР)';
COMMENT ON COLUMN core.object_risk_info.is_multiple_trip IS 'Тип поездки (для ВЗР)';
COMMENT ON COLUMN core.object_risk_info.document_vet IS 'Наличие вет.паспорта';
COMMENT ON COLUMN core.object_risk_info.breed_animal IS 'Тип/Классификация животного';
COMMENT ON COLUMN core.object_risk_info.name_animal IS 'Кличка животного';
COMMENT ON COLUMN core.object_risk_info.birth_date_animal IS 'Возраст животного';
COMMENT ON COLUMN core.object_risk_info.pet_type_name IS 'Вид домашнего животного';
COMMENT ON COLUMN core.object_risk_info.special_version_name IS 'Наименование спецверсии';
COMMENT ON COLUMN core.object_risk_info.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.object_risk_info.key_id IS 'Уникальный ключ';
CREATE TABLE core.object_risk_long (object_risk_long_id CHARACTER VARYING(50) NOT NULL, contract_long_id CHARACTER VARYING(50), contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), contract_object_id CHARACTER VARYING(50), object_risk_type_id CHARACTER VARYING(50), is_kredit_risk SMALLINT, premium_amt NUMERIC(36,2), premium_cur CHARACTER VARYING(7), premium_rub NUMERIC(36,2), premium_date DATE, cur_rate_date DATE, cur_rate NUMERIC(36,4), accounting_group CHARACTER VARYING(25), accounting_risk CHARACTER VARYING(100), dict7gs CHARACTER VARYING(25), form162 CHARACTER VARYING(254), is_co_insurance SMALLINT, co_insurance_role SMALLINT, bid CHARACTER VARYING(25), agreement_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.object_risk_long IS 'Риски по объекту для многолетнего договора';
COMMENT ON COLUMN core.object_risk_long.object_risk_long_id IS 'Идентификатор риска по объекту для многолетнего условного договора';
COMMENT ON COLUMN core.object_risk_long.contract_long_id IS 'Идентификатор многолетнего условного договора';
COMMENT ON COLUMN core.object_risk_long.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.object_risk_long.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.object_risk_long.contract_object_id IS 'Идентификатор объекта договора';
COMMENT ON COLUMN core.object_risk_long.object_risk_type_id IS 'Идентификатор типа риска по объекту';
COMMENT ON COLUMN core.object_risk_long.is_kredit_risk IS 'Признак наличия кредитного риска';
COMMENT ON COLUMN core.object_risk_long.premium_amt IS 'Начисленная премия для многолетнего условного договора в валюте';
COMMENT ON COLUMN core.object_risk_long.premium_cur IS 'Код валюты премии';
COMMENT ON COLUMN core.object_risk_long.premium_rub IS 'Начисленная премия для многолетнего условного договора в рублях расчётная';
COMMENT ON COLUMN core.object_risk_long.premium_date IS 'Целевая дата начисления премии многолетнего условного договора';
COMMENT ON COLUMN core.object_risk_long.cur_rate_date IS 'Дата определения курса начисленной премии';
COMMENT ON COLUMN core.object_risk_long.cur_rate IS 'Курс валюты начисленной премии';
COMMENT ON COLUMN core.object_risk_long.accounting_group IS 'Код учетной группы после перекодировки';
COMMENT ON COLUMN core.object_risk_long.accounting_risk IS 'Код УВС';
COMMENT ON COLUMN core.object_risk_long.dict7gs IS '7ГС';
COMMENT ON COLUMN core.object_risk_long.form162 IS 'Код вида формы 162';
COMMENT ON COLUMN core.object_risk_long.is_co_insurance IS 'Признак сострахования. 1 – договор сострахования.';
COMMENT ON COLUMN core.object_risk_long.co_insurance_role IS 'Роль в состраховании. 1 – страховщик лидер, 2 – страховщик участник.';
COMMENT ON COLUMN core.object_risk_long.bid IS 'Подразделение, в котором заключен договор';
COMMENT ON COLUMN core.object_risk_long.agreement_id IS 'Идентификатор дополнительного соглашения';
COMMENT ON COLUMN core.object_risk_long.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.object_risk_long.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.object_risk_long.hash IS 'Хэш';
COMMENT ON COLUMN core.object_risk_long.liability_start_date IS 'Дата начала ответственности многолетнего условного договора';
COMMENT ON COLUMN core.object_risk_long.liability_end_date IS 'Дата окончания ответственности многолетнего условного договора';
COMMENT ON COLUMN core.object_risk_long.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.object_risk_long.key_id IS 'Уникальный ключ';
CREATE TABLE core.object_risk_type (object_risk_type_id CHARACTER VARYING(50) NOT NULL, object_risk_type_name CHARACTER VARYING(2600), period_start DATE NOT NULL, period_end DATE NOT NULL, is_vehicle_attribute INTEGER, program_class CHARACTER VARYING(512), hash CHARACTER VARYING(32), object_class CHARACTER VARYING(512), productcode CHARACTER VARYING(255), offeringcode CHARACTER VARYING(255), coveragecode CHARACTER VARYING(255), attribute1 CHARACTER VARYING(250), casco_risk INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.object_risk_type IS 'Тип риска по объекту';
COMMENT ON COLUMN core.object_risk_type.object_risk_type_id IS 'Идентификатор типа риска по объекту';
COMMENT ON COLUMN core.object_risk_type.object_risk_type_name IS 'Наименование типа риска по объекту';
COMMENT ON COLUMN core.object_risk_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.object_risk_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.object_risk_type.is_vehicle_attribute IS 'Признак наличия атрибута ТС у типа риска по объекту';
COMMENT ON COLUMN core.object_risk_type.program_class IS 'Программа';
COMMENT ON COLUMN core.object_risk_type.hash IS 'Хэш';
COMMENT ON COLUMN core.object_risk_type.object_class IS 'Класс объекта';
COMMENT ON COLUMN core.object_risk_type.productcode IS 'Код продукта';
COMMENT ON COLUMN core.object_risk_type.offeringcode IS 'Код предложения';
COMMENT ON COLUMN core.object_risk_type.coveragecode IS 'Код покрытия';
COMMENT ON COLUMN core.object_risk_type.attribute1 IS 'Атрибут 1';
COMMENT ON COLUMN core.object_risk_type.casco_risk IS 'Код риска для КАСКО';
COMMENT ON COLUMN core.object_risk_type.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.object_risk_type.key_id IS 'Уникальный ключ';
CREATE TABLE core.operator (operator_id CHARACTER VARYING(50) NOT NULL, period_start DATE NOT NULL, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.operator IS 'Оператор';
COMMENT ON COLUMN core.operator.operator_id IS 'Идентификатор';
COMMENT ON COLUMN core.operator.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.operator.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.operator.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.operator.key_id IS 'Уникальный ключ';
CREATE TABLE core.operator_department (operator_department_id CHARACTER VARYING(50) NOT NULL, department_id CHARACTER VARYING(50), operator_id CHARACTER VARYING(50), period_start DATE NOT NULL, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.operator_department IS 'Подразделение оператора';
COMMENT ON COLUMN core.operator_department.operator_department_id IS 'Идентификатор связи';
COMMENT ON COLUMN core.operator_department.department_id IS 'Идентификатор точки продаж';
COMMENT ON COLUMN core.operator_department.operator_id IS 'Идентификатор оператора';
COMMENT ON COLUMN core.operator_department.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.operator_department.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.operator_department.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.operator_department.key_id IS 'Уникальный ключ';
CREATE TABLE core.other_partner (scc_id NUMERIC(38,0), other_partner_id CHARACTER VARYING(7) NOT NULL, other_partner_name CHARACTER VARYING(255), federal_partner_name CHARACTER VARYING(255), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.other_partner IS 'Cправочник Прочие партнеры (СКК 7.4.24)';
COMMENT ON COLUMN core.other_partner.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.other_partner.other_partner_id IS 'Код партнера';
COMMENT ON COLUMN core.other_partner.other_partner_name IS 'Наименование партнера';
COMMENT ON COLUMN core.other_partner.federal_partner_name IS 'Федеральный партнер';
COMMENT ON COLUMN core.other_partner.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.other_partner.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.other_partner.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.paid_return (paid_return_id CHARACTER VARYING(50) NOT NULL, declared_return_id CHARACTER VARYING(50), contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), payment_return_date TIMESTAMP(6) WITHOUT TIME ZONE, payment_return_amt NUMERIC(32,2), payment_return_cur CHARACTER VARYING(7), payment_return_rub NUMERIC(32,2), payment_return_type NUMERIC(2,0), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.paid_return IS 'Выплаченный возврат';
COMMENT ON COLUMN core.paid_return.paid_return_id IS 'Идентификатор выплаченного возврата';
COMMENT ON COLUMN core.paid_return.declared_return_id IS 'Идентификатор заявленного возврата';
COMMENT ON COLUMN core.paid_return.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.paid_return.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.paid_return.payment_return_date IS 'Дата выплаты';
COMMENT ON COLUMN core.paid_return.payment_return_amt IS 'Сумма выплаты в валюте';
COMMENT ON COLUMN core.paid_return.payment_return_cur IS 'Код валюты';
COMMENT ON COLUMN core.paid_return.payment_return_rub IS 'Сумма выплаты в рублях';
COMMENT ON COLUMN core.paid_return.payment_return_type IS 'Тип выплаты: 1 – Выплата, 2 – Отказ, 3 – Зачет убытка в части неоплаченной премии, 6 – Взаимозачет, 10 - Взаимозачет по акту';
COMMENT ON COLUMN core.paid_return.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.paid_return.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.paid_return.hash IS 'Хэш';
COMMENT ON COLUMN core.paid_return.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.paid_return.key_id IS 'Уникальный ключ';
CREATE TABLE core.paper (paper_id CHARACTER VARYING(50) NOT NULL, paper_number CHARACTER VARYING(100), paper_date DATE, type_code CHARACTER VARYING(80), type_name CHARACTER VARYING(4000), subtype_code CHARACTER VARYING(80), subtype_name CHARACTER VARYING(4000), status_code CHARACTER VARYING(80), status_name CHARACTER VARYING(4000), sender_counterparty_id CHARACTER VARYING(50), receiver_counterparty_id CHARACTER VARYING(50), packet_number CHARACTER VARYING(255), note CHARACTER VARYING(4000), src_created_ts TIMESTAMP(6) WITHOUT TIME ZONE, src_create_counterparty_id CHARACTER VARYING(100), src_modified_ts TIMESTAMP(6) WITHOUT TIME ZONE, src_modify_counterparty_id CHARACTER VARYING(50), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, lnr_code CHARACTER VARYING(255), paper_kind_id INTEGER, storno_date TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, billing_start_date DATE, billing_end_date DATE, paper_stage_id CHARACTER VARYING(50), key_id UUID NOT NULL, department_id CHARACTER VARYING(50));
COMMENT ON TABLE core.paper IS 'Документы хозяйственной деятельности';
COMMENT ON COLUMN core.paper.paper_id IS 'ID акта учета БСО /ID документа (первичный ключ)';
COMMENT ON COLUMN core.paper.paper_number IS 'Номер документа';
COMMENT ON COLUMN core.paper.paper_date IS 'Дата документа';
COMMENT ON COLUMN core.paper.type_code IS 'Код типа документа';
COMMENT ON COLUMN core.paper.type_name IS 'Наименование типа документа';
COMMENT ON COLUMN core.paper.subtype_code IS 'Код подтипа документа';
COMMENT ON COLUMN core.paper.subtype_name IS 'Наименование подтипа документа';
COMMENT ON COLUMN core.paper.status_code IS 'Код статуса документа';
COMMENT ON COLUMN core.paper.status_name IS 'Наименование статуса документа';
COMMENT ON COLUMN core.paper.sender_counterparty_id IS 'ID отправителя (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.paper.receiver_counterparty_id IS 'ID получателя/ ID контрагента (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.paper.packet_number IS 'Номер пакета';
COMMENT ON COLUMN core.paper.note IS 'Примечание';
COMMENT ON COLUMN core.paper.src_created_ts IS 'Дата создания документа';
COMMENT ON COLUMN core.paper.src_create_counterparty_id IS 'ID автора создания документа (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.paper.src_modified_ts IS 'Дата изменения документа';
COMMENT ON COLUMN core.paper.src_modify_counterparty_id IS 'ID автора изменения документа (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.paper.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.paper.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.paper.lnr_code IS 'Личный номер работника';
COMMENT ON COLUMN core.paper.paper_kind_id IS 'ID вида акта (справочник ref_paper_kind)';
COMMENT ON COLUMN core.paper.storno_date IS 'Дата сторнирования ОСАГО';
COMMENT ON COLUMN core.paper.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.paper.billing_start_date IS 'Дата начала документа';
COMMENT ON COLUMN core.paper.billing_end_date IS 'Дата окончания документа';
COMMENT ON COLUMN core.paper.paper_stage_id IS 'Стадия документа (выход на справочник core.ref_paper_stage)';
COMMENT ON COLUMN core.paper.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.paper.department_id IS 'Идентификатор подразделения документа (ссылка на справочник core.ref_department)';
CREATE TABLE core.paper_deferred_payment (paper_deferred_payment_id CHARACTER VARYING(50) NOT NULL, paper_id CHARACTER VARYING(50), act_payment_amt NUMERIC(36,10), deferred_payment_id CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.paper_deferred_payment IS 'Таблица связи оплат будущих периодов с документами хоз. Деятельности';
COMMENT ON COLUMN core.paper_deferred_payment.paper_deferred_payment_id IS 'Идентификатор связи графика платежей с актом (первичный ключ)';
COMMENT ON COLUMN core.paper_deferred_payment.paper_id IS 'Акт взаиморасчетов (лежит исн документов) это выход на БСО таблицу core.paper';
COMMENT ON COLUMN core.paper_deferred_payment.act_payment_amt IS 'Премия или КВ перестрахователя к оплате по Акту';
COMMENT ON COLUMN core.paper_deferred_payment.deferred_payment_id IS 'Идентификатор будущей оплаты (выход на табл. Deferred_payment)';
COMMENT ON COLUMN core.paper_deferred_payment.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.paper_deferred_payment.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.paper_deferred_payment.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.paper_deferred_payment.key_id IS 'Уникальный ключ';
CREATE TABLE core.paper_event (paper_event_id CHARACTER VARYING(50) NOT NULL, paper_id CHARACTER VARYING(50), event_type_id CHARACTER VARYING(50), event_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, counterparty_id CHARACTER VARYING(50), description CHARACTER VARYING(4000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.paper_event IS 'История документа учета БСО';
COMMENT ON COLUMN core.paper_event.paper_event_id IS 'Идентификатор события';
COMMENT ON COLUMN core.paper_event.paper_id IS 'Идентификатор документа';
COMMENT ON COLUMN core.paper_event.event_type_id IS 'Идентификатор события (Ссылка на справочник событий)';
COMMENT ON COLUMN core.paper_event.event_timestamp IS 'Дата начала действия события';
COMMENT ON COLUMN core.paper_event.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.paper_event.description IS 'Стадия прохождения события, комментарий';
COMMENT ON COLUMN core.paper_event.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.paper_event.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.paper_event.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.paper_event.key_id IS 'Уникальный ключ';
CREATE TABLE core.payment (payment_id CHARACTER VARYING(50) NOT NULL, payment_date TIMESTAMP(6) WITHOUT TIME ZONE, collection_date TIMESTAMP(6) WITHOUT TIME ZONE, payment_amt NUMERIC, payment_cur CHARACTER VARYING(7), payment_rub NUMERIC, period_start TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, hash CHARACTER VARYING(32), contract_id CHARACTER VARYING(50), agent_statement_id CHARACTER VARYING(50), blank_a7 CHARACTER VARYING, authorization_code CHARACTER VARYING(50), order_number CHARACTER VARYING(50), payment_type INTEGER, debit_writeoff_date DATE, is_offset_unpaid_premium INTEGER, is_return_premium INTEGER, agent_id CHARACTER VARYING(50), payer INTEGER, broker_licence CHARACTER VARYING(50), government_assist SMALLINT, blank_type CHARACTER VARYING(25), payment_doc_series CHARACTER VARYING(60), payment_doc_number CHARACTER VARYING(355), payment_method_ncode CHARACTER VARYING(7), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, matching_date DATE, key_id UUID NOT NULL, agent_report_id CHARACTER VARYING(50), agent_invoice_id CHARACTER VARYING(50));
COMMENT ON TABLE core.payment IS 'Оплаты по договору';
COMMENT ON COLUMN core.payment.payment_id IS 'Идентификатор оплаты по договору';
COMMENT ON COLUMN core.payment.payment_date IS 'Дата оплаты страхователем';
COMMENT ON COLUMN core.payment.collection_date IS 'Дата получения платежа страховщиком';
COMMENT ON COLUMN core.payment.payment_amt IS 'Сумма, оплаченная Страхователем в валюте договора';
COMMENT ON COLUMN core.payment.payment_cur IS 'Валюта договора';
COMMENT ON COLUMN core.payment.payment_rub IS 'Сумма, оплаченная Страхователем в рублях';
COMMENT ON COLUMN core.payment.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.payment.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.payment.hash IS 'Хэш';
COMMENT ON COLUMN core.payment.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.payment.agent_statement_id IS 'Идентификатор отчёта агента (по платежу)';
COMMENT ON COLUMN core.payment.blank_a7 IS 'Квитанция форма А-7 (серия-номер)';
COMMENT ON COLUMN core.payment.authorization_code IS 'Код авторизации';
COMMENT ON COLUMN core.payment.order_number IS 'Номера заказа';
COMMENT ON COLUMN core.payment.payment_type IS 'Способ оплаты: 1 - Наличными; 2 - Безналичный расчет; 3 - По кредитной карте; 9 - Другой; 10 - Взаимозачет по акту.';
COMMENT ON COLUMN core.payment.debit_writeoff_date IS 'Дата списания дебиторской задолженности';
COMMENT ON COLUMN core.payment.is_offset_unpaid_premium IS 'Признак зачета убытка в части неоплаченной премии: 1 – зачет убытка в части неоплаченной премии; 0 – иначе.';
COMMENT ON COLUMN core.payment.is_return_premium IS 'Признак возврата: 1 – расчет на возврат части страховой премии; 0 – иначе.';
COMMENT ON COLUMN core.payment.agent_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.payment.payer IS 'Признак плательщика: 1 - Страхователь, 2 - Посредник.';
COMMENT ON COLUMN core.payment.broker_licence IS 'Номер брокерской лицензии';
COMMENT ON COLUMN core.payment.government_assist IS 'Признак господдержки: 1 – оплата с господдержкой';
COMMENT ON COLUMN core.payment.blank_type IS 'Тип платежного документа';
COMMENT ON COLUMN core.payment.payment_doc_series IS 'Серия платежного документа';
COMMENT ON COLUMN core.payment.payment_doc_number IS 'Номер платежного документа';
COMMENT ON COLUMN core.payment.payment_method_ncode IS 'Метод оплаты страховой премии Страхователем по договору (согласно СКК 7.10.22)';
COMMENT ON COLUMN core.payment.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.payment.matching_date IS 'Дата квитования';
COMMENT ON COLUMN core.payment.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.payment.agent_report_id IS 'Идентификатор ОА';
COMMENT ON COLUMN core.payment.agent_invoice_id IS 'Идентификатор счета (ссылка на таблицу core.agent_invoice)';
CREATE TABLE core.payment_counterparty (payment_counterparty_id BIGINT DEFAULT nextval('payment_counterparty_id_seq'::regclass), payment_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50) NOT NULL, payment_counterparty_role INTEGER NOT NULL, period_start DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL) PARTITION BY RANGE (payment_counterparty_role);
CREATE TABLE db_edw.core.payment_counterparty1 PARTITION OF core.payment_counterparty FOR VALUES FROM (1) TO (2);
CREATE TABLE db_edw.core.payment_counterparty2 PARTITION OF core.payment_counterparty FOR VALUES FROM (2) TO (3);
CREATE TABLE db_edw.core.payment_counterparty3 PARTITION OF core.payment_counterparty FOR VALUES FROM (3) TO (4);
CREATE TABLE db_edw.core.payment_counterparty4 PARTITION OF core.payment_counterparty FOR VALUES FROM (4) TO (5);
CREATE TABLE db_edw.core.payment_counterparty5 PARTITION OF core.payment_counterparty FOR VALUES FROM (5) TO (6);
CREATE TABLE db_edw.core.payment_counterparty6 PARTITION OF core.payment_counterparty FOR VALUES FROM (6) TO (7);
CREATE TABLE db_edw.core.payment_counterparty7 PARTITION OF core.payment_counterparty FOR VALUES FROM (7) TO (8);
CREATE TABLE db_edw.core.payment_counterparty8 PARTITION OF core.payment_counterparty FOR VALUES FROM (8) TO (9);
COMMENT ON TABLE core.payment_counterparty IS 'Контрагенты по платежам';
COMMENT ON COLUMN core.payment_counterparty.payment_counterparty_id IS 'Идентификатор контрагента по платежу';
COMMENT ON COLUMN core.payment_counterparty.payment_id IS 'Идентификатор платежа';
COMMENT ON COLUMN core.payment_counterparty.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.payment_counterparty.counterparty_id IS 'Идентификатор контрагента';
COMMENT ON COLUMN core.payment_counterparty.payment_counterparty_role IS 'Роль контрагента';
COMMENT ON COLUMN core.payment_counterparty.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.payment_counterparty.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.payment_counterparty.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.payment_counterparty.key_id IS 'Уникальный ключ';
CREATE TABLE core.payment_risk (payment_risk_id CHARACTER VARYING(50) NOT NULL, payment_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), payment_risk_amt NUMERIC(38,2), payment_risk_cur CHARACTER VARYING(7), payment_risk_rub NUMERIC(38,2), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), payment_date TIMESTAMP(6) WITHOUT TIME ZONE, collection_date TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.payment_risk IS 'Оплаты по рискам по объекту';
COMMENT ON COLUMN core.payment_risk.payment_risk_id IS 'Идентификатор оплаты по риску по объекту';
COMMENT ON COLUMN core.payment_risk.payment_id IS 'Идентификатор оплаты по договору';
COMMENT ON COLUMN core.payment_risk.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.payment_risk.payment_risk_amt IS 'Сумма в валюте';
COMMENT ON COLUMN core.payment_risk.payment_risk_cur IS 'Код валюты';
COMMENT ON COLUMN core.payment_risk.payment_risk_rub IS 'Сумма в рублях';
COMMENT ON COLUMN core.payment_risk.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.payment_risk.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.payment_risk.hash IS 'Хэш';
COMMENT ON COLUMN core.payment_risk.payment_date IS 'Дата оплаты страхователем';
COMMENT ON COLUMN core.payment_risk.collection_date IS 'Дата получения платежа страховщиком';
COMMENT ON COLUMN core.payment_risk.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.payment_risk.key_id IS 'Уникальный ключ';
CREATE TABLE core.payment_schedule (payment_schedule_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), expected_date TIMESTAMP(6) WITHOUT TIME ZONE, expected_amt NUMERIC(36,2), expected_cur CHARACTER VARYING(7), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), is_actual SMALLINT, type CHARACTER VARYING(100), partner_counterparty_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.payment_schedule IS 'График платежей по договорам страхования и перестрахования';
COMMENT ON COLUMN core.payment_schedule.payment_schedule_id IS 'Идентификатор графика платежей (первичный ключ)';
COMMENT ON COLUMN core.payment_schedule.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.payment_schedule.expected_date IS 'Ожидаемая дата оплаты';
COMMENT ON COLUMN core.payment_schedule.expected_amt IS 'Ожидаемая сумма оплаты в валюте (договора)';
COMMENT ON COLUMN core.payment_schedule.expected_cur IS 'Код валюты (договора)';
COMMENT ON COLUMN core.payment_schedule.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.payment_schedule.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.payment_schedule.hash IS 'Хэш';
COMMENT ON COLUMN core.payment_schedule.is_actual IS 'Признак актуального графика платежа: 1 - актуальный, 0 - не актуальный';
COMMENT ON COLUMN core.payment_schedule.type IS 'Тип графика';
COMMENT ON COLUMN core.payment_schedule.partner_counterparty_id IS 'Идентификатор партнера';
COMMENT ON COLUMN core.payment_schedule.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.payment_schedule.key_id IS 'Уникальный ключ';
CREATE TABLE core.promocode_event (promocode_event_id CHARACTER VARYING(50) NOT NULL, event_date TIMESTAMP(6) WITHOUT TIME ZONE, contract_id CHARACTER VARYING(50), promocode_id CHARACTER VARYING(50), promocode CHARACTER VARYING(255), error_descr CHARACTER VARYING(255), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON COLUMN core.promocode_event.promocode_event_id IS 'Идентификатор применения промокода';
COMMENT ON COLUMN core.promocode_event.event_date IS 'Дата применения промокода';
COMMENT ON COLUMN core.promocode_event.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.promocode_event.promocode_id IS 'Идентификатор промокода';
COMMENT ON COLUMN core.promocode_event.promocode IS 'Промокод';
COMMENT ON COLUMN core.promocode_event.error_descr IS 'Описание ошибки';
COMMENT ON COLUMN core.promocode_event.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.promocode_event.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.promocode_event.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.promocode_event.key_id IS 'Уникальный ключ';
CREATE TABLE core.rates_cb (currency_id CHARACTER VARYING(3) NOT NULL, rate_date DATE NOT NULL, rate_value NUMERIC(32,4), rate_currency_quantity NUMERIC, vdat TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID);
COMMENT ON TABLE core.rates_cb IS 'Справочник курсов ЦБ';
COMMENT ON COLUMN core.rates_cb.currency_id IS 'Идентификатор валюты';
COMMENT ON COLUMN core.rates_cb.rate_date IS 'Дата курса валюты';
COMMENT ON COLUMN core.rates_cb.rate_value IS 'Значение курса валюты';
COMMENT ON COLUMN core.rates_cb.rate_currency_quantity IS 'Количество валют';
COMMENT ON COLUMN core.rates_cb.vdat IS 'Дата загрузки';
COMMENT ON COLUMN core.rates_cb.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.rates_cb.key_id IS 'Уникальный ключ';
CREATE TABLE core.ref_absence_type (absence_type_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_absence_type IS 'Справочник типов отсутствий';
COMMENT ON COLUMN core.ref_absence_type.absence_type_id IS 'Идентификатор типа отсутствия';
COMMENT ON COLUMN core.ref_absence_type.name IS 'Наименование типа отсутствия';
COMMENT ON COLUMN core.ref_absence_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_absence_type.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_account_group_781p (scc_id NUMERIC(38,0) NOT NULL, id_scc_account_781p CHARACTER VARYING(50), c_accounting_group_id CHARACTER VARYING(25), account_group_781p CHARACTER VARYING(25), dict7gs_id CHARACTER VARYING(7), period_start DATE DEFAULT '2023-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_account_group_781p IS 'Справочник учетной группы по 781П';
COMMENT ON COLUMN core.ref_account_group_781p.scc_id IS 'Идентификатор СКК';
COMMENT ON COLUMN core.ref_account_group_781p.id_scc_account_781p IS 'Идентификатор учетной группы по 781П';
COMMENT ON COLUMN core.ref_account_group_781p.c_accounting_group_id IS 'Код учетной группы';
COMMENT ON COLUMN core.ref_account_group_781p.account_group_781p IS 'Код учетной группы по 781П';
COMMENT ON COLUMN core.ref_account_group_781p.dict7gs_id IS 'Код 7ГС';
COMMENT ON COLUMN core.ref_account_group_781p.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_account_group_781p.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_account_group_781p.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_accrual_compensation (scc_id NUMERIC(38,0), id_accrual_compensation CHARACTER VARYING(254), dict7gs_id CHARACTER VARYING(7), opo_compensation_fund NUMERIC, fire_prevention_fund NUMERIC, agro_compensation_fund NUMERIC, preventive_fund NUMERIC, guarantee_reserve NUMERIC, compensation_fund NUMERIC, other_fund NUMERIC, start_date DATE, end_date DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE DEFAULT CURRENT_TIMESTAMP NOT NULL, period_end DATE DEFAULT '9999-12-31'::date);
COMMENT ON COLUMN core.ref_accrual_compensation.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_activity_type (activity_type_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_activity_type IS 'Справочник типа задач по урегулированию убытков';
COMMENT ON COLUMN core.ref_activity_type.activity_type_id IS 'Идентификатор типа задачи ';
COMMENT ON COLUMN core.ref_activity_type.name IS 'Наименование задачи';
COMMENT ON COLUMN core.ref_activity_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_activity_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_activity_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_add_coverage (add_coverage_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), risk_package_id NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_add_coverage IS 'Справочник Дополнительных покрытий (СКК 7.13.32)';
COMMENT ON COLUMN core.ref_add_coverage.add_coverage_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_add_coverage.name IS 'Наименование дополнительного покрытия';
COMMENT ON COLUMN core.ref_add_coverage.risk_package_id IS 'Идентификатор записи пакета рисков (Ссылка на core.ref_risk_package)';
COMMENT ON COLUMN core.ref_add_coverage.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_add_coverage.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_add_coverage.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_addendum_reason (addendum_reason_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(50), name CHARACTER VARYING(500), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_addendum_reason IS 'Справочник причин создания дополнительного соглашения к агентскому договору';
COMMENT ON COLUMN core.ref_addendum_reason.addendum_reason_id IS 'Идентификатор причины создания';
COMMENT ON COLUMN core.ref_addendum_reason.code IS 'Код причины создания';
COMMENT ON COLUMN core.ref_addendum_reason.name IS 'Наименование причины создания';
COMMENT ON COLUMN core.ref_addendum_reason.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_addendum_reason.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_addendum_reason.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_additional_equipment (additional_equipment_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), short_name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_additional_equipment IS 'Справочник Дополнительного инженерного оборудования';
COMMENT ON COLUMN core.ref_additional_equipment.additional_equipment_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_additional_equipment.name IS 'Наименование оборудования';
COMMENT ON COLUMN core.ref_additional_equipment.short_name IS 'Короткое наименование оборудования';
COMMENT ON COLUMN core.ref_additional_equipment.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_additional_equipment.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_additional_equipment.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_agent_invoice_link_type (agent_invoice_link_type_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(512), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
CREATE TABLE core.ref_agent_payment_type (agent_payment_type_id CHARACTER VARYING(100) NOT NULL, name CHARACTER VARYING(500), code CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_agent_payment_type IS 'Справочник типов удержания КВ';
COMMENT ON COLUMN core.ref_agent_payment_type.agent_payment_type_id IS 'Идентификатор типа удержания КВ';
COMMENT ON COLUMN core.ref_agent_payment_type.name IS 'Наименование типа';
COMMENT ON COLUMN core.ref_agent_payment_type.code IS 'Код типа';
COMMENT ON COLUMN core.ref_agent_payment_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_agent_payment_type.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_agent_report_status (agent_report_status_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(100), name CHARACTER VARYING(512), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_agent_report_status IS 'Справочник статусов ОА';
COMMENT ON COLUMN core.ref_agent_report_status.agent_report_status_id IS 'Идентификатор статуса ОА';
COMMENT ON COLUMN core.ref_agent_report_status.code IS 'Код статуса ОА';
COMMENT ON COLUMN core.ref_agent_report_status.name IS 'Наименование статуса ОА';
COMMENT ON COLUMN core.ref_agent_report_status.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_agent_report_status.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_agent_status (agent_status_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(100), name CHARACTER VARYING(512), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_agent_status IS 'Справочник статусов агента';
COMMENT ON COLUMN core.ref_agent_status.agent_status_id IS 'Идентификатор статуса агента';
COMMENT ON COLUMN core.ref_agent_status.code IS 'Код статуса агента';
COMMENT ON COLUMN core.ref_agent_status.name IS 'Наименование статуса агента';
COMMENT ON COLUMN core.ref_agent_status.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_agent_status.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_alarm_guard (alarm_guard_id CHARACTER VARYING(50) NOT NULL, alarm_guard CHARACTER VARYING(256), alarm_type NUMERIC, start_date DATE, end_date DATE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_alarm_guard IS 'Справочник противоугонных устройств';
COMMENT ON COLUMN core.ref_alarm_guard.alarm_guard_id IS 'Идентификатор противоугонного устройства';
COMMENT ON COLUMN core.ref_alarm_guard.alarm_guard IS 'Наименование противоугонного устройства';
COMMENT ON COLUMN core.ref_alarm_guard.alarm_type IS 'Тип противоугонного устройства: 1 - Поисковая противоугонная система (ППС), 2 - Электронная противоугонная система (ЭПС), 3 - Механическое противоугонное устройство (МПУ)';
COMMENT ON COLUMN core.ref_alarm_guard.start_date IS 'Дата начала действия противоугонного устройства';
COMMENT ON COLUMN core.ref_alarm_guard.end_date IS 'Дата окончания действия противоугонного устройства';
COMMENT ON COLUMN core.ref_alarm_guard.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_alarm_guard.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_alarm_guard.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_alarm_system_installed_type (alarm_system_installed_type_id CHARACTER VARYING(50) NOT NULL, description CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_alarm_system_installed_type IS 'Справочник типов установки противоугонных систем';
COMMENT ON COLUMN core.ref_alarm_system_installed_type.alarm_system_installed_type_id IS 'Идентификатор типа установки противоугонных систем';
COMMENT ON COLUMN core.ref_alarm_system_installed_type.description IS 'Описание типа установки противоугонных систем';
COMMENT ON COLUMN core.ref_alarm_system_installed_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_alarm_system_installed_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_alarm_system_installed_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_allocation (allocation_id NUMERIC NOT NULL, allocation_type_id NUMERIC, allocation_element_id NUMERIC, allocation_subtype_id NUMERIC, immovable_property_id NUMERIC, standart_rate NUMERIC, min_rate NUMERIC, max_rate NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_allocation IS 'Справочник Процентных распределений страховой суммы по элементам (СКК 7.13.77)';
COMMENT ON COLUMN core.ref_allocation.allocation_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_allocation.allocation_type_id IS 'Идентификатор записи типа процентного распределения (Ссылка на core.ref_allocation_type)';
COMMENT ON COLUMN core.ref_allocation.allocation_element_id IS 'Идентификатор записи элемента в процентном распределении (Ссылка на core.ref_allocation_element)';
COMMENT ON COLUMN core.ref_allocation.allocation_subtype_id IS 'Идентификатор записи подтипа процентного распределения (Ссылка на core.ref_allocation_subtype)';
COMMENT ON COLUMN core.ref_allocation.immovable_property_id IS 'Идентификатор записи недвижимого имущества (Ссылка на core.ref_immovable_property)';
COMMENT ON COLUMN core.ref_allocation.standart_rate IS 'Процент стандартного распределения';
COMMENT ON COLUMN core.ref_allocation.min_rate IS 'Минимальное значение без андеррайтинга';
COMMENT ON COLUMN core.ref_allocation.max_rate IS 'Максимальное значение без андеррайтинга';
COMMENT ON COLUMN core.ref_allocation.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_allocation.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_allocation.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_allocation_element (allocation_element_id NUMERIC NOT NULL, allocation_type_id NUMERIC, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_allocation_element IS 'Справочник Элементов для процентных распределений страховой суммы на покрытии (СКК 7.13.27)';
COMMENT ON COLUMN core.ref_allocation_element.allocation_element_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_allocation_element.allocation_type_id IS 'Идентификатор записи типа процентного распределения (Ссылка на core.ref_allocation_type)';
COMMENT ON COLUMN core.ref_allocation_element.name IS 'Наименование элемента';
COMMENT ON COLUMN core.ref_allocation_element.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_allocation_element.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_allocation_element.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_allocation_subtype (allocation_subtype_id NUMERIC NOT NULL, name CHARACTER VARYING(254), is_ext_finishing_insured NUMERIC, is_foundation_insured NUMERIC, is_roof_insured NUMERIC, is_mkd NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_allocation_subtype IS 'Справочник Подтипов процентных распределений страховой суммы на покрытии (СКК 7.13.75)';
COMMENT ON COLUMN core.ref_allocation_subtype.allocation_subtype_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_allocation_subtype.name IS 'Наименование подтипа процентных распределений';
COMMENT ON COLUMN core.ref_allocation_subtype.is_ext_finishing_insured IS 'Признак страхования внешней отделки в составе Общего Имущества у МКД: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_allocation_subtype.is_foundation_insured IS 'Признак страхования фундамента в составе Общего Имущества у МКД: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_allocation_subtype.is_roof_insured IS 'Признак страхования крыши в составе Общего Имущества у МКД: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_allocation_subtype.is_mkd IS 'Объект является Многоквартирным домом (МКД): 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_allocation_subtype.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_allocation_subtype.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_allocation_subtype.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_allocation_type (allocation_type_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_allocation_type IS 'Справочник Типов процентных распределений страховой суммы на покрытии (СКК 7.13.26)';
COMMENT ON COLUMN core.ref_allocation_type.allocation_type_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_allocation_type.name IS 'Наименование типа процентного распределения';
COMMENT ON COLUMN core.ref_allocation_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_allocation_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_allocation_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_autodictpaymentmethod (scc_id NUMERIC(38,0), payment_method_id CHARACTER VARYING(7), payment_method_name CHARACTER VARYING(100), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_autodictpaymentmethod IS 'Справочник способы возмещения (СКК 7.13.21)';
COMMENT ON COLUMN core.ref_autodictpaymentmethod.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_autodictpaymentmethod.payment_method_id IS 'Идентификатор оплаты';
COMMENT ON COLUMN core.ref_autodictpaymentmethod.payment_method_name IS 'Наименование идентификатора оплаты';
COMMENT ON COLUMN core.ref_autodictpaymentmethod.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_bank_email (scc_id NUMERIC NOT NULL, scc_status NUMERIC, id NUMERIC, date_from TIMESTAMP(6) WITHOUT TIME ZONE, date_to TIMESTAMP(6) WITHOUT TIME ZONE, is_node NUMERIC, base_id NUMERIC, id_ CHARACTER VARYING(254), bank_code NUMERIC, bank_name NUMERIC, bank_email CHARACTER VARYING(254), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.ref_bank_email.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_bank_email.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_bank_email.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_bordereau_type (bordereau_type_id CHARACTER VARYING(80) NOT NULL, bordereau_type_name CHARACTER VARYING(4000), bordereau_type_code CHARACTER VARYING(80), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_bordereau_type IS 'Справочник типов бордеро';
COMMENT ON COLUMN core.ref_bordereau_type.bordereau_type_id IS 'ID типа бордеро (первичный ключ)';
COMMENT ON COLUMN core.ref_bordereau_type.bordereau_type_name IS 'Наименование типа бордеро';
COMMENT ON COLUMN core.ref_bordereau_type.bordereau_type_code IS 'Код типа бордеро';
COMMENT ON COLUMN core.ref_bordereau_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_build_part (build_part_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_build_part IS 'Справочник Частей строения (СКК 7.13.39)';
COMMENT ON COLUMN core.ref_build_part.build_part_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_build_part.name IS 'Наименование части строения';
COMMENT ON COLUMN core.ref_build_part.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_build_part.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_build_part.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_business_line (business_line_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(50), name CHARACTER VARYING(256), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_business_line IS 'Справочник линий бизнеса';
COMMENT ON COLUMN core.ref_business_line.business_line_id IS 'Идентификатор линии бизнеса';
COMMENT ON COLUMN core.ref_business_line.code IS 'Код линии бизнеса';
COMMENT ON COLUMN core.ref_business_line.name IS 'Наименование линии бизнеса';
COMMENT ON COLUMN core.ref_business_line.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_business_line.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_business_line.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_carrier_type (scc_id NUMERIC NOT NULL, code CHARACTER VARYING(3), short_name CHARACTER VARYING(234), full_name CHARACTER VARYING(234), vehicle_or_tractor CHARACTER VARYING(1), vehicle_short_category CHARACTER VARYING(20), period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_carrier_type IS 'Типы ТС';
COMMENT ON COLUMN core.ref_carrier_type.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_carrier_type.code IS 'Код';
COMMENT ON COLUMN core.ref_carrier_type.short_name IS 'Краткое наименование';
COMMENT ON COLUMN core.ref_carrier_type.full_name IS 'Полное наименование';
COMMENT ON COLUMN core.ref_carrier_type.vehicle_or_tractor IS 'Обычное ТС или трактор (0 - обычное, 1 - трактор)';
COMMENT ON COLUMN core.ref_carrier_type.vehicle_short_category IS 'Категория ТС';
COMMENT ON COLUMN core.ref_carrier_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_carrier_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_carrier_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_cash_flow_item (cash_flow_item_id CHARACTER VARYING(50) NOT NULL, parent_id CHARACTER VARYING(50), name CHARACTER VARYING(4000), code CHARACTER VARYING(40), period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_cash_flow_item IS 'Справочник статьей движения денежных средств';
COMMENT ON COLUMN core.ref_cash_flow_item.cash_flow_item_id IS 'Идентификатор статьи ДДС';
COMMENT ON COLUMN core.ref_cash_flow_item.parent_id IS 'Идентификатор родительской статьи ДДС';
COMMENT ON COLUMN core.ref_cash_flow_item.name IS 'Наименование статьи ДДС';
COMMENT ON COLUMN core.ref_cash_flow_item.code IS 'Код статьи ДДС';
COMMENT ON COLUMN core.ref_cash_flow_item.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_cash_flow_item.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_cash_flow_item.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_claim_appeal_status (claim_appeal_status_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(4000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_claim_appeal_status IS 'Справочник статуса обращения по урегулированному убытку';
COMMENT ON COLUMN core.ref_claim_appeal_status.claim_appeal_status_id IS 'Идентификатор статуса обращения';
COMMENT ON COLUMN core.ref_claim_appeal_status.name IS 'Наименование статуса обращения';
COMMENT ON COLUMN core.ref_claim_appeal_status.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_claim_appeal_status.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_claim_appeal_status.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_claim_appeal_type (claim_appeal_type_id INTEGER NOT NULL, claim_appeal_type_name CHARACTER VARYING(4000));
COMMENT ON TABLE core.ref_claim_appeal_type IS 'Справочник типа обращения по убытку';
COMMENT ON COLUMN core.ref_claim_appeal_type.claim_appeal_type_id IS 'Уникальный идентификатор записи';
COMMENT ON COLUMN core.ref_claim_appeal_type.claim_appeal_type_name IS 'Наименование типа обращения';
CREATE TABLE core.ref_claim_payment_type (claim_payment_type_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(50), name CHARACTER VARYING(256), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_claim_payment_type IS 'Справочник типа оплаты судебного требования';
COMMENT ON COLUMN core.ref_claim_payment_type.claim_payment_type_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_claim_payment_type.code IS 'Код типа оплаты';
COMMENT ON COLUMN core.ref_claim_payment_type.name IS 'Наименование типа оплаты';
COMMENT ON COLUMN core.ref_claim_payment_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_claim_payment_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_claim_payment_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_claim_requirement_type (claim_requirement_type_id CHARACTER VARYING(50) NOT NULL, type_name CHARACTER VARYING(4000), subtype_name CHARACTER VARYING(4000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_claim_requirement_type IS 'Справочник тип требования обращения по урегулированному убытку';
COMMENT ON COLUMN core.ref_claim_requirement_type.claim_requirement_type_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_claim_requirement_type.type_name IS 'Наименование типа требования';
COMMENT ON COLUMN core.ref_claim_requirement_type.subtype_name IS 'Наименование подтипа требования';
COMMENT ON COLUMN core.ref_claim_requirement_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_claim_requirement_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_claim_requirement_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_communication_status (communication_status_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(256), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_communication_status IS 'Справочник Статусов отправки уведомлений';
COMMENT ON COLUMN core.ref_communication_status.communication_status_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_communication_status.name IS 'Наименование статуса отправки';
COMMENT ON COLUMN core.ref_communication_status.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_communication_status.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_communication_status.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_communication_type (communication_type_id CHARACTER VARYING(254) NOT NULL, name CHARACTER VARYING(254), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_communication_type IS 'Справочник Статусов отправки уведомлений';
COMMENT ON COLUMN core.ref_communication_type.communication_type_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_communication_type.name IS 'Наименование статуса отправки уведомления';
COMMENT ON COLUMN core.ref_communication_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_communication_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_communication_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_construction_condition (construction_condition_id NUMERIC NOT NULL, name CHARACTER VARYING(254), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_construction_condition IS 'Справочник Состояния завершенности элементов Объекта незавершенного строительства';
COMMENT ON COLUMN core.ref_construction_condition.construction_condition_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_construction_condition.name IS 'Наименование состояния завершенности';
COMMENT ON COLUMN core.ref_construction_condition.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_construction_condition.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_construction_condition.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_construction_condition_delta_old (construction_condition_id CHARACTER VARYING(50) NOT NULL, ncode NUMERIC, code CHARACTER VARYING(50), name CHARACTER VARYING(256), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
CREATE TABLE core.ref_contract_expense_type (contract_expense_type_id INTEGER NOT NULL, contract_expense_type_name CHARACTER VARYING(255), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_contract_expense_type IS 'Справочник тип расходов по договору страхования';
COMMENT ON COLUMN core.ref_contract_expense_type.contract_expense_type_id IS 'Уникальный идентификатор записи';
COMMENT ON COLUMN core.ref_contract_expense_type.contract_expense_type_name IS 'Наименование типа расхода';
COMMENT ON COLUMN core.ref_contract_expense_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_contract_link_type (contract_link_type_id NUMERIC, name CHARACTER VARYING(500));
COMMENT ON TABLE core.ref_contract_link_type IS 'Справочник типов связи договоров';
COMMENT ON COLUMN core.ref_contract_link_type.contract_link_type_id IS 'Идентификатор связи договоров';
COMMENT ON COLUMN core.ref_contract_link_type.name IS 'Название связи договоров';
CREATE TABLE core.ref_contract_source_user_type (source_user_type_id CHARACTER VARYING(50), code CHARACTER VARYING(50), name CHARACTER VARYING(500));
COMMENT ON COLUMN core.ref_contract_source_user_type.source_user_type_id IS 'Идентификатор типа связи';
COMMENT ON COLUMN core.ref_contract_source_user_type.code IS 'Код типа связи';
COMMENT ON COLUMN core.ref_contract_source_user_type.name IS 'Наименование типа связи';
CREATE TABLE core.ref_contract_type (contract_type_id INTEGER NOT NULL, contract_type_name CHARACTER VARYING(255), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_contract_type IS 'Справочник Типов договоров';
COMMENT ON COLUMN core.ref_contract_type.contract_type_id IS 'Уникальный идентификатор записи';
COMMENT ON COLUMN core.ref_contract_type.contract_type_name IS 'Наименование типа договора';
COMMENT ON COLUMN core.ref_contract_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_counterparty_link_type (counterparty_link_type_id CHARACTER VARYING(50) NOT NULL, counterparty_link_type_code CHARACTER VARYING(50), counterparty_link_type_name CHARACTER VARYING(512), counterparty_link_type_desr CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_counterparty_link_type IS 'Справочник типов связей контрагентов';
COMMENT ON COLUMN core.ref_counterparty_link_type.counterparty_link_type_id IS 'Id типа';
COMMENT ON COLUMN core.ref_counterparty_link_type.counterparty_link_type_code IS 'Код типа';
COMMENT ON COLUMN core.ref_counterparty_link_type.counterparty_link_type_name IS 'Название типа';
COMMENT ON COLUMN core.ref_counterparty_link_type.counterparty_link_type_desr IS 'Описание типа связи';
COMMENT ON COLUMN core.ref_counterparty_link_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_counterparty_link_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_counterparty_link_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_counterparty_role (counterparty_role_id BIGSERIAL NOT NULL, counterparty_role_ncode BIGINT, counterparty_role_name CHARACTER VARYING(500), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_counterparty_role IS 'Справочник ролей контрагента';
COMMENT ON COLUMN core.ref_counterparty_role.counterparty_role_id IS 'Уникальный идентификатор записи (первичный ключ)';
COMMENT ON COLUMN core.ref_counterparty_role.counterparty_role_ncode IS 'Код роли контрагента (числовой)';
COMMENT ON COLUMN core.ref_counterparty_role.counterparty_role_name IS 'Наименование роли контрагента';
COMMENT ON COLUMN core.ref_counterparty_role.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_countries (scc_id NUMERIC(38,0), short_name CHARACTER VARYING(70), iso_country_code CHARACTER VARYING(3), full_name CHARACTER VARYING(70), dns_country_code CHARACTER VARYING(2), digit_country_code CHARACTER VARYING(3), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.ref_countries.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_coverage_area (coverage_area_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_coverage_area IS 'Справочник Площади покрытия внешней отделки (СКК 7.13.33)';
COMMENT ON COLUMN core.ref_coverage_area.coverage_area_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_coverage_area.name IS 'Наименование площади покрытия';
COMMENT ON COLUMN core.ref_coverage_area.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_coverage_area.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_coverage_area.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_creation_type (creation_type_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(100), name CHARACTER VARYING(512), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_creation_type IS 'Справочник типов создания Актов выполненных работ (АВР)';
COMMENT ON COLUMN core.ref_creation_type.creation_type_id IS 'Идентификатор типа создания АВР';
COMMENT ON COLUMN core.ref_creation_type.code IS 'Код типа';
COMMENT ON COLUMN core.ref_creation_type.name IS 'Наименование типа создания АВР';
COMMENT ON COLUMN core.ref_creation_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_creation_type.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_currencies (scc_id NUMERIC NOT NULL, scc_status NUMERIC, base_id NUMERIC, erkc_convert NUMERIC(1,0), countries_fk$ NUMERIC(10,0), country_list CHARACTER VARYING(400) COLLATE "C", letter_currency_code CHARACTER VARYING(3) COLLATE "C", digit_currency_code CHARACTER VARYING(3) COLLATE "C", currency_name CHARACTER VARYING(200) COLLATE "C", is_node NUMERIC(1,0), tick NUMERIC(22,0), date_to TIMESTAMP(6) WITHOUT TIME ZONE, date_from TIMESTAMP(6) WITHOUT TIME ZONE, id NUMERIC(10,0), creation_time CHARACTER VARYING(32) COLLATE "C", user_id CHARACTER VARYING(30) COLLATE "C", countries_fk_ NUMERIC, countries_fk NUMERIC, period_start DATE DEFAULT '2023-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_currencies IS 'Справочник Классификаторов валют';
COMMENT ON COLUMN core.ref_currencies.scc_id IS 'Идентификатор СКК';
COMMENT ON COLUMN core.ref_currencies.scc_status IS 'Статус актуальности записи в СКК: 0 - запись актуальна, 1 - запись не актуальна.';
COMMENT ON COLUMN core.ref_currencies.erkc_convert IS 'Конвертируется ЕРКЦ';
COMMENT ON COLUMN core.ref_currencies.countries_fk$ IS 'Краткое наименование страны';
COMMENT ON COLUMN core.ref_currencies.country_list IS 'Список стран';
COMMENT ON COLUMN core.ref_currencies.letter_currency_code IS 'Буквенный код валюты';
COMMENT ON COLUMN core.ref_currencies.digit_currency_code IS 'Цифровой код валюты';
COMMENT ON COLUMN core.ref_currencies.currency_name IS 'Наименование валюты';
COMMENT ON COLUMN core.ref_currencies.is_node IS 'Флаг, показывающий, является ли данная запись узлом дерева (не листом). Используется только для иерархических справочников';
COMMENT ON COLUMN core.ref_currencies.tick IS 'Ссылка на основание';
COMMENT ON COLUMN core.ref_currencies.date_to IS 'Дата и время, по которое действует данная запись';
COMMENT ON COLUMN core.ref_currencies.date_from IS 'Дата и время, начиная с которого действует данная запись';
COMMENT ON COLUMN core.ref_currencies.id IS 'Числовой идентификатор записи';
COMMENT ON COLUMN core.ref_currencies.creation_time IS 'Время создания записи';
COMMENT ON COLUMN core.ref_currencies.user_id IS 'Имя пользователя, создавшего запись';
COMMENT ON COLUMN core.ref_currencies.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_currencies.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_currencies.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_d_transport_type (scc_id NUMERIC NOT NULL, code BIGINT, name CHARACTER VARYING(1024), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_d_transport_type IS 'Справочник: Вид транспорта и вид перевозок';
COMMENT ON COLUMN core.ref_d_transport_type.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_d_transport_type.code IS 'Код';
COMMENT ON COLUMN core.ref_d_transport_type.name IS 'Наименование';
COMMENT ON COLUMN core.ref_d_transport_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_d_transport_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_d_transport_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_dc_acc_group (scc_id BIGINT, central_accounting_group_id CHARACTER VARYING(25), group_id CHARACTER VARYING(50), group_name CHARACTER VARYING(256), reserve_calc_method_id CHARACTER VARYING(7), parent_accounting_group_id CHARACTER VARYING(25), max_rpnu_quarters_number NUMERIC(5,0), average_contract_time NUMERIC(5,0), loss_registration_start_date DATE, state1 NUMERIC(2,0), group_code NUMERIC(5,0), short_name CHARACTER VARYING(50), is_additional NUMERIC(1,0), reinsurance NUMERIC(5,0), stabilization_restriction NUMERIC(5,0), calc_osago_reserves NUMERIC(1,0), unprofitableness NUMERIC(5,0), profitability NUMERIC(5,0), start_date DATE, end_date DATE, referable NUMERIC(1,0), detailing NUMERIC(5,0), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.ref_dc_acc_group.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_dc_acc_group_22 (scc_id NUMERIC NOT NULL, scc_status NUMERIC, base_id NUMERIC, group_mf CHARACTER VARYING(10) COLLATE "C", end_date_11 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_11 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_10 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_10 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_09 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_09 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_08 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_08 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_07 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_07 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_06 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_06 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_05 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_05 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_04 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_04 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_03 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_03 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_02 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_02 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_01 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_01 TIMESTAMP(6) WITHOUT TIME ZONE, reservcalcmetfk_fk$ NUMERIC(10,0), parent_dcag_fk_fk$ NUMERIC(10,0), detailing NUMERIC(5,0), referable NUMERIC(1,0), end_date TIMESTAMP(6) WITHOUT TIME ZONE, start_date TIMESTAMP(6) WITHOUT TIME ZONE, profitability NUMERIC(5,0), unprofitableness NUMERIC(5,0), calc_osago_reserves NUMERIC(1,0), stabilization_restriction NUMERIC(5,0), reinsurance NUMERIC(5,0), is_additional NUMERIC(1,0), short_name CHARACTER VARYING(50) COLLATE "C", group_code NUMERIC(5,0), state NUMERIC(2,0), loss_registr_start_date TIMESTAMP(6) WITHOUT TIME ZONE, average_contract_time NUMERIC(5,0), max_rpnu_quarters_number NUMERIC(5,0), group_name CHARACTER VARYING(256) COLLATE "C", group_id CHARACTER VARYING(50) COLLATE "C", c_accounting_group_id CHARACTER VARYING(25) COLLATE "C", creation_time CHARACTER VARYING(32) COLLATE "C", is_node NUMERIC(1,0), user_id CHARACTER VARYING(30) COLLATE "C", tick NUMERIC(22,0), date_to TIMESTAMP(6) WITHOUT TIME ZONE, date_from TIMESTAMP(6) WITHOUT TIME ZONE, id NUMERIC(10,0), end_date_12 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_12 TIMESTAMP(6) WITHOUT TIME ZONE, reservcalcmetfk_fk_ NUMERIC, parent_dcag_fk_fk_ NUMERIC, reservcalcmetfk_fk NUMERIC, parent_dcag_fk_fk NUMERIC, start_date_13 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_13 TIMESTAMP(6) WITHOUT TIME ZONE, start_date_14 TIMESTAMP(6) WITHOUT TIME ZONE, end_date_14 TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE DEFAULT '2023-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, is_m_risk CHARACTER VARYING(256), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_dc_acc_group_22 IS 'Централизованный справочник учетных групп (СКК "7.2.1")';
COMMENT ON COLUMN core.ref_dc_acc_group_22.scc_id IS 'Идентификатор СКК';
COMMENT ON COLUMN core.ref_dc_acc_group_22.scc_status IS 'Статус актуальности записи в СКК: 0 - запись актуальна, 1 - запись не актуальна.';
COMMENT ON COLUMN core.ref_dc_acc_group_22.group_mf IS 'УГ МФ';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_11 IS 'ООО РГС-Юг - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_11 IS 'ООО РГС-Юг - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_10 IS 'ООО РГС-Центр - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_10 IS 'ООО РГС-Центр - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_09 IS 'ООО РГС-Урал - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_09 IS 'ООО РГС-Урал - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_08 IS 'ООО РГС-Сибирь - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_08 IS 'ООО РГС-Сибирь - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_07 IS 'ООО РГС-Северо-Запад - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_07 IS 'ООО РГС-Северо-Запад - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_06 IS 'ООО РГС-Поволжье - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_06 IS 'ООО РГС-Поволжье - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_05 IS 'ООО РГС-Дальний Восток - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_05 IS 'ООО РГС-Дальний Восток - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_04 IS 'ООО РГС-Татарстан - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_04 IS 'ООО РГС-Татарстан - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_03 IS 'ООО Росгосстрах - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_03 IS 'ООО Росгосстрах - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_02 IS 'ООО РГС-Аккорд - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_02 IS 'ООО РГС-Аккорд - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_01 IS 'ОАО РГС - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_01 IS 'ОАО РГС - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.reservcalcmetfk_fk$ IS 'Алгоритм расчета РНП';
COMMENT ON COLUMN core.ref_dc_acc_group_22.parent_dcag_fk_fk$ IS 'Родительский номер учетной группы';
COMMENT ON COLUMN core.ref_dc_acc_group_22.detailing IS 'Уровень детализации';
COMMENT ON COLUMN core.ref_dc_acc_group_22.referable IS 'Используется для ввода';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date IS 'Дата, начиная с которой перестает действовать данная версия записи. Если пусто - то нет ограничений по сроку конца действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date IS 'Дата, начиная с которой начинает действовать данная версия записи. Если пусто - то нет ограничений по сроку начала действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.profitability IS 'Нормативная рентабельность, используемая для расчета СР по ОСАГО.';
COMMENT ON COLUMN core.ref_dc_acc_group_22.unprofitableness IS 'Нормативная убыточность, используемая для расчета РВУ (по ОСАГО)';
COMMENT ON COLUMN core.ref_dc_acc_group_22.calc_osago_reserves IS '0 - Резервы по ОСАГО (Резерв выравнивания убыточности и Стаб. резерв по ОСАГО) не создаются, 1 - создаются';
COMMENT ON COLUMN core.ref_dc_acc_group_22.stabilization_restriction IS 'Ограничение на стаб.резерв';
COMMENT ON COLUMN core.ref_dc_acc_group_22.reinsurance IS '0 - Страхование (включая сострахование) и перестрахование, 1 - Страхование (включая сострахование), 2 - Перестрахование';
COMMENT ON COLUMN core.ref_dc_acc_group_22.is_additional IS '0 - основная У.Г. 1 - дополнительная';
COMMENT ON COLUMN core.ref_dc_acc_group_22.short_name IS 'Краткое наименование';
COMMENT ON COLUMN core.ref_dc_acc_group_22.group_code IS 'Целочисленный код У.Г.';
COMMENT ON COLUMN core.ref_dc_acc_group_22.state IS 'Статус записи';
COMMENT ON COLUMN core.ref_dc_acc_group_22.loss_registr_start_date IS 'Дата начала регистрации убытков для расчета РПНУ';
COMMENT ON COLUMN core.ref_dc_acc_group_22.average_contract_time IS 'Средний срок действия договора';
COMMENT ON COLUMN core.ref_dc_acc_group_22.max_rpnu_quarters_number IS 'Максимальное количество кварталов для расчета РПНУ';
COMMENT ON COLUMN core.ref_dc_acc_group_22.group_name IS 'Наименование учетной группы';
COMMENT ON COLUMN core.ref_dc_acc_group_22.group_id IS 'Код учетной группы';
COMMENT ON COLUMN core.ref_dc_acc_group_22.c_accounting_group_id IS 'Внутренний номер учетной группы';
COMMENT ON COLUMN core.ref_dc_acc_group_22.creation_time IS 'Время создания записи';
COMMENT ON COLUMN core.ref_dc_acc_group_22.is_node IS 'Флаг, показывающий, является ли данная запись узлом дерева (не листом). Используется только для иерархических справочников';
COMMENT ON COLUMN core.ref_dc_acc_group_22.user_id IS 'Имя пользователя, создавшего запись';
COMMENT ON COLUMN core.ref_dc_acc_group_22.tick IS 'Ссылка на основание';
COMMENT ON COLUMN core.ref_dc_acc_group_22.date_to IS 'Дата и время, по которое действует данная запись';
COMMENT ON COLUMN core.ref_dc_acc_group_22.date_from IS 'Дата и время, начиная с которого действует данная запись';
COMMENT ON COLUMN core.ref_dc_acc_group_22.id IS 'Числовой идентификатор записи';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_12 IS 'ООО Росгосстрах - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_12 IS 'ООО Росгосстрах - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.reservcalcmetfk_fk_ IS 'Алгоритм расчета РНП';
COMMENT ON COLUMN core.ref_dc_acc_group_22.parent_dcag_fk_fk_ IS 'Родительский номер учетной группы';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_13 IS 'ОАО КС - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_13 IS 'ОАО КС - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.start_date_14 IS 'ЗАО КПС - Начало действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.end_date_14 IS 'ЗАО КПС - Конец действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_dc_acc_group_22.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_dcaccountingrisk (scc_id NUMERIC(38,0), end_date DATE, start_date DATE, detailing CHARACTER VARYING(5), number_1_gs CHARACTER VARYING(50), referable CHARACTER VARYING(1), person_type CHARACTER VARYING(1), sphere_of_ins CHARACTER VARYING(1), is_m_risk CHARACTER VARYING(1), is_life_risk CHARACTER VARYING(1), reinsurance CHARACTER VARYING(1), acc_risk_name CHARACTER VARYING(250), short_name CHARACTER VARYING(50), acc_risk_code CHARACTER VARYING(8), creation_time CHARACTER VARYING(32), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.ref_dcaccountingrisk.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_debit_writeoff_reason (debit_writeoff_reason_id CHARACTER VARYING(7), name CHARACTER VARYING(100), period_start DATE, period_end DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_debit_writeoff_reason IS 'Справочник причин списания дебиторской задолженности (СКК 4.2.38)';
COMMENT ON COLUMN core.ref_debit_writeoff_reason.debit_writeoff_reason_id IS 'Идентификатор причины списания дебиторской задолженности';
COMMENT ON COLUMN core.ref_debit_writeoff_reason.name IS 'Наименование причины списания дебиторской задолженности';
COMMENT ON COLUMN core.ref_debit_writeoff_reason.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_debit_writeoff_reason.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_debit_writeoff_reason.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_deferred_payment_type (deferred_payment_type_id CHARACTER VARYING(50) NOT NULL, functional_area_name CHARACTER VARYING(100), payment_type CHARACTER VARYING(100), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_deferred_payment_type IS 'Справочник Типы будущих оплат';
COMMENT ON COLUMN core.ref_deferred_payment_type.deferred_payment_type_id IS 'Идентификатор типов будущaих оплат (первичный ключ)';
COMMENT ON COLUMN core.ref_deferred_payment_type.functional_area_name IS 'Функциональная область';
COMMENT ON COLUMN core.ref_deferred_payment_type.payment_type IS 'Тип оплаты';
COMMENT ON COLUMN core.ref_deferred_payment_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_department (department_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(2000), branch_code CHARACTER VARYING(20), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_department IS 'Справочник подразделений';
COMMENT ON COLUMN core.ref_department.department_id IS 'Идентификатор подразделения	';
COMMENT ON COLUMN core.ref_department.name IS 'Наименование подразделения';
COMMENT ON COLUMN core.ref_department.branch_code IS 'Код подразделения (Ссылка на core.branches.branch_code)';
COMMENT ON COLUMN core.ref_department.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_department.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_detail_location (detail_location_id NUMERIC NOT NULL, fias_city_code CHARACTER VARYING(2000), fias_district_code CHARACTER VARYING(2000), fias_region_code CHARACTER VARYING(2000), city_name CHARACTER VARYING(2000), district_name CHARACTER VARYING(2000), region_name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_detail_location IS 'Справочник Районов, городов для КЭ квартир (уточненное местоположение) (СКК 7.13.70)';
COMMENT ON COLUMN core.ref_detail_location.detail_location_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_detail_location.fias_city_code IS 'Код города ФИАС';
COMMENT ON COLUMN core.ref_detail_location.fias_district_code IS 'Код района ФИАС';
COMMENT ON COLUMN core.ref_detail_location.fias_region_code IS 'Код региона ФИАС';
COMMENT ON COLUMN core.ref_detail_location.city_name IS 'Наименование района/города';
COMMENT ON COLUMN core.ref_detail_location.district_name IS 'Наименование поселка/района города/округа/улицы';
COMMENT ON COLUMN core.ref_detail_location.region_name IS 'Наименование региона';
COMMENT ON COLUMN core.ref_detail_location.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_detail_location.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_detail_location.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_dict7gs (scc_id NUMERIC(38,0) NOT NULL, parent_scc_id NUMERIC(38,0), dict7gs_number CHARACTER VARYING(256), dict7gs_id CHARACTER VARYING(7), dict7gs_name CHARACTER VARYING(256), referable NUMERIC(1,0), msfo_type_name CHARACTER VARYING(32), gvs_scc_id NUMERIC(38,0), gvs_2020_scc_id NUMERIC(38,0), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, gvs_uo_scc_id NUMERIC, ins_type_code NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_dict7gs IS 'Справочник Кодов 7ГС (СКК 7.3.39)';
COMMENT ON COLUMN core.ref_dict7gs.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_dict7gs.parent_scc_id IS 'Идентификатор родителя';
COMMENT ON COLUMN core.ref_dict7gs.dict7gs_number IS 'Номер строки 7ГС';
COMMENT ON COLUMN core.ref_dict7gs.dict7gs_id IS 'ID строки 7ГС';
COMMENT ON COLUMN core.ref_dict7gs.dict7gs_name IS 'Наименование строки 7ГС';
COMMENT ON COLUMN core.ref_dict7gs.referable IS 'Ссылочность';
COMMENT ON COLUMN core.ref_dict7gs.msfo_type_name IS 'Вид МСФО';
COMMENT ON COLUMN core.ref_dict7gs.gvs_scc_id IS 'ГВС в УО 2013';
COMMENT ON COLUMN core.ref_dict7gs.gvs_2020_scc_id IS 'ГВС в УО 2020';
COMMENT ON COLUMN core.ref_dict7gs.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_dict7gs.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_dict7gs.gvs_uo_scc_id IS 'ГВС продукт';
COMMENT ON COLUMN core.ref_dict7gs.ins_type_code IS 'ГВС риск';
COMMENT ON COLUMN core.ref_dict7gs.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_dict7gs_22 (scc_id NUMERIC NOT NULL, scc_status NUMERIC, base_id NUMERIC, msfo_type_name CHARACTER VARYING(32) COLLATE "C", maximum_commission_rate NUMERIC(12,2), insuarance_type_code_fk$ NUMERIC(10,0), link_to_7527_2013_fk$ NUMERIC(10,0), insurance_type CHARACTER VARYING(256) COLLATE "C", dict7gs_22_fk$ NUMERIC(10,0), shift_physical NUMERIC(5,0), additional NUMERIC(1,0), referable NUMERIC(1,0), dict7gs_name CHARACTER VARYING(256) COLLATE "C", dict7gs_number CHARACTER VARYING(256) COLLATE "C", dict7gs_id CHARACTER VARYING(7) COLLATE "C", is_node NUMERIC(1,0), creation_time CHARACTER VARYING(96) COLLATE "C", user_id CHARACTER VARYING(90) COLLATE "C", tick NUMERIC(22,0), date_to TIMESTAMP(6) WITHOUT TIME ZONE, date_from TIMESTAMP(6) WITHOUT TIME ZONE, id NUMERIC(10,0), dict7gs_22_fk_ NUMERIC, insuarance_type_code_fk_ NUMERIC, link_to_7527_2013_fk_ NUMERIC, dict7gs_22_fk NUMERIC, insuarance_type_code_fk NUMERIC, link_to_7527_2013_fk NUMERIC, ins_type_code_2020_fk NUMERIC, ins_type_code_uo NUMERIC, ins_type_code NUMERIC, period_start DATE DEFAULT '2023-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_dict7gs_22 IS 'Справочник Кодов 7ГС (СКК 7.3.39)';
COMMENT ON COLUMN core.ref_dict7gs_22.scc_id IS 'Идентификатор СКК';
COMMENT ON COLUMN core.ref_dict7gs_22.scc_status IS 'Статус актуальности записи в СКК: 0 - запись актуальна, 1 - запись не актуальна.';
COMMENT ON COLUMN core.ref_dict7gs_22.msfo_type_name IS 'Вид МСФО';
COMMENT ON COLUMN core.ref_dict7gs_22.maximum_commission_rate IS 'Максимальная ставка КВ';
COMMENT ON COLUMN core.ref_dict7gs_22.insuarance_type_code_fk$ IS 'ГВС в УО';
COMMENT ON COLUMN core.ref_dict7gs_22.link_to_7527_2013_fk$ IS 'ГВС в УО_2013';
COMMENT ON COLUMN core.ref_dict7gs_22.insurance_type IS 'ГВС в УО';
COMMENT ON COLUMN core.ref_dict7gs_22.dict7gs_22_fk$ IS 'Родительская строка 7ГС';
COMMENT ON COLUMN core.ref_dict7gs_22.shift_physical IS 'Сдвиг физ. лиц';
COMMENT ON COLUMN core.ref_dict7gs_22.additional IS 'Признак дополнительной строки';
COMMENT ON COLUMN core.ref_dict7gs_22.referable IS 'Ссылочность';
COMMENT ON COLUMN core.ref_dict7gs_22.dict7gs_name IS 'Наименование строки 7ГС';
COMMENT ON COLUMN core.ref_dict7gs_22.dict7gs_number IS 'Номер строки 7ГС';
COMMENT ON COLUMN core.ref_dict7gs_22.dict7gs_id IS 'ID строки 7ГС';
COMMENT ON COLUMN core.ref_dict7gs_22.is_node IS 'Флаг, показывающий, является ли данная запись узлом дерева (не листом). Используется только для иерархических справочников';
COMMENT ON COLUMN core.ref_dict7gs_22.creation_time IS 'Время создания записи';
COMMENT ON COLUMN core.ref_dict7gs_22.user_id IS 'Имя пользователя, создавшего запись';
COMMENT ON COLUMN core.ref_dict7gs_22.tick IS 'Ссылка на основание';
COMMENT ON COLUMN core.ref_dict7gs_22.date_to IS 'Дата и время, по которое действует данная запись';
COMMENT ON COLUMN core.ref_dict7gs_22.date_from IS 'Дата и время, начиная с которого действует данная запись';
COMMENT ON COLUMN core.ref_dict7gs_22.id IS 'Числовой идентификатор записи';
COMMENT ON COLUMN core.ref_dict7gs_22.dict7gs_22_fk_ IS 'Родительская строка 7ГС';
COMMENT ON COLUMN core.ref_dict7gs_22.insuarance_type_code_fk_ IS 'ГВС в УО';
COMMENT ON COLUMN core.ref_dict7gs_22.link_to_7527_2013_fk_ IS 'ГВС в УО_2013';
COMMENT ON COLUMN core.ref_dict7gs_22.ins_type_code_2020_fk IS 'ГВС в УО_2020';
COMMENT ON COLUMN core.ref_dict7gs_22.ins_type_code_uo IS 'ГВС_продукт';
COMMENT ON COLUMN core.ref_dict7gs_22.ins_type_code IS 'ГВС_риск';
COMMENT ON COLUMN core.ref_dict7gs_22.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_dict7gs_22.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_dict7gs_22.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_dictinsurer (scc_id NUMERIC NOT NULL, insurer_id CHARACTER VARYING(10), insurer_name CHARACTER VARYING(255), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_dictinsurer IS 'Страховые компании (СКК 7.5.2)';
COMMENT ON COLUMN core.ref_dictinsurer.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_dictinsurer.insurer_id IS 'Код';
COMMENT ON COLUMN core.ref_dictinsurer.insurer_name IS 'Наименование';
COMMENT ON COLUMN core.ref_dictinsurer.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_dictinsurer.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_dictinsurer.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_dictproject (scc_id NUMERIC(38,0) NOT NULL, project_type_id INTEGER, project_id CHARACTER VARYING(7), project_name CHARACTER VARYING(100), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_dictproject IS 'Справочник проектов (СКК 7.4.8)';
COMMENT ON COLUMN core.ref_dictproject.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_dictproject.project_type_id IS 'Идентификатор типа проекта';
COMMENT ON COLUMN core.ref_dictproject.project_id IS 'Идентификатор проекта';
COMMENT ON COLUMN core.ref_dictproject.project_name IS 'Наименование проекта';
COMMENT ON COLUMN core.ref_dictproject.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_dominant_currency (scc_id NUMERIC(38,0) NOT NULL, id_currency CHARACTER VARYING(50), do_account_group_781p CHARACTER VARYING(25), do_letter_currency_code CHARACTER VARYING(5), do_digit_currency_code CHARACTER VARYING(5), period_start DATE DEFAULT '2023-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_dominant_currency IS 'Справочник доминирующей валюты учетной группы по 781П(СКК -7.3.96)';
COMMENT ON COLUMN core.ref_dominant_currency.scc_id IS 'Идентификатор СКК';
COMMENT ON COLUMN core.ref_dominant_currency.id_currency IS 'Идентификатор доминирующей валюты';
COMMENT ON COLUMN core.ref_dominant_currency.do_account_group_781p IS 'Код учетной группы по 781П (Первичный ключ)';
COMMENT ON COLUMN core.ref_dominant_currency.do_letter_currency_code IS 'Валюта (аббревиатура)';
COMMENT ON COLUMN core.ref_dominant_currency.do_digit_currency_code IS 'Код валюты';
COMMENT ON COLUMN core.ref_dominant_currency.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_dominant_currency.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_dominant_currency.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_elementary_risk (elementary_risk_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_elementary_risk IS 'Справочник Элементарных рисков';
COMMENT ON COLUMN core.ref_elementary_risk.elementary_risk_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_elementary_risk.name IS 'Наименование элементарного риска';
COMMENT ON COLUMN core.ref_elementary_risk.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_elementary_risk.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_elementary_risk.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_employee_department_type (employee_department_type_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(512), description CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_employee_department_type IS 'Справочник типов привязки сотрудника к подразделению';
COMMENT ON COLUMN core.ref_employee_department_type.employee_department_type_id IS 'Уникальный идентификатор записи';
COMMENT ON COLUMN core.ref_employee_department_type.name IS 'Наименование типа привязки сотрудника к подразделению';
COMMENT ON COLUMN core.ref_employee_department_type.description IS 'Описание типа привязки сотрудника к подразделению';
COMMENT ON COLUMN core.ref_employee_department_type.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_employee_department_type.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_employee_department_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_employee_link_type (employee_link_type_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(50), name CHARACTER VARYING(512), description CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_employee_link_type IS 'Справочник типов связей сотрудников';
COMMENT ON COLUMN core.ref_employee_link_type.employee_link_type_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_employee_link_type.code IS 'Код';
COMMENT ON COLUMN core.ref_employee_link_type.name IS 'Наименование';
COMMENT ON COLUMN core.ref_employee_link_type.description IS 'Описание';
COMMENT ON COLUMN core.ref_employee_link_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_employee_link_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_employee_link_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_equipment_condition (equipment_condition_id CHARACTER VARYING(50) NOT NULL, ncode NUMERIC, code CHARACTER VARYING(50), name CHARACTER VARYING(256), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_equipment_condition IS 'Справочник Состояния подключения инженерного оборудования';
COMMENT ON COLUMN core.ref_equipment_condition.equipment_condition_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_equipment_condition.ncode IS 'Числовой код состояния подключения оборудования';
COMMENT ON COLUMN core.ref_equipment_condition.code IS 'Код состояния подключения оборудования';
COMMENT ON COLUMN core.ref_equipment_condition.name IS 'Наименование состояния подключения оборудования';
COMMENT ON COLUMN core.ref_equipment_condition.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_equipment_condition.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_equipment_condition.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_event_type (event_type_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(4000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_event_type IS 'Справочник событий';
COMMENT ON COLUMN core.ref_event_type.event_type_id IS 'Идентификатор события';
COMMENT ON COLUMN core.ref_event_type.name IS 'Наименование события';
COMMENT ON COLUMN core.ref_event_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_event_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_event_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_external_equipment (external_equipment_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_external_equipment IS 'Справочник Внешнего оборудования';
COMMENT ON COLUMN core.ref_external_equipment.external_equipment_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_external_equipment.name IS 'Наименование оборудования';
COMMENT ON COLUMN core.ref_external_equipment.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_external_equipment.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_external_equipment.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_file_type (file_type_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(512), code CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_file_type IS 'Справочник типов прикрепленных документов к договору страхования';
COMMENT ON COLUMN core.ref_file_type.file_type_id IS 'Идентификатор типа документа';
COMMENT ON COLUMN core.ref_file_type.name IS 'Наименование типа документа';
COMMENT ON COLUMN core.ref_file_type.code IS 'Код типа документа';
COMMENT ON COLUMN core.ref_file_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_file_type.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_finishing_type (finishing_type_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_finishing_type IS 'Справочник Типов отделки';
COMMENT ON COLUMN core.ref_finishing_type.finishing_type_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_finishing_type.name IS 'Наименование типа отделки';
COMMENT ON COLUMN core.ref_finishing_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_finishing_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_finishing_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_guru_reserve_group (scc_id NUMERIC(38,0), code_t_lob CHARACTER VARYING(50), code_product CHARACTER VARYING(50), code_coverage_type CHARACTER VARYING(50), subject_type_id CHARACTER VARYING(7), reserve_group_id CHARACTER VARYING(254), c_accounting_group_id CHARACTER VARYING(25), reserve_group_id_2020 CHARACTER VARYING(254), form162 CHARACTER VARYING(254), start_date TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, end_date TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_guru_reserve_group IS 'Соответствие покрытий ГУРУ резервным и учетным группам';
COMMENT ON COLUMN core.ref_guru_reserve_group.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_guru_reserve_group.code_t_lob IS 'Код линии бизнеса ГУРУ';
COMMENT ON COLUMN core.ref_guru_reserve_group.code_product IS 'Код продукта ГУРУ';
COMMENT ON COLUMN core.ref_guru_reserve_group.code_coverage_type IS 'Код покрытия ГУРУ';
COMMENT ON COLUMN core.ref_guru_reserve_group.subject_type_id IS 'Тип субъекта';
COMMENT ON COLUMN core.ref_guru_reserve_group.reserve_group_id IS 'Код резервной группы';
COMMENT ON COLUMN core.ref_guru_reserve_group.c_accounting_group_id IS 'Код учетной группы';
COMMENT ON COLUMN core.ref_guru_reserve_group.reserve_group_id_2020 IS 'Код резервной группы 2020';
COMMENT ON COLUMN core.ref_guru_reserve_group.form162 IS 'Код вида формы 162';
COMMENT ON COLUMN core.ref_guru_reserve_group.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_guru_reserve_group.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_guru_reserve_group.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_gvs (scc_id NUMERIC(38,0) NOT NULL, insurance_type_code NUMERIC(10,0), insurance_type CHARACTER VARYING(254), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_gvs IS 'Справочник группы видов страхования (ГВС) (СКК 7.5.27)';
COMMENT ON COLUMN core.ref_gvs.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_gvs.insurance_type_code IS 'Код типа страхования';
COMMENT ON COLUMN core.ref_gvs.insurance_type IS 'Тип страхования';
COMMENT ON COLUMN core.ref_gvs.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_gvs_ifrs17 (scc_id NUMERIC NOT NULL, dict7gs_id CHARACTER VARYING(7) COLLATE "C", insuarance_type_code NUMERIC(10,0), id_scc CHARACTER VARYING(254), id_ifrs17_portfolio CHARACTER VARYING(254) COLLATE "C", sale_channel_type_id CHARACTER VARYING(7) COLLATE "C", start_date TIMESTAMP(6) WITHOUT TIME ZONE, end_date TIMESTAMP(6) WITHOUT TIME ZONE, created_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, modified_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_gvs_ifrs17 IS 'Справочник сегментации МСФО17 (СКК 2.2.28)';
COMMENT ON COLUMN core.ref_gvs_ifrs17.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_gvs_ifrs17.dict7gs_id IS 'Код 7ГС (ссылка на поле dict7gs_id в справочнике ref_dict7gs_22 Справочник Кодов 7ГС)';
COMMENT ON COLUMN core.ref_gvs_ifrs17.insuarance_type_code IS 'Код типа страхования (ссылка на поле в справочнике ref_gvs Справочник группы видов страхования)';
COMMENT ON COLUMN core.ref_gvs_ifrs17.id_scc IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_gvs_ifrs17.id_ifrs17_portfolio IS 'ID портфеля МСФО17 (ссылка на поле id_ifrs17_portfolio в справочнике ref_ifrs17_portfolio Справочник портфелей МСФО17)';
COMMENT ON COLUMN core.ref_gvs_ifrs17.sale_channel_type_id IS 'Код канала продаж (ссылка на поле sale_channel_type_id в справочнике ref_dictsalechanneltype200 Справочник Каналы продаж)';
COMMENT ON COLUMN core.ref_gvs_ifrs17.start_date IS 'Дата начала действия из СКК';
COMMENT ON COLUMN core.ref_gvs_ifrs17.end_date IS 'Дата окончания действия из СКК';
COMMENT ON COLUMN core.ref_gvs_ifrs17.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_gvs_ifrs17.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_gvs_ifrs17.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_gvs_ifrs17_old (scc_id NUMERIC NOT NULL, base_id NUMERIC, dict7gs_id NUMERIC, date_to TIMESTAMP(6) WITHOUT TIME ZONE, tick NUMERIC(22,0), is_node NUMERIC, insuarance_type_code NUMERIC, id_scc CHARACTER VARYING(254), scc_status SMALLINT, id_ifrs17_portfolio NUMERIC, sale_channel_type2008_id NUMERIC, id NUMERIC, date_from TIMESTAMP(6) WITHOUT TIME ZONE, start_date TIMESTAMP(6) WITHOUT TIME ZONE, end_date TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
CREATE TABLE core.ref_gvs_uo (scc_id NUMERIC NOT NULL, gvs_scc_id NUMERIC, insured_type_id CHARACTER VARYING(254), insured_type CHARACTER VARYING(2000), insuarance_type_fp_id CHARACTER VARYING(254), insuarance_type_fp CHARACTER VARYING(2000), insuarance_type_fp_group CHARACTER VARYING(2000), insuarance_type_fp_makro CHARACTER VARYING(2000), retail_lob1 CHARACTER VARYING(2000), retail_lob2 CHARACTER VARYING(2000), gvs_uo_id CHARACTER VARYING(254), ins_type_fp_makro2020 CHARACTER VARYING(2000), ins_type_group_id CHARACTER VARYING(254), retail_lob1_2020 CHARACTER VARYING(2000), retail_lob2_2020 CHARACTER VARYING(2000), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_gvs_uo IS 'Группы видов страхования УО';
COMMENT ON COLUMN core.ref_gvs_uo.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_gvs_uo.gvs_scc_id IS 'Идентификатор ГВС';
COMMENT ON COLUMN core.ref_gvs_uo.insured_type_id IS 'Код типа контрагента';
COMMENT ON COLUMN core.ref_gvs_uo.insured_type IS 'Наименование типа контрагента';
COMMENT ON COLUMN core.ref_gvs_uo.insuarance_type_fp_id IS 'Код группы видов страхования УО';
COMMENT ON COLUMN core.ref_gvs_uo.insuarance_type_fp IS 'Наименование группы видов страхования УО';
COMMENT ON COLUMN core.ref_gvs_uo.insuarance_type_fp_group IS 'ГЛБ';
COMMENT ON COLUMN core.ref_gvs_uo.insuarance_type_fp_makro IS 'Наименование группы видов страхования макро';
COMMENT ON COLUMN core.ref_gvs_uo.retail_lob1 IS 'ГЛБ1';
COMMENT ON COLUMN core.ref_gvs_uo.retail_lob2 IS 'ГЛБ2';
COMMENT ON COLUMN core.ref_gvs_uo.gvs_uo_id IS 'Идентификатор ГВС УО';
COMMENT ON COLUMN core.ref_gvs_uo.ins_type_fp_makro2020 IS 'Наименование группы видов страхования макро 2020';
COMMENT ON COLUMN core.ref_gvs_uo.ins_type_group_id IS 'Код группы видов страхования 2020';
COMMENT ON COLUMN core.ref_gvs_uo.retail_lob1_2020 IS 'ГЛБ1_2020';
COMMENT ON COLUMN core.ref_gvs_uo.retail_lob2_2020 IS 'ГЛБ2_2020';
COMMENT ON COLUMN core.ref_gvs_uo.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_gvs_uo.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_gvs_uo.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_ifrs17_portfolio (scc_id NUMERIC NOT NULL, type_ifrs17_portfolio CHARACTER VARYING(254), name_ifrs17_portfolio CHARACTER VARYING(254), id_ifrs17_portfolio CHARACTER VARYING(254), start_date TIMESTAMP(6) WITHOUT TIME ZONE, end_date TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_ifrs17_portfolio IS 'Справочник портфелей МСФО17 (СКК 2.2.25)';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.type_ifrs17_portfolio IS 'Тип портфеля МСФО17';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.name_ifrs17_portfolio IS 'Название портфеля МСФО17';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.id_ifrs17_portfolio IS 'ID портфеля МСФО17';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.start_date IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.end_date IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_ifrs17_portfolio.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_immovable_property (immovable_property_id NUMERIC NOT NULL, type_name CHARACTER VARYING(100), name CHARACTER VARYING(30), property_code CHARACTER VARYING(254), type_code CHARACTER VARYING(254), product_code NUMERIC, is_attached NUMERIC, is_detached NUMERIC, is_unfinished NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_immovable_property IS 'Справочник Недвижимого имущества (СКК 7.8.14)';
COMMENT ON COLUMN core.ref_immovable_property.immovable_property_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_immovable_property.type_name IS 'Наименование типа недвижимого имущества';
COMMENT ON COLUMN core.ref_immovable_property.name IS 'Наименование недвижимого имущества';
COMMENT ON COLUMN core.ref_immovable_property.property_code IS 'Код недвижимого имущества';
COMMENT ON COLUMN core.ref_immovable_property.type_code IS 'Код типа недвижимого имущества';
COMMENT ON COLUMN core.ref_immovable_property.product_code IS 'Идентификатор из справочника Продуктов GW (7.11.4 - ref_productgwpc.scc_id)';
COMMENT ON COLUMN core.ref_immovable_property.is_attached IS 'Признак, что недвижимое имущество может быть пристройкой: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_immovable_property.is_detached IS 'Признак, что недвижимое имущество может быть отдельно стоящим строением: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_immovable_property.is_unfinished IS 'Признак, что недвижимое имущество может быть Объект незавершенного строительства (ОНС): 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_immovable_property.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_immovable_property.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_immovable_property.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_insurance_type (insurance_type_id NUMERIC NOT NULL, short_name CHARACTER VARYING(40), full_name CHARACTER VARYING(4000), code CHARACTER VARYING(40), short_code CHARACTER VARYING(4000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_insurance_type IS 'Справочник Видов страхования';
COMMENT ON COLUMN core.ref_insurance_type.insurance_type_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_insurance_type.short_name IS 'Краткое наименование вида страхования';
COMMENT ON COLUMN core.ref_insurance_type.full_name IS 'Полное наименование вида страхования';
COMMENT ON COLUMN core.ref_insurance_type.code IS 'Код вида страхования';
COMMENT ON COLUMN core.ref_insurance_type.short_code IS 'Краткий код вида страхования';
COMMENT ON COLUMN core.ref_insurance_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_insurance_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_insurance_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_intermediary_channel (intermediary_channel_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(255), description CHARACTER VARYING(500), effective_start TIMESTAMP(6) WITHOUT TIME ZONE, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_intermediary_channel IS 'Справочник каналов привлечения';
COMMENT ON COLUMN core.ref_intermediary_channel.intermediary_channel_id IS 'Идентификатор канала привлечения';
COMMENT ON COLUMN core.ref_intermediary_channel.name IS ' Название канала привлечения';
COMMENT ON COLUMN core.ref_intermediary_channel.description IS 'Описание канала привлечения';
COMMENT ON COLUMN core.ref_intermediary_channel.effective_start IS 'Дата\время начала действия канала привлечения';
COMMENT ON COLUMN core.ref_intermediary_channel.effective_end IS 'Дата\время окончания канала привлечения';
COMMENT ON COLUMN core.ref_intermediary_channel.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_intermediary_channel.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_intermediary_channel.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_invoice_status (invoice_status_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(50), name CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_invoice_status IS 'Справочник статусов клиентских и агентских счетов';
COMMENT ON COLUMN core.ref_invoice_status.invoice_status_id IS 'Идентификатор статуса счета';
COMMENT ON COLUMN core.ref_invoice_status.code IS 'Код статуса';
COMMENT ON COLUMN core.ref_invoice_status.name IS 'Наименование статуса';
COMMENT ON COLUMN core.ref_invoice_status.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_invoice_status.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_kladr_okato (scc_id NUMERIC, kod_kladr CHARACTER VARYING(254), name_kladr CHARACTER VARYING(2000), kod_okato CHARACTER VARYING(254), name_okato CHARACTER VARYING(2000), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_kladr_okato IS 'Справочник КЛАДР-ОКАТО';
COMMENT ON COLUMN core.ref_kladr_okato.scc_id IS 'Идентификатор СКК';
COMMENT ON COLUMN core.ref_kladr_okato.kod_kladr IS 'Код КЛАДР';
COMMENT ON COLUMN core.ref_kladr_okato.name_kladr IS 'Наименование КЛАДР';
COMMENT ON COLUMN core.ref_kladr_okato.kod_okato IS 'Код КЛАДР ОКАТО';
COMMENT ON COLUMN core.ref_kladr_okato.name_okato IS 'Наименование ОКАТО';
COMMENT ON COLUMN core.ref_kladr_okato.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_landscape (landscape_id CHARACTER VARYING(254) NOT NULL, parent_landscape_id CHARACTER VARYING(254), name CHARACTER VARYING(2000), dimension NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_landscape IS 'Справочник Объектов ландшафтного дизайна (СКК 7.13.23)';
COMMENT ON COLUMN core.ref_landscape.landscape_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_landscape.parent_landscape_id IS 'Идентификатор записи родительского ландшафтного дизайна';
COMMENT ON COLUMN core.ref_landscape.name IS 'Наименование ландшафтного дизайна';
COMMENT ON COLUMN core.ref_landscape.dimension IS 'Величина измерения ландшафтного дизайна: 1-Площадь, 2-Количество';
COMMENT ON COLUMN core.ref_landscape.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_landscape.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_landscape.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_leaser (scc_id NUMERIC, leaser_id CHARACTER VARYING(254), name_leaser CHARACTER VARYING(2000), inn CHARACTER VARYING(254), ogrn CHARACTER VARYING(254), adress CHARACTER VARYING(2000), phone CHARACTER VARYING(254), data_registration DATE, name_registration_office CHARACTER VARYING(2000), email CHARACTER VARYING(2000), leasing_company_id CHARACTER VARYING(7), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_leaser IS 'Справочник лизингополучателей';
COMMENT ON COLUMN core.ref_leaser.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_leaser.leaser_id IS 'Идентификатор лизингодателя';
COMMENT ON COLUMN core.ref_leaser.name_leaser IS 'Наименование лизингодателя';
COMMENT ON COLUMN core.ref_leaser.inn IS 'ИНН';
COMMENT ON COLUMN core.ref_leaser.ogrn IS 'ОРГН';
COMMENT ON COLUMN core.ref_leaser.adress IS 'Адрес';
COMMENT ON COLUMN core.ref_leaser.phone IS 'Номер телефона';
COMMENT ON COLUMN core.ref_leaser.data_registration IS 'Дата регистрации';
COMMENT ON COLUMN core.ref_leaser.name_registration_office IS 'Наименование офиса регистрации';
COMMENT ON COLUMN core.ref_leaser.email IS 'Электронная почта';
COMMENT ON COLUMN core.ref_leaser.leasing_company_id IS 'Код лизинговой компании';
COMMENT ON COLUMN core.ref_leaser.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_loss_cause (loss_cause_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(50), name CHARACTER VARYING(256), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_loss_cause IS 'Справочник типы рисков по убыткам';
COMMENT ON COLUMN core.ref_loss_cause.loss_cause_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_loss_cause.code IS 'Код типа риска';
COMMENT ON COLUMN core.ref_loss_cause.name IS 'Наименование типа риска';
COMMENT ON COLUMN core.ref_loss_cause.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_loss_cause.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_loss_cause.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_material (material_id NUMERIC NOT NULL, parent_material_id NUMERIC, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_material IS 'Справочник Материалов (СКК 7.13.43 + справочник из GW)';
COMMENT ON COLUMN core.ref_material.material_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_material.parent_material_id IS 'Идентификатор записи родительского материала';
COMMENT ON COLUMN core.ref_material.name IS 'Наименование материала';
COMMENT ON COLUMN core.ref_material.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_material.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_material.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_movable_property (movable_property_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), type_name CHARACTER VARYING(254), item_amt NUMERIC, group_amt NUMERIC, wear_norm NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_movable_property IS 'Справочник Движимого имущества (СКК 7.13.69)';
COMMENT ON COLUMN core.ref_movable_property.movable_property_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_movable_property.name IS 'Наименование движимого имущества';
COMMENT ON COLUMN core.ref_movable_property.type_name IS 'Наименование подтипа движимого имущества: house - домашнее имущество, other - другое имущество';
COMMENT ON COLUMN core.ref_movable_property.item_amt IS 'Страховая сумма на андеррайтинг за единицу';
COMMENT ON COLUMN core.ref_movable_property.group_amt IS 'Страховая сумма на андеррайтинг по группе';
COMMENT ON COLUMN core.ref_movable_property.wear_norm IS 'Норма износа в год';
COMMENT ON COLUMN core.ref_movable_property.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_movable_property.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_movable_property.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_nonstandard_criteria (nonstandard_criteria_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), product_code NUMERIC, is_ofr_nonstandard_criteria NUMERIC, is_ofr_nonstandard_location NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_nonstandard_criteria IS 'Справочник Критериев нестандартности объекта (СКК 7.13.62)';
COMMENT ON COLUMN core.ref_nonstandard_criteria.nonstandard_criteria_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_nonstandard_criteria.name IS 'Наименование критерия нестандартности';
COMMENT ON COLUMN core.ref_nonstandard_criteria.product_code IS 'Идентификатор из справочника Продуктов GW (7.11.4 - ref_productgwpc.scc_id)';
COMMENT ON COLUMN core.ref_nonstandard_criteria.is_ofr_nonstandard_criteria IS 'Признак отображения в ОФР в "Критерий нестандартности объекта": 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_nonstandard_criteria.is_ofr_nonstandard_location IS 'Признак отображения в ОФР в "Особенности местоположения": 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_nonstandard_criteria.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_nonstandard_criteria.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_nonstandard_criteria.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_offeringgwpc (offering_name CHARACTER VARYING(2000), end_date TIMESTAMP(6) WITHOUT TIME ZONE, base_id DOUBLE PRECISION, date_to TIMESTAMP(6) WITHOUT TIME ZONE, tick NUMERIC(22,0), is_node DOUBLE PRECISION, scc_status SMALLINT, scc_id DOUBLE PRECISION, offering_code CHARACTER VARYING(254), id DOUBLE PRECISION, scc2_id CHARACTER VARYING(254), date_from TIMESTAMP(6) WITHOUT TIME ZONE, start_date TIMESTAMP(6) WITHOUT TIME ZONE, offering_type CHARACTER VARYING(2000), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.ref_offeringgwpc.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_osago_segment (scc_id NUMERIC NOT NULL, osago_segment_id NUMERIC, name CHARACTER VARYING(2000), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_osago_segment IS 'Сегменты ОСАГО';
COMMENT ON COLUMN core.ref_osago_segment.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_osago_segment.osago_segment_id IS 'Код сегмента';
COMMENT ON COLUMN core.ref_osago_segment.name IS 'Наименование сегмента';
COMMENT ON COLUMN core.ref_osago_segment.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_osago_segment.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_osago_segment.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_paper_kind (paper_kind_id INTEGER, paper_kind_name CHARACTER VARYING(128), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_paper_kind IS 'Справочник видов акта';
COMMENT ON COLUMN core.ref_paper_kind.paper_kind_id IS 'ID вида акта (первичный ключ)';
COMMENT ON COLUMN core.ref_paper_kind.paper_kind_name IS 'Имя вида акта';
COMMENT ON COLUMN core.ref_paper_kind.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_paper_stage (paper_stage_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(4000), code CHARACTER VARYING(40), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_paper_stage IS 'Справочник стадий акта';
COMMENT ON COLUMN core.ref_paper_stage.paper_stage_id IS 'Идентификатор стадии документа';
COMMENT ON COLUMN core.ref_paper_stage.name IS 'Наименование стадии документа';
COMMENT ON COLUMN core.ref_paper_stage.code IS 'Код стадии документа';
COMMENT ON COLUMN core.ref_paper_stage.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_paper_stage.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_paper_stage.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_partner (partner_id CHARACTER VARYING(50) NOT NULL, partner_code CHARACTER VARYING(7), partner_short_name CHARACTER VARYING(255), partner_full_name CHARACTER VARYING(1000), partner_federal_name CHARACTER VARYING(255), partner_address CHARACTER VARYING(1000), partner_type_id CHARACTER VARYING(50), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_partner IS 'Справочник партнёров';
COMMENT ON COLUMN core.ref_partner.partner_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_partner.partner_code IS 'Код партнера';
COMMENT ON COLUMN core.ref_partner.partner_short_name IS 'Короткое наименование партнера';
COMMENT ON COLUMN core.ref_partner.partner_full_name IS 'Полное наименование партнера';
COMMENT ON COLUMN core.ref_partner.partner_federal_name IS 'Наименование федерального партнера';
COMMENT ON COLUMN core.ref_partner.partner_address IS 'Адрес партнера';
COMMENT ON COLUMN core.ref_partner.partner_type_id IS 'Идентификатор типа партнера (Ссылка на core.ref_partner_type)';
COMMENT ON COLUMN core.ref_partner.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_partner.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_partner.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_partner_type (partner_type_id CHARACTER VARYING(50), partner_type_code CHARACTER VARYING(1000), partner_type_name CHARACTER VARYING(50), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_partner_type IS 'Справочник типов партнёров';
COMMENT ON COLUMN core.ref_partner_type.partner_type_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_partner_type.partner_type_code IS 'Код типа партнера';
COMMENT ON COLUMN core.ref_partner_type.partner_type_name IS 'Наименование типа партнера';
COMMENT ON COLUMN core.ref_partner_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_partner_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_partner_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_payment_frequency (payment_frequency_id CHARACTER VARYING(50) NOT NULL, payment_period_id CHARACTER VARYING(50), payment_quantity_id CHARACTER VARYING(50), name CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_payment_frequency IS 'Справочник количества и частоты оплат';
COMMENT ON COLUMN core.ref_payment_frequency.payment_frequency_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_payment_frequency.payment_period_id IS 'Идентификатор периода оплат';
COMMENT ON COLUMN core.ref_payment_frequency.payment_quantity_id IS 'Идентификатор количества оплат';
COMMENT ON COLUMN core.ref_payment_frequency.name IS 'Наименование количества и частоты оплат';
COMMENT ON COLUMN core.ref_payment_frequency.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_payment_frequency.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_payment_frequency.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_payment_method (payment_method_id CHARACTER VARYING(50) NOT NULL, ncode CHARACTER VARYING(7), name CHARACTER VARYING(254), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_payment_method IS 'Справочник Метод оплаты';
COMMENT ON COLUMN core.ref_payment_method.payment_method_id IS 'Идентификатор оплаты';
COMMENT ON COLUMN core.ref_payment_method.ncode IS 'Код метода оплаты';
COMMENT ON COLUMN core.ref_payment_method.name IS 'Наименование метода оплаты';
COMMENT ON COLUMN core.ref_payment_method.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_payment_method.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_payment_method.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_payment_period (payment_period_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_payment_period IS 'Справочник периодов оплат';
COMMENT ON COLUMN core.ref_payment_period.payment_period_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_payment_period.name IS 'Наименование частоты оплат';
COMMENT ON COLUMN core.ref_payment_period.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_payment_period.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_payment_period.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_payment_quantity (payment_quantity_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(50), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_payment_quantity IS 'Справочник количества оплат';
COMMENT ON COLUMN core.ref_payment_quantity.payment_quantity_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_payment_quantity.name IS 'Наименование количества оплат';
COMMENT ON COLUMN core.ref_payment_quantity.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_payment_quantity.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_payment_quantity.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_premise (name CHARACTER VARYING(2000), period_end DATE NOT NULL, period_start DATE, premise_id NUMERIC NOT NULL, product_code NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_premise IS 'Справочник Помещений (СКК 7.13.38)';
COMMENT ON COLUMN core.ref_premise.name IS 'Наименование помещения';
COMMENT ON COLUMN core.ref_premise.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_premise.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_premise.premise_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_premise.product_code IS 'Идентификатор из справочника Продуктов GW (7.11.4 - ref_productgwpc.scc_id)';
COMMENT ON COLUMN core.ref_premise.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_product (scc_id NUMERIC(38,0), product_id CHARACTER VARYING(7), product_number CHARACTER VARYING(50), product_name CHARACTER VARYING(100), sale_start_date DATE, sale_end_date DATE, period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_product IS 'Справочник продуктов (СКК 7.3.2)';
COMMENT ON COLUMN core.ref_product.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_product.product_id IS 'Идентификатор продукта';
COMMENT ON COLUMN core.ref_product.product_number IS 'Номер продукта';
COMMENT ON COLUMN core.ref_product.product_name IS 'Наименование продукта';
COMMENT ON COLUMN core.ref_product.sale_start_date IS 'Дата начала продажи';
COMMENT ON COLUMN core.ref_product.sale_end_date IS 'Дата конца продажи';
COMMENT ON COLUMN core.ref_product.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_product.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_product.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_product_catalog (product_my NUMERIC, end_date TIMESTAMP(6) WITHOUT TIME ZONE, insuarance_type CHARACTER VARYING(2000), ifrs_portfolio CHARACTER VARYING(2000), product_name_techcode NUMERIC, id_ekis NUMERIC, product_status CHARACTER VARYING(254), product_code NUMERIC, insuarance_type_techcode NUMERIC, product_comment CHARACTER VARYING(2000), product_id CHARACTER VARYING(254), scc_status NUMERIC(1,0), scc_id NUMERIC NOT NULL, offering_code NUMERIC, product_order CHARACTER VARYING(254), id NUMERIC, product_variant_techcode NUMERIC, product_description CHARACTER VARYING(2000), start_date TIMESTAMP(6) WITHOUT TIME ZONE, product_prolong NUMERIC, product_code_pf CHARACTER VARYING(2000), insurance_rule_id NUMERIC, ifrs_components CHARACTER VARYING(2000), product_ksp NUMERIC, base_id NUMERIC, product_variant CHARACTER VARYING(2000), id_ekis_objects NUMERIC, date_to TIMESTAMP(6) WITHOUT TIME ZONE, tick NUMERIC(22,0), product_cost_fact NUMERIC, is_node NUMERIC, product_name CHARACTER VARYING(2000), product_class_id_fk NUMERIC, product_blank CHARACTER VARYING(2000), product_name_base CHARACTER VARYING(2000), product_pf NUMERIC, product_cost_agreed NUMERIC, date_from TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_product_catalog IS 'Справочник Реестр продуктов';
COMMENT ON COLUMN core.ref_product_catalog.product_my IS 'Для своих (ДА/НЕТ)';
COMMENT ON COLUMN core.ref_product_catalog.end_date IS 'Дата окончания действия продукта';
COMMENT ON COLUMN core.ref_product_catalog.insuarance_type IS 'Группа страхования';
COMMENT ON COLUMN core.ref_product_catalog.ifrs_portfolio IS 'Наименование портфеля';
COMMENT ON COLUMN core.ref_product_catalog.product_name_techcode IS 'Технический идентификатор продукта';
COMMENT ON COLUMN core.ref_product_catalog.id_ekis IS 'ID продукта/правила (ЕКИС СКК 1.1.10)';
COMMENT ON COLUMN core.ref_product_catalog.product_status IS 'Статус продукта';
COMMENT ON COLUMN core.ref_product_catalog.product_code IS 'Код продукта (Guidewire)';
COMMENT ON COLUMN core.ref_product_catalog.insuarance_type_techcode IS 'Технический номер группы страхования';
COMMENT ON COLUMN core.ref_product_catalog.product_comment IS 'Комментарий';
COMMENT ON COLUMN core.ref_product_catalog.product_id IS 'Порядковый номер продукта';
COMMENT ON COLUMN core.ref_product_catalog.scc_status IS 'Статус актуальности записи в СКК: 0 - запись актуальна, 1 - запись не актуальна.';
COMMENT ON COLUMN core.ref_product_catalog.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_product_catalog.offering_code IS 'Код Предложения (Guidewire)';
COMMENT ON COLUMN core.ref_product_catalog.product_order IS 'Приказ о вводе в действие продукта';
COMMENT ON COLUMN core.ref_product_catalog.id IS 'Числовой идентификатор записи';
COMMENT ON COLUMN core.ref_product_catalog.product_variant_techcode IS 'Технический идентификатор варианта продукта';
COMMENT ON COLUMN core.ref_product_catalog.product_description IS 'Краткое описание продукта';
COMMENT ON COLUMN core.ref_product_catalog.start_date IS 'Дата старта продаж продукта';
COMMENT ON COLUMN core.ref_product_catalog.product_prolong IS 'Пролонгация договора страхования (Да/Нет)';
COMMENT ON COLUMN core.ref_product_catalog.product_code_pf IS 'Код продукта';
COMMENT ON COLUMN core.ref_product_catalog.insurance_rule_id IS 'ID правила страхования (АРМ СКК 7.3.3)';
COMMENT ON COLUMN core.ref_product_catalog.ifrs_components IS 'Выделяемые составляющие (МСФО17)';
COMMENT ON COLUMN core.ref_product_catalog.product_ksp IS 'Коробочный продукт (да/нет)';
COMMENT ON COLUMN core.ref_product_catalog.product_variant IS 'Вариант продукта';
COMMENT ON COLUMN core.ref_product_catalog.id_ekis_objects IS 'ID объекта (ЕКИС СКК 1.1.12)';
COMMENT ON COLUMN core.ref_product_catalog.date_to IS 'Дата и время, по которое действует данная запись';
COMMENT ON COLUMN core.ref_product_catalog.tick IS 'Ссылка на основание';
COMMENT ON COLUMN core.ref_product_catalog.product_cost_fact IS 'ИТ расходы на разработку продукта (факт)';
COMMENT ON COLUMN core.ref_product_catalog.is_node IS 'Флаг, показывающий, является ли данная запись узлом дерева (не листом). Используется только для иерархических справочников';
COMMENT ON COLUMN core.ref_product_catalog.product_name IS 'Маркетинговое название продукта';
COMMENT ON COLUMN core.ref_product_catalog.product_class_id_fk IS 'Код класса договора';
COMMENT ON COLUMN core.ref_product_catalog.product_blank IS 'Вид оформления (БСО/ПО)';
COMMENT ON COLUMN core.ref_product_catalog.product_name_base IS 'Продукт (основной)';
COMMENT ON COLUMN core.ref_product_catalog.product_pf IS 'Продукт ПФ';
COMMENT ON COLUMN core.ref_product_catalog.product_cost_agreed IS 'ИТ расходы на разработку продукта (согласовано)';
COMMENT ON COLUMN core.ref_product_catalog.date_from IS 'Дата и время, начиная с которого действует данная запись';
COMMENT ON COLUMN core.ref_product_catalog.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_product_catalog.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_product_catalog.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_product_mapping (project_id CHARACTER VARYING(7), contract_series CHARACTER VARYING(254), insurance_rule_id CHARACTER VARYING(25), id_ekis CHARACTER VARYING(255), id_ekis_objects CHARACTER VARYING(255), product_code CHARACTER VARYING(254), offering_code CHARACTER VARYING(254), product_id CHARACTER VARYING(254), project_type_id CHARACTER VARYING(7), period_start DATE, period_end DATE, modified_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, hash CHARACTER VARYING(32), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_product_mapping IS 'Справочник маппинга продуктов различных систем (SCC, ЕКИС, GWPC) (СКК 7.13.56)';
COMMENT ON COLUMN core.ref_product_mapping.project_id IS 'Идентификатор проекта';
COMMENT ON COLUMN core.ref_product_mapping.contract_series IS 'Серия контракта';
COMMENT ON COLUMN core.ref_product_mapping.insurance_rule_id IS 'Идентификатор правила страхования';
COMMENT ON COLUMN core.ref_product_mapping.id_ekis IS 'Идентификатор ЕКИС';
COMMENT ON COLUMN core.ref_product_mapping.id_ekis_objects IS 'Идентификатор объектов ЕКИС';
COMMENT ON COLUMN core.ref_product_mapping.product_code IS 'Код продукта';
COMMENT ON COLUMN core.ref_product_mapping.offering_code IS 'Код предложения';
COMMENT ON COLUMN core.ref_product_mapping.product_id IS 'Идентификатор продукта';
COMMENT ON COLUMN core.ref_product_mapping.project_type_id IS 'Идентификатор типа проекта';
COMMENT ON COLUMN core.ref_product_mapping.period_start IS 'Начало периода';
COMMENT ON COLUMN core.ref_product_mapping.period_end IS 'Окончание периода';
COMMENT ON COLUMN core.ref_product_mapping.modified_timestamp IS 'Время последнего изменения';
COMMENT ON COLUMN core.ref_product_mapping.hash IS 'Хеш-сумма для контроля целостности';
COMMENT ON COLUMN core.ref_product_mapping.updated_ts IS 'Время обновления записи';
CREATE TABLE core.ref_product_version (product_version_id CHARACTER VARYING(37) NOT NULL, code CHARACTER VARYING(32), version INTEGER, name CHARACTER VARYING(512), description CHARACTER VARYING(512), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_product_version IS 'Справочник версий продуктов';
COMMENT ON COLUMN core.ref_product_version.product_version_id IS 'Идентификатор версии продуктов';
COMMENT ON COLUMN core.ref_product_version.code IS 'Код продукта';
COMMENT ON COLUMN core.ref_product_version.version IS 'Код версии продукта';
COMMENT ON COLUMN core.ref_product_version.name IS 'Наименование кода версии продукта';
COMMENT ON COLUMN core.ref_product_version.description IS 'Описание кода версии продукта';
COMMENT ON COLUMN core.ref_product_version.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_product_version.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_product_version.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_promocode (promocode_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(255), product_code CHARACTER VARYING(50), discount_amt NUMERIC, min_day_duration INTEGER, max_day_duration INTEGER, max_usage_cnt INTEGER, type CHARACTER VARYING(50), subscription_period CHARACTER VARYING(100), effective_start TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.ref_promocode.promocode_id IS 'Идентификатор промокода';
COMMENT ON COLUMN core.ref_promocode.code IS 'Промокод';
COMMENT ON COLUMN core.ref_promocode.product_code IS 'Код страхового продукта';
COMMENT ON COLUMN core.ref_promocode.discount_amt IS 'Размер скидки';
COMMENT ON COLUMN core.ref_promocode.min_day_duration IS 'Минимальное количество дней длительности договора, для которого действует скидка';
COMMENT ON COLUMN core.ref_promocode.max_day_duration IS 'Максимальное количество дней длительности договора, для которого действует скидка';
COMMENT ON COLUMN core.ref_promocode.max_usage_cnt IS 'Возможное количество применений промокода одним клиентом';
COMMENT ON COLUMN core.ref_promocode.type IS 'Тип промокода';
COMMENT ON COLUMN core.ref_promocode.subscription_period IS 'Периоды подписки, на которые действует cкидка';
COMMENT ON COLUMN core.ref_promocode.effective_start IS 'Дата и время начала действия промокода';
COMMENT ON COLUMN core.ref_promocode.effective_end IS 'Дата и время окончания действия промокода';
COMMENT ON COLUMN core.ref_promocode.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_promocode.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_promocode.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_receipt_channel (receipt_channel_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(4000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_receipt_channel IS 'Справочник канал получения обращения по урегулированному убытку';
COMMENT ON COLUMN core.ref_receipt_channel.receipt_channel_id IS 'Идентификатор канала';
COMMENT ON COLUMN core.ref_receipt_channel.name IS 'Наименование канала';
COMMENT ON COLUMN core.ref_receipt_channel.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_receipt_channel.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_receipt_channel.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_redefcode7gs (scc_id NUMERIC NOT NULL, current7gs_id NUMERIC, new7gs_id NUMERIC, programm_id NUMERIC, product_id NUMERIC, comment_ CHARACTER VARYING(2000) COLLATE "C", start_date TIMESTAMP(6) WITHOUT TIME ZONE, end_date TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_redefcode7gs IS 'Справочник Доопределение кодов 7ГС (СКК 7.3.90)';
COMMENT ON COLUMN core.ref_redefcode7gs.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_redefcode7gs.current7gs_id IS 'Текущий ID строки 7ГС';
COMMENT ON COLUMN core.ref_redefcode7gs.new7gs_id IS 'Новый ID строки 7ГС';
COMMENT ON COLUMN core.ref_redefcode7gs.programm_id IS 'Идентификатор программы';
COMMENT ON COLUMN core.ref_redefcode7gs.product_id IS 'Идентификатор продукта';
COMMENT ON COLUMN core.ref_redefcode7gs.comment_ IS 'Комментарий';
COMMENT ON COLUMN core.ref_redefcode7gs.start_date IS 'Дата начала действия записи (в справочнике-источнике)';
COMMENT ON COLUMN core.ref_redefcode7gs.end_date IS 'Дата окончания действия записи (в справочнике-источнике)';
COMMENT ON COLUMN core.ref_redefcode7gs.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_redefcode7gs.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_redefcode7gs.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_reinsurance_type (reinsurance_type_id CHARACTER VARYING(50) NOT NULL, code CHARACTER VARYING(50), name CHARACTER VARYING(256), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_reinsurance_type IS 'Справочник видов перестрахования';
COMMENT ON COLUMN core.ref_reinsurance_type.reinsurance_type_id IS 'Идентификатор вида перестрахования';
COMMENT ON COLUMN core.ref_reinsurance_type.code IS 'Код линии вида перестрахования';
COMMENT ON COLUMN core.ref_reinsurance_type.name IS 'Наименование вида перестрахования';
COMMENT ON COLUMN core.ref_reinsurance_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_reinsurance_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_reinsurance_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_relation_type (relation_type_id INTEGER NOT NULL, relation_type_name CHARACTER VARYING(200), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.ref_relation_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_reservation (reservation_id CHARACTER VARYING(25) NOT NULL, name CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_reservation IS 'Справочник оговорки';
COMMENT ON COLUMN core.ref_reservation.reservation_id IS 'Идентификатор оговорки';
COMMENT ON COLUMN core.ref_reservation.name IS 'Наименование оговорки';
COMMENT ON COLUMN core.ref_reservation.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_reservation.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_reservation.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_reservation_value (reservation_value_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(256), reservation_id CHARACTER VARYING(25), period_start DATE, period_end DATE NOT NULL, code NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_reservation_value IS 'Справочник значения оговорок';
COMMENT ON COLUMN core.ref_reservation_value.reservation_value_id IS 'Идентификатор значения оговорки';
COMMENT ON COLUMN core.ref_reservation_value.name IS 'Наименование значения оговорки';
COMMENT ON COLUMN core.ref_reservation_value.reservation_id IS 'Идентификатор оговорки';
COMMENT ON COLUMN core.ref_reservation_value.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_reservation_value.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_reservation_value.code IS 'Код значения оговорки (идентификатор записи в СКК 7.9.12)';
COMMENT ON COLUMN core.ref_reservation_value.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_reserve_groups_def (scc_id NUMERIC(38,0), dict7gs_id CHARACTER VARYING(7) NOT NULL, subject_type_id CHARACTER VARYING(7) NOT NULL, reserve_group_id CHARACTER VARYING(254) NOT NULL, reserve_group_id_2020 CHARACTER VARYING(254), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_reserve_groups_def IS 'Справочник: Резервные группы';
COMMENT ON COLUMN core.ref_reserve_groups_def.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_reserve_groups_def.dict7gs_id IS 'Код 7ГС';
COMMENT ON COLUMN core.ref_reserve_groups_def.subject_type_id IS 'Тип субъекта';
COMMENT ON COLUMN core.ref_reserve_groups_def.reserve_group_id IS 'Код резервной группы';
COMMENT ON COLUMN core.ref_reserve_groups_def.reserve_group_id_2020 IS 'Код резервной группы 2020';
COMMENT ON COLUMN core.ref_reserve_groups_def.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_reserve_groups_def.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_reserve_groups_def.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_resgroup_osbu_resgr (scc_id NUMERIC NOT NULL, reserve_group_id CHARACTER VARYING(254), id_res_group_osbu CHARACTER VARYING(254), name_res_group_osbu CHARACTER VARYING(2000), id_line_bisiness_msfo CHARACTER VARYING(254), name_line_bisiness_msfo CHARACTER VARYING(254), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_resgroup_osbu_resgr IS 'Справочник: Соответствие резервных групп и резервных групп ОСБУ';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.reserve_group_id IS 'Код резервной группы';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.id_res_group_osbu IS 'Код резервной группы ОСБУ';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.name_res_group_osbu IS 'Название резервной группы ОСБУ';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.id_line_bisiness_msfo IS 'Код линии бизнеса МСФО';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.name_line_bisiness_msfo IS 'Название линии бизнеса МСФО';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_resgroup_osbu_resgr.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_risk_factor (risk_factor_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), product_scc_id NUMERIC, is_additional_text NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_risk_factor IS 'Справочник Факторов риска (СКК 7.13.18)';
COMMENT ON COLUMN core.ref_risk_factor.risk_factor_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_risk_factor.name IS 'Наименование фактора риска';
COMMENT ON COLUMN core.ref_risk_factor.product_scc_id IS 'Идентификатор из справочника Продуктов GW (7.11.4 - ref_productgwpc.scc_id)';
COMMENT ON COLUMN core.ref_risk_factor.is_additional_text IS 'Признак необходимости ввода доп. информации: 1 – Да, 0 – Нет, -1 – Не определен';
COMMENT ON COLUMN core.ref_risk_factor.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_risk_factor.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_risk_factor.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_risk_package (risk_package_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), service_name CHARACTER VARYING(2000), product_code NUMERIC, offering_code NUMERIC, is_editability NUMERIC, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_risk_package IS 'Справочник Пакетов рисков (СКК 7.13.48)';
COMMENT ON COLUMN core.ref_risk_package.risk_package_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_risk_package.name IS 'Наименование пакета рисков';
COMMENT ON COLUMN core.ref_risk_package.service_name IS 'Наименование сервисов, входящих в пакет';
COMMENT ON COLUMN core.ref_risk_package.product_code IS 'Идентификатор из справочника Продуктов GW (7.11.4 - ref_productgwpc.scc_id)';
COMMENT ON COLUMN core.ref_risk_package.offering_code IS 'Код предложения (Ссылка на core.ref_offeringgwpc.scc_id)';
COMMENT ON COLUMN core.ref_risk_package.is_editability IS 'Признак редактируемости: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.ref_risk_package.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_risk_package.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_risk_package.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_sale_channel_bk (scc_id NUMERIC NOT NULL, sale_channel_bk_id CHARACTER VARYING(254) COLLATE "C", sale_channel_bk_name CHARACTER VARYING(2000) COLLATE "C", period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_sale_channel_bk IS 'Справочник УУ Большие каналы продаж (СКК 2.3.4)';
COMMENT ON COLUMN core.ref_sale_channel_bk.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_sale_channel_bk.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_sale_channel_bk.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_sale_channel_bk.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_sale_channel_groupmk (sale_channel_grmk_scc_id NUMERIC NOT NULL, sale_channel_groupmk_id CHARACTER VARYING(254), sale_channel_groupmk_name CHARACTER VARYING(2000), period_start DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_sale_channel_groupmk IS 'Справочник: Группа малых каналов продаж';
COMMENT ON COLUMN core.ref_sale_channel_groupmk.sale_channel_grmk_scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_sale_channel_groupmk.sale_channel_groupmk_id IS 'Код группы малого канала продаж';
COMMENT ON COLUMN core.ref_sale_channel_groupmk.sale_channel_groupmk_name IS 'Наименование группы малого канала продаж';
COMMENT ON COLUMN core.ref_sale_channel_groupmk.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_sale_channel_groupmk.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_sale_channel_groupmk.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_sale_channel_mk (scc_id NUMERIC NOT NULL, sale_channel_mk_id CHARACTER VARYING(254) COLLATE "C", sale_channel_mk_name CHARACTER VARYING(2000) COLLATE "C", period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_sale_channel_mk IS 'Справочник УУ Малые каналы продаж (СКК 2.3.2)';
COMMENT ON COLUMN core.ref_sale_channel_mk.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_sale_channel_mk.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_sale_channel_mk.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_sale_channel_mk.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_security_review (security_review_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_security_review IS 'Справочник результатов проверки департамента по обеспечению безопасности';
COMMENT ON COLUMN core.ref_security_review.security_review_id IS 'Идентификатор результата проверки';
COMMENT ON COLUMN core.ref_security_review.name IS 'Результат проверки';
COMMENT ON COLUMN core.ref_security_review.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_security_review.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_security_review.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_soil_type (soil_type_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_soil_type IS 'Справочник Типов почвы (СКК 7.13.22)';
COMMENT ON COLUMN core.ref_soil_type.soil_type_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_soil_type.name IS 'Наименование типа почвы';
COMMENT ON COLUMN core.ref_soil_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_soil_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_soil_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_source_system (name CHARACTER VARYING(500) NOT NULL, code CHARACTER VARYING(50) NOT NULL, prefix CHARACTER VARYING(50), schema_name CHARACTER VARYING(500), description CHARACTER VARYING(2000));
COMMENT ON COLUMN core.ref_source_system.name IS 'Наименование системы';
COMMENT ON COLUMN core.ref_source_system.code IS 'Код системы';
COMMENT ON COLUMN core.ref_source_system.prefix IS 'Префикс системы';
COMMENT ON COLUMN core.ref_source_system.schema_name IS 'Схема в ODS';
COMMENT ON COLUMN core.ref_source_system.description IS 'Описание';
CREATE TABLE core.ref_strict_blank_paper_type (strict_blank_paper_type_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(100), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT clock_timestamp());
COMMENT ON TABLE core.ref_strict_blank_paper_type IS 'Справочник типов связи БСО и документов хоз. деятельности';
COMMENT ON COLUMN core.ref_strict_blank_paper_type.strict_blank_paper_type_id IS 'Идентификатор типа связи';
COMMENT ON COLUMN core.ref_strict_blank_paper_type.name IS 'Наименование типа связи';
COMMENT ON COLUMN core.ref_strict_blank_paper_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_strict_blank_paper_type.period_end IS 'Дата окончания действия записи';
CREATE TABLE core.ref_structural_element (structural_element_id NUMERIC NOT NULL, name CHARACTER VARYING(2000), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_structural_element IS 'Справочник Конструктивных элементов (КЭ) (СКК 7.13.30)';
COMMENT ON COLUMN core.ref_structural_element.structural_element_id IS 'Идентификатор записи';
COMMENT ON COLUMN core.ref_structural_element.name IS 'Наименование конструктивного элемента';
COMMENT ON COLUMN core.ref_structural_element.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.ref_structural_element.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.ref_structural_element.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_subscription_cause (subscription_cause_id CHARACTER VARYING(37) NOT NULL, code TEXT, name CHARACTER VARYING(512), description TEXT, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_subscription_cause IS 'Справочник причин изменения статусов подписки';
COMMENT ON COLUMN core.ref_subscription_cause.subscription_cause_id IS 'Идентификатор обоснования изменения статуса';
COMMENT ON COLUMN core.ref_subscription_cause.code IS 'Код причины изменения статуса';
COMMENT ON COLUMN core.ref_subscription_cause.name IS 'Наименование причины изменения статуса';
COMMENT ON COLUMN core.ref_subscription_cause.description IS 'Описание причины изменения статуса';
COMMENT ON COLUMN core.ref_subscription_cause.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_subscription_cause.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_subscription_cause.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_subscription_reason (subscription_reason_id CHARACTER VARYING(37) NOT NULL, code TEXT, description TEXT, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_subscription_reason IS 'Справочник обоснований изменений статусов подписки';
COMMENT ON COLUMN core.ref_subscription_reason.subscription_reason_id IS 'Идентификатор обоснования изменения статуса';
COMMENT ON COLUMN core.ref_subscription_reason.code IS 'Код обоснования изменения статуса';
COMMENT ON COLUMN core.ref_subscription_reason.description IS 'Описание обоснования изменения статуса';
COMMENT ON COLUMN core.ref_subscription_reason.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_subscription_reason.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_subscription_reason.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_subscription_status (subscription_status_id CHARACTER VARYING(37) NOT NULL, code TEXT, name CHARACTER VARYING(512), description TEXT, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_subscription_status IS 'Справочник статусов подписки';
COMMENT ON COLUMN core.ref_subscription_status.subscription_status_id IS 'Идентификатор статуса подписки';
COMMENT ON COLUMN core.ref_subscription_status.code IS 'Код статуса подписки';
COMMENT ON COLUMN core.ref_subscription_status.name IS 'Наименование статуса подписки';
COMMENT ON COLUMN core.ref_subscription_status.description IS 'Описание статуса подписки';
COMMENT ON COLUMN core.ref_subscription_status.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_subscription_status.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_subscription_status.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.ref_subscription_type (subscription_type_id CHARACTER VARYING(37) NOT NULL, code TEXT, name CHARACTER VARYING(512), description TEXT, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.ref_subscription_type IS 'Справочник типов подписки';
COMMENT ON COLUMN core.ref_subscription_type.subscription_type_id IS 'Идентификатор типа подписки';
COMMENT ON COLUMN core.ref_subscription_type.code IS 'Код типа подписки';
COMMENT ON COLUMN core.ref_subscription_type.name IS 'Наименование типа подписки';
COMMENT ON COLUMN core.ref_subscription_type.description IS 'Описание типа подписки';
COMMENT ON COLUMN core.ref_subscription_type.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.ref_subscription_type.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.ref_subscription_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.region_vip (bid CHARACTER VARYING(5) NOT NULL, vip_id CHARACTER VARYING(10) NOT NULL, group_code CHARACTER VARYING(25), group_name CHARACTER VARYING(512), full_name CHARACTER VARYING(512), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.region_vip.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.regress (regress_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), payment_receive_date DATE, payment_amt NUMERIC(36,2), premium_cur CHARACTER VARYING(7), payment_rub NUMERIC(36,2), hash CHARACTER VARYING(32), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.regress IS 'Регресс';
COMMENT ON COLUMN core.regress.regress_id IS 'Идентификатор регресса';
COMMENT ON COLUMN core.regress.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.regress.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.regress.payment_receive_date IS 'Дата получения платежа';
COMMENT ON COLUMN core.regress.payment_amt IS 'Сумма платежа';
COMMENT ON COLUMN core.regress.premium_cur IS 'Код валюты премии';
COMMENT ON COLUMN core.regress.payment_rub IS 'Сумма платежа в рублях';
COMMENT ON COLUMN core.regress.hash IS 'Хэш';
COMMENT ON COLUMN core.regress.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.regress.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.regress.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.regress.key_id IS 'Уникальный ключ';
CREATE TABLE core.reinsurance_condition (reinsurance_condition_id CHARACTER VARYING(50) NOT NULL, type CHARACTER VARYING(100), contract_id CHARACTER VARYING(50), base_document_number CHARACTER VARYING(100), original_contract_id CHARACTER VARYING(50), original_contract_number CHARACTER VARYING(1000), addendum_description CHARACTER VARYING(1000), insurant_name CHARACTER VARYING(1000), object_descriprion CHARACTER VARYING(1000), object_risk_descriprion CHARACTER VARYING(1000), accept_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, cancel_date TIMESTAMP(6) WITHOUT TIME ZONE, accrual_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_cur_code CHARACTER VARYING(7), original_contract_liability_amt NUMERIC(36,2), reinsurance_rate NUMERIC, contract_liability_amt NUMERIC(36,2), premium_cur_code CHARACTER VARYING(7), premium_cur_rate NUMERIC, contract_premium_amt NUMERIC(36,2), contract_commission_amt NUMERIC(36,2), liability_share NUMERIC, liability_amt NUMERIC(36,2), reinsurance_type_code CHARACTER VARYING(40), reinsurance_type_name CHARACTER VARYING(1024), business_line_code CHARACTER VARYING(40), business_line_name CHARACTER VARYING(1024), return_reason CHARACTER VARYING(1000), premium_amt NUMERIC(36,2), commission_amt NUMERIC(36,2), premium_return_amt NUMERIC(36,2), commission_return_amt NUMERIC(36,2), premium_oper_type_code CHARACTER VARYING(40), premium_oper_type_name CHARACTER VARYING(1024), commission_oper_type_code CHARACTER VARYING(40), commission_oper_type_name CHARACTER VARYING(1024), premium_return_oper_type_code CHARACTER VARYING(40), premium_return_oper_type_name CHARACTER VARYING(1024), commission_return_oper_type_code CHARACTER VARYING(40), commission_return_oper_type_name CHARACTER VARYING(1024), cedent_name CHARACTER VARYING(1000), cedent_code CHARACTER VARYING(1000), premium_type CHARACTER VARYING(1000), additional_analytics CHARACTER VARYING(1000), reinsurance_category CHARACTER VARYING(1024), period1_start TIMESTAMP(6) WITHOUT TIME ZONE, period1_end TIMESTAMP(6) WITHOUT TIME ZONE, period2_start TIMESTAMP(6) WITHOUT TIME ZONE, period2_end TIMESTAMP(6) WITHOUT TIME ZONE, period3_start TIMESTAMP(6) WITHOUT TIME ZONE, period3_end TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, _fkey CHARACTER VARYING(50), bordereau_id CHARACTER VARYING(50), ifrs17_accrual_date TIMESTAMP(6) WITHOUT TIME ZONE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.reinsurance_condition IS 'Условия договоров перестрахования';
COMMENT ON COLUMN core.reinsurance_condition.reinsurance_condition_id IS 'Идентификатор условия договора перестрахования (первичный ключ)';
COMMENT ON COLUMN core.reinsurance_condition.type IS 'Тип условия договора перестрахования';
COMMENT ON COLUMN core.reinsurance_condition.contract_id IS 'Идентификатор договора перестрахования (внешний ключ на табл. contract и contract_reinsurance)';
COMMENT ON COLUMN core.reinsurance_condition.base_document_number IS 'Номер документа-источника';
COMMENT ON COLUMN core.reinsurance_condition.original_contract_id IS 'Идентификатор договора переданного/принятого в перестрахование (внешний ключ на табл. contract)';
COMMENT ON COLUMN core.reinsurance_condition.original_contract_number IS 'Номер договора переданного/принятого в перестрахование';
COMMENT ON COLUMN core.reinsurance_condition.addendum_description IS 'ДС к договору - Описание';
COMMENT ON COLUMN core.reinsurance_condition.insurant_name IS 'Страхователь';
COMMENT ON COLUMN core.reinsurance_condition.object_descriprion IS 'Описание объекта перестрахования';
COMMENT ON COLUMN core.reinsurance_condition.object_risk_descriprion IS 'Описание риска по объекту перестрахования';
COMMENT ON COLUMN core.reinsurance_condition.accept_date IS 'Дата акцепта';
COMMENT ON COLUMN core.reinsurance_condition.liability_start_date IS 'Дата начала ответственности';
COMMENT ON COLUMN core.reinsurance_condition.liability_end_date IS 'Дата окончания ответственности';
COMMENT ON COLUMN core.reinsurance_condition.cancel_date IS 'Дата досрочного расторжения';
COMMENT ON COLUMN core.reinsurance_condition.accrual_date IS 'Дата начисления МСФО-4';
COMMENT ON COLUMN core.reinsurance_condition.liability_cur_code IS 'Код валюты страховой суммы';
COMMENT ON COLUMN core.reinsurance_condition.original_contract_liability_amt IS 'Оригинальная страховая сумма / Эксцедент суммы';
COMMENT ON COLUMN core.reinsurance_condition.reinsurance_rate IS 'Доля (от Оригинальной страховой суммы/ от Эксцедента суммы), подлежащая перестрахованию';
COMMENT ON COLUMN core.reinsurance_condition.contract_liability_amt IS 'Страховая сумма по договору ВСЕГО, подлежащая перестрахованию';
COMMENT ON COLUMN core.reinsurance_condition.premium_cur_code IS 'Код валюты премии';
COMMENT ON COLUMN core.reinsurance_condition.premium_cur_rate IS 'Курс валюты премии';
COMMENT ON COLUMN core.reinsurance_condition.contract_premium_amt IS 'Премия по договору ВСЕГО (в вал. договора)';
COMMENT ON COLUMN core.reinsurance_condition.contract_commission_amt IS 'КВ по договору ВСЕГО (в вал. договора)';
COMMENT ON COLUMN core.reinsurance_condition.liability_share IS 'Доля покрытия/премии/КВ в процентах (Процентное соотношение)';
COMMENT ON COLUMN core.reinsurance_condition.liability_amt IS 'Страховая сумма';
COMMENT ON COLUMN core.reinsurance_condition.reinsurance_type_code IS 'Тип перестрахования - Код';
COMMENT ON COLUMN core.reinsurance_condition.reinsurance_type_name IS 'Тип перестрахования - Наименование';
COMMENT ON COLUMN core.reinsurance_condition.business_line_code IS 'Линия бизнеса - Код';
COMMENT ON COLUMN core.reinsurance_condition.business_line_name IS 'Линия бизнеса - Наименование';
COMMENT ON COLUMN core.reinsurance_condition.return_reason IS 'Причина возврата';
COMMENT ON COLUMN core.reinsurance_condition.premium_amt IS 'Премия к начислению, вал.';
COMMENT ON COLUMN core.reinsurance_condition.commission_amt IS 'КВ к начислению, вал.';
COMMENT ON COLUMN core.reinsurance_condition.premium_return_amt IS 'Возврат премии к начислению, вал.';
COMMENT ON COLUMN core.reinsurance_condition.commission_return_amt IS 'Возврат КВ к начислению, вал.';
COMMENT ON COLUMN core.reinsurance_condition.premium_oper_type_code IS 'Тип операции премии - Код';
COMMENT ON COLUMN core.reinsurance_condition.premium_oper_type_name IS 'Тип операции премии - Наименование';
COMMENT ON COLUMN core.reinsurance_condition.commission_oper_type_code IS 'Тип операции КВ - Код';
COMMENT ON COLUMN core.reinsurance_condition.commission_oper_type_name IS 'Тип операции КВ - Наименование';
COMMENT ON COLUMN core.reinsurance_condition.premium_return_oper_type_code IS 'Тип операции возврата премии - Код';
COMMENT ON COLUMN core.reinsurance_condition.premium_return_oper_type_name IS 'Тип операции возврата премии - Наименование';
COMMENT ON COLUMN core.reinsurance_condition.commission_return_oper_type_code IS 'Тип операции возврата КВ - Код';
COMMENT ON COLUMN core.reinsurance_condition.commission_return_oper_type_name IS 'Тип операции возврата КВ - Наименование';
COMMENT ON COLUMN core.reinsurance_condition.cedent_name IS 'Перестрахователь (Цедент)';
COMMENT ON COLUMN core.reinsurance_condition.cedent_code IS 'Код ДП перестрахователя (Цедент)';
COMMENT ON COLUMN core.reinsurance_condition.premium_type IS 'Вид премии (непропорция)';
COMMENT ON COLUMN core.reinsurance_condition.additional_analytics IS 'Дополнительна аналитика';
COMMENT ON COLUMN core.reinsurance_condition.reinsurance_category IS 'Категория перестрахования (Прямое или Ретроцессия)';
COMMENT ON COLUMN core.reinsurance_condition.period1_start IS 'Дата начала 1 периода (для ОСАГО)';
COMMENT ON COLUMN core.reinsurance_condition.period1_end IS 'Дата окончания 1 периода (для ОСАГО)';
COMMENT ON COLUMN core.reinsurance_condition.period2_start IS 'Дата начала 2 периода (для ОСАГО)';
COMMENT ON COLUMN core.reinsurance_condition.period2_end IS 'Дата окончания 2 периода (для ОСАГО)';
COMMENT ON COLUMN core.reinsurance_condition.period3_start IS 'Дата начала 3 периода (для ОСАГО)';
COMMENT ON COLUMN core.reinsurance_condition.period3_end IS 'Дата окончания 3 периода (для ОСАГО)';
COMMENT ON COLUMN core.reinsurance_condition.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.reinsurance_condition.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.reinsurance_condition.bordereau_id IS 'ID бордеро (табл. bordereau)';
COMMENT ON COLUMN core.reinsurance_condition.ifrs17_accrual_date IS 'Дата начисления МСФО-17';
COMMENT ON COLUMN core.reinsurance_condition.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.reinsurance_condition.key_id IS 'Уникальный ключ';
CREATE TABLE core.reinsurance_counterparty (reinsurance_counterparty_id CHARACTER VARYING(50) NOT NULL, reinsurance_condition_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50) NOT NULL, counterparty_role_id NUMERIC(10,0), reinsurance_counterparty_role NUMERIC(10,0), period_start DATE DEFAULT CURRENT_DATE, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, _fkey CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.reinsurance_counterparty IS 'Контрагенты по условиям договора перестрахования';
COMMENT ON COLUMN core.reinsurance_counterparty.reinsurance_counterparty_id IS 'Идентификатор контрагента по сущности перестрахования (первичный ключ)';
COMMENT ON COLUMN core.reinsurance_counterparty.reinsurance_condition_id IS 'Идентификатор условия договора перестрахования (внешний ключ на табл. reinsurance_condition)';
COMMENT ON COLUMN core.reinsurance_counterparty.counterparty_id IS 'Идентификатор контрагента (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.reinsurance_counterparty.counterparty_role_id IS 'Идентификатор роли контрагента (внешний ключ на справочник ref_counterparty_role)';
COMMENT ON COLUMN core.reinsurance_counterparty.reinsurance_counterparty_role IS 'Код роли контрагента';
COMMENT ON COLUMN core.reinsurance_counterparty.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.reinsurance_counterparty.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.reinsurance_counterparty.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.reinsurance_counterparty.key_id IS 'Уникальный ключ';
CREATE TABLE core.reinsurance_declared_return (reinsurance_declared_return_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), reinsurance_condition_id CHARACTER VARYING(50), accrual_date TIMESTAMP(6) WITHOUT TIME ZONE, return_amt NUMERIC(36,2), return_cur_code CHARACTER VARYING(7), base_document_number CHARACTER VARYING(100), expected_payment_date TIMESTAMP(6) WITHOUT TIME ZONE, partner_counterparty_id CHARACTER VARYING(50), _fkey CHARACTER VARYING(50), period_start DATE DEFAULT (CURRENT_DATE - 1) NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, bordereau_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, writeoff_date TIMESTAMP(6) WITHOUT TIME ZONE, writeoff_sum NUMERIC, reinsurance_expense_id CHARACTER VARYING(50), key_id UUID NOT NULL);
COMMENT ON TABLE core.reinsurance_declared_return IS 'Заявленный возврат по договорам перестрахования';
COMMENT ON COLUMN core.reinsurance_declared_return.reinsurance_declared_return_id IS 'Идентификатор заявленного возврата (первичный ключ)';
COMMENT ON COLUMN core.reinsurance_declared_return.contract_id IS 'Идентификатор договора перестрахования (внешний ключ на табл. contract и contract_reinsurance)';
COMMENT ON COLUMN core.reinsurance_declared_return.reinsurance_condition_id IS 'Идентификатор условия договора перестрахования (внешний ключ на табл. reinsurance_condition)';
COMMENT ON COLUMN core.reinsurance_declared_return.accrual_date IS 'Дата начисления';
COMMENT ON COLUMN core.reinsurance_declared_return.return_amt IS 'Сумма заявленного возврата в валюте';
COMMENT ON COLUMN core.reinsurance_declared_return.return_cur_code IS 'Код валюты';
COMMENT ON COLUMN core.reinsurance_declared_return.base_document_number IS 'Номер документа-источника';
COMMENT ON COLUMN core.reinsurance_declared_return.expected_payment_date IS 'Ожидаемая дата оплаты';
COMMENT ON COLUMN core.reinsurance_declared_return.partner_counterparty_id IS 'Идентификатор партнера (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.reinsurance_declared_return.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.reinsurance_declared_return.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.reinsurance_declared_return.bordereau_id IS 'ID бордеро (табл. bordereau)';
COMMENT ON COLUMN core.reinsurance_declared_return.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.reinsurance_declared_return.writeoff_date IS 'Дата списания задолженности New';
COMMENT ON COLUMN core.reinsurance_declared_return.writeoff_sum IS 'Списано задолженность в валюте, Вал. New';
COMMENT ON COLUMN core.reinsurance_declared_return.reinsurance_expense_id IS 'Связанное Обязательство New';
COMMENT ON COLUMN core.reinsurance_declared_return.key_id IS 'Уникальный ключ';
CREATE TABLE core.reinsurance_expense (reinsurance_expense_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), reinsurance_condition_id CHARACTER VARYING(50), partner_counterparty_id CHARACTER VARYING(50), accrual_date TIMESTAMP(6) WITHOUT TIME ZONE, is_accepted INTEGER, operation_code CHARACTER VARYING(40), operation_name CHARACTER VARYING(1024), currency_code CHARACTER VARYING(7), plan_payment_date TIMESTAMP(6) WITHOUT TIME ZONE, plan_payment_amt NUMERIC(36,2), currency_rate NUMERIC(36,8), plan_payment_rub NUMERIC(36,2), payment_amt NUMERIC(36,2), payment_date TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, reinsurance_transaction_id CHARACTER VARYING(50), business_line_id CHARACTER VARYING(50), reinsurance_type_id CHARACTER VARYING(50), storno_amt NUMERIC(36,2), storno_date DATE, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, registry_name CHARACTER VARYING(50), key_id UUID NOT NULL);
COMMENT ON TABLE core.reinsurance_expense IS 'Дополнительные расходы по договорам перестрахования';
COMMENT ON COLUMN core.reinsurance_expense.reinsurance_expense_id IS 'Идентификатор расхода';
COMMENT ON COLUMN core.reinsurance_expense.contract_id IS 'Идентификатор договора (внешний ключ на табл. contract)';
COMMENT ON COLUMN core.reinsurance_expense.reinsurance_condition_id IS 'Идентификатор условия перестрахования (внешний ключ на табл. reinsurance_condition)';
COMMENT ON COLUMN core.reinsurance_expense.partner_counterparty_id IS 'Идентификатор партнера (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.reinsurance_expense.accrual_date IS 'Дата начисления';
COMMENT ON COLUMN core.reinsurance_expense.is_accepted IS 'Принят к учету';
COMMENT ON COLUMN core.reinsurance_expense.operation_code IS 'Операция - Код';
COMMENT ON COLUMN core.reinsurance_expense.operation_name IS 'Операция - Наименование';
COMMENT ON COLUMN core.reinsurance_expense.currency_code IS 'Код Валюты';
COMMENT ON COLUMN core.reinsurance_expense.plan_payment_date IS 'Дата оплаты, план';
COMMENT ON COLUMN core.reinsurance_expense.plan_payment_amt IS 'Сумма к оплате, план';
COMMENT ON COLUMN core.reinsurance_expense.currency_rate IS 'Курс валюты';
COMMENT ON COLUMN core.reinsurance_expense.plan_payment_rub IS 'Сумма к оплате в рублях, план';
COMMENT ON COLUMN core.reinsurance_expense.payment_amt IS 'Сумма к оплате, факт оплачено';
COMMENT ON COLUMN core.reinsurance_expense.payment_date IS 'Дата фактической оплаты';
COMMENT ON COLUMN core.reinsurance_expense.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.reinsurance_expense.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.reinsurance_expense.reinsurance_transaction_id IS 'Идентификатор транзакции (операции) (внешний ключ на табл. reinsurance_transaction)';
COMMENT ON COLUMN core.reinsurance_expense.business_line_id IS 'Идентификатор линии бизнеса (выход на справочник core.ref_business_line)';
COMMENT ON COLUMN core.reinsurance_expense.reinsurance_type_id IS 'Идентификатор вида перестрахования (выход на справочник core.ref_reinsurance_type)';
COMMENT ON COLUMN core.reinsurance_expense.storno_amt IS 'Сумма сторно в валюте';
COMMENT ON COLUMN core.reinsurance_expense.storno_date IS 'Дата сторно';
COMMENT ON COLUMN core.reinsurance_expense.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.reinsurance_expense.registry_name IS 'Регистр учета - источник данных - из каких журналов КИАС тянутся данные';
COMMENT ON COLUMN core.reinsurance_expense.key_id IS 'Уникальный ключ';
CREATE TABLE core.reinsurance_paid_return (reinsurance_paid_return_id CHARACTER VARYING(50) NOT NULL, reinsurance_declared_return_id CHARACTER VARYING(50), contract_id CHARACTER VARYING(50), reinsurance_condition_id CHARACTER VARYING(50), payment_date TIMESTAMP(6) WITHOUT TIME ZONE, payment_amt NUMERIC(36,2), payment_cur_code CHARACTER VARYING(7), payment_type CHARACTER VARYING(100), _fkey CHARACTER VARYING(50), period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.reinsurance_paid_return IS 'Выплаченный возврат по договорам перестрахования';
COMMENT ON COLUMN core.reinsurance_paid_return.reinsurance_paid_return_id IS 'Идентификатор выплаченного возврата (первичный ключ)';
COMMENT ON COLUMN core.reinsurance_paid_return.reinsurance_declared_return_id IS 'Идентификатор заявленного возврата (внешний ключ на табл. reinsurance_declared_return)';
COMMENT ON COLUMN core.reinsurance_paid_return.contract_id IS 'Идентификатор договора перестрахования (внешний ключ на табл. contract и contract_reinsurance)';
COMMENT ON COLUMN core.reinsurance_paid_return.reinsurance_condition_id IS 'Идентификатор условия договора перестрахования (внешний ключ на табл. reinsurance_condition)';
COMMENT ON COLUMN core.reinsurance_paid_return.payment_date IS 'Дата оплаты / Дата зачета встречных требований';
COMMENT ON COLUMN core.reinsurance_paid_return.payment_amt IS 'Сумма оплаченная в валюте / Сумма зачтенных встречных требований в валюте';
COMMENT ON COLUMN core.reinsurance_paid_return.payment_cur_code IS 'Код валюты';
COMMENT ON COLUMN core.reinsurance_paid_return.payment_type IS 'Тип выплаты';
COMMENT ON COLUMN core.reinsurance_paid_return.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.reinsurance_paid_return.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.reinsurance_paid_return.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.reinsurance_paid_return.key_id IS 'Уникальный ключ';
CREATE TABLE core.reinsurance_transaction (reinsurance_transaction_id CHARACTER VARYING(50) NOT NULL, contract_id CHARACTER VARYING(50), transaction_code CHARACTER VARYING(40), transaction_name CHARACTER VARYING(1024), value_date TIMESTAMP(6) WITHOUT TIME ZONE, value_amt NUMERIC(36,2), value_cur CHARACTER VARYING(7), value_rub NUMERIC(36,2), operation_code CHARACTER VARYING(40), operation_name CHARACTER VARYING(1024), payment_document_number CHARACTER VARYING(100), accounting_entry NUMERIC(36,0), payment_schedule_id CHARACTER VARYING(50), reinsurance_declared_return_id CHARACTER VARYING(50), claim_id CHARACTER VARYING(50), reinsurance_expense_id CHARACTER VARYING(50), partner_counterparty_id CHARACTER VARYING(50), _fkey CHARACTER VARYING(50), period_start DATE DEFAULT CURRENT_DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, reinsurance_type_code CHARACTER VARYING(40), reinsurance_type_name CHARACTER VARYING(1024), business_line_code CHARACTER VARYING(40), business_line_name CHARACTER VARYING(1024), insurance_type_code CHARACTER VARYING(40), insurance_type_name CHARACTER VARYING(1024), bordereau_id CHARACTER VARYING(50), paper_id CHARACTER VARYING(50), value_date_ifrs17 TIMESTAMP(6) WITHOUT TIME ZONE, accounting_type CHARACTER VARYING(50), fs1c_payment_code CHARACTER VARYING(50), payment_document_date TIMESTAMP(6) WITHOUT TIME ZONE, cash_flow_item_id CHARACTER VARYING(50), broker_counterparty_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.reinsurance_transaction IS 'Транзакции (операции) по договорам перестрахования';
COMMENT ON COLUMN core.reinsurance_transaction.reinsurance_transaction_id IS 'Идентификатор транзакции (операции)';
COMMENT ON COLUMN core.reinsurance_transaction.contract_id IS 'Идентификатор договора (внешний ключ на табл. contract)';
COMMENT ON COLUMN core.reinsurance_transaction.transaction_code IS 'Типовая операция - Код';
COMMENT ON COLUMN core.reinsurance_transaction.transaction_name IS 'Типовая операция - Наименование';
COMMENT ON COLUMN core.reinsurance_transaction.value_date IS 'Дата транзакции МСФО-4';
COMMENT ON COLUMN core.reinsurance_transaction.value_amt IS 'Сумма транзакции';
COMMENT ON COLUMN core.reinsurance_transaction.value_cur IS 'Валюта транзакции';
COMMENT ON COLUMN core.reinsurance_transaction.value_rub IS 'Сумма транзакции в рублях';
COMMENT ON COLUMN core.reinsurance_transaction.operation_code IS 'Страховая операция - Код';
COMMENT ON COLUMN core.reinsurance_transaction.operation_name IS 'Страховая операция - Наименование';
COMMENT ON COLUMN core.reinsurance_transaction.payment_document_number IS 'Платежный документ';
COMMENT ON COLUMN core.reinsurance_transaction.accounting_entry IS 'Проводка по Типовой операции';
COMMENT ON COLUMN core.reinsurance_transaction.payment_schedule_id IS 'Идентификатор графика платежей (внешний ключ на табл. payment_schedule)';
COMMENT ON COLUMN core.reinsurance_transaction.reinsurance_declared_return_id IS 'Идентификатор возврата (внешний ключ на табл. reinsurance_declared_return)';
COMMENT ON COLUMN core.reinsurance_transaction.claim_id IS 'Идентификатор убытка (внешний ключ на табл. claim)';
COMMENT ON COLUMN core.reinsurance_transaction.reinsurance_expense_id IS 'Идентификатор дополнительных затрат (внешний ключ на табл. reinsurance_expense)';
COMMENT ON COLUMN core.reinsurance_transaction.partner_counterparty_id IS 'Идентификатор партнера (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.reinsurance_transaction.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.reinsurance_transaction.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.reinsurance_transaction.reinsurance_type_code IS 'Тип перестрахования - Код';
COMMENT ON COLUMN core.reinsurance_transaction.reinsurance_type_name IS 'Тип перестрахования - Наименование';
COMMENT ON COLUMN core.reinsurance_transaction.business_line_code IS 'Линия бизнеса - Код';
COMMENT ON COLUMN core.reinsurance_transaction.business_line_name IS 'Линия бизнеса - Наименование';
COMMENT ON COLUMN core.reinsurance_transaction.insurance_type_code IS 'Тип страхования - Код';
COMMENT ON COLUMN core.reinsurance_transaction.insurance_type_name IS 'Тип страхования - Наименование';
COMMENT ON COLUMN core.reinsurance_transaction.bordereau_id IS 'ID бордеро (табл. bordereau)';
COMMENT ON COLUMN core.reinsurance_transaction.paper_id IS 'ID акта взаиморасчетов (табл. paper)';
COMMENT ON COLUMN core.reinsurance_transaction.value_date_ifrs17 IS 'Дата транзакции МСФО-17';
COMMENT ON COLUMN core.reinsurance_transaction.accounting_type IS 'Вид учета';
COMMENT ON COLUMN core.reinsurance_transaction.fs1c_payment_code IS 'Идентификатор платежа FIN1C';
COMMENT ON COLUMN core.reinsurance_transaction.payment_document_date IS 'Дата платежа (без компоненты времени)';
COMMENT ON COLUMN core.reinsurance_transaction.cash_flow_item_id IS 'Ссылка на справочник "Статья движения денежных средств" (Бух. Учет)';
COMMENT ON COLUMN core.reinsurance_transaction.broker_counterparty_id IS 'Идентификатор контрагента ПП (брокера) (выход на табл. counterparty)';
COMMENT ON COLUMN core.reinsurance_transaction.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.reinsurance_transaction.key_id IS 'Уникальный ключ';
CREATE TABLE core.relation (rgs_id_1 CHARACTER VARYING(50) NOT NULL, rgs_id_2 CHARACTER VARYING(50) NOT NULL, relation_type_id INTEGER NOT NULL, counterparty_type CHARACTER VARYING(50) NOT NULL, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.relation IS 'Связи';
COMMENT ON COLUMN core.relation.rgs_id_1 IS 'РГС 1';
COMMENT ON COLUMN core.relation.rgs_id_2 IS 'РГС 2';
COMMENT ON COLUMN core.relation.relation_type_id IS 'Тип связи';
COMMENT ON COLUMN core.relation.counterparty_type IS 'Тип контрагента';
COMMENT ON COLUMN core.relation.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.relation.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.relation.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.relation.key_id IS 'Уникальный ключ';
CREATE TABLE core.remuneration_map_tab_1 (id SERIAL NOT NULL, nn INTEGER, remuneration_paid CHARACTER VARYING(32), remuneration_progn CHARACTER VARYING(32), remuneration_name CHARACTER VARYING(1024), vdat TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.remuneration_map_tab_1 IS 'Справочник маппинга кодов КВ';
COMMENT ON COLUMN core.remuneration_map_tab_1.id IS 'Идентификатор';
COMMENT ON COLUMN core.remuneration_map_tab_1.nn IS 'Номер п/п';
COMMENT ON COLUMN core.remuneration_map_tab_1.remuneration_paid IS 'Код КВ выплаченного';
COMMENT ON COLUMN core.remuneration_map_tab_1.remuneration_progn IS 'Код КВ прогнозного';
COMMENT ON COLUMN core.remuneration_map_tab_1.remuneration_name IS 'Описание КВ';
COMMENT ON COLUMN core.remuneration_map_tab_1.vdat IS 'Дата загрузки';
COMMENT ON COLUMN core.remuneration_map_tab_1.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.role (role_id CHARACTER VARYING(50) NOT NULL, name CHARACTER VARYING(512), period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.role IS 'Роль контрагента в системе';
COMMENT ON COLUMN core.role.role_id IS 'Идентификатор роли';
COMMENT ON COLUMN core.role.name IS 'Наименование роли';
COMMENT ON COLUMN core.role.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.role.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.role.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.role.key_id IS 'Уникальный ключ';
CREATE TABLE core.sale_channel_162 (sale_channel_162_code CHARACTER VARYING(2), sale_channel_162_name CHARACTER VARYING(106), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.sale_channel_162 IS 'Справочник каналов продаж по форме 162';
COMMENT ON COLUMN core.sale_channel_162.sale_channel_162_code IS 'Код';
COMMENT ON COLUMN core.sale_channel_162.sale_channel_162_name IS 'Наименование';
COMMENT ON COLUMN core.sale_channel_162.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.sale_channel_162_agent_link (agent_id CHARACTER VARYING(50) NOT NULL, sale_channel_162_code CHARACTER VARYING(10), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.sale_channel_162_agent_link IS 'Связи агента с каналом продаж по форме 162';
COMMENT ON COLUMN core.sale_channel_162_agent_link.agent_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.sale_channel_162_agent_link.sale_channel_162_code IS 'Код канала продаж по форме 162';
COMMENT ON COLUMN core.sale_channel_162_agent_link.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.sale_channel_type (scc_id NUMERIC(38,0) NOT NULL, sale_channel_type_id CHARACTER VARYING(7) NOT NULL, parent_scc_id NUMERIC(38,0), sale_channel_type_name CHARACTER VARYING(150), start_date DATE, end_date DATE, referable NUMERIC(1,0), reserves NUMERIC(1,0), sale_channel_grmk_scc_id NUMERIC(38,0), period_start DATE DEFAULT '1990-01-01'::date, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.sale_channel_type IS 'Справочник Каналы продаж 2008 (СКК 7.4.11)';
COMMENT ON COLUMN core.sale_channel_type.scc_id IS 'Идентификатор';
COMMENT ON COLUMN core.sale_channel_type.sale_channel_type_id IS 'Код канала продаж';
COMMENT ON COLUMN core.sale_channel_type.parent_scc_id IS 'Идентификатор родителя';
COMMENT ON COLUMN core.sale_channel_type.sale_channel_type_name IS 'Наименование канала продаж';
COMMENT ON COLUMN core.sale_channel_type.start_date IS 'Дата начала действия';
COMMENT ON COLUMN core.sale_channel_type.end_date IS 'Дата окончания действия';
COMMENT ON COLUMN core.sale_channel_type.referable IS 'Используется для ввода';
COMMENT ON COLUMN core.sale_channel_type.reserves IS 'Учитывать в резервах';
COMMENT ON COLUMN core.sale_channel_type.sale_channel_grmk_scc_id IS 'Идентификатор группы малого канала продаж';
COMMENT ON COLUMN core.sale_channel_type.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.sale_channel_type.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.sale_channel_type.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.segment (segment_id CHARACTER VARYING(100) NOT NULL, contract_id CHARACTER VARYING(50), payment_id CHARACTER VARYING(50), segment_code CHARACTER VARYING(50), is_agent_protect NUMERIC(1,0), counterparty_id CHARACTER VARYING(50), period_start DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.segment IS 'Сегментация ОСАГО';
COMMENT ON COLUMN core.segment.segment_id IS 'Идентификатор сегмента';
COMMENT ON COLUMN core.segment.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.segment.payment_id IS 'Идентификатор платежа';
COMMENT ON COLUMN core.segment.segment_code IS 'Код сегмента';
COMMENT ON COLUMN core.segment.is_agent_protect IS 'Признак защищённости (1 - Да; 0, null - нет)';
COMMENT ON COLUMN core.segment.counterparty_id IS 'Идентификатор агента';
COMMENT ON COLUMN core.segment.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.segment.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.segment.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.segment.key_id IS 'Уникальный ключ';
CREATE TABLE core.source_user (source_user_id CHARACTER VARYING(50) NOT NULL, last_name CHARACTER VARYING(500), first_name CHARACTER VARYING(500), middle_name CHARACTER VARYING(500), name CHARACTER VARYING(2000), login CHARACTER VARYING(500), source_system_code CHARACTER VARYING(50) NOT NULL, period_start DATE NOT NULL, period_end DATE DEFAULT '9999-12-31'::date NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.source_user IS 'Пользователи систем';
COMMENT ON COLUMN core.source_user.source_user_id IS 'Идентификатор пользователя';
COMMENT ON COLUMN core.source_user.last_name IS 'Фамилия';
COMMENT ON COLUMN core.source_user.first_name IS 'Имя';
COMMENT ON COLUMN core.source_user.middle_name IS 'Отчество';
COMMENT ON COLUMN core.source_user.name IS 'Полное имя';
COMMENT ON COLUMN core.source_user.login IS 'Имя пользователя в системе авторизации';
COMMENT ON COLUMN core.source_user.source_system_code IS 'Код системы пользователя';
COMMENT ON COLUMN core.source_user.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.source_user.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.source_user.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.source_user.key_id IS 'Уникальный ключ';
CREATE TABLE core.strict_blank (strict_blank_id CHARACTER VARYING(50) NOT NULL, strict_blank_series CHARACTER VARYING(10), strict_blank_number CHARACTER VARYING(40), type_code CHARACTER VARYING(40), type_name CHARACTER VARYING(1024), series_code TEXT, series_start_date TIMESTAMP(6) WITHOUT TIME ZONE, series_end_date TIMESTAMP(6) WITHOUT TIME ZONE, status_code CHARACTER VARYING(7), tech_status_name CHARACTER VARYING(1024), return_before_date TIMESTAMP(6) WITHOUT TIME ZONE, strict_blank_hist_id CHARACTER VARYING(50), sale_channel_type_id CHARACTER VARYING(40), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, status_name CHARACTER VARYING(256), tech_status_code CHARACTER VARYING(80), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL, department_code CHARACTER VARYING(50), lnr_code CHARACTER VARYING(50));
COMMENT ON TABLE core.strict_blank IS 'Бланки строгой отчетности';
COMMENT ON COLUMN core.strict_blank.strict_blank_id IS 'ID БСО (первичный ключ)';
COMMENT ON COLUMN core.strict_blank.strict_blank_series IS 'Серия БСО';
COMMENT ON COLUMN core.strict_blank.strict_blank_number IS 'Номер БСО';
COMMENT ON COLUMN core.strict_blank.type_code IS 'Код типа БСО';
COMMENT ON COLUMN core.strict_blank.type_name IS 'Наименование типа БСО';
COMMENT ON COLUMN core.strict_blank.series_code IS 'Код серии БСО';
COMMENT ON COLUMN core.strict_blank.series_start_date IS 'Дата начала действия серии';
COMMENT ON COLUMN core.strict_blank.series_end_date IS 'Дата окончания действия серии';
COMMENT ON COLUMN core.strict_blank.status_code IS 'Код статуса БСО (по СКК 7.5.41 Справочник Статусы БСО)';
COMMENT ON COLUMN core.strict_blank.tech_status_name IS 'Наименование технологического статуса БСО';
COMMENT ON COLUMN core.strict_blank.return_before_date IS 'Регламентированная дата (нахождения БСО на руках у агента)';
COMMENT ON COLUMN core.strict_blank.strict_blank_hist_id IS 'ID текущего состояния БСО (внешний ключ на табл. strict_blank_hist)';
COMMENT ON COLUMN core.strict_blank.sale_channel_type_id IS 'Код канала продаж (внешний ключ на табл. sale_channel_type - СКК 7.4.11 Справочник Каналы продаж 2008)';
COMMENT ON COLUMN core.strict_blank.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.strict_blank.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.strict_blank.status_name IS 'Наименование статуса БСО (по СКК 7.5.41 Справочник Статусы БСО)';
COMMENT ON COLUMN core.strict_blank.tech_status_code IS 'Код технологического статуса БСО';
COMMENT ON COLUMN core.strict_blank.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.strict_blank.key_id IS 'Уникальный ключ';
COMMENT ON COLUMN core.strict_blank.department_code IS 'Код подразделения СКК бланка строгой отчетности';
COMMENT ON COLUMN core.strict_blank.lnr_code IS 'ЛНР код сотрудника, составившего бланк строгой отчетности';
CREATE TABLE core.strict_blank_abort (strict_blank_abort_id CHARACTER VARYING(50) NOT NULL, type_name CHARACTER VARYING(1024), abort_date DATE, counterparty_id CHARACTER VARYING(50), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, type_code CHARACTER VARYING(80), paper_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.strict_blank_abort IS 'Запреты БСО';
COMMENT ON COLUMN core.strict_blank_abort.strict_blank_abort_id IS 'ID запрета БСО (первичный ключ)';
COMMENT ON COLUMN core.strict_blank_abort.type_name IS 'Наименование запрета';
COMMENT ON COLUMN core.strict_blank_abort.abort_date IS 'Дата запрета';
COMMENT ON COLUMN core.strict_blank_abort.counterparty_id IS 'ID контрагента (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.strict_blank_abort.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.strict_blank_abort.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.strict_blank_abort.type_code IS 'Код запрета';
COMMENT ON COLUMN core.strict_blank_abort.paper_id IS 'ID запрета БСО /ID документа (внешний ключ на табл. core.paper)';
COMMENT ON COLUMN core.strict_blank_abort.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.strict_blank_abort.key_id IS 'Уникальный ключ';
CREATE TABLE core.strict_blank_hist (strict_blank_hist_id CHARACTER VARYING(50) NOT NULL, strict_blank_id CHARACTER VARYING(50), counterparty_id CHARACTER VARYING(50), paper_id CHARACTER VARYING(50), status_code CHARACTER VARYING(80), status_name CHARACTER VARYING(1024), effective_start TIMESTAMP(6) WITHOUT TIME ZONE, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, branch_code CHARACTER VARYING(20), is_contract_exist INTEGER, src_created_ts TIMESTAMP(6) WITHOUT TIME ZONE, src_create_counterparty_id CHARACTER VARYING(50), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, parent_strict_blank_hist_id CHARACTER VARYING(50), contract_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.strict_blank_hist IS 'История состояний БСО';
COMMENT ON COLUMN core.strict_blank_hist.strict_blank_hist_id IS 'ID состояния БСО (первичный ключ)';
COMMENT ON COLUMN core.strict_blank_hist.strict_blank_id IS 'ID БСО (внешний ключ на табл. strict_blank)';
COMMENT ON COLUMN core.strict_blank_hist.counterparty_id IS 'ID контрагента/ владельца БСО (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.strict_blank_hist.paper_id IS 'ID документа учета БСО (внешний ключ на табл. paper)';
COMMENT ON COLUMN core.strict_blank_hist.status_code IS 'Код статуса БСО';
COMMENT ON COLUMN core.strict_blank_hist.status_name IS 'Наименование статус БСО';
COMMENT ON COLUMN core.strict_blank_hist.effective_start IS 'Дата начала действия состояния БСО';
COMMENT ON COLUMN core.strict_blank_hist.effective_end IS 'Дата окончания действия состояния БСО';
COMMENT ON COLUMN core.strict_blank_hist.branch_code IS 'Код подразделения (ссылка на поле branch_code табл. branches)';
COMMENT ON COLUMN core.strict_blank_hist.is_contract_exist IS 'Признак наличия договора: 1 - Да, 0 - Нет';
COMMENT ON COLUMN core.strict_blank_hist.src_created_ts IS 'Дата и время создания записи';
COMMENT ON COLUMN core.strict_blank_hist.src_create_counterparty_id IS 'ID автора создания записи (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.strict_blank_hist.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.strict_blank_hist.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.strict_blank_hist.parent_strict_blank_hist_id IS 'ID родительского состояния БСО';
COMMENT ON COLUMN core.strict_blank_hist.contract_id IS 'ID договора (внешний ключ на табл. contract)';
COMMENT ON COLUMN core.strict_blank_hist.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.strict_blank_hist.key_id IS 'Уникальный ключ';
CREATE TABLE core.strict_blank_limit (strict_blank_limit_id CHARACTER VARYING(50) NOT NULL, counterparty_id CHARACTER VARYING(50), quantity NUMERIC, effective_start TIMESTAMP(6) WITHOUT TIME ZONE, effective_end TIMESTAMP(6) WITHOUT TIME ZONE, strict_blank_type_code CHARACTER VARYING(40), strict_blank_type_name CHARACTER VARYING(1024), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, type_name CHARACTER VARYING(25), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.strict_blank_limit IS 'Лимиты БСО';
COMMENT ON COLUMN core.strict_blank_limit.strict_blank_limit_id IS 'ID лимита (первичный ключ)';
COMMENT ON COLUMN core.strict_blank_limit.counterparty_id IS 'ID контрагента (внешний ключ на табл. counterparty)';
COMMENT ON COLUMN core.strict_blank_limit.quantity IS 'Лимит';
COMMENT ON COLUMN core.strict_blank_limit.effective_start IS 'Дата начала периода лимита';
COMMENT ON COLUMN core.strict_blank_limit.effective_end IS 'Дата окончания периода лимита';
COMMENT ON COLUMN core.strict_blank_limit.strict_blank_type_code IS 'Код типа БСО';
COMMENT ON COLUMN core.strict_blank_limit.strict_blank_type_name IS 'Наименование типа БСО';
COMMENT ON COLUMN core.strict_blank_limit.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.strict_blank_limit.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.strict_blank_limit.type_name IS 'Наименование типа лимита';
COMMENT ON COLUMN core.strict_blank_limit.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.strict_blank_limit.key_id IS 'Уникальный ключ';
CREATE TABLE core.strict_blank_paper (strict_blank_paper_id CHARACTER VARYING(50) NOT NULL, strict_blank_id CHARACTER VARYING(50), paper_id CHARACTER VARYING(50), strict_blank_paper_type_id CHARACTER VARYING(50), period_start TIMESTAMP(6) WITHOUT TIME ZONE, period_end TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.strict_blank_paper IS 'Связь бланка строгой отчетности с документами хоз. деятельности';
COMMENT ON COLUMN core.strict_blank_paper.strict_blank_paper_id IS 'Идентификатор связи бланка строгой отчетности с документом хоз. деятельности';
COMMENT ON COLUMN core.strict_blank_paper.strict_blank_id IS 'Идентификатор бланка строгой отчетности (ссылка на таблицу core.strict_blank)';
COMMENT ON COLUMN core.strict_blank_paper.paper_id IS 'Идентификатор документа хоз. деятельности (ссылка на таблицу core.paper)';
COMMENT ON COLUMN core.strict_blank_paper.strict_blank_paper_type_id IS 'Идентификатор типа связи (ссылка на cправочник core.ref_strict_blank_paper_type)';
COMMENT ON COLUMN core.strict_blank_paper.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.strict_blank_paper.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.strict_blank_paper.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.strict_blank_paper.key_id IS 'Уникальный ключ';
CREATE TABLE core.strict_blank_rsa_hist (strict_blank_rsa_hist_id CHARACTER VARYING(50) NOT NULL, strict_blank_id CHARACTER VARYING(50), status_date TIMESTAMP(6) WITHOUT TIME ZONE, status_code CHARACTER VARYING(3), status_name CHARACTER VARYING(50), process_status_name CHARACTER VARYING(4000), process_note CHARACTER VARYING(4000), process_send_text CHARACTER VARYING, process_send_ts TIMESTAMP(6) WITHOUT TIME ZONE, process_reply_text CHARACTER VARYING, process_reply_ts TIMESTAMP(6) WITHOUT TIME ZONE, period_start TIMESTAMP(6) WITHOUT TIME ZONE NOT NULL, period_end TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT '9999-12-31 00:00:00'::timestamp without time zone NOT NULL, process_status_code CHARACTER VARYING(80), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.strict_blank_rsa_hist IS 'История статусов БСО и обмена данными с РСА';
COMMENT ON COLUMN core.strict_blank_rsa_hist.strict_blank_rsa_hist_id IS 'ID (первичный ключ)';
COMMENT ON COLUMN core.strict_blank_rsa_hist.strict_blank_id IS 'ID БСО (внешний ключ на табл. strict_blank)';
COMMENT ON COLUMN core.strict_blank_rsa_hist.status_date IS 'Дата статуса БСО';
COMMENT ON COLUMN core.strict_blank_rsa_hist.status_code IS 'Код статуса БСО';
COMMENT ON COLUMN core.strict_blank_rsa_hist.status_name IS 'Наименование статуса БСО';
COMMENT ON COLUMN core.strict_blank_rsa_hist.process_status_name IS 'Наименование статуса процесса обмена данными с РСА';
COMMENT ON COLUMN core.strict_blank_rsa_hist.process_note IS 'Примечание к процессу обмена данными с РСА';
COMMENT ON COLUMN core.strict_blank_rsa_hist.process_send_text IS 'JSON запроса в РСА';
COMMENT ON COLUMN core.strict_blank_rsa_hist.process_send_ts IS 'Дата/время отправки запроса в РСА';
COMMENT ON COLUMN core.strict_blank_rsa_hist.process_reply_text IS 'JSON ответа из РСА';
COMMENT ON COLUMN core.strict_blank_rsa_hist.process_reply_ts IS 'Дата/время получения ответа из РСА';
COMMENT ON COLUMN core.strict_blank_rsa_hist.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.strict_blank_rsa_hist.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.strict_blank_rsa_hist.process_status_code IS 'Код статуса процесса обмена данными с РСА';
COMMENT ON COLUMN core.strict_blank_rsa_hist.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.strict_blank_rsa_hist.key_id IS 'Уникальный ключ';
CREATE TABLE core.subject_federation (scc_id NUMERIC(38,0), subject_federation_name CHARACTER VARYING(50), subject_federation_code CHARACTER VARYING(2), period_start TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_DATE, period_end TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT '9999-12-31'::date, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.subject_federation.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.subject_federation.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.subject_federation.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.subscription (subscription_id CHARACTER VARYING(32) NOT NULL, subscription_source_id CHARACTER VARYING(64), counterparty_id CHARACTER VARYING(64), contract_id CHARACTER VARYING(50), subscription_type_id CHARACTER VARYING(37), subscription_status_id CHARACTER VARYING(37), business_key CHARACTER VARYING(20), subscription_cause_id CHARACTER VARYING(37), subscription_reason_id CHARACTER VARYING(37), next_offer_ts TIMESTAMP(6) WITHOUT TIME ZONE, next_payment_ts TIMESTAMP(6) WITHOUT TIME ZONE, subscription_created_ts TIMESTAMP(6) WITHOUT TIME ZONE, subscription_updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, status_updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, activated_ts TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.subscription IS 'Подписка';
COMMENT ON COLUMN core.subscription.subscription_id IS 'Идентификатор подписки (тех. поле)';
COMMENT ON COLUMN core.subscription.subscription_source_id IS 'Идентификатор подписки (бизнес-поле)';
COMMENT ON COLUMN core.subscription.counterparty_id IS 'Идентификатор клиента';
COMMENT ON COLUMN core.subscription.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.subscription.subscription_type_id IS 'Тип подписки (сore.ref_subscription_type)';
COMMENT ON COLUMN core.subscription.subscription_status_id IS 'Статус подписки (core.ref_subscription_status)';
COMMENT ON COLUMN core.subscription.business_key IS 'Бизнес ключ (уникальный ключ подписки)';
COMMENT ON COLUMN core.subscription.subscription_cause_id IS 'Причина изменения статуса (core.ref_subscription_cause)';
COMMENT ON COLUMN core.subscription.subscription_reason_id IS 'Обоснование изменения статуса (core.ref_subscription_reason)';
COMMENT ON COLUMN core.subscription.next_offer_ts IS 'Дата/время следующего выставления оферты';
COMMENT ON COLUMN core.subscription.next_payment_ts IS 'Дата/время очередного начала снятия денег';
COMMENT ON COLUMN core.subscription.subscription_created_ts IS 'Дата/время создания подписки';
COMMENT ON COLUMN core.subscription.subscription_updated_ts IS 'Дата/время изменения подписки';
COMMENT ON COLUMN core.subscription.status_updated_ts IS 'Дата/время начала действия статуса';
COMMENT ON COLUMN core.subscription.activated_ts IS 'Дата/время первого подключения подписки';
COMMENT ON COLUMN core.subscription.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.subscription.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.subscription.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.subscription.key_id IS 'Уникальный ключ';
CREATE TABLE core.t_131_139 (contract_id CHARACTER VARYING(50) NOT NULL, sale_channel_type_id CHARACTER VARYING(7), sale_channel_type_id_cor CHARACTER VARYING(7), created_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, modified_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, removed_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, period_start DATE, period_end DATE NOT NULL, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.t_131_139.period_start IS 'Дата начала действия';
COMMENT ON COLUMN core.t_131_139.period_end IS 'Дата окончания действия';
COMMENT ON COLUMN core.t_131_139.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.tr_errorslog (id SERIAL NOT NULL, source CHARACTER VARYING(100) NOT NULL, target CHARACTER VARYING(100) NOT NULL, priod_from TIMESTAMP(6) WITHOUT TIME ZONE, priod_to TIMESTAMP(6) WITHOUT TIME ZONE, id_key CHARACTER VARYING(250), created_timestamp TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP, errorcode CHARACTER VARYING(50), errorfields CHARACTER VARYING(100), errorcount INTEGER, errordiscr TEXT);
CREATE TABLE core.tr_log (id_batch INTEGER, channel_id CHARACTER VARYING(255), transname CHARACTER VARYING(255), status CHARACTER VARYING(15), lines_read BIGINT, lines_written BIGINT, lines_updated BIGINT, lines_input BIGINT, lines_output BIGINT, lines_rejected BIGINT, errors BIGINT, startdate TIMESTAMP(6) WITHOUT TIME ZONE, enddate TIMESTAMP(6) WITHOUT TIME ZONE, logdate TIMESTAMP(6) WITHOUT TIME ZONE, depdate TIMESTAMP(6) WITHOUT TIME ZONE, replaydate TIMESTAMP(6) WITHOUT TIME ZONE, log_field TEXT, log_date TIMESTAMP(6) WITHOUT TIME ZONE, stepname CHARACTER VARYING(255), step_copy SMALLINT);
CREATE TABLE core.tr_perfomance (id_batch INTEGER, seq_nr INTEGER, logdate TIMESTAMP(6) WITHOUT TIME ZONE, transname CHARACTER VARYING(255), stepname CHARACTER VARYING(255), step_copy INTEGER, lines_read BIGINT, lines_written BIGINT, lines_updated BIGINT, lines_input BIGINT, lines_output BIGINT, lines_rejected BIGINT, errors BIGINT, input_buffer_rows BIGINT, output_buffer_rows BIGINT);
CREATE TABLE core.tr_step (id_batch INTEGER, channel_id CHARACTER VARYING(255), log_date TIMESTAMP(6) WITHOUT TIME ZONE, transname CHARACTER VARYING(255), stepname CHARACTER VARYING(255), step_copy SMALLINT, lines_read BIGINT, lines_written BIGINT, lines_updated BIGINT, lines_input BIGINT, lines_output BIGINT, lines_rejected BIGINT, errors BIGINT);
CREATE TABLE core.transaction (transaction_id BIGINT DEFAULT nextval('transaction_back_transaction_id_seq'::regclass) NOT NULL, object_risk_id CHARACTER VARYING(50), transaction_date DATE, value_date DATE, value_amt NUMERIC(38,2), value_cur CHARACTER VARYING(3), value_rub NUMERIC(38,2), accounting_group CHARACTER VARYING(25), accounting_risk CHARACTER VARYING(100), dict7gs CHARACTER VARYING(25), form162 CHARACTER VARYING(254), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), bid CHARACTER VARYING(25), transaction_type NUMERIC(4,0), change_type CHARACTER VARYING(3), change_reason CHARACTER VARYING(100), contract_id CHARACTER VARYING(50), declared_return_id CHARACTER VARYING(50), cancel_storno_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), object_risk_long_id CHARACTER VARYING(50), insert_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, payment_risk_id CHARACTER VARYING(50), commission_risk_id CHARACTER VARYING(250), commission_risk_long_id CHARACTER VARYING(250), is_partner INTEGER, bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), vip_code CHARACTER VARYING(50), counterparty_type INTEGER, sale_channel_type CHARACTER VARYING(100), contract_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, agent_card_id CHARACTER VARYING(50), agent_code CHARACTER VARYING(150), agent_name CHARACTER VARYING(512), agent_type INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.transaction IS 'Транзакции';
COMMENT ON COLUMN core.transaction.transaction_id IS 'Идентификатор транзакции';
COMMENT ON COLUMN core.transaction.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.transaction.transaction_date IS 'Дата транзакции';
COMMENT ON COLUMN core.transaction.value_date IS 'Дата';
COMMENT ON COLUMN core.transaction.value_amt IS 'Сумма транзакция в валюте';
COMMENT ON COLUMN core.transaction.value_cur IS 'Код валюты';
COMMENT ON COLUMN core.transaction.value_rub IS 'Сумма транзакция в рублях';
COMMENT ON COLUMN core.transaction.accounting_group IS 'Код учетной группы после перекодировки';
COMMENT ON COLUMN core.transaction.accounting_risk IS 'Код УВС';
COMMENT ON COLUMN core.transaction.dict7gs IS '7ГС';
COMMENT ON COLUMN core.transaction.form162 IS 'Код вида формы 162';
COMMENT ON COLUMN core.transaction.is_co_insurance IS 'Признак сострахования. 1 – договор сострахования.';
COMMENT ON COLUMN core.transaction.co_insurance_role IS 'Роль в состраховании. 1 – страховщик лидер, 2 – страховщик участник.';
COMMENT ON COLUMN core.transaction.bid IS 'Подразделение, в котором заключен договор';
COMMENT ON COLUMN core.transaction.transaction_type IS 'Тип транзакции';
COMMENT ON COLUMN core.transaction.change_type IS 'Тип изменения: Добавление/Удаление/Модификация';
COMMENT ON COLUMN core.transaction.change_reason IS 'Причина изменения: Изменение условий договора/Исправление ошибки';
COMMENT ON COLUMN core.transaction.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.transaction.declared_return_id IS 'Идентификатор заявленного возврата';
COMMENT ON COLUMN core.transaction.cancel_storno_id IS 'Идентификатор сторнирования по расторжению';
COMMENT ON COLUMN core.transaction.contract_long_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.transaction.object_risk_long_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.transaction.insert_timestamp IS 'Дата и время вставки записи транзакции в ядро, техническое поле';
COMMENT ON COLUMN core.transaction.payment_risk_id IS 'Идентификатор оплаты по риску по объекту';
COMMENT ON COLUMN core.transaction.commission_risk_id IS 'Идентификатор прогнозного КВ';
COMMENT ON COLUMN core.transaction.commission_risk_long_id IS 'Идентификатор прогнозного КВ';
COMMENT ON COLUMN core.transaction.is_partner IS 'Признак партнера';
COMMENT ON COLUMN core.transaction.bank IS 'Банк';
COMMENT ON COLUMN core.transaction.leasing_company IS 'Лизинговая компания';
COMMENT ON COLUMN core.transaction.auto_dealer IS 'Автодилер';
COMMENT ON COLUMN core.transaction.other_partner IS 'Прочий партнер';
COMMENT ON COLUMN core.transaction.vip_code IS 'Код ключевого контрагента';
COMMENT ON COLUMN core.transaction.counterparty_type IS 'Тип контрагента';
COMMENT ON COLUMN core.transaction.sale_channel_type IS 'Тип канала продаж в договоре';
COMMENT ON COLUMN core.transaction.contract_date IS 'Дата заключения договора';
COMMENT ON COLUMN core.transaction.liability_start_date IS 'Дата начала ответственности по договору';
COMMENT ON COLUMN core.transaction.liability_end_date IS 'Дата окончания ответственности по договору';
COMMENT ON COLUMN core.transaction.agent_card_id IS 'Идентификатор агента в системе Босс-Кадровик';
COMMENT ON COLUMN core.transaction.agent_code IS 'Личный номер работника (ЛНР агента)';
COMMENT ON COLUMN core.transaction.agent_name IS 'Наименование агента';
COMMENT ON COLUMN core.transaction.agent_type IS 'Тип агента: 1 – Физическое лицо, 2 – Юридическое лицо, 5 – ПБОЮЛ';
COMMENT ON COLUMN core.transaction.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.transaction.key_id IS 'Уникальный ключ';
CREATE TABLE core.transaction6 (transaction_id BIGSERIAL NOT NULL, object_risk_id CHARACTER VARYING(50), transaction_date DATE, value_date DATE, value_amt NUMERIC(38,2), value_cur CHARACTER VARYING(3), value_rub NUMERIC(38,2), accounting_group CHARACTER VARYING(25), accounting_risk CHARACTER VARYING(100), dict7gs CHARACTER VARYING(25), form162 CHARACTER VARYING(254), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), bid CHARACTER VARYING(25), transaction_type NUMERIC(4,0), change_type CHARACTER VARYING(3), change_reason CHARACTER VARYING(100), contract_id CHARACTER VARYING(50), declared_return_id CHARACTER VARYING(50), cancel_storno_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), object_risk_long_id CHARACTER VARYING(50), insert_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, payment_risk_id CHARACTER VARYING(50), is_partner INTEGER, bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), vip_code CHARACTER VARYING(50), counterparty_type INTEGER, sale_channel_type CHARACTER VARYING(100), contract_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, agent_card_id CHARACTER VARYING(50), agent_code CHARACTER VARYING(150), agent_name CHARACTER VARYING(512), agent_type INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.transaction6 IS 'Транзакции тип 6';
COMMENT ON COLUMN core.transaction6.transaction_id IS 'Идентификатор транзакции';
COMMENT ON COLUMN core.transaction6.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.transaction6.transaction_date IS 'Дата транзакции';
COMMENT ON COLUMN core.transaction6.value_date IS 'Дата';
COMMENT ON COLUMN core.transaction6.value_amt IS 'Сумма транзакция в валюте';
COMMENT ON COLUMN core.transaction6.value_cur IS 'Код валюты';
COMMENT ON COLUMN core.transaction6.value_rub IS 'Сумма транзакция в рублях';
COMMENT ON COLUMN core.transaction6.accounting_group IS 'Код учетной группы после перекодировки';
COMMENT ON COLUMN core.transaction6.accounting_risk IS 'Код УВС';
COMMENT ON COLUMN core.transaction6.dict7gs IS '7ГС';
COMMENT ON COLUMN core.transaction6.form162 IS 'Код вида формы 162';
COMMENT ON COLUMN core.transaction6.is_co_insurance IS 'Признак сострахования. 1 – договор сострахования.';
COMMENT ON COLUMN core.transaction6.co_insurance_role IS 'Роль в состраховании. 1 – страховщик лидер, 2 – страховщик участник.';
COMMENT ON COLUMN core.transaction6.bid IS 'Подразделение, в котором заключен договор';
COMMENT ON COLUMN core.transaction6.transaction_type IS 'Тип транзакции';
COMMENT ON COLUMN core.transaction6.change_type IS 'Тип изменения: Добавление/Удаление/Модификация';
COMMENT ON COLUMN core.transaction6.change_reason IS 'Причина изменения: Изменение условий договора/Исправление ошибки';
COMMENT ON COLUMN core.transaction6.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.transaction6.declared_return_id IS 'Идентификатор заявленного возврата';
COMMENT ON COLUMN core.transaction6.cancel_storno_id IS 'Идентификатор сторнирования по расторжению';
COMMENT ON COLUMN core.transaction6.contract_long_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.transaction6.object_risk_long_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.transaction6.insert_timestamp IS 'Дата и время вставки записи транзакции в ядро, техническое поле';
COMMENT ON COLUMN core.transaction6.payment_risk_id IS 'Идентификатор оплаты по риску по объекту';
COMMENT ON COLUMN core.transaction6.is_partner IS 'Признак партнера';
COMMENT ON COLUMN core.transaction6.bank IS 'Банк';
COMMENT ON COLUMN core.transaction6.leasing_company IS 'Лизинговая компания';
COMMENT ON COLUMN core.transaction6.auto_dealer IS 'Автодилер';
COMMENT ON COLUMN core.transaction6.other_partner IS 'Прочий партнер';
COMMENT ON COLUMN core.transaction6.counterparty_type IS 'Тип контрагента';
COMMENT ON COLUMN core.transaction6.sale_channel_type IS 'Тип канала продаж в договоре';
COMMENT ON COLUMN core.transaction6.contract_date IS 'Дата заключения договора';
COMMENT ON COLUMN core.transaction6.liability_start_date IS 'Дата начала ответственности по договору';
COMMENT ON COLUMN core.transaction6.liability_end_date IS 'Дата окончания ответственности по договору';
COMMENT ON COLUMN core.transaction6.agent_card_id IS 'Идентификатор агента в системе Босс-Кадровик';
COMMENT ON COLUMN core.transaction6.agent_code IS 'Личный номер работника (ЛНР агента)';
COMMENT ON COLUMN core.transaction6.agent_name IS 'Наименование агента';
COMMENT ON COLUMN core.transaction6.agent_type IS 'Тип агента: 1 – Физическое лицо, 2 – Юридическое лицо, 5 – ПБОЮЛ';
COMMENT ON COLUMN core.transaction6.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.transaction6.key_id IS 'Уникальный ключ';
CREATE TABLE core.transaction_audit (transaction_id BIGSERIAL NOT NULL, object_risk_id CHARACTER VARYING(50), transaction_date DATE, value_date DATE, value_amt NUMERIC(38,2), value_cur CHARACTER VARYING(3), value_rub NUMERIC(38,2), accounting_group CHARACTER VARYING(25), accounting_risk CHARACTER VARYING(100), dict7gs CHARACTER VARYING(25), form162 CHARACTER VARYING(254), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), bid CHARACTER VARYING(25), transaction_type NUMERIC(4,0), change_type CHARACTER VARYING(3), change_reason CHARACTER VARYING(100), contract_id CHARACTER VARYING(50), declared_return_id CHARACTER VARYING(50), cancel_storno_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), object_risk_long_id CHARACTER VARYING(50), insert_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, payment_risk_id CHARACTER VARYING(50), commission_risk_id CHARACTER VARYING(250), userid CHARACTER VARYING, removed_timestamp TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP, commission_risk_long_id CHARACTER VARYING(250), is_partner INTEGER, bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), vip_code CHARACTER VARYING(50), counterparty_type INTEGER, transaction_old BIGINT, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.transaction_audit.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.transaction_bk (transaction_id BIGINT, object_risk_id CHARACTER VARYING(50), transaction_date DATE, value_date DATE, value_amt NUMERIC(38,2), value_cur CHARACTER VARYING(3), value_rub NUMERIC(38,2), accounting_group CHARACTER VARYING(25), accounting_risk CHARACTER VARYING(100), dict7gs CHARACTER VARYING(25), form162 CHARACTER VARYING(254), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), bid CHARACTER VARYING(25), transaction_type NUMERIC(4,0), change_type CHARACTER VARYING(3), change_reason CHARACTER VARYING(100), contract_id CHARACTER VARYING(50), declared_return_id CHARACTER VARYING(50), cancel_storno_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), object_risk_long_id CHARACTER VARYING(50), insert_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, payment_risk_id CHARACTER VARYING(50), commission_risk_id CHARACTER VARYING(250), commission_risk_long_id CHARACTER VARYING(250), is_partner INTEGER, bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), vip_code CHARACTER VARYING(50), counterparty_type INTEGER, sale_channel_type CHARACTER VARYING(100), contract_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, agent_card_id CHARACTER VARYING(50), agent_code CHARACTER VARYING(150), agent_name CHARACTER VARYING(512), agent_type INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.transaction_bk.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.transaction_hist (transaction_id BIGSERIAL NOT NULL, object_risk_id CHARACTER VARYING(50), transaction_date DATE, value_date DATE, value_amt NUMERIC(38,2), value_cur CHARACTER VARYING(3), value_rub NUMERIC(38,2), accounting_group CHARACTER VARYING(25), accounting_risk CHARACTER VARYING(100), dict7gs CHARACTER VARYING(25), form162 CHARACTER VARYING(254), is_co_insurance NUMERIC(1,0), co_insurance_role NUMERIC(1,0), bid CHARACTER VARYING(25), transaction_type NUMERIC(4,0), change_type CHARACTER VARYING(3), change_reason CHARACTER VARYING(100), contract_id CHARACTER VARYING(50), declared_return_id CHARACTER VARYING(50), cancel_storno_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), object_risk_long_id CHARACTER VARYING(50), insert_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, payment_risk_id CHARACTER VARYING(50), commission_risk_id CHARACTER VARYING(250), commission_risk_long_id CHARACTER VARYING(250), is_partner INTEGER, bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), vip_code CHARACTER VARYING(50), counterparty_type INTEGER, sale_channel_type CHARACTER VARYING(100), contract_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, agent_card_id CHARACTER VARYING(50), agent_code CHARACTER VARYING(150), agent_name CHARACTER VARYING(512), agent_type INTEGER, lagacy_id CHARACTER VARYING(50), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
CREATE TABLE core.transaction_mngr (transaction_id BIGSERIAL NOT NULL, contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), declared_return_id CHARACTER VARYING(50), cancel_storno_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), object_risk_long_id CHARACTER VARYING(50), payment_risk_id CHARACTER VARYING(50), commission_risk_id CHARACTER VARYING(250), transaction_date DATE, value_date DATE, value_amt NUMERIC(38,2), value_cur CHARACTER VARYING(3), value_rub NUMERIC(38,2), dict7gs CHARACTER VARYING(25), sale_channel_type CHARACTER VARYING(100), vip_code CHARACTER VARYING(50), counterparty_type INTEGER, is_partner INTEGER, transaction_type INTEGER, change_reason CHARACTER VARYING(100), insert_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), commission_risk_long_id CHARACTER VARYING(250), contract_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_start_date TIMESTAMP(6) WITHOUT TIME ZONE, liability_end_date TIMESTAMP(6) WITHOUT TIME ZONE, agent_card_id CHARACTER VARYING(50), agent_code CHARACTER VARYING(150), agent_name CHARACTER VARYING(512), agent_type INTEGER, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.transaction_mngr IS 'Транзакции по изменениям управленческих аналитик';
COMMENT ON COLUMN core.transaction_mngr.transaction_id IS 'Идентификатор транзакции';
COMMENT ON COLUMN core.transaction_mngr.contract_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.transaction_mngr.object_risk_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.transaction_mngr.declared_return_id IS 'Идентификатор заявленного возврата';
COMMENT ON COLUMN core.transaction_mngr.cancel_storno_id IS 'Идентификатор сторнирования по расторжению';
COMMENT ON COLUMN core.transaction_mngr.contract_long_id IS 'Идентификатор договора';
COMMENT ON COLUMN core.transaction_mngr.object_risk_long_id IS 'Идентификатор риска по объекту';
COMMENT ON COLUMN core.transaction_mngr.payment_risk_id IS 'Идентификатор оплаты по риску по объекту';
COMMENT ON COLUMN core.transaction_mngr.commission_risk_id IS 'Идентификатор прогнозного КВ/выплаченного КВ';
COMMENT ON COLUMN core.transaction_mngr.transaction_date IS 'Дата транзакции';
COMMENT ON COLUMN core.transaction_mngr.value_date IS 'Дата операции';
COMMENT ON COLUMN core.transaction_mngr.value_amt IS 'Сумма транзакция в валюте';
COMMENT ON COLUMN core.transaction_mngr.value_cur IS 'Код валюты';
COMMENT ON COLUMN core.transaction_mngr.value_rub IS 'Сумма транзакция в рублях';
COMMENT ON COLUMN core.transaction_mngr.dict7gs IS '7ГС';
COMMENT ON COLUMN core.transaction_mngr.sale_channel_type IS 'Тип канала продаж в договоре';
COMMENT ON COLUMN core.transaction_mngr.vip_code IS 'Код ключевого контрагента';
COMMENT ON COLUMN core.transaction_mngr.counterparty_type IS 'Тип контрагента';
COMMENT ON COLUMN core.transaction_mngr.is_partner IS 'Признак партнера';
COMMENT ON COLUMN core.transaction_mngr.transaction_type IS 'Тип транзакции: 1 – Начисленная премия; 2 – Возврат по расторжению; 3 – Возврат; 4 – Сторнирование премии по расторжению; 6 – Оплата страхователя; 61 – Оплата, посредник брокер; 62 – Оплата, посредник не брокер; 11 – Премия по многолетним договорам; 14 – Сторнирование премии по расторжению многолетнего договора; 12 – Возврат при расторжении многолетнего договора; 7 – ПАР, посредник не брокер; 8 – ПАР, посредник брокер; 71 – КАР, посредник не брокер; 81 – КАР, посредник брокер; 15 – ПАР, посредник не брокер; 16 – ПАР, посредник брокер; 151 – КАР, посредник не брокер; 161 – КАР, посредник брокер; 17 - ПАР по многолетним договорам, посредник не брокер; 18 - ПАР по многолетним договорам, посредник брокер..';
COMMENT ON COLUMN core.transaction_mngr.change_reason IS 'Причина изменения: Изменение условий договора/Исправление ошибки';
COMMENT ON COLUMN core.transaction_mngr.bank IS 'Банк';
COMMENT ON COLUMN core.transaction_mngr.leasing_company IS 'Лизинговая компания';
COMMENT ON COLUMN core.transaction_mngr.auto_dealer IS 'Автодилер';
COMMENT ON COLUMN core.transaction_mngr.other_partner IS 'Прочий партнер';
COMMENT ON COLUMN core.transaction_mngr.commission_risk_long_id IS 'Идентификатор прогнозного КВ';
COMMENT ON COLUMN core.transaction_mngr.contract_date IS 'Дата заключения договора';
COMMENT ON COLUMN core.transaction_mngr.liability_start_date IS 'Дата начала ответственности по договору';
COMMENT ON COLUMN core.transaction_mngr.liability_end_date IS 'Дата окончания ответственности по договору';
COMMENT ON COLUMN core.transaction_mngr.agent_card_id IS 'Идентификатор агента в системе Босс-Кадровик';
COMMENT ON COLUMN core.transaction_mngr.agent_code IS 'Личный номер работника (ЛНР агента)';
COMMENT ON COLUMN core.transaction_mngr.agent_name IS 'Наименование агента';
COMMENT ON COLUMN core.transaction_mngr.agent_type IS 'Тип агента: 1 – Физическое лицо, 2 – Юридическое лицо, 5 – ПБОЮЛ';
COMMENT ON COLUMN core.transaction_mngr.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.transaction_mngr.key_id IS 'Уникальный ключ';
CREATE TABLE core.transaction_mngr_audit (transaction_id BIGINT NOT NULL, contract_id CHARACTER VARYING(50), object_risk_id CHARACTER VARYING(50), declared_return_id CHARACTER VARYING(50), cancel_storno_id CHARACTER VARYING(50), contract_long_id CHARACTER VARYING(50), object_risk_long_id CHARACTER VARYING(50), payment_risk_id CHARACTER VARYING(50), commission_risk_id CHARACTER VARYING(250), transaction_date DATE, value_date DATE, value_amt NUMERIC(38,2), value_cur CHARACTER VARYING(3), value_rub NUMERIC(38,2), dict7gs CHARACTER VARYING(25), sale_channel_type CHARACTER VARYING(100), vip_code CHARACTER VARYING(50), counterparty_type INTEGER, is_partner INTEGER, transaction_type INTEGER, change_reason CHARACTER VARYING(100), insert_timestamp TIMESTAMP(6) WITHOUT TIME ZONE, bank CHARACTER VARYING(100), leasing_company CHARACTER VARYING(100), auto_dealer CHARACTER VARYING(100), other_partner CHARACTER VARYING(100), commission_risk_long_id CHARACTER VARYING(250), removed_timestamp TIMESTAMP(6) WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL, userid CHARACTER VARYING, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.transaction_mngr_audit.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.type_ins_form162 (id_section_line CHARACTER VARYING(254), parent_id_section_line CHARACTER VARYING(254), section162 NUMERIC, line NUMERIC, feature_input NUMERIC, short_name CHARACTER VARYING(2000), full_name CHARACTER VARYING(2000), line_in_section1 NUMERIC, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.type_ins_form162.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.uo_mapsale2020 (insuarance_type_code CHARACTER VARYING(50), insuarance_type CHARACTER VARYING(512), insuarance_type_group_id CHARACTER VARYING(50), insuarance_type_group_fp CHARACTER VARYING(512), insuarance_type_fp_makro2020 CHARACTER VARYING(512), insured_type_id CHARACTER VARYING(50), insured_type CHARACTER VARYING(50), sale_channel_type2008_id CHARACTER VARYING(50), sale_channel_type2008_name CHARACTER VARYING(512), sale_channel_groupmk_id_2020 CHARACTER VARYING(50), sale_channel_groupmk_name_2020 CHARACTER VARYING(512), partner_code CHARACTER VARYING(50), is_partner CHARACTER VARYING(50), partner_type_id CHARACTER VARYING(50), partner_type CHARACTER VARYING(512), sale_channel_mk_id CHARACTER VARYING(50), sale_channel_mk_name CHARACTER VARYING(512), sale_channel_groupmk_id CHARACTER VARYING(50), sale_channel_groupmk_name CHARACTER VARYING(512), ins_group CHARACTER VARYING(512), sale_channel_bk_id CHARACTER VARYING(50), sale_channel_bk_name CHARACTER VARYING(512), sale_channel_mk_name_full2020 CHARACTER VARYING(512), bfko CHARACTER VARYING(512), sale_channel_mk_id_2020_hype CHARACTER VARYING(512), sale_channel_mk_name_full2020_hype CHARACTER VARYING(512), sale_channel_bk_uo_id CHARACTER VARYING(50), sale_channel_bk_uo_name CHARACTER VARYING(512), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.uo_mapsale2020.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.uo_name_product (name_product CHARACTER VARYING(40) NOT NULL, serial_product CHARACTER VARYING(10) NOT NULL, id_arm CHARACTER VARYING(40), id_ekis CHARACTER VARYING(20), id_guidewire CHARACTER VARYING(30), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON TABLE core.uo_name_product IS 'Справочник маппинга продуктов';
COMMENT ON COLUMN core.uo_name_product.name_product IS 'Наименование продукта';
COMMENT ON COLUMN core.uo_name_product.serial_product IS 'Серия договора';
COMMENT ON COLUMN core.uo_name_product.id_arm IS 'Код продукта в системе АРМ';
COMMENT ON COLUMN core.uo_name_product.id_ekis IS 'Код продукта в системе ЕКИС';
COMMENT ON COLUMN core.uo_name_product.id_guidewire IS 'Код продукта в системе ГВ';
COMMENT ON COLUMN core.uo_name_product.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.uo_partner_fp2024 (partner_fp_name CHARACTER VARYING, bank_name CHARACTER VARYING, auto_dealer_name CHARACTER VARYING, other_partner_name CHARACTER VARYING, leasing_company_name CHARACTER VARYING, updated_ts TIMESTAMP(6) WITHOUT TIME ZONE);
COMMENT ON COLUMN core.uo_partner_fp2024.updated_ts IS 'Дата и время обновления';
CREATE TABLE core.vehicle (vehicle_id CHARACTER VARYING(50) NOT NULL, vin CHARACTER VARYING(50), is_vin_valid NUMERIC(1,0), engine_number CHARACTER VARYING(50), body_number CHARACTER VARYING(50), chassis_number CHARACTER VARYING(50), construction_date DATE, engine_power_kw NUMERIC, engine_power_hp NUMERIC, vehicle_model_name CHARACTER VARYING(512), vehicle_brand_name CHARACTER VARYING(512), period_start DATE, period_end DATE NOT NULL, hash CHARACTER VARYING(32), vehicle_model_id CHARACTER VARYING(50), vehicle_brand_id CHARACTER VARYING(50), rsa_code CHARACTER VARYING(50), tdkr_id CHARACTER VARYING(50), is_foreign INTEGER, allowable_weight NUMERIC, type CHARACTER VARYING(7), modify_date TIMESTAMP(6) WITHOUT TIME ZONE, rsatransdekrcode CHARACTER VARYING(100), vehicletypecodetransdekr CHARACTER VARYING(2), vehiclecategorytransdekr CHARACTER VARYING(2), rsa_transdekr_brand_id CHARACTER VARYING(20), rsa_transdekr_model_id CHARACTER VARYING(128), unit_measure_engine_power CHARACTER VARYING(10), publicid CHARACTER VARYING(64), engine_volume NUMERIC, is_pts_duplicate INTEGER, color_name CHARACTER VARYING(256), updated_ts TIMESTAMP(6) WITHOUT TIME ZONE, key_id UUID NOT NULL);
COMMENT ON TABLE core.vehicle IS 'Транспортные средства';
COMMENT ON COLUMN core.vehicle.vehicle_id IS 'Идентификатор транспортного средства';
COMMENT ON COLUMN core.vehicle.vin IS 'VIN/PIN (идентификационный номер)';
COMMENT ON COLUMN core.vehicle.is_vin_valid IS 'Распознан ли vin как корректный?';
COMMENT ON COLUMN core.vehicle.engine_number IS 'Номер двигателя';
COMMENT ON COLUMN core.vehicle.body_number IS 'Номер кузова';
COMMENT ON COLUMN core.vehicle.chassis_number IS 'Номер шасси';
COMMENT ON COLUMN core.vehicle.construction_date IS 'Дата выпуска';
COMMENT ON COLUMN core.vehicle.engine_power_kw IS 'Мощность двигателя (кВт)';
COMMENT ON COLUMN core.vehicle.engine_power_hp IS 'Мощность двигателя (л.с.)';
COMMENT ON COLUMN core.vehicle.vehicle_model_name IS 'Название модели';
COMMENT ON COLUMN core.vehicle.vehicle_brand_name IS 'Название марки';
COMMENT ON COLUMN core.vehicle.period_start IS 'Дата начала действия записи';
COMMENT ON COLUMN core.vehicle.period_end IS 'Дата окончания действия записи';
COMMENT ON COLUMN core.vehicle.hash IS 'Хэш';
COMMENT ON COLUMN core.vehicle.vehicle_model_id IS 'Идентификатор модели';
COMMENT ON COLUMN core.vehicle.vehicle_brand_id IS 'Идентификатор марки';
COMMENT ON COLUMN core.vehicle.rsa_code IS 'Код РСА ТС';
COMMENT ON COLUMN core.vehicle.tdkr_id IS 'Идентификатор ТС в Трансдекра (Модификация ТС СКК 5.1.32)';
COMMENT ON COLUMN core.vehicle.is_foreign IS 'Признак марки: 0 – Отечественная; 1 – Иностранная;';
COMMENT ON COLUMN core.vehicle.allowable_weight IS 'Максимально разрешенный вес';
COMMENT ON COLUMN core.vehicle.type IS 'Тип ТС. Соответствует значению поля Код СКК 5.1.1 "Классификатор типов ТС".';
COMMENT ON COLUMN core.vehicle.modify_date IS 'Дата модификации (Дата/время изменения записи)';
COMMENT ON COLUMN core.vehicle.rsatransdekrcode IS 'Код РСА Трансдекра – Модификация ТС (СКК 5.1.32)';
COMMENT ON COLUMN core.vehicle.vehicletypecodetransdekr IS 'Код РСА Трансдекра – Тип ТС (СКК 5.1.26)';
COMMENT ON COLUMN core.vehicle.vehiclecategorytransdekr IS 'Код РСА Трансдекра – Категория ТС (СКК 5.1.27)';
COMMENT ON COLUMN core.vehicle.rsa_transdekr_brand_id IS 'Идентификатор марки ТС (по СКК 5.1.24 Cправочник "РСА Трансдекра - Марка")';
COMMENT ON COLUMN core.vehicle.rsa_transdekr_model_id IS 'Идентификатор модели ТС (по СКК 5.1.25 Cправочник "РСА Трансдекра - Модель")';
COMMENT ON COLUMN core.vehicle.unit_measure_engine_power IS 'Единица измерения мощности двигателя';
COMMENT ON COLUMN core.vehicle.publicid IS 'Внешний ID';
COMMENT ON COLUMN core.vehicle.engine_volume IS 'Объем двигателя ТС';
COMMENT ON COLUMN core.vehicle.is_pts_duplicate IS 'Признак "ПТС Дубликат": 1 – да, 0 – нет, -1 – не определен';
COMMENT ON COLUMN core.vehicle.color_name IS 'Цвет ТС';
COMMENT ON COLUMN core.vehicle.updated_ts IS 'Дата и время обновления';
COMMENT ON COLUMN core.vehicle.key_id IS 'Уникальный ключ';
CREATE VIEW core.cdi_data (rgs_id, cdi_id, counterparty_id, contract_id, role, vip, like_vip, client_info, policy_number, policy_series, contract_series, contract_number, sale_channel_type, contract_start_date, contract_end_date, liability_start_date, liability_end_date, product) AS  SELECT u1.rgs_id,
    u1.cdi_id,
    u1.counterparty_id,
    cc.contract_id,
    cc.contract_counterparty_role AS role,
    gr.group_type AS vip,
    gr2.group_type AS like_vip,
    upper((((((COALESCE(btrim(c.last_name::text), 'NoData'::text) || ' '::text) || COALESCE(btrim(c.first_name::text), 'NoData'::text)) || ' '::text) || COALESCE(btrim(c.middle_name::text), 'NoData'::text)) || ' '::text) || COALESCE(c.birth_date, CURRENT_DATE)) AS client_info,
    cnt.policy_number,
    cnt.policy_series,
    cnt.contract_series,
    cnt.contract_number,
    cnt.sale_channel_type,
    cnt.contract_start_date,
    cnt.contract_end_date,
    cnt.liability_start_date,
    cnt.liability_end_date,
    cnt.product
   FROM core.cdi_counterparty u1
     JOIN core.contract_counterparty cc ON cc.counterparty_id::text = u1.counterparty_id::text AND cc.period_end = '9999-12-31'::date AND cc.is_primary = 1::numeric
     JOIN core.contract cnt ON cnt.contract_id::text = cc.contract_id::text AND cnt.period_end = '9999-12-31'::date AND cnt.is_active = 1::numeric AND cnt.contract_end_date > '2020-01-01'::date
     JOIN core.counterparty c ON c.counterparty_id::text = u1.cdi_id::text AND c.period_end = '9999-12-31'::date
     LEFT JOIN core."group" gr ON gr.counterparty_id::text = u1.cdi_id::text AND gr.period_end = '9999-12-31'::date AND (gr.group_type::text = ANY (ARRAY['VIP_RGS'::character varying::text, 'VIP_TEK'::character varying::text]))
     LEFT JOIN core."group" gr2 ON gr2.counterparty_id::text = u1.cdi_id::text AND gr2.period_end = '9999-12-31'::date AND gr2.group_type::text = 'LIKE_VIP'::text
  WHERE u1.period_end = '9999-12-31'::date AND (u1.counterparty_id::text >= 'ekis|'::text AND u1.counterparty_id::text <= 'ekis|99999999999999999999999'::text OR u1.counterparty_id::text >= 'gwpc|'::text AND u1.counterparty_id::text <= 'gwpc|99999999999999999999999'::text OR u1.counterparty_id::text >= 'arm4'::text AND u1.counterparty_id::text <= 'arm4|ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'::text);
CREATE VIEW core.vw_metrics (object_name, modify_date, selected, new_inserted, new_inserted_errors, updated, update_errors, update_not_need, closed, trn_cretae) AS  SELECT 'Rates CB'::text AS object_name,
    metrics.create_timestamp::date AS modify_date,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'CB rates get'::text THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS selected,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'CB rates Insert'::text THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS new_inserted,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'CB rates Insert'::text THEN metrics."Lines rejected"
            ELSE 0::bigint
        END) AS new_inserted_errors,
    0 AS updated,
    0 AS update_errors,
    0 AS update_not_need,
    0 AS closed,
    0 AS trn_cretae
   FROM core.metrics
  WHERE 1 = 1 AND metrics."Step name" ~~ 'CB rates%'::text
  GROUP BY (metrics.create_timestamp::date)
UNION ALL
 SELECT 'Reason rhange'::text AS object_name,
    metrics.create_timestamp::date AS modify_date,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'Reason Change select'::text THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS selected,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'Reason Change Insert / Update'::text THEN metrics."Lines output"
            ELSE 0::bigint
        END) AS new_inserted,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'Reason Change Errors'::text THEN metrics."Lines rejected"
            ELSE 0::bigint
        END) AS new_inserted_errors,
    0 AS updated,
    0 AS update_errors,
    0 AS update_not_need,
    0 AS closed,
    0 AS trn_cretae
   FROM core.metrics
  WHERE 1 = 1 AND metrics."Step name" ~~ 'Reason Change%'::text
  GROUP BY (metrics.create_timestamp::date)
UNION ALL
 SELECT 'agent_contract'::text AS object_name,
    metrics.create_timestamp::date AS modify_date,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'agent_contract select'::text THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS selected,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'agent_contract insert'::text THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS new_inserted,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'agent_contract insert'::text THEN metrics."Lines rejected"
            ELSE 0::bigint
        END) AS new_inserted_errors,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'agent_contract upd'::text THEN metrics."Lines updated"
            ELSE 0::bigint
        END) AS updated,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'agent_contract upd'::text THEN metrics."Lines updated"
            ELSE 0::bigint
        END) - sum(
        CASE
            WHEN btrim(metrics."Step name") = 'agent_contract insert upd'::text THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS update_errors,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'agent_contract upd'::text THEN metrics."Lines rejected"
            ELSE 0::bigint
        END) AS update_not_need,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'agent_contract close'::text THEN metrics."Lines updated"
            ELSE 0::bigint
        END) AS closed,
    0 AS trn_cretae
   FROM core.metrics
  WHERE 1 = 1 AND metrics."Step name" ~~ 'agent_contract%'::text
  GROUP BY (metrics.create_timestamp::date)
UNION ALL
 SELECT 'contract_long'::text AS object_name,
    metrics.create_timestamp::date AS modify_date,
    sum(
        CASE
            WHEN btrim(metrics."Step name") ~~ 'select contract_long'::text THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS selected,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'contract_long insert'::text THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS new_inserted,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'contract_long insert'::text THEN metrics."Lines rejected"
            ELSE 0::bigint
        END) AS new_inserted_errors,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'contract_long update'::text THEN metrics."Lines updated"
            ELSE 0::bigint
        END) AS updated,
    NULL::numeric AS update_errors,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'contract_long update'::text THEN metrics."Lines rejected"
            ELSE 0::bigint
        END) AS update_not_need,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = 'contract_long close'::text THEN metrics."Lines updated"
            ELSE 0::bigint
        END) AS closed,
    0 AS trn_cretae
   FROM core.metrics
  WHERE 1 = 1 AND metrics."Step name" ~~ '%contract_long%'::text
  GROUP BY (metrics.create_timestamp::date)
UNION ALL
 SELECT ob.objname AS object_name,
    metrics.create_timestamp::date AS modify_date,
    sum(
        CASE
            WHEN btrim(metrics."Step name") ~~ (ob.objname || ' select%'::text) THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS selected,
    sum(
        CASE
            WHEN btrim(metrics."Step name") ~~ (ob.objname || ' insert%'::text) THEN metrics."Lines written"
            ELSE 0::bigint
        END) - sum(
        CASE
            WHEN btrim(metrics."Step name") ~~ (ob.objname || ' update%'::text) THEN metrics."Lines updated"
            ELSE 0::bigint
        END) AS new_inserted,
    sum(
        CASE
            WHEN btrim(metrics."Step name") ~~ (ob.objname || ' insert'::text) THEN metrics."Lines rejected"
            ELSE 0::bigint
        END) AS new_inserted_errors,
    sum(
        CASE
            WHEN btrim(metrics."Step name") ~~ (ob.objname || ' update%'::text) THEN metrics."Lines updated"
            ELSE 0::bigint
        END) AS updated,
    NULL::numeric AS update_errors,
    sum(
        CASE
            WHEN btrim(metrics."Step name") ~~ (ob.objname || ' find%'::text) THEN metrics."Lines read"
            ELSE 0::bigint
        END) AS update_not_need,
    sum(
        CASE
            WHEN btrim(metrics."Step name") ~~ (ob.objname || ' close%'::text) THEN metrics."Lines updated"
            ELSE 0::bigint
        END) AS closed,
    sum(
        CASE
            WHEN btrim(metrics."Step name") = (ob.objname || ' trn insert'::text) THEN metrics."Lines written"
            ELSE 0::bigint
        END) AS trn_cretae
   FROM core.metrics
     JOIN ( SELECT unnest(ARRAY['object_risk_type'::text, 'payment'::text, 'address'::text, 'contract'::text, 'contact'::text, 'document'::text, 'vehicle'::text, 'vehicle_insured'::text, 'avto_usage'::text, 'commission_risk'::text, 'payment_risk'::text, 'paid_return'::text, 'object_risk'::text, 'object_risk_long'::text, 'contract_object'::text, 'contract_project'::text, 'contract_counterparty'::text, 'counterparty'::text, 'cancel_storno'::text, 'cancel_storno_long'::text, 'non_insurance_reserve'::text, 'regress'::text, 'agent_statement'::text, 'declared_return_long'::text, 'declared_return'::text, 'agreement'::text, 'transaction_mngr'::text, 'payment_schedule'::text, 'payment_counterparty'::text, 'commission_risk_sap_progn_long'::text]) AS objname) ob ON metrics."Step name" ~~ (ob.objname || '%'::text)
  GROUP BY ob.objname, (metrics.create_timestamp::date);
--/
CREATE FUNCTION core.bandelete ()  RETURNS trigger
  VOLATILE
AS $body$
BEGIN

Raise exception 'This record cannot be deleted!';

 RETURN OLD;
END;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.check_declared_return_saldo (date_calc date)  RETURNS integer
  VOLATILE
AS $body$
declare
	errors integer;
	
begin
	
	SELECT COALESCE(COUNT(*),0) INTO errors
	FROM core.declared_return r
	LEFT JOIN core.transaction t ON r.declared_return_id = t.declared_return_id
	WHERE r.period_end = '9999-12-31' AND r.period_start = date_calc
	AND t.declared_return_id IS NOT NULL
	GROUP BY r.declared_return_id, r.return_amt
	HAVING r.return_amt - SUM(t.value_amt) != 0;


	RETURN (SELECT COALESCE(errors,0));

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.check_object_risk_saldo (date_calc date)  RETURNS integer
  VOLATILE
AS $body$
declare
	errors integer;
	
begin
	SELECT COUNT(*) INTO errors FROM
	(SELECT r.object_risk_id, r.premium_amt - SUM(COALESCE(t.value_amt,0)) as result 
	FROM core.object_risk r
	LEFT JOIN core.transaction t ON r.object_risk_id = t.object_risk_id
	WHERE r.period_start = date_calc
	AND t.transaction_date <= r.period_start
	AND r.is_active = 1 
	AND t.declared_return_id IS NULL AND t.cancel_storno_id IS NULL
	GROUP BY r.object_risk_id, r.premium_amt
	UNION ALL
	SELECT r.object_risk_id, 0 - SUM(COALESCE(t.value_amt,0)) as result 
	FROM core.object_risk r
	LEFT JOIN core.object_risk r1 ON r.object_risk_id = r1.object_risk_id AND r.period_end = r1.period_start - '1 day'::interval
	LEFT JOIN core.transaction t ON r.object_risk_id = t.object_risk_id
	WHERE r1.object_risk_id IS NULL
	AND r.period_end = date_calc - '1 day'::interval 
	AND t.transaction_date <= r.period_end 									  
	AND t.declared_return_id IS NULL AND t.cancel_storno_id IS NULL
	GROUP BY r.object_risk_id, r.premium_amt) AS t 
	WHERE result != 0;
	
	
	RETURN (SELECT COALESCE(errors,0));

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.check_payment_shedule_contract_long (p_contract_id text)  RETURNS integer
  VOLATILE
AS $body$
declare
  shedule_count integer;
  shedule_date date ;
  shedule_valid integer ;
  mviews RECORD;

begin

  shedule_date = '1990-01-01'::date;
  shedule_valid = 1;
  SELECT COUNT(*) INTO shedule_count FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date;
  --Нет графика платежей т.е. не существует записей в payment_schedule таких, что payment_schedule.contract_id = object_risk.contract_id
  --Количество платежей в графике больше одного и не равно N, где N - количество полных лет (считаем по месяцам, 1 год = 12 месяцев) между contract.liability_start_date и contract.liability_end_date.
  --График платежей есть, но сумма платежей по графику sum(payment_schedule.expected_amt) не равна сумме начисленной премии по договору sum(object_risk.premium_amt), где payment_schedule.contract_id = object_risk.contract_id;
  IF shedule_count = 0
    OR (shedule_count > 1 AND shedule_count != (SELECT MAX(full_year) FROM core.contract_long c
    WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date))
    OR (shedule_count > 0 AND (SELECT TRUNC(SUM(expected_amt))FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date) !=
        (SELECT TRUNC(SUM(premium_amt)) FROM core.object_risk WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date))
    THEN shedule_valid = 0;

  ELSE
  --В графике больше одного платежа и период между очередными платежами в графике платежей меньше 12 мес. (payment_schedule.expected_date+1 текущей строки графика платежей - payment_schedule.expected_date предыдущей строки графика платежей < 12 месяцев);
      IF shedule_count > 1 THEN

          FOR mviews IN SELECT expected_date FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date ORDER BY expected_date LOOP
            IF core.diffofmonth(shedule_date::date, (mviews.expected_date::date + '1 day'::interval)::date) < 12
            THEN
              shedule_valid = 0;
              EXIT;
             END IF;
            shedule_date = mviews.expected_date::date;
          END LOOP;
       END IF;
  END IF;


	RETURN shedule_valid;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.check_payment_shedule_contract_long_old (p_contract_id text)  RETURNS integer
  VOLATILE
AS $body$
declare
  shedule_count integer;
  shedule_date date ;
  shedule_valid integer ;
  mviews RECORD;

begin

  shedule_date = '1990-01-01'::date;
  shedule_valid = 1;
  SELECT COUNT(*) INTO shedule_count FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date;
  IF shedule_count != (SELECT COUNT(*) FROM core.contract_long c
    WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date)
    THEN shedule_valid = 0;
  ELSE
    IF (SELECT TRUNC(SUM(expected_amt))FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date) !=
        (SELECT TRUNC(SUM(premium_amt)) FROM core.object_risk WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date)
      THEN shedule_valid = 0;
    ELSE
      IF shedule_count = 1 THEN RETURN 0;
        ELSE
          FOR mviews IN SELECT expected_date FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date ORDER BY expected_date LOOP
            IF core.diffofmonth(shedule_date::date, (mviews.expected_date::date + '1 day'::interval)::date) < 12
            THEN
              shedule_valid = 0;
              EXIT;
             END IF;
            shedule_date = mviews.expected_date::date;
          END LOOP;
       END IF;
    END IF;
  END IF;


	RETURN shedule_valid;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.check_payment_shedule_contract_long_old1 (p_contract_id text)  RETURNS integer
  VOLATILE
AS $body$
declare
  shedule_count integer;
  shedule_date date ;
  shedule_valid integer ;
  mviews RECORD;

begin

  shedule_date = '1990-01-01'::date;
  shedule_valid = 1;
  SELECT COUNT(*) INTO shedule_count FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date;
  --Нет графика платежей т.е. не существует записей в payment_schedule таких, что payment_schedule.contract_id = object_risk.contract_id
  --Количество платежей в графике больше одного и не равно N, где N - количество полных лет (считаем по месяцам, 1 год = 12 месяцев) между contract.liability_start_date и contract.liability_end_date.
  --График платежей есть, но сумма платежей по графику sum(payment_schedule.expected_amt) не равна сумме начисленной премии по договору sum(object_risk.premium_amt), где payment_schedule.contract_id = object_risk.contract_id;
  IF shedule_count = 0
    OR (shedule_count > 1 AND shedule_count != (SELECT COUNT(*) FROM core.contract_long c
    WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date))
    OR (shedule_count > 0 AND (SELECT TRUNC(SUM(expected_amt))FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date) !=
        (SELECT TRUNC(SUM(premium_amt)) FROM core.object_risk WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date))
    THEN shedule_valid = 0;

  ELSE
  --В графике больше одного платежа и период между очередными платежами в графике платежей меньше 12 мес. (payment_schedule.expected_date+1 текущей строки графика платежей - payment_schedule.expected_date предыдущей строки графика платежей < 12 месяцев);
      IF shedule_count > 1 THEN

          FOR mviews IN SELECT expected_date FROM core.payment_schedule WHERE contract_id = p_contract_id AND period_end = '9999-12-31'::date ORDER BY expected_date LOOP
            IF core.diffofmonth(shedule_date::date, (mviews.expected_date::date + '1 day'::interval)::date) < 12
            THEN
              shedule_valid = 0;
              EXIT;
             END IF;
            shedule_date = mviews.expected_date::date;
          END LOOP;
       END IF;
  END IF;


	RETURN shedule_valid;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.checktrnmngr ()  RETURNS boolean
  VOLATILE
AS $body$
declare
	_checked_timestamp timestamp;
    _created_timestamp timestamp;

begin
-- Е.В.Зубков 2025-10-09

SELECT created_timestamp, checked_timestamp INTO _created_timestamp, _checked_timestamp
    FROM core.loading_stats WHERE source_id='core' AND entity='transaction_mngr';

CREATE TEMP TABLE t AS (
    SELECT DISTINCT object_risk_id
    FROM core.transaction t
    WHERE t.insert_timestamp>current_date --заменить на переменную
    UNION
    SELECT DISTINCT object_risk_id
    FROM core.transaction_mngr t
    WHERE t.insert_timestamp>current_date --заменить на переменную
);

--проверка counterparty_type страхователя
SELECT
    'core.object_risk'::varchar AS check_object,
    CURRENT_DATE::timestamp AS check_date,
    t.object_risk_id AS check_id,
    2::smallint AS check_type,
    'core' AS check_source,
    _checked_timestamp::timestamp AS check_from,
    _created_timestamp::timestamp AS check_to,
    'object_risk_id'::varchar AS check_id_type,
    'Не определен тип страхователя'::varchar AS error_fields,
    'transaction_mngr' AS group_id
FROM
(SELECT contract_id, object_risk_id, SUM(value_rub) AS value_rub, transaction_type
    FROM (SELECT t1.contract_id,t1.object_risk_id,t1.value_rub, t1.transaction_type
        FROM core.transaction t1
        JOIN t ON t.object_risk_id=t1.object_risk_id
        WHERE t1.counterparty_type IS NULL
        AND t1.transaction_type NOT IN (5,6,61,62)
         UNION ALL
        SELECT t1.contract_id,t1.object_risk_id,t1.value_rub, t1.transaction_type
        FROM core.transaction_mngr t1
        JOIN t ON t.object_risk_id=t1.object_risk_id
        WHERE t1.counterparty_type IS NULL
        AND t1.transaction_type NOT IN (5,6,61,62)
        ) t
    GROUP BY contract_id,object_risk_id, transaction_type) t
WHERE value_rub!=0;


RETURN TRUE;

EXCEPTION
    WHEN others THEN
        INSERT INTO core.tr_errorslog(source, target, created_timestamp, errorcode,  errordiscr)
        SELECT 'checktrnmngr','dwh_settings.core_check', current_timestamp, SQLSTATE, SQLERRM;
        RETURN FALSE;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.clean_phone_number (phone_number text)  RETURNS text
  VOLATILE
AS $body$
declare
	coerced_phone_number text;
	temp_phone_number text;
	code_first_char text;
begin
    
	--Убираем все нецифровые символы
	coerced_phone_number = LEFT(regexp_replace(phone_number, '[^0-9]', '', 'g'), 11);

	--Удаляем в начале восьмерку или семерку при условии, что текущая длина номера - 11 символов
	if char_length(coerced_phone_number) = 11 then
		coerced_phone_number = regexp_replace(coerced_phone_number, '^[78]', '', 'g');
	end if;

		code_first_char = substring(coerced_phone_number from 1 for 1);
	if( not (code_first_char = '3' or code_first_char = '4' or code_first_char = '8' or code_first_char = '9')) then
		coerced_phone_number = '';
	end if;

	--Если длина номера не равна 10 символов, то считаем номер некорректным (т.е. отдаем пустую строку)
	if char_length(coerced_phone_number) < 10 then
		coerced_phone_number = '';
	end if;

	return LEFT(coerced_phone_number,10);
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.coerce_bodynum2 (bodynum text)  RETURNS character varying
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
declare

begin

	--Если строка пустая, то ее тоже считаем некорректно, т.е. вместо нее тоже будет записан null
	if bodynum = '' then return null; end if;

	--Убираем пробелы, переводим в верхний регистр
	bodynum = replace(upper(bodynum collate "ru_RU"), ' ', '');

	--Убираем не буквы и не цифры
	bodynum = regexp_replace(bodynum ,'([^[:alnum:]])+','', 'g');

	--Заменить кириллицу на латиницу
	bodynum = translate((bodynum collate "ru_RU"), 'АВЕКМНРСТУХ', 'ABEKMHPCTYX');

    --Проверяем, что строка не состоит только из цифр, или только из букв
    if bodynum ~* '^([A-ZА-Я]+|\d+)$' then
        return null;
    end if;

	return bodynum::varchar(25);
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.coerce_regnum2 (regnum text)  RETURNS character varying
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
declare

begin

	--Если строка пустая, то ее тоже считаем некорректно, т.е. вместо нее тоже будет записан null
	if regnum = '' or length(regnum) < 6 or length(regnum) > 10 then return null; end if;

	--Убираем пробелы, переводим в верхний регистр
	regnum = replace(upper(regnum collate "ru_RU"), ' ', '');

	--Заменить кириллицу на латиницу
	regnum = translate((regnum collate "ru_RU"), 'АВЕКМНРСТУХО', 'ABEKMHPCTYXO');

    --Проверяем, что строка не состоит только из цифр, или только из букв, или не соответствует формату рег.номера
    if regnum ~* '^([A-Z]+|\d+)$' or regnum ~ '[^0-9A-Z]' or regnum !~ '[0-9]{3}' or regnum ~ '000' then
        return null;
--         return vin||'_';
    end if;

	return regnum::varchar(25);
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.coerce_vin2 (vin text)  RETURNS character varying
  IMMUTABLE
  RETURNS NULL ON NULL INPUT
AS $body$
declare
-- 	coerced_vin varchar(17);
begin

--     coerced_vin = (vin collate "ru_RU");

	--Если строка пустая, то ее тоже считаем некорректно, т.е. вместо нее тоже будет записан null
	if vin = '' or length(vin) != 17 then return null; end if;

	--Убираем пробелы, переводим в верхний регистр
	vin = replace(upper(vin collate "ru_RU"), ' ', '');

	--Заменить кириллицу на латиницу
	vin = translate((vin collate "ru_RU"), 'АВЕКМНРСТУХIOО', 'ABEKMHPCTYX100');

    --Проверяем, что строка не состоит только из цифр, или только из букв, или не соответствует формату vin
    if vin ~* '^([A-Z]+|\d+)$' or vin !~* '^[A-HJ-NPR-Z0-9]{14}[0-9]{3}$' then
        return null;
--         return vin||'_';
    end if;

	return vin::varchar(17);
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.contract_ins_type (p_contractid character varying)  RETURNS TABLE(ins_type character varying, ins_type_orig character varying)
  VOLATILE
AS $body$
select
        mit.ins_type, mit.ins_type_orig
		from core.object_risk cor
		inner join core.ref_dict7gs d7 on cor.dict7gs=d7.dict7gs_id
		inner join core.ref_gvs gvs on d7.gvs_scc_id=gvs.scc_id
		inner join core.ref_man_insurance_type mit on gvs.insurance_type=mit.ins_type_orig
    where 1 = 1
      and cor.contract_id = p_contractid
    order by mit.id
    limit 1;
$body$ LANGUAGE sql
/
--/
CREATE FUNCTION core.contract_valid (cnt character varying)  RETURNS boolean
  VOLATILE
AS $body$
declare
	is_valid smallint = 0;
begin

    SELECT 1 INTO is_valid
FROM core.contract c
LEFT JOIN core.branches b ON c.bid = b.bid AND b.period_end = '9999-12-31'
WHERE c.contract_id = cnt
	AND c.is_active = 1 AND c.period_end = '9999-12-31'
    AND COALESCE(b.filial_code,'') != '99909980'
	AND (((c.premium_date >= '2017-01-01'::DATE OR c.premium_date IS NULL)
       AND COALESCE(COALESCE(c.liability_end_date,'9999-12-31'::date),'9999-12-31'::date) >= '2019-01-01' ::date
       AND COALESCE(core.diffofmonth(c.liability_start_date::date, c.liability_end_date::date),1) < 13 --13 месяцев https://jira-rgs.rgs.ru/browse/DWHIV-2716
      ) OR

    ( NOT (COALESCE(c.liability_end_date,'9999-12-31'::date) <= '2019-01-01' ::date
           OR (COALESCE(c.liability_end_date,'9999-12-31'::date) > '2019-01-01'::date AND COALESCE(c.contract_cancel_date, '9999-12-31'::date) < '2019-01-01'::date)
      ) AND core.diffofmonth(c.liability_start_date::date, c.liability_end_date::date) >= 13 --13 месяцев https://jira-rgs.rgs.ru/browse/DWHIV-2716
    )
   );


    return COALESCE(is_valid,0)=1;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.contractatrmngr (datecalc date)  RETURNS boolean
  VOLATILE
AS $body$
/*
Заполнение таблицы comdm.contract_atr_mngr
Е.В.Зубков 2025-02-12
Е.В.Зубков 2025-03-03 добавлено main_contract_id
 */

begin
DROP TABLE IF EXISTS tmp_coun;
DROP TABLE IF EXISTS  tmp_cnt;
DROP TABLE IF EXISTS  tmp_atr;

create temp table tmp_coun (counterparty_id varchar(50));
create temp table tmp_cnt (contract_id varchar(50));

    --новые и измененнные counterparty
    INSERT INTO tmp_coun(counterparty_id)
    SELECT cn1.counterparty_id
    FROM core.counterparty cn1
    LEFT JOIN core.counterparty cn2 ON cn1.counterparty_id=cn2.counterparty_id AND cn1.period_start-1=cn2.period_end
    WHERE 1=1
        AND cn1.period_start=datecalc
        AND cn1.period_end='9999-12-31'
        AND (COALESCE(cn1.vip_code,'')!=COALESCE(cn2.vip_code,'') OR
            COALESCE(cn1.counterparty_type,-1)!=COALESCE(cn2.counterparty_type,-1) OR
            COALESCE(cn1.card_id, '') != COALESCE(cn2.card_id, '') OR
            COALESCE(cn1.agent_code, '') != COALESCE(cn2.agent_code, '') OR
            COALESCE(cn1.name,'') != COALESCE(cn2.name,'') OR
            CONCAT(cn1.last_name, cn1.first_name, cn1.middle_name)  != CONCAT(cn2.last_name, cn2.first_name, cn2.middle_name))
    UNION ALL
    --закрытые counterparty
    SELECT cn1.counterparty_id
    FROM core.counterparty cn1
    LEFT JOIN core.counterparty cn2 ON cn1.counterparty_id=cn2.counterparty_id AND cn1.period_end+1=cn2.period_start
    WHERE 1=1
        AND cn1.period_end=datecalc-1 AND cn1.period_end<'9999-12-31'
        AND cn2.counterparty_id IS NULL
        ;

        INSERT INTO tmp_cnt (contract_id)
        SELECT DISTINCT COALESCE(c.main_contract_id, c.contract_id) AS contract_id
        FROM core.contract c WHERE c.period_start = datecalc AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0

        UNION
        SELECT DISTINCT COALESCE(c.main_contract_id, c.contract_id) AS contract_id
        FROM core.contract_counterparty cc
        JOIN core.contract c ON c.contract_id=cc.contract_id AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0
        WHERE 1 = 1
           AND cc.period_start= datecalc AND cc.period_end = '9999-12-31'
           AND cc.contract_counterparty_role IN (1, 2)
           AND cc.is_primary = 1

        UNION
        SELECT DISTINCT COALESCE(c.main_contract_id, c.contract_id) AS contract_id
        FROM core.contract_counterparty cc
        JOIN core.contract c ON c.contract_id=cc.contract_id AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0
        WHERE 1 = 1
           AND cc.period_end = datecalc-1 AND cc.period_end<'9999-12-31'
           AND cc.contract_counterparty_role IN (1, 2)
           AND cc.is_primary = 1

        UNION

        (WITH cc AS
        (SELECT DISTINCT cc.contract_id
        FROM tmp_coun
        JOIN core.contract_counterparty cc ON tmp_coun.counterparty_id = cc.counterparty_id
            AND cc.contract_counterparty_role IN (1, 2) AND cc.is_primary = 1 AND cc.period_end='9999-12-31')
        SELECT COALESCE(main_contract_id, c.contract_id) AS contract_id
        FROM cc
        JOIN core.contract c ON c.contract_id=cc.contract_id AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0)

        ;

create temp table tmp_atr AS (
    SELECT DISTINCT s.contract_id,
      cl.sale_channel_type,cl.bank, cl.leasing_company, cl.auto_dealer,cl.other_partner
     ,CASE WHEN  COALESCE(cl.bank, cl.leasing_company, cl.auto_dealer,cl.other_partner) IS NULL THEN 0 ELSE 1 END AS is_partner
     ,cn1.counterparty_type AS insurer_type,cn1.vip_code
     ,cn2.card_id AS agent_card_id,cn2.agent_code
     ,CASE WHEN cn2.counterparty_id IS NOT NULL THEN COALESCE(cn2.name, CONCAT_WS(' ',cn2.last_name, cn2.first_name, cn2.middle_name)) END AS agent_name
     ,cn2.counterparty_type AS agent_type
    FROM tmp_cnt s
    JOIN core.get_lastagreement(s.contract_id,current_date) last ON TRUE
    JOIN core.contract cl ON cl.contract_id=last AND cl.period_end = '9999-12-31' AND cl.is_active =1 AND cl.is_life=0 AND COALESCE(cl.contract_type_id,1)=1
    LEFT JOIN core.contract_counterparty cc1 ON cc1.contract_id=cl.contract_id AND cc1.contract_counterparty_role=1 AND cc1.is_primary=1 AND cc1.period_end='9999-12-31'
    LEFT JOIN core.counterparty cn1 ON cc1.counterparty_id=cn1.counterparty_id AND cn1.period_end='9999-12-31'
    LEFT JOIN core.contract_counterparty cc2 ON cc2.contract_id=cl.contract_id AND cc2.contract_counterparty_role=2 AND cc2.is_primary=1 AND cc2.period_end='9999-12-31'
    LEFT JOIN core.counterparty cn2 ON cc2.counterparty_id=cn2.counterparty_id AND cn2.period_end='9999-12-31'
    );


INSERT INTO dwh_settings.etl_comdm_contract_atr_mngr_delta(contract_id,_oper)
SELECT c.contract_id, 'R' AS _oper
FROM core.contract c
LEFT JOIN core.contract c1 ON c.contract_id=c1.contract_id AND c1.period_end = '9999-12-31'
WHERE c.period_end=datecalc-1 AND c.period_end<'9999-12-31' AND c1.contract_id IS NULL;

INSERT INTO dwh_settings.etl_comdm_contract_atr_mngr_delta(contract_id, main_contract_id, sale_channel_type, bank, leasing_company, auto_dealer, other_partner, is_partner, insurer_type, vip_code, agent_card_id, agent_code, agent_name, agent_type)
SELECT c.contract_id,c.main_contract_id,
      atr.sale_channel_type,atr.bank, atr.leasing_company, atr.auto_dealer,atr.other_partner,atr.is_partner
     ,atr.insurer_type,atr.vip_code,atr.agent_card_id,atr.agent_code, atr.agent_name,atr.agent_type
FROM tmp_atr atr
JOIN core.contract c ON COALESCE(c.main_contract_id,c.contract_id)=atr.contract_id AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0;


DROP TABLE IF EXISTS tmp_coun;
DROP TABLE IF EXISTS  tmp_cnt;
DROP TABLE IF EXISTS  tmp_atr;


RETURN true;

EXCEPTION
    WHEN others THEN
        INSERT INTO core.tr_errorslog(source, target, created_timestamp, errorcode,  errordiscr)
        SELECT 'core.contractatrmngr','comdm.contract_atr_mngr', current_timestamp, SQLSTATE, SQLERRM;
        DROP TABLE IF EXISTS tmp_coun;
        DROP TABLE IF EXISTS  tmp_cnt;
        DROP TABLE IF EXISTS  tmp_atr;
        RETURN false;

END
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.contractatrmngr_v1 (datecalc date)  RETURNS boolean
  VOLATILE
AS $body$
/*
Заполнение таблицы comdm.contract_atr_mngr
Е.В.Зубков 2025-02-12
Е.В.Зубков 2025-03-03 добавлено main_contract_id
 */

begin
DROP TABLE IF EXISTS tmp_coun;
DROP TABLE IF EXISTS  tmp_cnt;
DROP TABLE IF EXISTS  tmp_atr;

create temp table tmp_coun (counterparty_id varchar(50));
create temp table tmp_cnt (contract_id varchar(50));

    --новые и измененнные counterparty
    INSERT INTO tmp_coun(counterparty_id)
    SELECT cn1.counterparty_id
    FROM core.counterparty cn1
    LEFT JOIN core.counterparty cn2 ON cn1.counterparty_id=cn2.counterparty_id AND cn1.period_start-1=cn2.period_end
    WHERE 1=1
        AND cn1.period_start=datecalc
        AND cn1.period_end='9999-12-31'
        AND (COALESCE(cn1.vip_code,'')!=COALESCE(cn2.vip_code,'') OR
            COALESCE(cn1.counterparty_type,-1)!=COALESCE(cn2.counterparty_type,-1) OR
            COALESCE(cn1.card_id, '') != COALESCE(cn2.card_id, '') OR
            COALESCE(cn1.agent_code, '') != COALESCE(cn2.agent_code, '') OR
            COALESCE(cn1.name,'') != COALESCE(cn2.name,'') OR
            CONCAT(cn1.last_name, cn1.first_name, cn1.middle_name)  != CONCAT(cn2.last_name, cn2.first_name, cn2.middle_name))
    UNION ALL
    --закрытые counterparty
    SELECT cn1.counterparty_id
    FROM core.counterparty cn1
    LEFT JOIN core.counterparty cn2 ON cn1.counterparty_id=cn2.counterparty_id AND cn1.period_end+1=cn2.period_start
    WHERE 1=1
        AND cn1.period_end=datecalc-1 AND cn1.period_end<'9999-12-31'
        AND cn2.counterparty_id IS NULL
        ;

        INSERT INTO tmp_cnt (contract_id)
        SELECT DISTINCT COALESCE(c.main_contract_id, c.contract_id) AS contract_id
        FROM core.contract c WHERE c.period_start = datecalc AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0

        UNION
        SELECT DISTINCT COALESCE(c.main_contract_id, c.contract_id) AS contract_id
        FROM core.contract_counterparty cc
        JOIN core.contract c ON c.contract_id=cc.contract_id AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0
        WHERE 1 = 1
           AND cc.period_start= datecalc AND cc.period_end = '9999-12-31'
           AND cc.contract_counterparty_role IN (1, 2)
           AND cc.is_primary = 1

        UNION
        SELECT DISTINCT COALESCE(c.main_contract_id, c.contract_id) AS contract_id
        FROM core.contract_counterparty cc
        JOIN core.contract c ON c.contract_id=cc.contract_id AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0
        WHERE 1 = 1
           AND cc.period_end = datecalc-1 AND cc.period_end<'9999-12-31'
           AND cc.contract_counterparty_role IN (1, 2)
           AND cc.is_primary = 1

        UNION

        (WITH cc AS
        (SELECT DISTINCT cc.contract_id
        FROM tmp_coun
        JOIN core.contract_counterparty cc ON tmp_coun.counterparty_id = cc.counterparty_id
            AND cc.contract_counterparty_role IN (1, 2) AND cc.is_primary = 1 AND cc.period_end='9999-12-31')
        SELECT COALESCE(main_contract_id, c.contract_id) AS contract_id
        FROM cc
        JOIN core.contract c ON c.contract_id=cc.contract_id AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0)

        UNION

        SELECT DISTINCT  COALESCE(main_contract_id, c.contract_id) AS contract_id
        FROM dwh_settings.core_check ch
        JOIN core.contract c ON ch.check_id=c.contract_id AND c.period_end='9999-12-31'
        WHERE check_object='comdm.contract_atr_mngr' AND check_type=0 AND check_source='core' AND check_id_type='contract_id'

        ;

create temp table tmp_atr AS (
    SELECT DISTINCT cl.contract_id, cl.main_contract_id,
      cl.sale_channel_type,cl.bank, cl.leasing_company, cl.auto_dealer,cl.other_partner
     ,CASE WHEN  COALESCE(cl.bank, cl.leasing_company, cl.auto_dealer,cl.other_partner) IS NULL THEN 0 ELSE 1 END AS is_partner
     ,cn1.counterparty_type AS insurer_type,cn1.vip_code
     ,cn2.card_id AS agent_card_id,COALESCE(cn2.agent_code, cn2.jur_code) AS agent_code
     ,CASE WHEN cn2.counterparty_id IS NOT NULL THEN COALESCE(cn2.name, CONCAT_WS(' ',cn2.last_name, cn2.first_name, cn2.middle_name)) END AS agent_name
     ,cn2.counterparty_type AS agent_type
    FROM tmp_cnt s
    LEFT JOIN core.get_lastagreement(s.contract_id,current_date) last ON LEFT(last,4)='gwpc'
    JOIN core.contract cl ON COALESCE(cl.main_contract_id,cl.contract_id)=s.contract_id AND cl.period_end = '9999-12-31' AND cl.is_active =1 AND cl.is_life=0 AND COALESCE(cl.contract_type_id,1)=1
    LEFT JOIN core.contract_counterparty cc1 ON cc1.contract_id=COALESCE(last,cl.contract_id) AND cc1.contract_counterparty_role=1 AND cc1.is_primary=1 AND cc1.period_end='9999-12-31'
    LEFT JOIN core.counterparty cn1 ON cc1.counterparty_id=cn1.counterparty_id AND cn1.period_end='9999-12-31'
    LEFT JOIN core.contract_counterparty cc2 ON cc2.contract_id=COALESCE(last,cl.contract_id) AND cc2.contract_counterparty_role=2 AND cc2.is_primary=1 AND cc2.period_end='9999-12-31'
    LEFT JOIN core.counterparty cn2 ON cc2.counterparty_id=cn2.counterparty_id AND cn2.period_end='9999-12-31'
    );


INSERT INTO dwh_settings.etl_comdm_contract_atr_mngr_delta(contract_id,_oper)
SELECT c.contract_id, 'R' AS _oper
FROM core.contract c
LEFT JOIN core.contract c1 ON c.contract_id=c1.contract_id AND c1.period_end = '9999-12-31'
WHERE c.period_end=datecalc-1 AND c.period_end<'9999-12-31' AND c1.contract_id IS NULL;

INSERT INTO dwh_settings.etl_comdm_contract_atr_mngr_delta(contract_id, main_contract_id, sale_channel_type, bank, leasing_company, auto_dealer, other_partner, is_partner, insurer_type, vip_code, agent_card_id, agent_code, agent_name, agent_type)
SELECT atr.contract_id,atr.main_contract_id,
      atr.sale_channel_type,atr.bank, atr.leasing_company, atr.auto_dealer,atr.other_partner,atr.is_partner
     ,atr.insurer_type,atr.vip_code,atr.agent_card_id,atr.agent_code, atr.agent_name,atr.agent_type
FROM tmp_atr atr;
--JOIN core.contract c ON COALESCE(c.main_contract_id,c.contract_id)=atr.contract_id AND c.period_end = '9999-12-31' AND c.is_active = 1 AND c.is_life = 0;


DROP TABLE IF EXISTS tmp_coun;
DROP TABLE IF EXISTS  tmp_cnt;
DROP TABLE IF EXISTS  tmp_atr;


RETURN true;

EXCEPTION
    WHEN others THEN
        INSERT INTO core.tr_errorslog(source, target, created_timestamp, errorcode,  errordiscr)
        SELECT 'core.contractatrmngr','comdm.contract_atr_mngr', current_timestamp, SQLSTATE, SQLERRM;
        DROP TABLE IF EXISTS tmp_coun;
        DROP TABLE IF EXISTS  tmp_cnt;
        DROP TABLE IF EXISTS  tmp_atr;
        RETURN false;

END
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.diffofmonth (date_begin date, date_end date)  RETURNS integer
  VOLATILE
AS $body$
DECLARE mcount integer;

BEGIN


 SELECT (CASE	WHEN (date_part('day',date_end) >= date_part('day',date_begin) OR date_part('day',date_end +1 ) = 1) THEN 0 ELSE -1 END
  +(date_part('year',date_end) - date_part('year',date_begin)) * 12
  +(date_part('month',date_end) - date_part('month',date_begin)))::integer INTO mcount;

  RETURN mcount;
  
END;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_auto_claim2 ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
	return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on ls.entity = 'auto_claim'
            where l.mart_code = 'auto_claim2'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_contract_hier ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'contract_hier'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_dm_corp2 ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'dm_corp2'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_dm_kasko2 ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'dm_kasko2'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_dm_m5kbm ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'dm_m5kbm'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_dm_osago2 ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'dm_osago2'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_dm_realty ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина обновлена ' || l.end_timestamp::date||' в '||l.end_timestamp::time]
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина обновлена ' || l.end_timestamp::date||' в '||l.end_timestamp::time]
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Слишком долгое обновление витрины']
                    when l.status = 'finished' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Витрина не обновилась за последние сутки']
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'dm_realty'
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_dm_realty2 ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'dm_realty2'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_pr_claim2 ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'pr_claim2'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_splunk_audatex ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
/*	return query
        select
            0::SMALLINT alert_code,
            'Заглушка на время разработки'::CHARACTER VARYING alert_text
        from (values (null)) as dummy;
*/
	return query
        with last_log as (
            select *
            from (select
                      *,
                      row_number() over (order by begin_timestamp desc) pos
                  from core.dmm_log log
                    JOIN core.dmm_mart mart ON mart.mart_code = log.mart_code
                  where log.mart_code = 'splunk_audatex' --для каждой витрины будет меняться только этот параметр
                    and begin_timestamp >= current_date::timestamp + load_start_time) q
            where pos = 1
        )
        select
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 2 --если записи лога за сегодня нет, или статус ошибочный, то красный уровень (аварийное состояние)
                when last_log.status = 'running' and current_timestamp::time NOT BETWEEN last_log.load_start_time AND last_log.load_end_time
                    then 1 --процесс до сих пор работает, желтый уровень (приближаемся к аварийному состоянию)
                when last_log.status = 'finished'
                    then 0 --все нормально
            end::SMALLINT as alert_code,
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 'Процесс не запустился или завершен с ошибкой.'
                when last_log.status = 'running'
                    then 'Время работы процесса превысило плановое.' --тут ожидаю что они будут исполнять запросы в определенное время, которое мы укажем
                when last_log.status = 'finished'
                    then 'Витрина актуальна на ' || to_char(current_timestamp, 'DD.MM.YYYY HH24:MI:SS')
            end::CHARACTER VARYING alert_text
        from (values (null)) as dummy
        left join last_log on 1 = 1;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_splunk_avtocod ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
	return query
        with last_log as (
            select *
            from (select
                      *,
                      row_number() over (order by begin_timestamp desc) pos
                  from core.dmm_log log
                    JOIN core.dmm_mart mart ON mart.mart_code = log.mart_code
                  where log.mart_code = 'splunk_avtocod' --для каждой витрины будет меняться только этот параметр
                    and begin_timestamp >= current_date::timestamp + load_start_time) q
            where pos = 1
        )
        select
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 2 --если записи лога за сегодня нет, или статус ошибочный, то красный уровень (аварийное состояние)
                when last_log.status = 'running' and current_timestamp::time NOT BETWEEN last_log.load_start_time AND last_log.load_end_time
                    then 1 --процесс до сих пор работает, желтый уровень (приближаемся к аварийному состоянию)
                when last_log.status = 'finished'
                    then 0 --все нормально
            end::SMALLINT as alert_code,
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 'Процесс не запустился или завершен с ошибкой.'
                when last_log.status = 'running'
                    then 'Время работы процесса превысило плановое.' --тут ожидаю что они будут исполнять запросы в определенное время, которое мы укажем
                when last_log.status = 'finished'
                    then 'Витрина актуальна на ' || to_char(current_timestamp, 'DD.MM.YYYY HH24:MI:SS')
            end::CHARACTER VARYING alert_text
        from (values (null)) as dummy
        left join last_log on 1 = 1        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_splunk_beeline ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
/*	return query
        select
            0::SMALLINT alert_code,
            'Заглушка на время разработки'::CHARACTER VARYING alert_text
        from (values (null)) as dummy;*/

	return query
        with last_log as (
            select *
            from (select
                      *,
                      row_number() over (order by begin_timestamp desc) pos
                  from core.dmm_log log
                    JOIN core.dmm_mart mart ON mart.mart_code = log.mart_code
                  where log.mart_code = 'splunk_beeline' --для каждой витрины будет меняться только этот параметр
                    and begin_timestamp >= current_date::timestamp + load_start_time) q
            where pos = 1
        )
        select
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 2 --если записи лога за сегодня нет, или статус ошибочный, то красный уровень (аварийное состояние)
                when last_log.status = 'running' and current_timestamp::time NOT BETWEEN last_log.load_start_time AND last_log.load_end_time
                    then 1 --процесс до сих пор работает, желтый уровень (приближаемся к аварийному состоянию)
                when last_log.status = 'finished'
                    then 0 --все нормально
            end::SMALLINT as alert_code,
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 'Процесс не запустился или завершен с ошибкой.'
                when last_log.status = 'running'
                    then 'Время работы процесса превысило плановое.' --тут ожидаю что они будут исполнять запросы в определенное время, которое мы укажем
                when last_log.status = 'finished'
                    then 'Витрина актуальна на ' || to_char(current_timestamp, 'DD.MM.YYYY HH24:MI:SS')
            end::CHARACTER VARYING alert_text
        from (values (null)) as dummy
        left join last_log on 1 = 1        ;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_splunk_gwpc ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
	return query
        with last_log as (
            select *
            from (select
                      dmm_log_id,
                      row_number() over (order by begin_timestamp desc) pos
                  from core.dmm_log
                  where mart_code = 'splunk_gwpc'
                    and begin_timestamp::date = current_date) q
            where pos = 1
        )
        select
            case
                when log.dmm_log_id is null or status = 'error' or modified_timestamp + '24 hour'::interval <= current_timestamp
                    then 2
                when status = 'running' and modified_timestamp + (select delta_period from core.dmm_mart where mart_code = 'splunk_gwpc')::text::interval <= current_timestamp
                    then 1
                else 0 --все нормально
            end::SMALLINT as alert_code,
            case
                when log.dmm_log_id is null or status = 'error' or modified_timestamp + '24 hour'::interval <= current_timestamp
                    then 'Витрина не актуальна на ' || (to_char(current_timestamp, 'dd.mm.yyyy HH24:MI:SS'))
                when status = 'running' and modified_timestamp + (select delta_period from core.dmm_mart where mart_code = 'splunk_gwpc')::text::interval <= current_timestamp
                    then 'Время работы процесса превысило плановое.'
                else 'Витрина актуальна на ' || (to_char(current_timestamp, 'dd.mm.yyyy HH24:MI:SS'))
            end::CHARACTER VARYING alert_text
        from (values (null)) as dummy
        left join last_log on 1 = 1
        left join core.dmm_log log on log.dmm_log_id = last_log.dmm_log_id;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_splunk_mfms ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
/*	return query
        select
            0::SMALLINT alert_code,
            'Заглушка на время разработки'::CHARACTER VARYING alert_text
        from (values (null)) as dummy;*/

	return query
        with last_log as (
            select *
            from (select
                      *,
                      row_number() over (order by begin_timestamp desc) pos
                  from core.dmm_log log
                    JOIN core.dmm_mart mart ON mart.mart_code = log.mart_code
                  where log.mart_code = 'splunk_mfms' --для каждой витрины будет меняться только этот параметр
                    and begin_timestamp >= current_date::timestamp + load_start_time) q
            where pos = 1
        )
        select
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 2 --если записи лога за сегодня нет, или статус ошибочный, то красный уровень (аварийное состояние)
                when last_log.status = 'running' and current_timestamp::time NOT BETWEEN last_log.load_start_time AND last_log.load_end_time
                    then 1 --процесс до сих пор работает, желтый уровень (приближаемся к аварийному состоянию)
                when last_log.status = 'finished'
                    then 0 --все нормально
            end::SMALLINT as alert_code,
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 'Процесс не запустился или завершен с ошибкой.'
                when last_log.status = 'running'
                    then 'Время работы процесса превысило плановое.' --тут ожидаю что они будут исполнять запросы в определенное время, которое мы укажем
                when last_log.status = 'finished'
                    then 'Витрина актуальна на ' || to_char(current_timestamp, 'DD.MM.YYYY HH24:MI:SS')
            end::CHARACTER VARYING alert_text
        from (values (null)) as dummy
        left join last_log on 1 = 1        ;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_splunk_transdekra ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
/*	return query
        select
            0::SMALLINT alert_code,
            'Заглушка на время разработки'::CHARACTER VARYING alert_text
        from (values (null)) as dummy;*/

	return query
        with last_log as (
            select *
            from (select
                      *,
                      row_number() over (order by begin_timestamp desc) pos
                  from core.dmm_log log
                    JOIN core.dmm_mart mart ON mart.mart_code = log.mart_code
                  where log.mart_code = 'splunk_transdekra' --для каждой витрины будет меняться только этот параметр
                    and begin_timestamp >= current_date::timestamp + load_start_time) q
            where pos = 1
        )
        select
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 2 --если записи лога за сегодня нет, или статус ошибочный, то красный уровень (аварийное состояние)
                when last_log.status = 'running' and current_timestamp::time NOT BETWEEN last_log.load_start_time AND last_log.load_end_time
                    then 1 --процесс до сих пор работает, желтый уровень (приближаемся к аварийному состоянию)
                when last_log.status = 'finished'
                    then 0 --все нормально
            end::SMALLINT as alert_code,
            case
                when last_log.dmm_log_id is null or last_log.status = 'error'
                    then 'Процесс не запустился или завершен с ошибкой.'
                when last_log.status = 'running'
                    then 'Время работы процесса превысило плановое.' --тут ожидаю что они будут исполнять запросы в определенное время, которое мы укажем
                when last_log.status = 'finished'
                    then 'Витрина актуальна на ' || to_char(current_timestamp, 'DD.MM.YYYY HH24:MI:SS')
            end::CHARACTER VARYING alert_text
        from (values (null)) as dummy
        left join last_log on 1 = 1        ;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.dmm_status_vehicle_chain ()  RETURNS TABLE(alert_code smallint, alert_text character varying)
  VOLATILE
AS $body$
-- при обновлении не забудь добавить код процедуры в конфлюенс
-- https://confluence.rgs.ru/pages/viewpage.action?pageId=240070766
begin
    return query
        select
            t.result[1]::smallint alert_code,
            t.result[2]::varchar alert_text
        from (
            select
                case
                    when current_timestamp between current_date + '00:00:01'::time and current_date + '08:00:00'::time then
                    case
                        when l.status = 'error' and l.end_timestamp < (current_date + '00:00:00'::time) then array ['2','Обновление витрины упало с ошибкой']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'running' and ((current_date + '00:00:00'::time) - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                        when l.status = 'finished' and l.description = 'success' and ((current_date + '00:00:00'::time) - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                        else array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    end
                    when l.status = 'error' then array ['2','Обновление витрины упало с ошибкой']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) > '12 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) > '32 hours'::interval then array ['2','Задержка обновления витрины']
                    when l.status = 'running' and (current_timestamp - l.begin_timestamp) < '12 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                    when l.status = 'finished' and l.description = 'success' and (current_timestamp - l.end_timestamp) < '32 hours'::interval then array ['0','Витрина актуальна на ' || ls.created_timestamp::date]
                end result
            from core.dmm_log l
            left join core.loading_stats ls on l.mart_code = ls.entity
            where l.mart_code = 'vehicle_chain'
              and l.begin_timestamp < (
                case
                    when current_timestamp between current_date + '00:00:00'::time and current_date + '08:00:00'::time then current_date + '00:00:00'::time
                    else current_timestamp
                end)
            order by l.mart_code, l.begin_timestamp desc
            limit 1
        ) t
        ;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_golden_vehicle_id (src_vehicle_id character varying)  RETURNS character varying
  VOLATILE
AS $body$
declare
	golden_vehicle_id varchar(50);
begin
	select	vu_golden.vehicle_id into golden_vehicle_id
	from	core.cdi_vehicle_united vu
			join core.cdi_vehicle_united vu_golden on vu.rgs_id = vu_golden.rgs_id and vu_golden.period_end = '9999-12-31' and left(vu_golden.vehicle_id, 4) = 'cdi1'		
	where	vu.vehicle_id = src_vehicle_id and vu.period_end = '9999-12-31' 
	limit 1;
	
	return golden_vehicle_id;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_ins_type (src_contract_object_id character varying)  RETURNS text
  VOLATILE
AS $body$
declare
	ins_type text;
begin
	select	gs_ref.insurance_type into ins_type
	from	core.object_risk r
			join core.ref_dict7gs gs on r.dict7gs = gs.dict7gs_id
			join core.ref_gvs gs_ref on gs.gvs_scc_id::numeric = gs_ref.scc_id
	where	r.contract_object_id = src_contract_object_id
			and r.period_end = '9999-12-31'
	limit	1;
	
	return ins_type;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_last_checked_timestamp (system_id text, entity_name text)  RETURNS timestamp without time zone
  VOLATILE
AS $body$
declare
	stat_query_text text;
	last_checked_timestamp timestamp;
begin
	select checked_timestamp into last_checked_timestamp from core.loading_stats where source_id = system_id and entity = entity_name;
	return last_checked_timestamp;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_last_loading_timestamp (system_id text, entity_name text)  RETURNS timestamp without time zone
  VOLATILE
AS $body$
declare
	stat_query_text text;
	last_load_timestamp timestamp;
begin
	select created_timestamp into last_load_timestamp from core.loading_stats where source_id = system_id and entity = entity_name;
	return last_load_timestamp;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_last_loading_trn (system_id text, entity_name text)  RETURNS timestamp without time zone
  VOLATILE
AS $body$
declare
	stat_query_text text;
	last_load_timestamp timestamp;
begin
	select trn_created_timestamp into last_load_timestamp from core.loading_stats where source_id = system_id and entity = entity_name;
	return last_load_timestamp;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_last_success_load ()  RETURNS date
  VOLATILE
AS $body$
declare saccess_load_date date;
begin
	SELECT MAX(logdate)::DATE INTO saccess_load_date
  FROM core.jb_log
  WHERE jobname = 'jb_CoreMain'
  AND status = 'end' AND errors = 0;

  return saccess_load_date;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_lastagreement (_contract_id character varying, _date date DEFAULT CURRENT_DATE)  RETURNS character varying
  VOLATILE
AS $body$
declare
	result varchar(50);
begin
/*
 Е.В.Зубков
 2024-11-20
 Функция возвращает последний ДС на дату (только для активных договров). Если дата не указана, то на current_date
 */



WITH RECURSIVE last AS
(SELECT c.contract_id,next.contract_id AS next_contract_id, next.parent_contract_id
FROM core.contract c
LEFT JOIN core.contract next ON next.parent_contract_id = c.contract_id
    AND _date BETWEEN next.period_start AND next.period_end
    AND COALESCE(next.is_active,1)=1
WHERE 1=1
  AND _date BETWEEN c.period_start AND c.period_end
  AND COALESCE(c.is_active,1)=1
  AND c.contract_id = _contract_id
UNION
SELECT c.contract_id, next.contract_id AS next_contract_id, next.parent_contract_id
FROM last c
LEFT JOIN core.contract next ON next.parent_contract_id = c.next_contract_id
    AND _date BETWEEN next.period_start AND next.period_end
    AND COALESCE(next.is_active,1)=1
WHERE 1=1
)
SELECT COALESCE(last.next_contract_id,last.contract_id) INTO result
FROM last
LEFT JOIN last AS last1 ON COALESCE(last.next_contract_id,last.contract_id)=last1.parent_contract_id
WHERE last1.contract_id IS NULL;

RETURN result;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_maxperiodend (id character varying, object_name character varying)  RETURNS date
  VOLATILE
AS $body$
declare
	periodend date;
begin

   IF object_name = 'contract'
       THEN SELECT MAX(period_end) INTO periodend FROM core.contract WHERE contract_id = id;
   ELSIF object_name = 'object_risk'
       THEN SELECT MAX(period_end) INTO periodend FROM core.object_risk WHERE object_risk_id = id;
   ELSIF object_name = 'payment'
       THEN SELECT MAX(period_end) INTO periodend FROM core.payment WHERE payment_id = id;
   ELSIF object_name = 'payment_risk'
       THEN SELECT MAX(period_end) INTO periodend FROM core.payment_risk WHERE payment_risk_id = id;
   ELSIF object_name = 'declared_return'
       THEN SELECT MAX(period_end) INTO periodend FROM core.declared_return WHERE declared_return_id = id;
   ELSIF object_name = 'contract_counterparty'
       THEN SELECT MAX(period_end) INTO periodend FROM core.contract_counterparty WHERE contract_counterparty_id = id::numeric;
   ELSIF object_name = 'counterparty'
       THEN SELECT MAX(period_end) INTO periodend FROM core.counterparty WHERE counterparty_id = id;
   END IF;
return periodend;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_rate (p_cur character varying, p_date date)  RETURNS numeric
  VOLATILE
AS $body$
declare
	rate numeric;
begin

   SELECT ROUND(rate_value / rate_currency_quantity,4)  INTO rate
   FROM core.rates_cb
   WHERE currency_id = UPPER(p_cur)
   AND rate_date = (SELECT max(rate_date) FROM core.rates_cb WHERE rate_date <= p_date AND currency_id = UPPER(p_cur));



	return rate;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_rate_8 (p_cur character varying, p_date date)  RETURNS numeric
  VOLATILE
AS $body$
declare
	rate numeric;
begin

   SELECT ROUND(rate_value / rate_currency_quantity,8)  INTO rate
   FROM core.rates_cb
   WHERE currency_id = UPPER(p_cur)
   AND rate_date = (SELECT max(rate_date) FROM core.rates_cb WHERE rate_date <= p_date AND currency_id = UPPER(p_cur));



	return rate;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_trn_attribute (contract_id character varying, contract_long_id character varying, object_risk_id character varying, transaction_date date, num integer, object_risk_long_id character varying DEFAULT NULL::character varying)  RETURNS TABLE(sale_channel_type character varying, vip_code character varying, counterparty_type integer, is_partner integer, bank character varying, leasing_company character varying, auto_dealer character varying, other_partner character varying, contract_date timestamp without time zone, liability_start_date timestamp without time zone, liability_end_date timestamp without time zone, agent_card_id character varying, agent_code character varying, agent_name character varying, agent_type integer)
  VOLATILE
AS $body$
begin

RETURN QUERY

WITH par AS
(SELECT contract_id, contract_long_id, object_risk_id,  transaction_date, num, object_risk_long_id)

SELECT
 atr.sale_channel_type
,atr.vip_code
,atr.insurer_type AS counterparty_type
,atr.is_partner::int AS is_partner
,atr.bank AS bank
,atr.leasing_company AS leasing_company
,atr.auto_dealer AS auto_dealer
,atr.other_partner AS other_partner
,c.contract_date
,COALESCE(rl.liability_start_date,cl.liability_start_date,r.liability_start_date,c.liability_start_date) AS liability_start_date
,COALESCE(rl.liability_end_date,cl.liability_end_date, r.liability_end_date,c.liability_end_date) AS liability_end_date
,atr.agent_card_id
,atr.agent_code AS agent_code
,atr.agent_name AS agent_name
,atr.agent_type AS agent_type
FROM par
JOIN core.contract c ON c.contract_id = par.contract_id
    AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN c.period_start AND c.period_end
LEFT JOIN comdm.contract_atr_mngr atr ON atr.contract_id = c.contract_id
    AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN atr.period_start AND atr.period_end
LEFT JOIN core.contract_long cl ON cl.contract_id = c.contract_id AND cl.contract_long_id = par.contract_long_id
	AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN cl.period_start AND cl.period_end
LEFT JOIN core.object_risk r ON r.object_risk_id = par.object_risk_id
    AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN r.period_start AND r.period_end
LEFT JOIN core.object_risk_long rl ON rl.contract_long_id = cl.contract_long_id AND rl.object_risk_long_id = par.object_risk_long_id
	AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN rl.period_start AND rl.period_end
LIMIT 1;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_trn_attribute_old (contract_id character varying, contract_long_id character varying, object_risk_id character varying, transaction_date date, num integer)  RETURNS TABLE(sale_channel_type character varying, vip_code character varying, counterparty_type integer, is_partner integer, bank character varying, leasing_company character varying, auto_dealer character varying, other_partner character varying, contract_date timestamp without time zone, liability_start_date timestamp without time zone, liability_end_date timestamp without time zone, agent_card_id character varying, agent_code character varying, agent_name character varying, agent_type integer)
  VOLATILE
AS $body$
begin

RETURN QUERY

WITH par AS
(SELECT contract_id, contract_long_id, object_risk_id,  transaction_date, num)

SELECT
 atr.sale_channel_type
,atr.vip_code
,atr.insurer_type AS counterparty_type
,atr.is_partner::int AS is_partner
,atr.bank AS bank
,atr.leasing_company AS leasing_company
,atr.auto_dealer AS auto_dealer
,atr.other_partner AS other_partner
,c.contract_date
,COALESCE(rl.liability_start_date,cl.liability_start_date,r.liability_start_date,c.liability_start_date) AS liability_start_date
,COALESCE(rl.liability_start_date,cl.liability_end_date, r.liability_end_date,c.liability_end_date) AS liability_end_date
,atr.agent_card_id
,atr.agent_code AS agent_code
,atr.agent_name AS agent_name
,atr.agent_type AS agent_type
FROM par
JOIN core.contract c ON c.contract_id = par.contract_id
    AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN c.period_start AND c.period_end
LEFT JOIN comdm.contract_atr_mngr atr ON atr.contract_id = c.contract_id
    AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN atr.period_start AND atr.period_end
LEFT JOIN core.contract_long cl ON cl.contract_id = c.contract_id AND cl.contract_long_id = par.contract_long_id
	AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN cl.period_start AND cl.period_end
LEFT JOIN core.object_risk r ON r.object_risk_id = par.object_risk_id
    AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN r.period_start AND r.period_end
LEFT JOIN core.object_risk_long rl ON rl.contract_long_id = cl.contract_long_id AND rl.object_risk_id = r.object_risk_id
	AND par.transaction_date::date - CASE par.num::integer WHEN 1 THEN '1 day'::interval ELSE '0 day'::interval END BETWEEN rl.period_start AND rl.period_end
LIMIT 1;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.get_value_from_jb_log (p_job_name text, p_job_key text, p_regexp text, p_num integer, p_date date)  RETURNS TABLE(actual_value text)
  VOLATILE
AS $body$
begin
	return query
	select sq.actual_value
	from (
		select
			(regexp_match(log_field, regexp_replace(p_job_key, '([!$()*+.:<=>?[\\\]^{|}-])', '\\\1', 'g') || p_regexp))[p_num] as actual_value,
			row_number() over(order by enddate desc) as rn
		from core.jb_log l
		where jobname = p_job_name
			and enddate::date = p_date
			and log_field like '%' || p_job_key || '%'
			and status = 'end'
	) sq
	where sq.rn = 1;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.ispulscontract (_contract_id character varying)  RETURNS boolean
  VOLATILE
AS $body$
declare
	result boolean = true;
begin

    SELECT CASE WHEN c.contract_date>=d.variable::date OR c.premium_date>=d.variable::date THEN FALSE ELSE TRUE END INTO result
    FROM core.contract c
    JOIN dwh_settings.set_axioma d ON type = 'MERGEDATE'
    WHERE c.contract_id = _contract_id AND c.period_end =  core.get_maxperiodend(c.contract_id,'contract');

RETURN result;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.ispulsreturn (_return_id character varying)  RETURNS boolean
  VOLATILE
AS $body$
declare
	result boolean = true;
begin

    SELECT CASE WHEN dr.application_date>=d.variable::date OR c.contract_date>=d.variable::date  THEN FALSE ELSE TRUE END INTO result
    FROM core.declared_return dr
    JOIN core.contract c ON dr.contract_id = c.contract_id AND c.period_end =  core.get_maxperiodend(c.contract_id,'contract')
    JOIN dwh_settings.set_axioma d ON type = 'MERGEDATE'
    WHERE dr.declared_return_id=_return_id AND dr.period_end =  core.get_maxperiodend(dr.declared_return_id,'declared_return');

RETURN result;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.ispulsrisk (_risk_id character varying)  RETURNS boolean
  VOLATILE
AS $body$
declare
	result boolean = true;
begin
SELECT
CASE WHEN c.contract_date>=d.variable::date OR r.premium_date>=d.variable::date
        OR (COALESCE(r.premium_date, c.contract_date)<d.variable::date
        AND c.liability_end_date>=d.variable::date AND c.modify_date>d.variable::date AND COALESCE(t.value_amt,0)!=r.premium_amt )
        THEN FALSE ELSE TRUE END INTO result
    FROM core.contract c
    JOIN core.object_risk r ON c.contract_id = r.contract_id AND r.period_end = core.get_maxperiodend(r.object_risk_id,'object_risk')
    JOIN dwh_settings.set_axioma d ON type = 'MERGEDATE'
    LEFT JOIN LATERAL (SELECT SUM(t.value_amt) AS value_amt FROM core.transaction_hist t WHERE r.object_risk_id = t.object_risk_id AND transaction_type = 201
        AND t.value_date<d.variable::date) t ON TRUE
    WHERE r.object_risk_id = _risk_id AND c.period_end =  core.get_maxperiodend(c.contract_id,'contract');

RETURN result;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.rgs2household (rgs_id character varying)  RETURNS character varying[]
  VOLATILE
  RETURNS NULL ON NULL INPUT
AS $body$
declare
    is_in_hh numeric;
    a varchar(50);
    arr_hh_rgs_id varchar(50)[] ;
    arr_tmp varchar(50)[] ;
begin

    -- step 1.
    arr_hh_rgs_id = arr_hh_rgs_id || rgs_id;

    -- проверяем входит ли этот rgs_id в какое-нибудь домохозяйство
    select
        coalesce(
            (select
                 1
             from core.households hh
             where 1 = 1
               and (hh.rgs_id_1 = rgs_id or hh.rgs_id_2 = rgs_id)
               and hh.period_end = '9999-12-31'
               and hh.relation_type_id != '510'
             limit 1)
            , 0)
    into is_in_hh
    ;

    -- если не входит ни в одно домохозяйство, то будет ДХ из самого себя
    if is_in_hh = 0 then return arr_hh_rgs_id; end if;

    -- рекурсивно собираем значения, начиная с  rgs_id
    select
        core.rgs_hh_list(rgs_id,array[rgs_id])
    into arr_tmp;

    -- step 2.
    arr_hh_rgs_id = arr_hh_rgs_id || arr_tmp;

--     raise notice 'Value: %', arr_tmp;
    return  arr_hh_rgs_id;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.rgs2household_hist (rgs_id character varying, calc_dt date)  RETURNS character varying[]
  VOLATILE
  RETURNS NULL ON NULL INPUT
AS $body$
declare
    is_in_hh numeric;
    a varchar(50);
    arr_hh_rgs_id varchar(50)[] ;
    arr_tmp varchar(50)[] ;
begin

    -- step 1.
    arr_hh_rgs_id = arr_hh_rgs_id || rgs_id;

    -- проверяем входит ли этот rgs_id в какое-нибудь домохозяйство
    select
        coalesce(
            (select
                 1
             from core.households hh
             where 1 = 1
               and (hh.rgs_id_1 = rgs_id or hh.rgs_id_2 = rgs_id)
               and hh.period_start <= calc_dt
               and hh.period_end >= calc_dt
               and hh.relation_type_id != '510'
             limit 1)
            , 0)
    into is_in_hh
    ;

    -- если не входит ни в одно домохозяйство, то будет ДХ из самого себя
    if is_in_hh = 0 then return arr_hh_rgs_id; end if;

    -- рекурсивно собираем значения, начиная с  rgs_id
    select
        core.rgs_hh_list(rgs_id,array[rgs_id])
    into arr_tmp;

    -- step 2.
    arr_hh_rgs_id = arr_hh_rgs_id || arr_tmp;

--     raise notice 'Value: %', arr_tmp;
    return  arr_hh_rgs_id;

end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.rgs_hh_list (rgs_id character varying, arr_rgs_id character varying[])  RETURNS character varying[]
  VOLATILE
  RETURNS NULL ON NULL INPUT
AS $body$
declare
    current_array varchar(50)[];
    tmp_array  varchar(50)[];
    result_array    varchar(50)[];
begin

    select
        array_agg(t.rgs_id_2)
    into tmp_array
    from (
        select distinct
            hh.rgs_id_2
        from core.households hh
        where 1 = 1
          and hh.rgs_id_1 = rgs_id
          and hh.relation_type_id != '510'
          and hh.period_end = '9999-12-31'::date
          and hh.rgs_id_2 != all (arr_rgs_id)
--         limit 2
    ) t;
    current_array = current_array || tmp_array;
    arr_rgs_id = arr_rgs_id || tmp_array;

    select
        array_agg(t.rgs_id_1)
    into tmp_array
    from (
        select distinct
            hh.rgs_id_1
        from core.households hh
        where 1 = 1
          and hh.rgs_id_2 = rgs_id
          and hh.period_end = '9999-12-31'::date
          and hh.relation_type_id != '510'
          and hh.rgs_id_1 != all (arr_rgs_id)
--         limit 2
    ) t;
    current_array = current_array || tmp_array;
    arr_rgs_id = arr_rgs_id || tmp_array;

--     raise notice 'rgs_id: %, current_array: %, arr_rgs_id: %', rgs_id, current_array, arr_rgs_id;

    if array_upper(current_array, 1) is null then
        return null;
    end if;

--     current_array = current_array || core.rgs_hh_list(current_array[1], arr_rgs_id);
--     excl_array = excl_array || current_array;
--     current_array = current_array || core.rgs_hh_list(current_array[2], arr_rgs_id);
--     excl_array = excl_array || current_array;

    for i in 1 .. array_upper(current_array, 1)
        loop
            result_array = core.rgs_hh_list(current_array[i], arr_rgs_id);
            current_array = current_array || result_array;
            arr_rgs_id = arr_rgs_id || result_array;
        end loop;

    return current_array;
end;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.transaction_audit ()  RETURNS trigger
  VOLATILE
AS $body$
BEGIN
        --
        -- Добавление строки в emp_audit, которая отражает операцию, выполняемую в emp;
        -- для определения типа операции применяется специальная переменная TG_OP.
        --
        IF (TG_OP = 'DELETE' OR TG_OP = 'UPDATE') THEN
            INSERT INTO core.transaction_audit (object_risk_id, transaction_date, value_date, value_amt, value_cur, value_rub, accounting_group, accounting_risk, dict7gs, form162, is_co_insurance, co_insurance_role, bid,
                transaction_type, change_type, change_reason, contract_id, declared_return_id, cancel_storno_id, contract_long_id, object_risk_long_id, insert_timestamp, payment_risk_id, commission_risk_id,  commission_risk_long_id, userid,
                    transaction_old)
            SELECT OLD.object_risk_id, OLD.transaction_date, OLD.value_date, OLD.value_amt, OLD.value_cur, OLD.value_rub, OLD.accounting_group, OLD.accounting_risk, OLD.dict7gs, OLD.form162, OLD.is_co_insurance, OLD.co_insurance_role, OLD.bid,
                   OLD.transaction_type, OLD.change_type, OLD.change_reason, OLD.contract_id, OLD.declared_return_id, OLD.cancel_storno_id, OLD.contract_long_id, OLD.object_risk_long_id, OLD.insert_timestamp,
                   OLD.payment_risk_id, OLD.commission_risk_id,  OLD.commission_risk_long_id , user, OLD.transaction_id ;
        END IF;
        RETURN NULL; -- возвращаемое значение для триггера AFTER игнорируется
    END;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.transaction_mngr_audit ()  RETURNS trigger
  VOLATILE
AS $body$
BEGIN
        --
        --
        IF (TG_OP = 'DELETE' OR TG_OP = 'UPDATE') THEN
            INSERT INTO core.transaction_mngr_audit (transaction_id,contract_id,object_risk_id,	declared_return_id,	cancel_storno_id,contract_long_id,
	object_risk_long_id,payment_risk_id,	commission_risk_id ,	transaction_date ,	value_date,	value_amt ,	value_cur ,	value_rub ,
	dict7gs ,	sale_channel_type ,	vip_code ,	counterparty_type ,	is_partner ,	transaction_type ,	change_reason ,	insert_timestamp,
	bank ,	leasing_company ,	auto_dealer ,	other_partner ,	commission_risk_long_id , userid)
            SELECT old.transaction_id,old.contract_id,old.object_risk_id,	old.declared_return_id,	old.cancel_storno_id,old.contract_long_id,
	old.object_risk_long_id,old.payment_risk_id,	old.commission_risk_id ,	old.transaction_date ,	old.value_date,	old.value_amt ,	old.value_cur ,	old.value_rub ,
	old.dict7gs ,	old.sale_channel_type ,	old.vip_code ,	old.counterparty_type ,	old.is_partner ,	old.transaction_type ,	old.change_reason ,	old.insert_timestamp,
	old.bank ,	old.leasing_company ,	old.auto_dealer ,	old.other_partner ,	old.commission_risk_long_id , user  ;
        END IF;
        RETURN NULL; -- возвращаемое значение для триггера AFTER игнорируется
    END;
$body$ LANGUAGE plpgsql
/
--/
CREATE FUNCTION core.trndateenable (_transaction_type numeric, _value_date date, _contract_date date DEFAULT NULL::date, _bid character varying DEFAULT NULL::character varying)  RETURNS TABLE(system_id character, enabled boolean)
  VOLATILE
AS $body$
begin

RETURN QUERY
        SELECT 'axio'::char(4) AS system_id, CASE WHEN _value_date>=d.variable::date OR (_transaction_type=1 AND COALESCE(_contract_date,'1990-01-01'::DATE)>=d.variable::date) THEN true ELSE false END AS enabled
        FROM dwh_settings.set_axioma d WHERE type = 'MERGEDATE'
        UNION ALL
        SELECT 'ekis'::char(4) AS system_id , CASE WHEN COALESCE(_bid,'') = COALESCE(b.variable,'') THEN
            CASE WHEN _value_date>=d.variable::date OR (_transaction_type=1 AND COALESCE(_contract_date,'1990-01-01'::DATE)>=d.variable::date) THEN true ELSE false END
            ELSE true END AS enabled
        FROM dwh_settings.set_ekis d
        JOIN dwh_settings.set_ekis b ON b.type = 'MERGEDATE' AND b.subtype = 'BID'
        WHERE d.type = 'MERGEDATE' AND d.subtype IS NULL
        UNION ALL
        SELECT UNNEST(ARRAY['arm4'::char(4) ,'gwpc'::char(4) ,'kias'::char(4),'impl'::char(4)])  AS system_id, true AS enabled;


end;
$body$ LANGUAGE plpgsql
/
--/
CREATE PROCEDURE core.update_month_close_calendar () 
 LANGUAGE plpgsql
AS $body$
declare
    max_end_date date;
    begin_rep_period_val date;
    start_date_val date;
    end_date_val date;
begin
    
    select max(end_date) into max_end_date
    from core.month_close_calendar;

    if max_end_date is null then
        raise notice 'Таблица core.month_close_calendar пуста. Процедура завершена.';
        return;
    end if;

    begin_rep_period_val := date_trunc('month', max_end_date);
    start_date_val := max_end_date + interval '1 day';

    select date(min(calendar_date))
    into end_date_val
    from cdm_analysis.calendar_work
    where is_day_off = 0
      and date_trunc('month', calendar_date) = date_trunc('month', max_end_date + interval '1 month');

    if end_date_val is null then
        raise notice 'Таблица core.month_close_calendar не обновлена. Процедура завершена.';
        return;
    end if;

    
    insert into core.month_close_calendar(begin_rep_period, start_date, end_date)
    values (begin_rep_period_val::date, start_date_val::date, end_date_val::date);

    
    update cdm_analysis_out.global_param
    set value = to_char((begin_rep_period_val - interval'1 month')::date, 'ddmmyyyy')
    where param_id = 'CLOSE_DATE';

    raise notice 'Процедура завершена успешно.';
end;
$body$
/
