#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	printf "\033[01;31m[-] Script is not running as root\033[0m\n"
	exit
elif ! which go >/dev/null; then
	printf "\033[01;31m[-] Golang is not installed\033[0m\n"
	exit
fi

go build main.go && cp main /usr/bin/koth

cat << EOF > /etc/systemd/system/koth.service
[Unit]
Description=THM KOTH service

[Service]
User=root
Group=root
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/koth
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload >/dev/null
systemctl enable koth.service >/dev/null 2>&1
systemctl start koth.service >/dev/null

printf "\033[01;32m[+] Service Installed\033[0m\n"
