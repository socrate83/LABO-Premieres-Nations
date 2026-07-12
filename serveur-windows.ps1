# Serveur LABO — Windows natif (PowerShell 5.1, SANS Python)
param(
    [int]$Port = 8081
)

$Root   = $PSScriptRoot
$Host_  = "127.0.0.1"
$Url    = "http://${Host_}:$Port/"
$Prefix = "${Url}"

Set-Location $Root

function Write-Log($Text) {
    $line = "$(Get-Date -Format 'HH:mm:ss') $Text"
    Add-Content -Path (Join-Path $Root "labo-serveur.log") -Value $line -Encoding UTF8
    Write-Host $line
}

Clear-Host
Write-Host ""
Write-Host "  ========================================" -ForegroundColor Yellow
Write-Host "   LABO Premieres Nations" -ForegroundColor Yellow
Write-Host "   $Url" -ForegroundColor Cyan
Write-Host "  ========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Dossier : $Root"
Write-Host ""

if (-not (Test-Path (Join-Path $Root "index.html"))) {
    Write-Host "  [ERREUR] index.html manquant dans ce dossier." -ForegroundColor Red
    Write-Host "  Retelecharge le ZIP depuis GitHub."
    Write-Log "ERREUR index.html manquant"
    Read-Host "  Appuie sur Entree pour fermer"
    exit 1
}

$Listener = New-Object System.Net.HttpListener
$Listener.Prefixes.Add($Prefix)

try {
    $Listener.Start()
} catch {
    Write-Host "  [ERREUR] Impossible de demarrer le serveur." -ForegroundColor Red
    Write-Host "  $_" -ForegroundColor Red
    Write-Log "ERREUR demarrage: $_"
    Read-Host "  Appuie sur Entree pour fermer"
    exit 1
}

Write-Host "  [OK] Serveur actif sur $Url" -ForegroundColor Green
Write-Host ""
Write-Host "  >>> NE FERME PAS cette fenetre <<<" -ForegroundColor Green
Write-Host "  Arret : Ctrl+C ou fermer la fenetre"
Write-Host ""
Write-Log "Serveur demarre $Url"

Start-Sleep -Seconds 1
Start-Process $Url

$Mime = @{
    ".html" = "text/html; charset=utf-8"
    ".htm"  = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".json" = "application/json; charset=utf-8"
    ".txt"  = "text/plain; charset=utf-8"
}

try {
    while ($Listener.IsListening) {
        $Context  = $Listener.GetContext()
        $Request  = $Context.Request
        $Response = $Context.Response

        $Path = [Uri]::UnescapeDataString($Request.Url.AbsolutePath)
        if ($Path -eq "/") { $Path = "/index.html" }

        $Relative = $Path.TrimStart("/").Replace("/", [IO.Path]::DirectorySeparatorChar)
        $FilePath = Join-Path $Root $Relative

        if (Test-Path $FilePath -PathType Leaf) {
            $Bytes = [IO.File]::ReadAllBytes($FilePath)
            $Response.StatusCode = 200
            $Response.ContentLength64 = $Bytes.Length
            $Ext = [IO.Path]::GetExtension($FilePath).ToLower()
            if ($Mime.ContainsKey($Ext)) {
                $Response.ContentType = $Mime[$Ext]
            }
            $Response.OutputStream.Write($Bytes, 0, $Bytes.Length)
            Write-Host "  200  $Path"
        } else {
            $Response.StatusCode = 404
            $Msg = [Text.Encoding]::UTF8.GetBytes("404 - Fichier introuvable : $Path")
            $Response.ContentLength64 = $Msg.Length
            $Response.ContentType = "text/plain; charset=utf-8"
            $Response.OutputStream.Write($Msg, 0, $Msg.Length)
            Write-Host "  404  $Path" -ForegroundColor DarkYellow
        }
        $Response.Close()
    }
} catch {
    Write-Host "  [ERREUR] $_" -ForegroundColor Red
    Write-Log "ERREUR runtime: $_"
} finally {
    $Listener.Stop()
    Write-Host ""
    Write-Host "  Serveur arrete."
    Write-Log "Serveur arrete"
    Read-Host "  Appuie sur Entree pour fermer"
}
