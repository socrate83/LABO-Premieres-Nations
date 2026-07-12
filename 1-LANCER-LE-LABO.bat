@echo off
chcp 65001 >nul
title LANCER LE LABO

cd /d "%~dp0"

echo.
echo  ==========================================
echo   LABO Premieres Nations
echo   Double-clic = lance le serveur
echo  ==========================================
echo.
echo  Dossier : %CD%
echo.

if not exist "index.html" (
    echo  [ERREUR] Tu n'es pas dans le bon dossier
    echo  ou la version est incomplete.
    echo  Retelecharge le ZIP depuis GitHub.
    goto :fin
)

echo  Fichiers : OK
echo.
echo  Une fenetre va s'ouvrir avec le serveur.
echo  NE LA FERME PAS.
echo  Chrome s'ouvrira sur http://127.0.0.1:8081
echo.
pause

start "LABO serveur 8081" /D "%~dp0" cmd /k LABO.bat

:fin
