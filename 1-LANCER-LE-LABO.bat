@echo off
chcp 65001 >nul
title LABO serveur 8081 — NE PAS FERMER

cd /d "%~dp0"

echo.
echo  ==========================================
echo   LABO Premieres Nations
echo   http://127.0.0.1:8081
echo  ==========================================
echo.
echo  Dossier : %CD%
echo.

if not exist "index.html" (
    echo  [ERREUR] index.html manquant.
    echo  Retelecharge le ZIP depuis GitHub.
    goto :fin
)

if not exist "serveur-windows.ps1" (
    echo  [ERREUR] serveur-windows.ps1 manquant.
    echo  Retelecharge le ZIP depuis GitHub.
    goto :fin
)

echo  Demarrage... NE FERME PAS cette fenetre.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0serveur-windows.ps1"

:fin
pause
