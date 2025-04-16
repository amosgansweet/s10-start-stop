#!/bin/bash
ps aux | grep -v grep | grep webh2 > /dev/null
  if [ $? -ne 0 ]; then
      echo "process 'run webh2' stop，starting..."
      cd $HOME/domains/aomega-yahai.serv00.net/public_html
      nohup $HOME/domains/aomega-yahai.serv00.net/public_html/webh2 server -c $HOME/domains/aomega-yahai.serv00.net/logs/web159.yaml >/dev/null 2>&1 &
  fi
