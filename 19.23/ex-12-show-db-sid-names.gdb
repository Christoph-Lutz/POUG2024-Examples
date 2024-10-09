# Purpose:
#   Read the db and sid names from the Oracle
#   sga variables ksqgdn_ and kspssidst_.
# 
# Author:
#  Christoph Lutz
#
# Date:
#   Sep-21 2024
#
# Usage:
#   gdb -q -x ex-12-show-db-sid-names.gdb -p <oracle_pid>

set pagination off
set confirm off

x/s &ksqgdn_

x/s &kspssidst_

quit
