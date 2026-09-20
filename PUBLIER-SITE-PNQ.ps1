# Publie le site premieres-nations-quebec sur GitHub (1 clic) — Socrate
param([string]$PnqPath = "")

$LaboRoot = $PSScriptRoot
$Bundle   = Join-Path $LaboRoot "docs\pnq-image-fix\pnq-site-a-publier.bundle"
$SiteUrl  = "https://socrate83.github.io/premieres-nations-quebec/Home.html"

Clear-Host
Write-Host ""
Write-Host "  ==========================================" -ForegroundColor Yellow
Write-Host "   PUBLIER le site Premieres Nations Quebec" -ForegroundColor Yellow
Write-Host "  ==========================================" -ForegroundColor Yellow
Write-Host ""

if (-not (Test-Path $Bundle)) {
    Write-Host "  Mise a jour du LABO (git pull)..." -ForegroundColor Cyan
    Push-Location $LaboRoot
    git pull origin main 2>&1 | Out-Host
    Pop-Location
}
if (-not (Test-Path $Bundle)) {
    Write-Host "  [ERREUR] Fichier manquant : pnq-site-a-publier.bundle" -ForegroundColor Red
    Write-Host "  Ouvre le dossier LABO dans Cursor et fais git pull."
    Read-Host "  Entree pour fermer"
    exit 1
}

$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    Write-Host "  [ERREUR] Git non installe." -ForegroundColor Red
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
    $PnqRoot = Read-Host "  Colle le chemin du dossier PNQ"
}

Write-Host "  Site PNQ : $PnqRoot" -ForegroundColor Green
Write-Host ""

Push-Location $PnqRoot
try {
    Write-Host "  1/3 — git pull origin main" -ForegroundColor Cyan
    git pull origin main
    if ($LASTEXITCODE -ne 0) { throw "git pull a echoue" }

    Write-Host "  2/3 — appliquer la mise a jour (Base44 supprime, images locales)" -ForegroundColor Cyan
    git pull $Bundle main
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "  Si conflit : dis a Socrate dans Cursor." -ForegroundColor Yellow
        throw "git pull bundle a echoue (code $LASTEXITCODE)"
    }

    Write-Host "  3/3 — git push origin main (publication GitHub Pages)" -ForegroundColor Cyan
    git push origin main
    if ($LASTEXITCODE -ne 0) { throw "git push a echoue — connecte-toi a GitHub (GitHub Desktop ou git)" }

    Write-Host ""
    Write-Host "  [OK] Site publie ! Attends 1 a 3 minutes." -ForegroundColor Green
    Write-Host "  $SiteUrl" -ForegroundColor Yellow
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
