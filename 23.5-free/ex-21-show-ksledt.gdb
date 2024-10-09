# Purpose:
#  Example that shows how to read the Oracle wait
#  event names from the ksledt_ array in the sga.
#
# Author:
#  Christoph Lutz
#
# Date:
#   Sep-21 2024
#
# Usage:
#   gdb -q -x ex-21-show-ksledt.gdb -p <oracle_pid>
# 
# Notes:
#  This example only prints the first three wait
#  events exposed in x$ksled.
#
#  The output of this script should match with
#  the output of the following query:
#    select addr, indx, kslednam from x$ksled 
#    where rownum <= 3 order by indx;

set pagination off
set confirm off

printf "\n&ksledt_:\n"
x/1xg &ksledt_

printf "\n**ksledt_:\n"
x/15xg *(char **)&ksledt_

set $kslednam=*(char **)&ksledt_
set $ksledsz = 56
set $indx=0

printf "\nWait event names:\n"
printf "indx=%d kslednam='%s'\n", $indx, *(char **)($kslednam + $indx++ * $ksledsz)
printf "indx=%d kslednam='%s'\n", $indx, *(char **)($kslednam + $indx++ * $ksledsz)
printf "indx=%d kslednam='%s'\n", $indx, *(char **)($kslednam + $indx++ * $ksledsz)
printf "\n"

quit
