#!/bin/sh
set -e

until pg_isready -h db -p 5432; do
    echo "Waiting for the database..."
    sleep 2
done

echo "Running migrations..."
php artisan migrate --force

exec "$@"
