@echo off
chcp 65001 >nul
title AIDE LABO — Lis ceci en premier

cd /d "%~dp0"

echo.
echo  ====================================================
echo   LABO Premieres Nations
echo   AIDE RAPIDE — pas besoin de terminal
echo  ====================================================
echo.
echo  1. Double-clic LABO.bat  (dans ce meme dossier)
echo  2. Une fenetre NOIRE s'ouvre — NE PAS la fermer
echo  3. Chrome s'ouvre sur http://127.0.0.1:8081
echo.
echo  Tu es dans le dossier :
echo  %CD%
echo.
echo  Fichiers necessaires :
if exist "LABO.bat" (echo    LABO.bat          OK) else (echo    LABO.bat          MANQUANT)
if exist "index.html" (echo    index.html        OK) else (echo    index.html        MANQUANT)
if exist "serveur.py" (echo    serveur.py        OK) else (echo    serveur.py        MANQUANT)
echo.
echo  ====================================================
echo  Appuie sur une touche pour LANCER le labo maintenant...
pause >nul

call "%~dp0LABO.bat"
