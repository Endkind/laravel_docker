#!/bin/sh
set -e

until pg_isready -h db -p 5432; do
    echo "Waiting for the database..."
    sleep 2
done

MIGRATE=${MIGRATE:-once}

if [ "$MIGRATE" = "true" ]; then
    echo "Running migrations..."
    php artisan migrate --force
elif [ "$MIGRATE" = "false" ]; then
    echo "Skipping migrations..."
elif [ "$MIGRATE" = "once" ]; then
    TABLE_EXISTS=$(PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USERNAME -d $DB_DATABASE -t -c "SELECT to_regclass('public.migrations');")
    if [ "$TABLE_EXISTS" = " " ]; then
        echo "Running migrations..."
        php artisan migrate --force
    else
        MIGRATIONS_COUNT=$(PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USERNAME -d $DB_DATABASE -t -c "SELECT COUNT(*) FROM migrations;")
        if [ "$MIGRATIONS_COUNT" -eq "0" ]; then
            echo "Running migrations..."
            php artisan migrate --force
        else
            echo "Migrations already run, skipping..."
        fi
    fi
elif [ "$MIGRATE" = "datetime" ]; then
    CURRENT_TIME=$(date +%Y-%m-%dT%H:%M:%S)
    if [ "$CURRENT_TIME" \< "$MIGRATE_DATETIME" ]; then
        echo "Running migrations..."
        php artisan migrate --force
    else
        echo "Skipping migrations, past datetime..."
    fi
else
    echo "Invalid MIGRATE value, skipping migrations..."
fi

exec "$@"
