#!/bin/bash

# Проверка на запуск от имени root (нужно для управления ufw и установки)
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт через sudo"
  exit
fi

echo "--- Выключение UFW ---"
ufw disable

echo "--- Замена корневого сертификата ---"
bash -c 'cat << EOF > /etc/ipsec.d/cacerts/root_ca.crt
-----BEGIN CERTIFICATE-----
MIIByDCCAW6gAwIBAgIUd8I5tuTW1lIrcKrMmjAiBhYnyHwwCgYIKoZIzj0EAwIw
MzEXMBUGA1UEBRMOMjAyNjAyMTYwMTE5MTMxGDAWBgNVBAMMD0lkZWNvIFVUTSBG
U1RFSzAeFw0yNjAyMTUwMTE5MTNaFw0zNjAyMTQwMTE5MTNaMDMxFzAVBgNVBAUT
DjIwMjYwMjE2MDExOTEzMRgwFgYDVQQDDA9JZGVjbyBVVE0gRlNURUswWTATBgcq
hkjOPQIBBggqhkjOPQMBBwNCAATCcWtfYDuLEpnHFsX84SMn3HPVul4/pQtS+9nD
9Jt8z+H2x1Z2Ri5nKP9FGDxh0j6nMqldfv6XTm6jsY4yQNmfo2AwXjAdBgNVHQ4E
FgQUy+Sz7V0IcIctKIiU5XFa8wOyXrIwDwYDVR0TAQH/BAUwAwEB/zALBgNVHQ8E
BAMCAYYwHwYDVR0jBBgwFoAUy+Sz7V0IcIctKIiU5XFa8wOyXrIwCgYIKoZIzj0E
AwIDSAAwRQIhAI1YgmFzl0SBIiZZsnNA6X0YwPAVgiL1emLq1C/etfVrAiBiMLK2
yFu7kJfgOknw3vx3rud1YV63czR1XaF1H79pWg==
-----END CERTIFICATE-----
EOF'

echo "--- Перезапуск службы IPSec ---"
ipsec restart

echo "--- Включение UFW ---"
ufw enable

seconds=10
echo "Внимание! Компьютер перезагрузится через $seconds секунд."

while [ $seconds -gt 0 ]; do
    echo -ne "Осталось: $seconds сек. \r"
    sleep 1
    : $((seconds--))
done

echo -e "\nВыполняю перезагрузку..."
reboot now
