@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title LABO Premières Nations — port 8081

cd /d "%~dp0"

set "PORT=8081"
set "URL=http://localhost:%PORT%"

echo.
echo  ========================================
echo   LABO Premières Nations
echo   Serveur local : %URL%
echo  ========================================
echo.

:: --- Le serveur répond déjà ? ---
powershell -NoProfile -Command "try { (Invoke-WebRequest -Uri '%URL%' -UseBasicParsing -TimeoutSec 2).StatusCode } catch { exit 1 }" >nul 2>&1
if %errorlevel%==0 (
    echo  [OK] Le serveur répond déjà.
    start "" "%URL%"
    pause
    exit /b 0
)

:: --- Trouver Python ---
set "PYEXE="
set "PYARG="

where py >nul 2>&1
if !errorlevel!==0 (
    py -3 --version >nul 2>&1
    if !errorlevel!==0 (
        set "PYEXE=py"
        set "PYARG=-3"
        goto :found_python
    )
)

where python >nul 2>&1
if !errorlevel!==0 (
    python --version >nul 2>&1
    if !errorlevel!==0 (
        set "PYEXE=python"
        goto :found_python
    )
)

where python3 >nul 2>&1
if !errorlevel!==0 (
    python3 --version >nul 2>&1
    if !errorlevel!==0 (
        set "PYEXE=python3"
        goto :found_python
    )
)

echo  [ERREUR] Python introuvable.
echo.
echo  ERR_CONNECTION_REFUSED = aucun serveur ne tourne sur le port %PORT%.
echo.
echo  Étapes :
echo    1. Installe Python : https://www.python.org/downloads/
echo    2. Coche "Add python.exe to PATH" à l'installation
echo    3. Ferme et rouvre l'explorateur de fichiers
echo    4. Double-clic DEMARRER-LABO.bat
echo.
echo  Diagnostic : double-clic VERIFIER-LABO.bat
echo.
pause
exit /b 1

:found_python
if defined PYARG (
    echo  [OK] Python : %PYEXE% %PYARG%
) else (
    echo  [OK] Python : %PYEXE%
)
echo.
echo  IMPORTANT : laisse cette fenêtre OUVERTE.
echo  Si tu la fermes, localhost refusera la connexion.
echo  Pour arrêter le serveur : Ctrl+C
echo.

:: Ouvrir le navigateur après 2 secondes (le temps que le serveur démarre)
start "" cmd /c "timeout /t 2 /nobreak >nul && start %URL%"

:: Serveur au premier plan — tant que cette fenêtre est ouverte, localhost fonctionne
if defined PYARG (
    %PYEXE% %PYARG% -m http.server %PORT%
) else (
    %PYEXE% -m http.server %PORT%
)

echo.
echo  Serveur arrêté. localhost ne répondra plus.
pause
