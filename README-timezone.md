# Настройка временных зон в XDMoD

## Проблема
XDMoD требует синхронизации временных зон между всеми компонентами для корректной работы с датами.

## Решение
Все компоненты настроены на UTC:

### 1. Система контейнера
- `TZ=UTC` в docker-compose.yml
- `ln -sf /usr/share/zoneinfo/UTC /etc/localtime` в entrypoint.sh

### 2. PHP
- `date.timezone = UTC` в php.ini (Apache и CLI)

### 3. MySQL
- `default-time-zone = '+00:00'` в my.cnf
- `SET GLOBAL time_zone = '+00:00'` в entrypoint.sh

### 4. XDMoD ресурсы
- Для отображения дат пользователям можно настроить `timezone` в resources.json

## Проверка синхронизации
```bash
docker exec xdmod bash -c '
echo "Container: $(date)"
echo "PHP: $(php -r "echo date(\"Y-m-d H:i:s T\");")"
echo "MySQL: $(mysql -u root -psecure_root_password_123 -se "SELECT NOW(), @@time_zone;")"
'
```

Все компоненты должны показывать одинаковое время в UTC.