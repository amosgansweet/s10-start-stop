#!/bin/bash

# use pgrep to check webh2 process PID
PID=$(pgrep webh2)

# check PID
if [ -n "$PID" ]; then
  echo "find webh2 process，PID 为: $PID"

  # try stop process
  kill "$PID"
  if [ $? -eq 0 ]; then # check kill succeed 
    echo "sent signal to $PID"

    # await process (max 5 s)
    TIMEOUT=5
    COUNT=0
    while ps -p "$PID" > /dev/null && [ $COUNT -lt $TIMEOUT ]; do
      sleep 1
      COUNT=$((COUNT + 1))
    done

    # check process stop
    if ! ps -p "$PID" > /dev/null; then
      echo "process $PID stopped。"
    else
      echo "process $PID can not stop at $TIMEOUT s，force probably。"
      kill -9 "$PID" # force stop
      if [ $? -eq 0 ]; then
        echo "forced stop $PID"
      else
        echo "force fail $PID 。"
      fi
    fi

  else
    echo "stop process fail $PID 。"
  fi

else
  echo "not find process webh2 。"
fi
