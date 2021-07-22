#!/bin/bash

# nginx -g 'daemon off;'

sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/nginx.conf && nginx -g 'daemon off;'