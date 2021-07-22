#!/bin/bash
set -ex

RUN_XTERM=${RUN_XTERM:-yes}

RUN_CODE=${RUN_CODE:-yes}

case $RUN_XTERM in
  false|no|n|0)
    rm -f /app/conf.d/xterm.conf
    ;;
esac


exec  supervisord -c /app/supervisord.conf

