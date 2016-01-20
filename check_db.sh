#!/bin/bash

if [ ! -d /data/db/ ]; then
      echo "Creating DB dir"
      NEW_DB=1
      mkdir -p /data/db
      chown postgres:postgres /data/db
      chmod 700 /data/db
      su postgres --command "/usr/lib/postgresql/9.4/bin/initdb -D /data/db"
      # Postgres might not start on first run, due to no db
      systemctl start postgresql
  fi

  while :
  do
      echo "Checking if postgres DB is ready"
      su postgres --command 'psql -c "select pg_postmaster_start_time()"'
      if [ $? == 0 ]; then
        echo "DB ready!"
        break;
      else
        sleep 5;
      fi
  done

  while true; do sleep 10; done