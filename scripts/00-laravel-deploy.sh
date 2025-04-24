#!/usr/bin/env bash
set -e

echo "Running Composer install..."
composer install \
    --no-dev \
    --optimize-autoloader \
    --working-dir=/var/www/html                 :contentReference[oaicite:10]{index=10}

echo "Generating application key..."
php artisan key:generate --ansi               :contentReference[oaicite:11]{index=11}

echo "Clearing caches..."
php artisan optimize:clear

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Migrating database..."
php artisan migrate --force

echo "Deploy script complete."
