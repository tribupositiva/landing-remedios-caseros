$ErrorActionPreference = "Stop"
$destDir = Join-Path $env:TEMP "remedios_git_sync"
if (Test-Path $destDir) {
    Remove-Item -Recurse -Force $destDir
}

# Read git token from ~/.git-credentials
$credPath = Join-Path $HOME ".git-credentials"
if (-not (Test-Path $credPath)) {
    throw "No se encontro .git-credentials"
}
$credContent = Get-Content -Raw $credPath
if ($credContent -match 'https://([^:]+):([^@]+)@github\.com') {
    $user = $Matches[1]
    $token = $Matches[2]
} else {
    throw "No se pudo extraer token de .git-credentials"
}

Write-Host "Clonando repositorio..."
$cloneUrl = "https://oauth2:${token}@github.com/tribupositiva/remedioscaseros.git"
git clone --depth 1 $cloneUrl $destDir

Write-Host "Copiando landing v2 mejorada..."
$srcHtml = "c:\Users\a\Downloads\Productos Digitales\Proyecto Antigravity Digital\landing-remedios-v2-mejorada.html"
$destV2Dir = Join-Path $destDir "landingremediosv2"
if (-not (Test-Path $destV2Dir)) {
    New-Item -ItemType Directory -Path $destV2Dir -Force | Out-Null
}
Copy-Item $srcHtml (Join-Path $destV2Dir "index.html") -Force

# Copiar imagenes locales al repo
$srcImages = "c:\Users\a\Downloads\Productos Digitales\Proyecto Antigravity Digital\images"
$destImages = Join-Path $destDir "images"
$destV2Images = Join-Path $destV2Dir "images"
if (Test-Path $srcImages) {
    Copy-Item -Recurse -Force "$srcImages\*" $destImages
    if (-not (Test-Path $destV2Images)) {
        New-Item -ItemType Directory -Path $destV2Images -Force | Out-Null
    }
    Copy-Item -Recurse -Force "$srcImages\*" $destV2Images
}

Set-Location $destDir
git config user.name "tribupositiva"
git config user.email "tribupositiva@gmail.com"

git status
git add .
$status = git status --porcelain
if ($status) {
    Write-Host "Haciendo commit y push..."
    git commit -m "feat(v2): agregar indice clickeable por problema, rediseño mockup 3d y 6 resenas con fotos"
    git push origin main
    Write-Host "Push exitoso a main!"
} else {
    Write-Host "No hay cambios pendientes para commitear."
}
