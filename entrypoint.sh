#!/bin/sh
set -e

rm -f /waldo_api/tmp/pids/server.pid

bin/rails db:prepare

# Execute dockerfile cmd
exec "$@"
