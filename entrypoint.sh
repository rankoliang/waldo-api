#!/bin/bash
set -e

rm -f /waldo-api/tmp/pids/server.pid

rails db:setup && rails db:reset

# Execute dockerfile cmd
exec "$@"
