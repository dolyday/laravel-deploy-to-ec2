#!/bin/bash

set -e

echo "🧰 Running entrypoint script..."

echo "🔐 Setting permissions for /var/www/html"
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

echo "📄 Copying .env.example to .env..."
if [ ! -f .env ]; then
    cp .env.example .env
fi

echo "📦 Running composer install..."
composer install --no-interaction --prefer-dist --optimize-autoloader

echo "🔑 Generating app key..."
php artisan key:generate

until mysql -h "$DB_HOST" -u "$DB_USERNAME" -p"$DB_PASSWORD" -e "select 1"; do
    echo "Waiting for database..."
    sleep 5
done

# Run migrations
php artisan migrate --force

echo "🧹 Clearing and caching config and routes..."
php artisan config:clear
php artisan config:cache
php artisan route:clear
php artisan route:cache

echo "🚀 Starting Apache..."
exec apache2-foreground
