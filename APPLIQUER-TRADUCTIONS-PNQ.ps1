# Publie les traductions PNQ (accueil EN/ES) — Windows
param(
    [string]$PnqPath = ""
)

$LaboRoot = $PSScriptRoot
$FilesDir = Join-Path $LaboRoot "docs\pnq-i18n-patch\files"
$SiteUrl  = "https://socrate83.github.io/premieres-nations-quebec/Home.html"

function Write-Step($Text) {
    Write-Host ""
    Write-Host "  $Text" -ForegroundColor Cyan
}

Clear-Host
Write-Host ""
Write-Host "  ========================================" -ForegroundColor Yellow
Write-Host "   Publier traductions site PNQ" -ForegroundColor Yellow
Write-Host "  ========================================" -ForegroundColor Yellow
Write-Host ""

if (-not (Test-Path (Join-Path $FilesDir "Home.html"))) {
    Write-Host "  [ERREUR] Fichiers manquants dans docs\pnq-i18n-patch\files\" -ForegroundColor Red
    Write-Host "  Fais git pull dans le LABO."
    Read-Host "  Entree pour fermer"
    exit 1
}

$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    Write-Host "  [ERREUR] Git introuvable." -ForegroundColor Red
    Read-Host "  Entree pour fermer"
    exit 1
}

$candidates = @()
if ($PnqPath -and (Test-Path $PnqPath)) { $candidates += $PnqPath }
$candidates += @(
    "$env:USERPROFILE\.cursor\socrate\premieres-nations-quebec",
    "$env:USERPROFILE\Documents\premieres-nations-quebec",
    "$env:USERPROFILE\Desktop\premieres-nations-quebec",
    "$env:USERPROFILE\premieres-nations-quebec"
)

$PnqRoot = $null
foreach ($c in $candidates) {
    if ((Test-Path (Join-Path $c ".git")) -and (Test-Path (Join-Path $c "Home.html"))) {
        $PnqRoot = $c
        break
    }
}

if (-not $PnqRoot) {
    Write-Host "  Dossier premieres-nations-quebec introuvable." -ForegroundColor Yellow
    $PnqRoot = Read-Host "  Chemin complet du dossier PNQ"
    if (-not (Test-Path (Join-Path $PnqRoot ".git"))) {
        Write-Host "  [ERREUR] Pas un depot Git." -ForegroundColor Red
        Read-Host "  Entree pour fermer"
        exit 1
    }
}

Write-Host "  Dossier PNQ : $PnqRoot" -ForegroundColor Green

Push-Location $PnqRoot
try {
    Write-Step "1/4 — git pull"
    git pull origin main
    if ($LASTEXITCODE -ne 0) { throw "git pull echoue" }

    Write-Step "2/4 — copier les fichiers traduits"
    Copy-Item -Force (Join-Path $FilesDir "Home.html") (Join-Path $PnqRoot "Home.html")
    Copy-Item -Force (Join-Path $FilesDir "Videos.html") (Join-Path $PnqRoot "Videos.html")
    Copy-Item -Force (Join-Path $FilesDir "lang-switcher.js") (Join-Path $PnqRoot "lang-switcher.js")
    Copy-Item -Force (Join-Path $FilesDir "locales\fr.json") (Join-Path $PnqRoot "locales\fr.json")
    Copy-Item -Force (Join-Path $FilesDir "locales\en.json") (Join-Path $PnqRoot "locales\en.json")
    Copy-Item -Force (Join-Path $FilesDir "locales\es.json") (Join-Path $PnqRoot "locales\es.json")
    Copy-Item -Force (Join-Path $FilesDir "locales\home-spotlights-i18n.json") (Join-Path $PnqRoot "locales\home-spotlights-i18n.json")

    Write-Step "3/4 — git commit"
    git add Home.html Videos.html lang-switcher.js locales/fr.json locales/en.json locales/es.json locales/home-spotlights-i18n.json
    git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Deja a jour — rien a pousser." -ForegroundColor Yellow
    } else {
        git commit -m "Traduire accueil apres les articles (FR/EN/ES)"
        if ($LASTEXITCODE -ne 0) { throw "git commit echoue" }

        Write-Step "4/4 — git push origin main"
        git push origin main
        if ($LASTEXITCODE -ne 0) { throw "git push echoue — verifie ta connexion GitHub" }

        Write-Host ""
        Write-Host "  [OK] Site mis a jour sur GitHub." -ForegroundColor Green
        Write-Host "  Attends 1-3 min, puis teste EN/ES sur l'accueil."
    }

    Write-Host ""
    Write-Host "  Lien : $SiteUrl" -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    Start-Process $SiteUrl
}
catch {
    Write-Host ""
    Write-Host "  [ERREUR] $_" -ForegroundColor Red
}
finally {
    Pop-Location
}

Read-Host "  Entree pour fermer"
