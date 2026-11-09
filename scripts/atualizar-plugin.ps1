<#
.SYNOPSIS
  Atualiza o plugin Observability Dev Toolkit do Antigravity.
.DESCRIPTION
  Em um clone Git, usa git pull --ff-only, valida e instala pelo diretório local.
  Sem clone Git, usa o repositório remoto; nunca desinstala automaticamente.
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\scripts\atualizar-plugin.ps1
#>
[CmdletBinding()]
param([switch]$ViaGitHub, [switch]$Ajuda)
if ($Ajuda) {
  Write-Output 'Uso: .\scripts\atualizar-plugin.ps1 [-ViaGitHub] [-Ajuda]'
  exit 0
}
if (-not (Get-Command agy -ErrorAction SilentlyContinue)) {
  Write-Error 'CLI agy não encontrada no PATH.'
  exit 1
}
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$url = 'https://github.com/victoralecrim11/observability-antigravity.git'
$source = $root
if ($ViaGitHub -or -not (Test-Path (Join-Path $root '.git'))) {
  Write-Warning 'Sem clone Git local (ou modo remoto solicitado); a instalação será solicitada via URL GitHub.'
  $source = $url
} else {
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error 'Git não encontrado: necessário para atualizar clone local.'
    exit 1
  }
  Write-Host '== Atualizando o clone (apenas fast-forward)' -ForegroundColor Cyan
  & git -C $root pull --ff-only
  if ($LASTEXITCODE -ne 0) {
    Write-Error 'git pull falhou ou exige merge; nenhuma instalação foi feita.'
    exit 1
  }
  Write-Host '== Validando manifesto local' -ForegroundColor Cyan
  & agy plugin validate $root
  if ($LASTEXITCODE -ne 0) {
    Write-Error 'Validação do plugin falhou; instalação cancelada.'
    exit 1
  }
}
Write-Host '== Instalando atualização Antigravity' -ForegroundColor Cyan
& agy plugin install $source
if ($LASTEXITCODE -ne 0) {
  Write-Error 'Falha na instalação. Caso já exista, use agy plugin uninstall observability e reinstale manualmente.'
  exit 1
}
Write-Host '== Plugins instalados' -ForegroundColor Cyan
& agy plugin list
Write-Host 'Concluído. Reinicie Antigravity/reabra o workspace para carregar a versão.' -ForegroundColor Green
