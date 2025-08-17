<?php
/**
 * NextCloud дополнительная конфигурация
 * Поместите этот файл в ./nextcloud/config/z-custom.config.php
 * после первоначальной установки NextCloud
 */

$CONFIG = array_merge($CONFIG, [
    // 🌐 Доверенные домены и прокси
    'trusted_domains' => [
        'cloud.fiwa-gik.ru',
        'localhost'
    ],
    'trusted_proxies' => [
        '172.16.0.0/12',
        '10.0.0.0/8',
        '192.168.0.0/16'
    ],
    'overwritehost' => 'cloud.fiwa-gik.ru',
    'overwriteprotocol' => 'https',
    'overwritewebroot' => '',
    'overwritecondaddr' => '',
    'forwarded_for_headers' => ['HTTP_X_FORWARDED_FOR', 'HTTP_FORWARDED_FOR'],
    
    // 🔴 Redis конфигурация
    'memcache.distributed' => '\OC\Memcache\Redis',
    'memcache.locking' => '\OC\Memcache\Redis',
    'memcache.local' => '\OC\Memcache\APCu',
    'redis' => [
        'host' => 'nextcloud-redis',
        'port' => 6379,
        'timeout' => 0.0,
        'password' => getenv('REDIS_PASSWORD'),
        'dbindex' => 0,
    ],
    
    // 📧 Mail конфигурация (настройте под свой SMTP)
    'mail_from_address' => 'noreply',
    'mail_domain' => 'fiwa-gik.ru',
    'mail_smtpmode' => 'smtp',
    'mail_smtphost' => 'smtp.yandex.ru',
    'mail_smtpport' => 587,
    'mail_smtpsecure' => 'tls',
    'mail_smtpauth' => 1,
    'mail_smtpauthtype' => 'LOGIN',
    // 'mail_smtpname' => 'your-email@yandex.ru',
    // 'mail_smtppassword' => 'your-app-password',
    
    // 🚀 Производительность
    'htaccess.RewriteBase' => '/',
    'default_phone_region' => 'RU',
    'default_locale' => 'ru_RU',
    'default_language' => 'ru',
    'logtimezone' => 'Europe/Moscow',
    'log_type' => 'file',
    'logfile' => '/var/www/html/data/nextcloud.log',
    'loglevel' => 2, // 0=debug, 1=info, 2=warn, 3=error
    'logdateformat' => 'F d, Y H:i:s',
    
    // 🔐 Безопасность
    'auth.bruteforce.protection.enabled' => true,
    'ratelimit.protection.enabled' => true,
    'csrf.disabled' => false,
    'check_for_working_wellknown_setup' => false,
    'check_for_working_htaccess' => false,
    
    // 📁 Файлы
    'filesystem_check_changes' => 1,
    'part_file_in_storage' => false,
    'enable_previews' => true,
    'preview_max_x' => 2048,
    'preview_max_y' => 2048,
    'preview_max_scale_factor' => 10,
    'preview_max_filesize_image' => 50, // MB
    'enabledPreviewProviders' => [
        'OC\Preview\PNG',
        'OC\Preview\JPEG',
        'OC\Preview\GIF',
        'OC\Preview\BMP',
        'OC\Preview\XBitmap',
        'OC\Preview\MP3',
        'OC\Preview\MP4',
        'OC\Preview\AVI',
        'OC\Preview\Movie',
        'OC\Preview\PDF',
        'OC\Preview\TXT',
        'OC\Preview\MarkDown'
    ],
    
    // 🔄 Обновления и приложения
    'updater.release.channel' => 'stable',
    'has_rebuilt_cache' => true,
    'maintenance_window_start' => 3, // 3 AM maintenance window
    
    // 📊 Метрики и мониторинг
    'enable_certificate_management' => false, // Traefik handles SSL
    'integrity.check.disabled' => false,
    'upgrade.disable-web' => false,
    
    // 🗃️ База данных
    'mysql.utf8mb4' => true,
    'dbdriveroptions' => [
        1002 => 'SET sql_mode="STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"'
    ],
    
    // 🎛️ Прочие настройки
    'sharing.force_share_accept' => false,
    'sharing.enable_share_accept' => false,
    'simpleSignUpLink.shown' => false,
    'knowledgebaseenabled' => false,
    'allow_user_to_change_mail_address' => false,
    
    // 🔌 App Store
    'appstoreenabled' => true,
    'apps_paths' => [
        [
            'path' => '/var/www/html/apps',
            'url' => '/apps',
            'writable' => false,
        ],
        [
            'path' => '/var/www/html/custom_apps',
            'url' => '/custom_apps',
            'writable' => true,
        ],
    ],
]);
