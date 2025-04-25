#!/bin/bash

# Install dependencies
composer install --no-dev
npm ci
npm run build

# Prepare Laravel
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Create necessary directories
mkdir -p public/build
chmod -R 777 storage bootstrap/cache