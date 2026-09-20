@echo off
setlocal
chcp 65001 >nul
title Publier site Premieres Nations Quebec

cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0PUBLIER-SITE-PNQ.ps1" %*
exit /b %ERRORLEVEL%
