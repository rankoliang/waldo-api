#!/bin/bash
set -e

rm -f /waldo-api/tmp/pids/server.pid

# Execute dockerfile cmd
exec "$@"
