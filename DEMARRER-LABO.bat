@echo off
chcp 65001 >nul
title LABO Premières Nations — port 8081

:: Se placer dans le dossier du dépôt (là où se trouve ce fichier .bat)
cd /d "%~dp0"

set PORT=8081
set URL=http://localhost:%PORT%

echo.
echo  ========================================
echo   LABO Premières Nations
echo   Serveur local : %URL%
echo  ========================================
echo.

:: Vérifier si le port 8081 est déjà utilisé par notre serveur
netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo  Le port %PORT% est déjà actif.
    echo  Ouverture du navigateur...
    start "" "%URL%"
    echo.
    echo  Si la page ne s'affiche pas, ferme l'autre fenêtre du serveur
    echo  puis relance DEMARRER-LABO.bat
    pause
    exit /b 0
)

:: Trouver Python (py launcher Windows, puis python)
where py >nul 2>&1
if %errorlevel%==0 (
    set PYTHON=py -3
    goto :start
)
where python >nul 2>&1
if %errorlevel%==0 (
    set PYTHON=python
    goto :start
)

echo  ERREUR : Python n'est pas installé ou pas dans le PATH.
echo  Installe Python depuis https://www.python.org/downloads/
echo  Coche "Add Python to PATH" lors de l'installation.
pause
exit /b 1

:start
echo  Démarrage du serveur avec : %PYTHON% -m http.server %PORT%
echo  Laisse cette fenêtre OUVERTE pendant tes essais.
echo  Pour arrêter : Ctrl+C ou ferme la fenêtre.
echo.

:: Ouvrir le navigateur après 1 seconde
start "" cmd /c "timeout /t 1 /nobreak >nul && start %URL%"

:: Lancer le serveur (bloque ici tant que la fenêtre reste ouverte)
%PYTHON% -m http.server %PORT%
