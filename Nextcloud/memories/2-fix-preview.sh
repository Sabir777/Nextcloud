#!/bin/bash

# 🧠 Установка приложения Recognize (распознавание лиц и объектов)
docker exec -u www-data nextcloud php /var/www/html/occ app:install recognize

# ✅ Включение Recognize
docker exec -u www-data nextcloud php /var/www/html/occ app:enable recognize

# 🖼️ Установка Preview Generator (генератор превью)
docker exec -u www-data nextcloud php /var/www/html/occ app:install previewgenerator

# ✅ Включение Preview Generator
docker exec -u www-data nextcloud php /var/www/html/occ app:enable previewgenerator

# 🔧 Настройка Preview Generator для всех типов файлов
docker exec -u www-data nextcloud php /var/www/html/occ config:app:set previewgenerator squareSizes --value="32 256"
docker exec -u www-data nextcloud php /var/www/html/occ config:app:set previewgenerator widthSizes --value="256 384"
docker exec -u www-data nextcloud php /var/www/html/occ config:app:set previewgenerator heightSizes --value="256"

# 🚀 Генерация превью для всех существующих файлов
docker exec -u www-data nextcloud php /var/www/html/occ preview:generate-all

# 🧠 Настройка Recognize для лучшей производительности
docker exec -u www-data nextcloud php /var/www/html/occ config:app:set recognize nice_binary --value="/usr/bin/nice"
docker exec -u www-data nextcloud php /var/www/html/occ config:app:set recognize tensorflow.gpu --value="false"
docker exec -u www-data nextcloud php /var/www/html/occ config:app:set recognize tensorflow.purejs --value="false"

# 🔄 Запуск начального сканирования Recognize
docker exec -u www-data nextcloud php /var/www/html/occ recognize:classify

# 📊 Переиндексация Memories с новыми возможностями
docker exec -u www-data nextcloud php /var/www/html/occ memories:index --force

# 🛠️ Восстановление системы после всех изменений (ваша команда)
docker exec -u www-data nextcloud php /var/www/html/occ maintenance:repair --include-expensive

# ✅ Проверка статуса установленных приложений
docker exec -u www-data nextcloud php /var/www/html/occ app:list | grep -E "(recognize|previewgenerator)"

# 📈 Проверка статуса Memories после установки
docker exec -u www-data nextcloud php /var/www/html/occ memories:index --stats

# 🔍 Проверка конфигурации Preview Generator
docker exec -u www-data nextcloud php /var/www/html/occ config:list | grep preview

# 🧠 Проверка статуса Recognize
docker exec -u www-data nextcloud php /var/www/html/occ recognize:status
