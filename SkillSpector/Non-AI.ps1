# Non-AI.ps1 - SkillSpector static scan only (no LLM)
#Requires -Version 5.1
[CmdletBinding()]
param(
    # Directory/file/URL to scan; defaults to this script's folder
    [string]$Target = ""
)

# 1. Check prerequisites: uv AND git (uv shells out to git for git+https installs)
if (-not (Get-Command "uv" -ErrorAction SilentlyContinue)) {
    Write-Host "uv is not installed. Install it first by running: irm https://astral.sh/uv/install.ps1 | iex" -ForegroundColor Red
    exit 1
}
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) {
    Write-Host "git is not installed. uv needs git to install SkillSpector from a git URL. Get it at https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
}

# 2. Refresh the current session PATH so uv tool shims resolve
$uvBinPath = Join-Path $env:USERPROFILE ".local\bin"
if (($env:PATH -split ';') -notcontains $uvBinPath) {
    $env:PATH = "$uvBinPath;$env:PATH"
}

# 3. Install or update SkillSpector (PEP 508 direct ref with the MCP extra)
Write-Host "Checking for SkillSpector updates..." -ForegroundColor Cyan
$installSpec = "skillspector[mcp] @ git+https://github.com/NVIDIA/SkillSpector.git"
if (Get-Command "skillspector" -ErrorAction SilentlyContinue) {
    uv tool install --reinstall $installSpec
} else {
    uv tool install $installSpec
}
if ($LASTEXITCODE -ne 0) {
    Write-Host "uv tool install failed (exit code $LASTEXITCODE)." -ForegroundColor Red
    exit $LASTEXITCODE
}

# 4. Run a static security scan (without LLM)
if (-not $Target) { $Target = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path } }
Write-Host "Running SkillSpector static scan of '$Target'..." -ForegroundColor Green
skillspector scan $Target --no-llm
$exitCode = $LASTEXITCODE

# Exit codes: 0 = SAFE/CAUTION, 1 = DO_NOT_INSTALL findings, 2 = scan error
if ($exitCode -eq 1) { Write-Host "SkillSpector returned DO_NOT_INSTALL findings." -ForegroundColor Red }
exit $exitCode