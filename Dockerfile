FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy composer files first for better caching
COPY composer.* ./

# Install dependencies with increased memory limit
RUN php -d memory_limit=-1 /usr/bin/composer install --no-interaction --no-dev --optimize-autoloader --verbose

# Copy the rest of the application
COPY . /var/www/html/

# Configure Apache
# Make sure the docker directory exists
RUN mkdir -p /var/www/html/docker

# Copy the Apache configuration
COPY docker/000-default.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache modules
RUN a2enmod rewrite

# Set permissions
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache && \
    chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]