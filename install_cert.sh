#!/bin/bash

# Проверка на запуск от имени root (нужно для управления ufw и установки)
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт через sudo"
  exit
fi



echo "--- Перезапуск службы IPSec ---"
#ipsec restart

exit
sleep 1
pkill -u $USER

#seconds=10
#echo "Внимание! Компьютер перезагрузится через $seconds секунд."
#
#while [ $seconds -gt 0 ]; do
#    echo -ne "Осталось: $seconds сек. \r"
#    sleep 1
#    : $((seconds--))
#done
#
#echo -e "\nВыполняю перезагрузку..."
#reboot now
