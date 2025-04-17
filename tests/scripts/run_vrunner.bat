@echo off
chcp 65001
if "%1"=="session_kill" call vrunner session kill --settings tests/tools/vrunner.json
if "%1"=="loadrepo" call vrunner loadrepo --settings %2
if "%1"=="updatedb" call vrunner updatedb --settings %2