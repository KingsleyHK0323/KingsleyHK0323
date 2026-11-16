# Non-AI.ps1 - SkillSpector static scan only (no LLM)
#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$Target = ""
)

# 1. Check prerequisites: uv AND git
if (-not (Get-Command "uv" -ErrorAction SilentlyContinue)) {
    Write-Host "uv is not installed. Install it first by running: irm https://astral.sh/uv/install.ps1 | iex" -ForegroundColor Red
    Read-Host "`nPress Enter to exit"
    exit 1
}
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) {
    Write-Host "git is not installed. uv needs git to install SkillSpector from a git URL. Get it at https://git-scm.com/download/win" -ForegroundColor Red
    Read-Host "`nPress Enter to exit"
    exit 1
}

# 2. Refresh current session PATH
$uvBinPath = Join-Path $env:USERPROFILE ".local\bin"
if (($env:PATH -split ';') -notcontains $uvBinPath) {
    $env:PATH = "$uvBinPath;$env:PATH"
}

# 3. Install or update SkillSpector
Write-Host "Checking for SkillSpector updates..." -ForegroundColor Cyan
$installSpec = "skillspector[mcp] @ git+https://github.com/NVIDIA/SkillSpector.git"
if (Get-Command "skillspector" -ErrorAction SilentlyContinue) {
    uv tool install --reinstall $installSpec
} else {
    uv tool install $installSpec
}
if ($LASTEXITCODE -ne 0) {
    Write-Host "uv tool install failed (exit code $LASTEXITCODE)." -ForegroundColor Red
    Read-Host "`nPress Enter to exit"
    exit $LASTEXITCODE
}

# 4. Run a static security scan (without LLM)
if (-not $Target) { $Target = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path } }
Write-Host "Running SkillSpector static scan of '$Target'..." -ForegroundColor Green
skillspector scan $Target --no-llm
$exitCode = $LASTEXITCODE

if ($exitCode -eq 1) { Write-Host "SkillSpector returned DO_NOT_INSTALL findings." -ForegroundColor Red }
Read-Host "`nPress Enter to exit"
exit $exitCode