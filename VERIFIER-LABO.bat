@echo off
setlocal EnableExtensions
chcp 65001 >nul
title Vérification LABO — localhost 8081

cd /d "%~dp0"

set "PORT=8081"
set "URL=http://localhost:%PORT%"

echo.
echo  ========================================
echo   DIAGNOSTIC LABO Premières Nations
echo  ========================================
echo.

:: 1. Dossier
echo  [1] Dossier du labo :
echo      %CD%
if exist "index.html" (
    echo      index.html : OK
) else (
    echo      index.html : MANQUANT — fais git pull ou récupère la dernière version
)
if exist "articles\pierre-memoire.html" (
    echo      article pierre-memoire : OK
) else (
    echo      article pierre-memoire : MANQUANT
)
echo.

:: 2. Python
echo  [2] Python :
set "FOUND=0"
where py >nul 2>&1 && (py -3 --version 2>nul && set "FOUND=1" && echo      py -3 : OK)
if "%FOUND%"=="0" where python >nul 2>&1 && (python --version 2>nul && set "FOUND=1" && echo      python : OK)
if "%FOUND%"=="0" where python3 >nul 2>&1 && (python3 --version 2>nul && set "FOUND=1" && echo      python3 : OK)
if "%FOUND%"=="0" (
    echo      Python : NON TROUVE
    echo      ^> Installe Python avec "Add to PATH" coche
)
echo.

:: 3. Port 8081
echo  [3] Port %PORT% :
netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo      Port %PORT% : OCCUPE (un serveur tourne peut-etre)
) else (
    echo      Port %PORT% : LIBRE (aucun serveur — normal si DEMARRER-LABO pas lance)
)
echo.

:: 4. Test HTTP
echo  [4] Test http://localhost:%PORT% :
powershell -NoProfile -Command "try { $r = Invoke-WebRequest -Uri '%URL%' -UseBasicParsing -TimeoutSec 3; Write-Host '      HTTP' $r.StatusCode '- SERVEUR OK' } catch { Write-Host '      REFUSE - serveur non demarre (ERR_CONNECTION_REFUSED)' }"
echo.

:: 5. Conclusion
echo  ========================================
echo   QUE FAIRE ?
echo  ========================================
echo.
powershell -NoProfile -Command "try { (Invoke-WebRequest -Uri '%URL%' -UseBasicParsing -TimeoutSec 2).StatusCode | Out-Null; Write-Host '  Le serveur fonctionne. Double-clic OUVRIR-LABO.bat' } catch { Write-Host '  Double-clic DEMARRER-LABO.bat' ; Write-Host '  Garde la fenetre noire OUVERTE' ; Write-Host '  Puis va sur : %URL%' }"
echo.
pause
