#!/usr/bin/bash
#
# Purpose:
#  Helper script to calculate tls offset of a given 
#  address. Can be used to calculate the saddr or
#  paddr tls offsets.
#
# Author:
#   Christoph Lutz
#
# Date:
#   Sep-21 2024
#
# Usage:
#   ./ex-32-calculate-tls-offset.sh <pid> <addr>
#
#   pid : ospid of existing oracle process
#   addr: addr of existing oracle session or
#         process (for instance v$session.saddr
#         or v$process.addr)
#
#   Example:
#   ./ex-32-calculate-tls-offset.sh 7128 0x7ea0cf60
#
# Notes:
#   The script must be executed as the root user

SEARCH_OFFSET="0x100000"

if [[ $# -ne 2 ]]
 then
    echo
    echo "Usage: $0 <pid> <addr>"
    echo
    exit 1
fi

if [[ $(id -u) -ne 0 ]]
 then
    echo
    echo "Script must be executed as root user. Aborting."
    echo
    exit 1
fi

PID="$1"
SADDR="$2"

echo
echo "INFO: pid is: $PID"
echo "INFO: addr is: $SADDR"

offset=$(gdb -q -p $PID <<EOF | grep -oP '.*offset=\K(.*)'
set pagination off
set confirm off
dont-repeat
find \$fs_base-$SEARCH_OFFSET, \$fs_base, $SADDR 
set \$addr = (unsigned long long)\$_
# p/x \$fs_base - \$addr
printf "offset=0x%x\n", \$fs_base - \$addr
quit
EOF
)

echo "INFO: addr offset is: $offset"
echo
