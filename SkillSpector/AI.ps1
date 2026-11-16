# AI.ps1 - SkillSpector scan with LLM semantic analysis via local Ollama
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

# 4. Verify Ollama is running and model is available
$ollamaUrl = "http://localhost:11434"
try {
    $tags = Invoke-RestMethod -Uri "$ollamaUrl/api/tags" -TimeoutSec 5
} catch {
    Write-Host "Ollama is not reachable at $ollamaUrl. Start it first ('ollama serve' or tray app), then re-run." -ForegroundColor Red
    Read-Host "`nPress Enter to exit"
    exit 1
}
$model = "qwen2.5-coder:7b"
if ($tags.models.name -notcontains $model) {
    Write-Host "Model '$model' not found locally. Pulling it now..." -ForegroundColor Yellow
    ollama pull $model
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to pull model '$model'." -ForegroundColor Red
        Read-Host "`nPress Enter to exit"
        exit $LASTEXITCODE
    }
}

# 5. Configure Ollama environment variables
$env:SKILLSPECTOR_PROVIDER = "openai"
$env:OPENAI_API_KEY       = "ollama"
$env:OPENAI_BASE_URL      = "$ollamaUrl/v1"
$env:SKILLSPECTOR_MODEL   =$model

# 6. Run the security scan
if (-not $Target) {$Target = if ($PSScriptRoot) {$PSScriptRoot } else { (Get-Location).Path } }
Write-Host "Running SkillSpector scan of '$Target'..." -ForegroundColor Green
skillspector scan $Target
$exitCode =$LASTEXITCODE

if ($exitCode -eq 1) { Write-Host "SkillSpector returned DO_NOT_INSTALL findings." -ForegroundColor Red }
Read-Host "`nPress Enter to exit"
exit $exitCode
```[cite: 16]

---

### 2. `Non-AI.ps1`
```powershell
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
    Write-Host "git is not installed. uv needs git to install SkillSpector from a git URL. Get it at