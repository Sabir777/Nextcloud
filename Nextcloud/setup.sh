#!/bin/bash

# 🎨 Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 NextCloud Setup Script${NC}"
echo "================================"

# Проверка существования сети traefik
if ! docker network ls | grep -q traefik; then
    echo -e "${RED}❌ Сеть 'traefik' не найдена!${NC}"
    echo -e "${YELLOW}💡 Создаю сеть traefik...${NC}"
    docker network create traefik
    echo -e "${GREEN}✅ Сеть traefik создана${NC}"
fi

# Создание директорий
echo -e "${YELLOW}📁 Создание директорий...${NC}"
mkdir -p ./nextcloud/{config,data,apps,themes}
mkdir -p ./logs

# Установка прав доступа
echo -e "${YELLOW}🔐 Установка прав доступа...${NC}"
chown -R 33:33 ./nextcloud/
chmod -R 755 ./nextcloud/

# Проверка .env файла
if [ ! -f .env ]; then
    echo -e "${RED}❌ Файл .env не найден!${NC}"
    echo -e "${YELLOW}💡 Создайте .env файл с необходимыми переменными${NC}"
    exit 1
fi

# Валидация переменных окружения
source .env
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$REDIS_PASSWORD" ] || [ -z "$NEXTCLOUD_ADMIN_PASSWORD" ]; then
    echo -e "${RED}❌ Не все переменные окружения установлены!${NC}"
    echo -e "${YELLOW}💡 Проверьте файл .env${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Все проверки пройдены!${NC}"
echo ""
echo -e "${BLUE}🐳 Запуск NextCloud...${NC}"
echo "================================"

# Запуск сервисов
docker compose up -d

# Ожидание запуска
echo -e "${YELLOW}⏳ Ожидание запуска сервисов (60 секунд)...${NC}"
sleep 60

# Проверка статуса
echo ""
echo -e "${BLUE}📊 Статус сервисов:${NC}"
docker compose ps

echo ""
echo -e "${GREEN}🎉 NextCloud должен быть доступен по адресу:${NC}"
echo -e "${BLUE}https://cloud.fiwa-gik.ru${NC}"
echo ""
echo -e "${YELLOW}📝 Данные для входа:${NC}"
echo "Пользователь: $NEXTCLOUD_ADMIN_USER"
echo "Пароль: $NEXTCLOUD_ADMIN_PASSWORD"
echo ""
echo -e "${YELLOW}🔧 Полезные команды:${NC}"
echo "docker compose logs -f nextcloud     # Логи NextCloud"
echo "docker compose logs -f nextcloud-db  # Логи базы данных"
echo "docker compose exec nextcloud bash   # Войти в контейнер"
echo "docker compose down                  # Остановить все сервисы"
echo ""

# Проверка доступности
echo -e "${YELLOW}🔍 Проверка доступности...${NC}"
sleep 10

if curl -sSf https://cloud.fiwa-gik.ru > /dev/null 2>&1; then
    echo -e "${GREEN}✅ NextCloud доступен!${NC}"
else
    echo -e "${RED}❌ NextCloud пока недоступен. Проверьте логи:${NC}"
    echo "docker compose logs nextcloud"
fi
