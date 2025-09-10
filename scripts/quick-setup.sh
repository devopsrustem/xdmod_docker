#!/bin/bash
set -e

echo "Быстрая настройка XDMoD..."

# Создание конфигурационных файлов напрямую
mkdir -p /etc/xdmod

# portal_settings.ini
cat > /etc/xdmod/portal_settings.ini << 'EOF'
[general]
title = "Open XDMoD"
site_address = "https://10.36.80.9:8443/"
email_from = "admin@local"
email_to = "admin@local"
chromium_path = ""
center_logo = ""
dashboard = "on"

[database]
host = "localhost"
port = "3306"
user = "xdmod"
pass = "secure_xdmod_password_123"

[datawarehouse]
host = "localhost"
port = "3306"
user = "xdmod"
pass = "secure_xdmod_password_123"

[logger]
host = "localhost"
port = "3306"
user = "xdmod"
pass = "secure_xdmod_password_123"

[shredder]
host = "localhost"
port = "3306"
user = "xdmod"
pass = "secure_xdmod_password_123"

[hpcdb]
host = "localhost"
port = "3306"
user = "xdmod"
pass = "secure_xdmod_password_123"
EOF

# organization.json
cat > /etc/xdmod/organization.json << 'EOF'
{
    "name": "Test Organization",
    "abbrev": "TO"
}
EOF

# resources.json
cat > /etc/xdmod/resources.json << 'EOF'
[
    {
        "resource": "tcluster01",
        "name": "testcluster01",
        "description": "Test Cluster 01",
        "resource_type": "HPC",
        "resource_allocation_type": "GPU"
    }
]
EOF

# resource_specs.json
cat > /etc/xdmod/resource_specs.json << 'EOF'
[
    {
        "resource": "tcluster01",
        "start_date": "2025-09-03",
        "cpu_node_count": 2,
        "cpu_processor_count": 512,
        "cpu_ppn": 256,
        "gpu_node_count": 2,
        "gpu_processor_count": 16,
        "gpu_ppn": 8
    }
]
EOF

echo "Инициализация баз данных XDMoD..."
xdmod-ingestor --bootstrap

echo "Создание администратора..."
mysql -u root -psecure_root_password_123 << 'EOF'
USE moddb;
INSERT IGNORE INTO Users (id, username, email_address, first_name, last_name, time_created, time_last_updated, account_is_active, person_id, user_type, password_last_updated) 
VALUES (1, 'admin', 'admin@localhost', 'Admin', 'User', NOW(), NOW(), 1, 1, 1, NOW());

INSERT IGNORE INTO UserRoles (user_id, role_id, is_active, is_primary) 
VALUES (1, 1, 1, 1);

UPDATE Users SET password = MD5('admin123') WHERE username = 'admin';
EOF

echo "Настройка ACL..."
acl-config

echo "XDMoD настроен успешно!"
echo "URL: https://10.36.80.9:8443/"
echo "Логин: admin"
echo "Пароль: admin123"