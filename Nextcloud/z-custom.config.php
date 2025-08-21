<?php
if (!isset($CONFIG) || !is_array($CONFIG)) {
    $CONFIG = array();
}

$CONFIG += array(
    // 📱 Установка региона по умолчанию для телефонных номеров
    'default_phone_region' => 'RU',

    // 🌐 Принудительное использование HTTPS
    'overwriteprotocol' => 'https',

    // 🛡️ Обработка заголовков от обратного прокси
    'forwarded_for_headers' => ['HTTP_X_FORWARDED_FOR', 'HTTP_X_REAL_IP'],

    // 🚫 Отключение веб-интерфейса обновления
    'upgrade.disable-web' => true,

    // 🧠 Указание доверенных прокси (Traefik в Docker-сети)
    'trusted_proxies' => [
        '172.18.0.0/16',
    ],

    // 🕒 Настройка окна обслуживания (время запуска фоновых задач)
    'maintenance_window_start' => 3, // 3:00 ночи

    // 🧭 (опционально) Принудительное указание хоста, если требуется
    // 'overwritehost' => 'cloud.example.com',

    // 🎬 НАСТРОЙКИ ПРЕВЬЮ ВИДЕО
    // Включение превью
    'enable_previews' => true,
    'preview_max_x' => 2048,
    'preview_max_y' => 2048,
    
    // Путь к ffmpeg для обработки видео
    'preview_ffmpeg_path' => '/usr/bin/ffmpeg',
    
    // Настройки качества превью для видео
    'movie_max_x' => 1920,
    'movie_max_y' => 1080,
    
    // Включенные провайдеры превью
    'enabledPreviewProviders' => [
        'OC\\Preview\\PNG',
        'OC\\Preview\\JPEG',
        'OC\\Preview\\GIF',
        'OC\\Preview\\BMP',
        'OC\\Preview\\XBitmap',
        'OC\\Preview\\Movie',    // ← Превью для видео
        'OC\\Preview\\PDF',
        'OC\\Preview\\MP3',
        'OC\\Preview\\TXT',
        'OC\\Preview\\MarkDown',
        'OC\\Preview\\OpenDocument',
        'OC\\Preview\\MSOffice2003',
        'OC\\Preview\\MSOffice2007',
        'OC\\Preview\\MSOfficeDoc',
        'OC\\Preview\\HEIC',
    ],
    
    // 🖼️ ДОПОЛНИТЕЛЬНЫЕ НАСТРОЙКИ ПРЕВЬЮ
    // Максимальный размер файла для генерации превью (в байтах)
    'preview_max_filesize_image' => 50, // 50 MB для изображений
    
    // Настройки кэша превью
    'preview_libreoffice_path' => '/usr/bin/libreoffice',
    'preview_office_cl_parameters' => '--headless --nologo --nofirststartwizard --invisible --norestore --convert-to pdf --outdir ',
);
