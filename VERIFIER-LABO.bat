@echo off
setlocal EnableExtensions
chcp 65001 >nul
title Verification LABO — 127.0.0.1:8081

cd /d "%~dp0"
set "PORT=8081"
set "URL=http://127.0.0.1:%PORT%"

echo.
echo  ========================================
echo   DIAGNOSTIC LABO Premières Nations
echo  ========================================
echo.

echo  [1] Dossier :
echo      %CD%
if exist "index.html" (echo      index.html : OK) else (echo      index.html : MANQUANT — git pull)
if exist "serveur.py" (echo      serveur.py : OK) else (echo      serveur.py : MANQUANT — git pull)
if exist "articles\pierre-memoire.html" (echo      article    : OK) else (echo      article    : MANQUANT)
echo.

echo  [2] Python :
set "FOUND=0"
where py >nul 2>&1 && (py -3 --version 2>nul && set "FOUND=1" && echo      py -3 : OK)
if "%FOUND%"=="0" where python >nul 2>&1 && (python --version 2>nul && set "FOUND=1" && echo      python : OK)
if "%FOUND%"=="0" echo      Python : NON TROUVE
echo.

echo  [3] Port %PORT% sur 127.0.0.1 :
netstat -ano | findstr "127.0.0.1:%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo      ECOUTE sur 127.0.0.1:%PORT% — OK
) else (
    echo      RIEN n'ecoute — serveur non demarre
    netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul 2>&1
    if %errorlevel%==0 echo      (Attention : port occupe ailleurs, pas sur 127.0.0.1)
)
echo.

echo  [4] URL a utiliser dans Chrome :
echo      %URL%
echo      (http:// avec 127.0.0.1 — PAS https://)
echo.

echo  ========================================
echo   QUE FAIRE ?
echo  ========================================
netstat -ano | findstr "127.0.0.1:%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo   Serveur OK — ouvre : %URL%
) else (
    echo   Double-clic LABO.bat ou DEMARRER-LABO.bat
    echo   Garde la fenetre noire OUVERTE
)
echo.
pause
