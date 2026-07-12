@echo off
chcp 65001 >nul
title Modifier index.html

cd /d "%~dp0"

if not exist "index.html" (
    echo index.html introuvable dans %CD%
    pause
    exit /b 1
)

echo.
echo  Ouverture de index.html pour MODIFICATION...
echo  Enregistre avec Ctrl+S quand tu as fini.
echo  Puis F5 dans Chrome pour voir le resultat.
echo.

notepad "%~dp0index.html"
