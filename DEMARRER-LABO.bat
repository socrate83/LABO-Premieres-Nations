@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title LABO serveur port 8081

cd /d "%~dp0"
set "PORT=8081"
set "URL=http://127.0.0.1:%PORT%"

echo.
echo  ========================================
echo   LABO Premières Nations
echo   %URL%
echo  ========================================
echo.

if not exist "index.html" (
    echo  [ERREUR] index.html manquant dans ce dossier.
    echo  Dossier actuel : %CD%
    echo  Fais git pull pour recuperer la derniere version.
    goto :fin
)

if not exist "serveur.py" (
    echo  [ERREUR] serveur.py manquant. Fais git pull.
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
echo  Installe Python : https://www.python.org/downloads/
echo  Coche "Add python.exe to PATH"
goto :fin

:found_python
if defined PYARG (
    echo  [OK] Python : %PYEXE% %PYARG%
    %PYEXE% %PYARG% serveur.py
) else (
    echo  [OK] Python : %PYEXE%
    %PYEXE% serveur.py
)

echo.
echo  Serveur arrete.

:fin
pause
