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
