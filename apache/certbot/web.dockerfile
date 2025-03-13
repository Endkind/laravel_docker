FROM node:23 AS node_builder

WORKDIR /app

COPY . .

RUN npm install \
    && npm run build


FROM php:8.4-apache as runtime

WORKDIR /var/www

RUN rm -rf /var/www/index.html

COPY . .

COPY apache2/http.conf /etc/apache2/sites-available/000-default.conf
COPY apache2/https.conf /etc/apache2/sites-available/default-ssl.conf

COPY --from=node_builder /app/public/build ./public/build

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    libzip-dev \
    libpq-dev \
    postgresql-client \
    certbot \
    cron \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-install pdo pdo_pgsql \
    && composer install --no-dev --optimize-autoloader \
    && chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www \
    && chmod +x /var/www/entrypoint.sh \
    && php artisan key:generate \
    && a2enmod rewrite ssl \
    && a2ensite default-ssl

ENTRYPOINT ["/var/www/entrypoint.sh"]
CMD ["apache2-foreground"]
