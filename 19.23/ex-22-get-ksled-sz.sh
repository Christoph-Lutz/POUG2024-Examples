#!/usr/bin/bash
# 
# Purpose:
#   Helper script to calculate the size of a ksled entry 
#   in ksledt_.
# 
# Author:
#   Christoph Lutz
#
# Date:
#   Sep-21 2024
# 
# Notes:
#   Run the script as oracle user and make sure the
#   oracle environment is set accordinly.

sqlplus <<EOF | grep ksled_sz
connect / as sysdba
set lines 130 pages 999

select 
  'ksled_sz=' ||sz ||' (0x' ||trim(to_char(sz, 'xxxxxxxxxxxxxxx')) ||')'
from
(
  select 
    to_number(addr, 'xxxxxxxxxxxxxxxx') - 
    to_number(lag(addr,1) over (order by indx), 'xxxxxxxxxxxxxxxx') as sz 
  from 
    x\$ksled 
  where 
    rownum <= 2 order by indx
)
where 
  sz is not null
/

EOF
