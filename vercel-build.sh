#!/bin/bash

# Install dependencies
composer install --no-dev
npm ci

# Build the frontend
npm run build

# Prepare Laravel
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan inertia:middleware