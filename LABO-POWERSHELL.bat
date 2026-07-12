@echo off
:: Ouvre LABO.ps1 dans PowerShell (pour ceux qui utilisent PowerShell)
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0LABO.ps1"
pause
