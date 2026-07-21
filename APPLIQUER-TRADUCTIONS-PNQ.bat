@echo off
setlocal EnableExtensions
chcp 65001 >nul
title Publier traductions PNQ

cd /d "%~dp0"

if not exist "docs\pnq-i18n-patch\files\Home.html" (
    echo.
    echo  [ERREUR] Fichiers manquants. Fais git pull dans le LABO.
    echo.
    pause
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0APPLIQUER-TRADUCTIONS-PNQ.ps1" %*
exit /b %ERRORLEVEL%
