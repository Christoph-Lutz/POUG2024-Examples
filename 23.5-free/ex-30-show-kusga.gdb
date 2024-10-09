# Purpose:
#  Example that shows how to read the pointer to the
#  session array from ksusge_ and then uses it to
#  print the addrs of the session structs (ksuse).
#
# Author:
#  Christoph Lutz
#
# Date:
#   Sep-28 2024
#
# Usage:
#   gdb -q -x ex-30-show-kusga.gdb -p <oracle_pid>
# 
# Notes:
#  This example only prints the first four saddrs
#  exposed in x$ksuse.
#
#  The output of this script should match with
#  the output of the following query:
#    select sid, lower(saddr) saddr 
#    from v$session where sid in (1,2,3,4);
#
#  The offset of the session array pointer in 
#  ksusga_ has changed from 0x9 to 0x8 compared
#  to 19c.

set pagination off
set confirm off

printf "\n### &ksusga_:\n"
x/10xg &ksusga_

printf "\n### (char *)&ksusga_+0x8:\n"
x/1xg (char *)&ksusga_+0x8

printf "\n### *((char **)&ksusga_+0x8)\n"
x/4xg *((char **)&ksusga_+0x8)

quit
