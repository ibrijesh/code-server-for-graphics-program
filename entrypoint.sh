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


#exec sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/sites-enabled/default && nginx -g 'daemon off;'