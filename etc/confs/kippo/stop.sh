#!/bin/sh

PIDFILE=/opt/kippo/kippo.pid

cd $(dirname $0)

PID=$(cat $PIDFILE 2>/dev/null)

if [ -n "$PID" ]; then
  echo "Stopping kippo...\n"
  kill -TERM $PID
fi
