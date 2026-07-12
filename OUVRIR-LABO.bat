@echo off
chcp 65001 >nul
set "URL=http://localhost:8081"

:: Si le serveur ne répond pas, lancer DEMARRER-LABO.bat
powershell -NoProfile -Command "try { (Invoke-WebRequest -Uri '%URL%' -UseBasicParsing -TimeoutSec 2).StatusCode | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
if %errorlevel%==1 (
    echo  Le serveur n'est pas demarre. Lancement de DEMARRER-LABO.bat...
    start "" "%~dp0DEMARRER-LABO.bat"
    exit /b 0
)

start "" "%URL%"
