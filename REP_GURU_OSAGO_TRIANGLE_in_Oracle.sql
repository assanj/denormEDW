SELECT 
sale_channel_mk_name,
convert(to_char(t.sale_channel_mk_name),'UTF8','utf8')

FROM a_teat_tr_atr_gw t


35=BK
4как перекодировать


SELECT 
    sale_channel_mk_name                                              AS as_is,
    CONVERT(sale_channel_mk_name, 'AL32UTF8', 'CL8MSWIN1251')         AS conv_win1251_to_utf8,
    CONVERT(sale_channel_mk_name, 'AL32UTF8', 'CL8ISO8859P5')         AS conv_iso8859_5_to_utf8,
    CONVERT(sale_channel_mk_name, 'AL32UTF8', 'CL8KOI8R')             AS conv_koi8r_to_utf8,
    CONVERT(sale_channel_mk_name, 'CL8MSWIN1251', 'AL32UTF8')         AS conv_utf8_to_win1251,
    CONVERT(sale_channel_mk_name, 'CL8ISO8859P5', 'AL32UTF8')         AS conv_utf8_to_iso8859_5,
    UTL_I18N.RAW_TO_CHAR(
        UTL_I18N.STRING_TO_RAW(sale_channel_mk_name, 'CL8MSWIN1251'),
        'AL32UTF8'
    )                                                                 AS utl_win1251_to_utf8,
    UTL_I18N.RAW_TO_CHAR(
        UTL_I18N.STRING_TO_RAW(sale_channel_mk_name, 'AL32UTF8'),
        'CL8MSWIN1251'
    )                                                                 AS utl_utf8_to_win1251,
    UTL_I18N.RAW_TO_CHAR(
        UTL_I18N.STRING_TO_RAW(sale_channel_mk_name, 'CL8ISO8859P5'),
        'AL32UTF8'
    )                                                                 AS utl_iso8859_5_to_utf8,
    UTL_I18N.RAW_TO_CHAR(
        UTL_I18N.STRING_TO_RAW(sale_channel_mk_name, 'CL8KOI8R'),
        'AL32UTF8'
    )                                                                 AS utl_koi8r_to_utf8,
    DUMP(sale_channel_mk_name, 1016)                                  AS bytes_hex
FROM a_teat_tr_atr_gw t
WHERE ROWNUM <= 20;

SELECT 
    sale_channel_mk_name,
    CONVERT(sale_channel_mk_name, 'AL32UTF8', 'CL8MSWIN1251') AS try1,
    CONVERT(sale_channel_mk_name, 'AL16UTF16', 'CL8MSWIN1251') AS try2
FROM a_teat_tr_atr_gw t
WHERE ROWNUM <= 5;
SELECT 
    sale_channel_mk_name,
    DUMP(sale_channel_mk_name, 1016) AS bytes_hex,
    LENGTH(sale_channel_mk_name)    AS len_chars,
    LENGTHB(sale_channel_mk_name)   AS len_bytes,
    ASCIISTR(sale_channel_mk_name)  AS ascii_repr
FROM a_teat_tr_atr_gw t
WHERE ROWNUM <= 5;

1	35=BK	Typ=1 Len=18 CharacterSet=CL8MSWIN1251: 4,10,4,33,4,35,4,3d,4,42,4,4b,0,20,4,18,4,1f	18	18	35=BK
2	35=BK	Typ=1 Len=30 CharacterSet=CL8MSWIN1251: 4,10,4,33,4,35,4,3d,4,42,4,4b,0,20,4,3a,4,40,4,3e,4,3c,4,35,0,20,4,18,4,1f	30	30	35=BK
3	D8AK	Typ=1 Len=10 CharacterSet=CL8MSWIN1251: 4,1e,4,44,4,38,4,41,4,4b	10	10	D8AK
4	35=BK	Typ=1 Len=30 CharacterSet=CL8MSWIN1251: 4,10,4,33,4,35,4,3d,4,42,4,4b,0,20,4,3a,4,40,4,3e,4,3c,4,35,0,20,4,18,4,1f	30	30	35=BK
5	35=BK	Typ=1 Len=30 CharacterSet=CL8MSWIN1251: 4,10,4,33,4,35,4,3d,4,42,4,4b,0,20,4,3a,4,40,4,3e,4,3c,4,35,0,20,4,18,4,1f	30	30	35=BK



SELECT parameter, value 
FROM nls_database_parameters 
WHERE parameter IN ('NLS_CHARACTERSET','NLS_NCHAR_CHARACTERSET');

1	NLS_CHARACTERSET	CL8MSWIN1251
2	NLS_NCHAR_CHARACTERSET	AL16UTF16

SELECT parameter, value 
FROM nls_session_parameters 
WHERE parameter IN ('NLS_CHARACTERSET','NLS_NCHAR_CHARACTERSET');

1	NLS_LANGUAGE	RUSSIAN
2	NLS_TERRITORY	AMERICA
3	NLS_CURRENCY	$
4	NLS_ISO_CURRENCY	AMERICA
5	NLS_NUMERIC_CHARACTERS	.,
6	NLS_CALENDAR	GREGORIAN
7	NLS_DATE_FORMAT	DD.MM.YYYY
8	NLS_DATE_LANGUAGE	RUSSIAN
9	NLS_SORT	RUSSIAN
10	NLS_TIME_FORMAT	HH.MI.SSXFF AM
11	NLS_TIMESTAMP_FORMAT	DD-MON-RR HH.MI.SSXFF AM
12	NLS_TIME_TZ_FORMAT	HH.MI.SSXFF AM TZR
13	NLS_TIMESTAMP_TZ_FORMAT	DD-MON-RR HH.MI.SSXFF AM TZR
14	NLS_DUAL_CURRENCY	$
15	NLS_COMP	BINARY
16	NLS_LENGTH_SEMANTICS	BYTE
17	NLS_NCHAR_CONV_EXCP	FALSE

SELECT userenv('language') FROM dual;
RUSSIAN_AMERICA.CL8MSWIN1251
