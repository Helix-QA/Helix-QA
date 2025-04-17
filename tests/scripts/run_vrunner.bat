@echo off
chcp 65001
if "%1"=="session_kill" call vrunner session kill --settings    tests/tools/vrunner.json
if "%1"=="loadrepo" call vrunner loadrepo --settings            tests/tools/vrunner.json
if "%1"=="updatedb" call vrunner updatedb --settings            tests/tools/vrunner.json
if "%1"=="unload" call vrunner unload --settings                tests/tools/vrunner.json
if "%1"=="unload" call vrunner unload --settings                tests/tools/vrunner.json
if "%1"=="unload" call vrunner unload --settings                tests/tools/vrunner.json
