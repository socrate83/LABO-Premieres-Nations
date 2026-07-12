@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title LABO serveur port 8081

cd /d "%~dp0"
set "PORT=8081"
set "URL=http://localhost:%PORT%"

echo.
echo  ========================================
echo   LABO Premières Nations
echo   %URL%
echo  ========================================
echo.

:: Serveur deja actif ?
netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul 2>&1
if %errorlevel%==0 (
    echo  [OK] Le serveur tourne deja sur le port %PORT%.
    start "" "%URL%"
    goto :fin
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

echo  [ERREUR] Python introuvable.
echo.
echo  ERR_CONNECTION_REFUSED = aucun serveur ne tourne.
echo.
echo  1. Installe Python : https://www.python.org/downloads/
echo  2. Coche "Add python.exe to PATH"
echo  3. Relance ce fichier
echo.
goto :fin

:found_python
if defined PYARG (
    echo  [OK] Python : %PYEXE% %PYARG%
) else (
    echo  [OK] Python : %PYEXE%
)
echo.
echo  >>> NE FERME PAS cette fenetre <<<
echo  Tant qu'elle est ouverte, %URL% fonctionne.
echo  Arret : Ctrl+C ou fermer la fenetre.
echo.

start "" cmd /c "timeout /t 2 /nobreak >nul && start %URL%"

if defined PYARG (
    %PYEXE% %PYARG% -m http.server %PORT%
) else (
    %PYEXE% -m http.server %PORT%
)

echo.
echo  Serveur arrete.

:fin
pause
