#!/bin/bash

# Автоматический импорт данных SLURM в XDMoD
# Запускается каждые 15 минут через cron

CLUSTER_NAME="tcluster01"
LOG_FILE="/var/log/slurm-import.log"

echo "$(date): Автоматический импорт данных SLURM" >> $LOG_FILE

# Импорт данных через xdmod-slurm-helper (рекомендуемый метод)
TZ=UTC /usr/share/xdmod/bin/xdmod-slurm-helper -r $CLUSTER_NAME >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "$(date): Данные SLURM успешно импортированы" >> $LOG_FILE
    
    # Запуск ingestor для обработки данных
    /usr/share/xdmod/bin/xdmod-ingestor >> $LOG_FILE 2>&1
    
    if [ $? -eq 0 ]; then
        echo "$(date): Данные успешно обработаны ingestor" >> $LOG_FILE
    else
        echo "$(date): ОШИБКА при обработке данных ingestor" >> $LOG_FILE
    fi
else
    echo "$(date): ОШИБКА при импорте данных через xdmod-slurm-helper" >> $LOG_FILE
fi