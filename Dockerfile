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

# Modificar configuración de PHP-FPM
RUN sed -i 's/pm.max_children = 5/pm.max_children = 10/' /usr/local/etc/php-fpm.d/www.conf

# Exponer el puerto 9000 y especificar el comando para iniciar PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]
