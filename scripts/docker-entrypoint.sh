#!/usr/bin/env sh
set -eu

envsubst '${NAME}' < /usr/local/nginx/conf/rtmp.conf.template > /usr/local/nginx/conf/rtmp.conf

exec "$@"