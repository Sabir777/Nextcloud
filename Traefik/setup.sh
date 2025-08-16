#!/bin/bash

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Настройка Traefik для fiwa-gik.ru ===${NC}"

# 1. Создание необходимых файлов и директорий
echo -e "${YELLOW}📁 Создание структуры файлов...${NC}"

mkdir -p logs
chmod 755 logs

if [ ! -f "acme.json" ]; then
    touch acme.json
    chmod 600 acme.json
    echo -e "${GREEN}✅ Создан acme.json${NC}"
else
    chmod 600 acme.json
    echo -e "${YELLOW}⚠️ acme.json уже существует, обновлены права доступа${NC}"
fi

# 2. Создание Docker сети
echo -e "${YELLOW}🌐 Создание Docker сети...${NC}"
if ! docker network ls | grep -q "traefik"; then
    docker network create traefik
    echo -e "${GREEN}✅ Сеть traefik создана${NC}"
else
    echo -e "${YELLOW}⚠️ Сеть traefik уже существует${NC}"
fi

# 3. Генерация пароля для dashboard
echo -e "${YELLOW}🔐 Генерация пароля для Traefik Dashboard...${NC}"
read -p "Введите пароль для админа: " -s password
echo ""

if command -v htpasswd &> /dev/null; then
    HASH=$(htpasswd -nb admin "$password")
    echo -e "${GREEN}✅ Хеш пароля сгенерирован:${NC}"
    echo -e "${BLUE}$HASH${NC}"
    echo ""
    echo -e "${YELLOW}📝 Скопируйте этот хеш и замените в middlewares.yml строку:${NC}"
    echo -e "${RED}- \"admin:\$2y\$10\$...\"${NC}"
    echo -e "${YELLOW}на:${NC}"
    echo -e "${BLUE}- \"$HASH\"${NC}"
else
    echo -e "${RED}❌ htpasswd не найден!${NC}"
    echo -e "${YELLOW}Установите: sudo apt install apache2-utils${NC}"
fi

echo ""
echo -e "${BLUE}=== Финальный чек-лист ===${NC}"
echo -e "${YELLOW}1.${NC} Замените email в traefik.yml"
echo -e "${YELLOW}2.${NC} Замените хеш пароля в middlewares.yml"
echo -e "${YELLOW}3.${NC} Проверьте DNS записи: proxy.fiwa-gik.ru, cloud.fiwa-gik.ru, www.fiwa-gik.ru"
echo ""
echo -e "${GREEN}После всех замен запустите:${NC}"
echo -e "${BLUE}docker-compose up -d${NC}"
echo ""
echo -e "${GREEN}Доступ к dashboard:${NC}"
echo -e "${BLUE}https://proxy.fiwa-gik.ru${NC}"
