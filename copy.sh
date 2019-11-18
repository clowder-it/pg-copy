#!/bin/sh

source /pgenv.sh

#echo "Running with these environment options" >> /var/log/cron.log
#set | grep PG >> /var/log/cron.log

echo "Starting copy from $SOURCE_DATABASE to $TARGET_DATABASE" >> /var/log/cron.log

# Disconnect all sessions
psql -d $POSTGRES_DATABASE -t -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity 
WHERE pg_stat_activity.datname = '$SOURCE_DATABASE' AND pid <> pg_backend_pid();"
psql -d $POSTGRES_DATABASE -t -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity 
WHERE pg_stat_activity.datname = '$TARGET_DATABASE' AND pid <> pg_backend_pid();"
# Destroy $TARGET_DATABASE
psql -d $POSTGRES_DATABASE -t -c "DROP DATABASE $TARGET_DATABASE;"
# Copy $SOURCE_DATABASE to $TARGET_DATABASE
psql -d $POSTGRES_DATABASE -t -c "CREATE DATABASE $TARGET_DATABASE WITH TEMPLATE $SOURCE_DATABASE;"
