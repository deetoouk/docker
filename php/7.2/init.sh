#!/bin/bash

echo "Sorting out crontab..."
FILE=/home/crontab

if [ -f "$FILE" ]
then
    echo "Executing: sudo crontab -u root $FILE"
    crontab -u root $FILE
    service cron start
fi

echo "Starting php-fpm..."
php-fpm
