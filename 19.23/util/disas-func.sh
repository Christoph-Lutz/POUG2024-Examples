#!/usr/bin/bash
#
# Purpose:
#   Helper script to disassemble a function in a binary
#   with gdb.
#
# Author:
#   Christoph Lutz
#
# Date:
#   Sep-22 2024
#

if [[ $# -ne 2 ]]
 then
    echo
    echo "Usage: $0 <binary> <function>"
    echo
    exit 1
fi

BINARY="$1"
FUNCTION="$2"

gdb -batch -ex "file $BINARY" -ex "disassemble $FUNCTION"
