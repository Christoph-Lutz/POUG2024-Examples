#!/usr/bin/bash
# Purpose:
#   Little helper script to demonstrate the
#   use of ex-20-ora_wait_trace_12c_18c.py
# 
# Author:
#   Christoph Lutz
# 
# Date:
#   Sep-29 2024
#
# Usage:
#  ex-20-ora_wait_trace.sh <oracle_sid> <oracle_ospid>
#
# Notes:
#  Adjust the variables below for your environment

export WORK_DIR="$(pwd)"
export ORACLE_HOME=/u01/app/oracle/product/19.0.0.0/dbhome_1923_1
export EVENTSNAME_SQL="$WORK_DIR/ex-20-eventsname.sql"
export EVENTSNAME_SED="$WORK_DIR/ex-20-eventsname.sed"
export WAIT_TRACE_SCRIPT="$WORK_DIR/ex-20-ora_wait_trace_12c_18c.py"

export ORACLE_SID="$1"
export OSPID="$2"

if [[ $# -ne 2 ]]
 then
  echo
  echo "Usage: $0 <oracle_sid> <oracle_ospid>"
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

echo "INFO: ORACLE_HOME is $ORACLE_HOME"
echo "INFO: WORK_DIR is $WORK_DIR"
echo "INFO: EVENTSNAME_SQL is $EVENTSNAME_SQL"
echo "INFO: EVENTSNAME_SED is $EVENTSNAME_SED"
echo "INFO: WAIT_TRACE_SCRIPT is $WAIT_TRACE_SCRIPT"

su oracle -m -c /usr/bin/bash <<EOF
  $ORACLE_HOME/bin/sqlplus /nolog <<EOF2
  connect / as sysdba
  @$EVENTSNAME_SQL
EOF2
EOF

echo "INFO: executing command: unbuffer $WAIT_TRACE_SCRIPT -p $OSPID | unbuffer -p sed -f $EVENTSNAME_SED"
unbuffer $WAIT_TRACE_SCRIPT -p $OSPID | unbuffer -p sed -f $EVENTSNAME_SED
