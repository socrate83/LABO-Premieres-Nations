@echo off
setlocal EnableExtensions
chcp 65001 >nul
title LABO — Ouvrir 127.0.0.1:8081

cd /d "%~dp0"
set "URL=http://127.0.0.1:8081"
set "PORT=8081"

echo.
echo  LABO Premières Nations
echo  ----------------------
echo  Adresse : %URL%
echo.

netstat -ano | findstr "127.0.0.1:%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo  [OK] Serveur actif. Ouverture de Chrome...
    start chrome "%URL%"
    if errorlevel 1 start "" "%URL%"
    timeout /t 3 >nul
    exit /b 0
)

echo  [!] Serveur non demarre. Lancement...
echo.

start "LABO serveur port 8081" /D "%~dp0" cmd /k DEMARRER-LABO.bat

echo  Attends 4 secondes...
timeout /t 4 /nobreak >nul

netstat -ano | findstr "127.0.0.1:%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo  [OK] Serveur demarre.
    start chrome "%URL%"
    if errorlevel 1 start "" "%URL%"
) else (
    echo  [ERREUR] Le serveur n'a pas demarre.
    echo  Regarde la fenetre "LABO serveur port 8081".
    echo  Ou lance VERIFIER-LABO.bat
)

echo.
pause
