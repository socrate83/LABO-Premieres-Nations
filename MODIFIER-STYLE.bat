@echo off
chcp 65001 >nul
title Modifier le style CSS

cd /d "%~dp0"

notepad "%~dp0assets\css\style.css"
