@echo off
chcp 65001
call vrunner session kill --with-nolock --db %1 --db-user Админ