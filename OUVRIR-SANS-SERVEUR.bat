@echo off
chcp 65001 >nul
title OUVRIR SANS SERVEUR (secours)

cd /d "%~dp0"

echo.
echo  Mode secours : ouvre index.html directement dans Chrome.
echo  (Pas besoin de serveur, mais certains liens peuvent etre limites.)
echo.

if not exist "index.html" (
    echo  index.html manquant dans %CD%
    pause
    exit /b 1
)

start chrome "file:///%CD:\=/%/index.html"
if errorlevel 1 start "" "%CD%\index.html"

echo  Si Chrome ne s'ouvre pas, double-clic sur index.html
pause
