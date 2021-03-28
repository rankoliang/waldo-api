#!/bin/bash
set -e

rm -f /waldo_api/tmp/pids/server.pid

rails db:prepare

# Execute dockerfile cmd
exec "$@"
