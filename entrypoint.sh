#!/bin/sh

echo "
export PGUSER=$POSTGRES_USER
export PGPASSWORD=$POSTGRES_PASSWORD
export PGPORT=$POSTGRES_PORT
export PGHOST=$POSTGRES_HOST
export DUMPPREFIX=$DUMPPREFIX
 " > /pgenv.sh

crond -f