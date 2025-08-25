# Создайте структуру папок:
mkdir -p coturn talk-signaling redis nats janus

# 1. coturn/turnserver.conf
cat > coturn/turnserver.conf << 'EOF'
listening-port=3478
tls-listening-port=5349

# Диапазон портов для relay
min-port=49152
max-port=49172

# Включить verbose логи (отключите в продакшене)
verbose

# Имя сервера (замените на ваш домен)
server-name=turn.fiwa-gik.ru
realm=fiwa-gik.ru

# Включить долгосрочные credentials
use-auth-secret
static-auth-secret=ВАША_СЕКРЕТНАЯ_СТРОКА_ЗАМЕНИТЕ_ЭТО

# Запретить loopback адреса
no-loopback-peers
no-multicast-peers

# Включить fingerprint
fingerprint

# Certificats (пути к сертификатам от Let's Encrypt через Traefik)
cert=/etc/letsencrypt/live/turn.fiwa-gik.ru/fullchain.pem
pkey=/etc/letsencrypt/live/turn.fiwa-gik.ru/privkey.pem

# Логирование
log-file=stdout
syslog
EOF

# 2. talk-signaling/server.conf  
cat > talk-signaling/server.conf << 'EOF'
[http]
listen = 0.0.0.0:8080

[https]
listen = 0.0.0.0:8443
certificate = /etc/letsencrypt/live/signaling.fiwa-gik.ru/fullchain.pem
key = /etc/letsencrypt/live/signaling.fiwa-gik.ru/privkey.pem

[app]
debug = false

# Токен для аутентификации с Nextcloud (сгенерируйте случайную строку)
token = СГЕНЕРИРУЙТЕ_СЛУЧАЙНУЮ_СТРОКУ_64_СИМВОЛА

[sessions]
hashkey = СГЕНЕРИРУЙТЕ_СЛУЧАЙНУЮ_СТРОКУ_32_СИМВОЛА
blockkey = СГЕНЕРИРУЙТЕ_СЛУЧАЙНУЮ_СТРОКУ_32_СИМВОЛА

[clients]
internalsecret = СГЕНЕРИРУЙТЕ_СЛУЧАЙНУЮ_СТРОКУ_64_СИМВОЛА

[backend]
allowed = cloud.fiwa-gik.ru
secret = NEXTCLOUD_SHARED_SECRET
timeout = 10
connectionsperhost = 8

[nats]
url = nats://nats:4222

[mcu]
type = janus
url = ws://janus:8188/janus

[turn]
api = http://coturn:8080/
secret = ВАША_СЕКРЕТНАЯ_СТРОКА_ИЗ_COTURN
servers = turn:turn.fiwa-gik.ru:3478?transport=udp,turn:turn.fiwa-gik.ru:3478?transport=tcp
EOF

# 3. redis/redis.conf
cat > redis/redis.conf << 'EOF'
# Базовая конфигурация Redis для Talk
bind 0.0.0.0
port 6379
protected-mode no
timeout 0
keepalive 300

# Настройки сохранения
save 900 1
save 300 10  
save 60 10000

# Логирование
loglevel notice
logfile ""

# Настройки памяти
maxmemory 256mb
maxmemory-policy allkeys-lru

# Отключить опасные команды
rename-command FLUSHDB ""
rename-command FLUSHALL ""
rename-command KEYS ""
rename-command CONFIG ""
rename-command DEBUG ""
EOF

# 4. nats/nats.conf
cat > nats/nats.conf << 'EOF'
# NATS server configuration for Talk
port: 4222
http_port: 8222

# Логирование
log_file: "/var/log/nats.log"
logtime: true
debug: false
trace: false

# Лимиты
max_connections: 1000
max_control_line: 4096
max_payload: 65536
max_pending: 67108864

# Кластеринг отключен для простой установки
cluster {
  port: 6222
}

# Мониторинг
monitor_port: 8222
EOF

# 5. janus/janus.jcfg (основная конфигурация Janus)
mkdir -p janus
cat > janus/janus.jcfg << 'EOF'
general: {
    configs_folder = "/opt/janus/etc/janus"
    plugins_folder = "/opt/janus/lib/janus/plugins"
    transports_folder = "/opt/janus/lib/janus/transports"
    events_folder = "/opt/janus/lib/janus/events"
    
    log_to_stdout = true
    debug_level = 4
    
    interface = "0.0.0.0"
    plugins_disabled = []
    
    session_timeout = 60
    reclaim_session_timeout = 0
    
    server_name = "Janus WebRTC Server"
    pid_file = "/tmp/janus.pid"
}

certificates: {
    cert_pem = "/etc/letsencrypt/live/janus.fiwa-gik.ru/fullchain.pem"
    cert_key = "/etc/letsencrypt/live/janus.fiwa-gik.ru/privkey.pem"
}

media: {
    ipv6 = false
    max_nack_queue = 1000
    rtp_port_range = "20000-20020"
}
EOF

echo "Конфигурационные файлы созданы!"
echo "Не забудьте:"
echo "1. Заменить все ЗАГЛАВНЫЕ_СТРОКИ на реальные значения"
echo "2. Сгенерировать секретные ключи"
echo "3. Настроить DNS записи для поддоменов"
echo "4. Добавить энтрипоинты в Traefik для нестандартных портов"
