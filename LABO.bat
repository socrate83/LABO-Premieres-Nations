@echo off
chcp 65001 >nul
title LABO serveur 8081

cd /d "%~dp0"

echo.
echo  LABO Premieres Nations
echo  Demarrage du serveur Windows (sans Python)...
echo.

if not exist "index.html" (
    echo  [ERREUR] index.html manquant dans :
    echo  %CD%
    echo.
    echo  Retelecharge le ZIP depuis GitHub.
    pause
    exit /b 1
)

if not exist "serveur-windows.ps1" (
    echo  [ERREUR] serveur-windows.ps1 manquant. Retelecharge le ZIP.
    pause
    exit /b 1
)

:: Lance le serveur PowerShell dans CETTE fenetre (reste ouverte)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0serveur-windows.ps1"
