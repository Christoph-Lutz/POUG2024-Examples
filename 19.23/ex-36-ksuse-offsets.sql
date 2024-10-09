-- Query modified from source:
-- https://jonathanlewis.wordpress.com/2022/03/16/excavating-x/

set lines 130 pages 999
col tab for a30
col col for a30
col off_hex just right

define table_name='X$KSUSE'
define column_names="'KSUSENUM','KSUUDNAM'"

select
    t.kqftanam tab,
    c.kqfconam col,
    c.kqfcosiz sz,
    c.kqfcooff off, 
    to_char(c.kqfcooff, 'xxxxxxxxxxxxxxxx') off_hex
from
    x$kqfta t,
    x$kqfco c
where
    c.kqfcotab = t.indx
and t.kqftanam = '&&table_name'
and c.kqfconam in (&&column_names)
/

