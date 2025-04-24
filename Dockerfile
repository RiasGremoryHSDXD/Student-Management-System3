# -----------------------------
# Stage 1: Build React/Vite assets
# -----------------------------
    FROM node:18-alpine AS assets
    WORKDIR /app
    
    # Install JS deps & build
    COPY package*.json ./
    RUN npm ci
    COPY . .
    RUN npm run build
    
    # -----------------------------
    # Stage 2: Install PHP deps
    # -----------------------------
    FROM composer:2 AS php-deps
    WORKDIR /app
    
    # Copy only composer files for caching
    COPY composer.json composer.lock ./
    RUN composer install \
        --no-dev \
        --optimize-autoloader \
        --no-interaction
    
    # -----------------------------
    # Stage 3: Final PHP-FPM image
    # -----------------------------
    FROM richarvey/nginx-php-fpm:latest
    # Tell Nginx which folder to serve
    ENV WEBROOT /var/www/html/public                                    :contentReference[oaicite:2]{index=2}
    ENV PHP_ERRORS_STDERR 1                                             :contentReference[oaicite:3]{index=3}
    ENV RUN_SCRIPTS 1                                                   :contentReference[oaicite:4]{index=4}
    ENV REAL_IP_HEADER 1
    ENV APP_ENV production
    ENV APP_DEBUG false
    ENV LOG_CHANNEL stderr
    ENV COMPOSER_ALLOW_SUPERUSER 1
    
    WORKDIR /var/www/html
    
    # Copy application code
    COPY . .
    
    # Copy Composer’s vendor directory
    COPY --from=php-deps /app/vendor ./vendor
    
    # Copy built frontend into public/build
    COPY --from=assets /app/public/build ./public/build
    
    # Ensure Laravel can write to storage & cache
    RUN chown -R www-data:www-data storage bootstrap/cache
    
    # Expose and start
    EXPOSE 80
    CMD ["/start.sh"]