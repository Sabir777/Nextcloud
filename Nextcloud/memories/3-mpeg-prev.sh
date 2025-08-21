#!/bin/bash

echo "🔄 Начинаем переиндексацию Memories..."

# Очистить существующий индекс Memories
echo "📂 Очистка индекса Memories..."
docker exec -u www-data nextcloud php /var/www/html/occ memories:index --clear

# Переиндексировать все файлы
echo "🔍 Индексация файлов..."
docker exec -u www-data nextcloud php /var/www/html/occ memories:index

# Принудительно сгенерировать превью для всех файлов
echo "🖼️ Генерация превью для всех файлов..."
docker exec -u www-data nextcloud php /var/www/html/occ preview:generate-all

# Более точечная генерация превью
echo "📹 Генерация превью для видео..."
docker exec -u www-data nextcloud php /var/www/html/occ preview:pre-generate

# Проверка статуса
echo "✅ Проверка статуса Memories..."
docker exec -u www-data nextcloud php /var/www/html/occ memories:index --force

echo "🎉 Переиндексация завершена!"
