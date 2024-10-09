# Purpose:
#  Example that shows how to read the Oracle latch 
#  names from the kslldt array in the sga.
#
# Author:
#  Christoph Lutz
#
# Date:
#   Sep-21 2024
#
# Usage:
#   gdb -q -x show-kslldt.gdb -p <oracle_pid>
#
# Notes:
#  This example only prints the first three latch
#  names exposed in x$kslltr.
#
#  The output of this script should match with
#  the output of the following query:
#    select indx, kslltnum, kslltaddr, kslltnam 
#    from x$kslltr where rownum <= 3; 

set pagination off
set confirm off

printf "\n"
printf "&kslldst_sga_\n"
x/1xg &kslldst_sga_

printf "\n*(char **)&kslldst_sga_+0x8\n"
x/1xg *(char **)&kslldst_sga_+0x8

printf "\n*(char ***)(*(char **)&kslldst_sga_+0x8)\n"
x/20xg *(char ***)(*(char **)&kslldst_sga_+0x8)

set $kslltnum=0
set $kslld_sz=0x28

printf "\n******\n"
printf "latch#=%u kslltnam=%s\n", ++$kslltnum, *(char **)((char *)(&kslldt) + ($kslltnum * $kslld_sz))
printf "latch#=%u kslltnam=%s\n", ++$kslltnum, *(char **)((char *)(&kslldt) + ($kslltnum * $kslld_sz))
printf "latch#=%u kslltnam=%s\n", ++$kslltnum, *(char **)((char *)(&kslldt) + ($kslltnum * $kslld_sz))
printf "\n******\n"

quit
