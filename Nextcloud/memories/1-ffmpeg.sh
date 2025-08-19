#!/bin/bash

# 🔧 Установка ffmpeg (требует root прав)
docker exec -u root nextcloud bash -c "apt-get update && apt-get install -y ffmpeg imagemagick ghostscript"

# ✅ Проверка установки ffmpeg
docker exec -u www-data nextcloud which ffmpeg

# ✅ Проверка версии ffmpeg  
docker exec -u www-data nextcloud ffmpeg -version

# 🔗 Создание символических ссылок для совместимости
docker exec -u root nextcloud bash -c "ln -sf /usr/bin/ffmpeg /usr/local/bin/ffmpeg && ln -sf /usr/bin/ffprobe /usr/local/bin/ffprobe"

# 🔄 Переиндексация Memories после установки ffmpeg
docker exec -u www-data nextcloud php /var/www/html/occ memories:index --force

# 🖼️ Генерация превью для существующих медиафайлов
docker exec -u www-data nextcloud php /var/www/html/occ preview:generate-all

# 🛠️ Восстановление системы после изменений (ваша команда)
docker exec -u www-data nextcloud php /var/www/html/occ maintenance:repair --include-expensive

# 📊 Проверка статуса Memories
docker exec -u www-data nextcloud php /var/www/html/occ memories:index --stats

# 🧹 Очистка кеша приложений
docker exec -u www-data nextcloud php /var/www/html/occ files:cleanup

# 🔍 Проверка конфигурации Memories
docker exec -u www-data nextcloud php /var/www/html/occ config:list | grep memories

# 📝 Проверка логов на ошибки
docker exec -u www-data nextcloud php /var/www/html/occ log:file --lines=20
