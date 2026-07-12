# LABO Premières Nations — lancer le serveur local (PowerShell)
# Double-clic droit > "Executer avec PowerShell"  OU  dans PowerShell : .\LABO.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Set-Location -Path $PSScriptRoot

$Port = 8081
$Url  = "http://127.0.0.1:$Port/"

Write-Host ""
Write-Host "  ========================================" -ForegroundColor DarkYellow
Write-Host "   LABO Premieres Nations" -ForegroundColor Yellow
Write-Host "   $Url" -ForegroundColor Cyan
Write-Host "  ========================================" -ForegroundColor DarkYellow
Write-Host ""
Write-Host "  Dossier : $PSScriptRoot"
Write-Host ""

if (-not (Test-Path "index.html")) {
    Write-Host "  [ERREUR] index.html manquant dans ce dossier." -ForegroundColor Red
    Write-Host "  Va dans le dossier LABO-Premieres-Nations (git pull)."
    Read-Host "  Appuie sur Entree pour fermer"
    exit 1
}

if (-not (Test-Path "serveur.py")) {
    Write-Host "  [ERREUR] serveur.py manquant. Fais git pull." -ForegroundColor Red
    Read-Host "  Appuie sur Entree pour fermer"
    exit 1
}

# Trouver Python
$pythonArgs = $null
foreach ($candidate in @(
    @{ Exe = "py"; Args = @("-3") },
    @{ Exe = "python"; Args = @() },
    @{ Exe = "python3"; Args = @() }
)) {
    if (Get-Command $candidate.Exe -ErrorAction SilentlyContinue) {
        $pythonArgs = $candidate
        break
    }
}

if (-not $pythonArgs) {
    Write-Host "  [ERREUR] Python introuvable." -ForegroundColor Red
    Write-Host "  Installe Python : https://www.python.org/downloads/"
    Write-Host "  Coche 'Add python.exe to PATH'"
    Read-Host "  Appuie sur Entree pour fermer"
    exit 1
}

Write-Host "  [OK] Python : $($pythonArgs.Exe) $($pythonArgs.Args -join ' ')"
Write-Host ""
Write-Host "  >>> NE FERME PAS cette fenetre <<<" -ForegroundColor Green
Write-Host "  Chrome va s'ouvrir sur : $Url"
Write-Host "  Arret : Ctrl+C"
Write-Host ""

$allArgs = @($pythonArgs.Args + @("serveur.py"))
& $pythonArgs.Exe @allArgs

Write-Host ""
Write-Host "  Serveur arrete."
Read-Host "  Appuie sur Entree pour fermer"
