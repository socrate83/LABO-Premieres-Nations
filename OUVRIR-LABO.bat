@echo off
setlocal EnableExtensions
chcp 65001 >nul
title LABO — Ouvrir localhost 8081

cd /d "%~dp0"
set "URL=http://localhost:8081"
set "PORT=8081"

echo.
echo  LABO Premières Nations
echo  ----------------------
echo.

:: Test sans PowerShell : le port 8081 écoute-t-il ?
netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo  [OK] Serveur actif. Ouverture du navigateur...
    start "" "%URL%"
    timeout /t 3 >nul
    exit /b 0
)

echo  [!] Serveur NON demarre — ERR_CONNECTION_REFUSED si tu ouvres le navigateur seul.
echo.
echo  Lancement de DEMARRER-LABO.bat dans une nouvelle fenetre...
echo  >>> GARDE cette nouvelle fenetre OUVERTE <<<
echo.

start "LABO serveur port 8081" /D "%~dp0" cmd /k DEMARRER-LABO.bat

echo  Attends 3 secondes que le serveur demarre...
timeout /t 3 /nobreak >nul

netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo  [OK] Serveur demarre. Ouverture du navigateur...
    start "" "%URL%"
) else (
    echo  [ERREUR] Le serveur n'a pas demarre.
    echo  Regarde la fenetre "LABO serveur port 8081" pour le message d'erreur.
    echo  Ou lance VERIFIER-LABO.bat pour un diagnostic.
)

echo.
pause
