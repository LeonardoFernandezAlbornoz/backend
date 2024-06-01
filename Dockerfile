FROM php:8.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar extensiones de PHP
RUN docker-php-ext-install pdo pdo_mysql zip intl mbstring xml

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo
WORKDIR /var/www/symfony

# Copiar los archivos del proyecto
COPY . .

# Copiar archivos de Composer y instalar dependencias
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --ignore-platform-reqs --no-interaction --prefer-dist

# Cambiar permisos para el almacenamiento de caché y logs
RUN chown -R www-data:www-data /var/www/symfony/var

EXPOSE 9000
CMD ["php-fpm"]