@echo off
chcp 65001 >nul
title Modifier l'article Pierre

cd /d "%~dp0"

if not exist "articles\pierre-memoire.html" (
    echo Fichier introuvable.
    pause
    exit /b 1
)

echo.
echo  Ouverture de l'article pour MODIFICATION...
echo  Enregistre Ctrl+S  puis  F5 dans Chrome.
echo.

notepad "%~dp0articles\pierre-memoire.html"
