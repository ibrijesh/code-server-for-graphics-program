#!/bin/bash

sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/sites-enabled/default && nginx -g 'daemon off;'