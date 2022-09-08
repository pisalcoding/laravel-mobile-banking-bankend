FROM php:8.1.0-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user
RUN chown -R www-data:www-data /var/www
RUN chown -R $user:$user /var/www
RUN chmod -R g+w /var/www/

# Set working directory
WORKDIR /var/www

# Installing Dependency
COPY composer.json ./
RUN composer install --no-scripts

COPY .env.example .env
RUN php artisan key:generate

# Setup storage & permissions
RUN chmod -R 777 ./storage/ &&\
    chmod -R 775 . &&\
    chown -R nginx.nginx . &&\
    chmod -R 777 ./storage/ &&\
    semanage fcontext -a -t httpd_sys_rw_content_t './bootstrap/cache(/.*)?' || true &&\
    semanage fcontext -a -t httpd_sys_rw_content_t './storage(/.*)?' || true &&\
    restorecon -Rv '.' || true
RUN php artisan storage:link || true

