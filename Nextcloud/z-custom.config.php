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
);
