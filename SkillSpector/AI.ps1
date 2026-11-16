# Made by GitHub@KingsleyHK0323
# AI.ps1 - SkillSpector scan with LLM semantic analysis via local Ollama
#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$Target = ""
)

# 1. Verify Ollama is running and model is available
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

# 2. Configure Ollama environment variables
$env:SKILLSPECTOR_PROVIDER = "openai"
$env:OPENAI_API_KEY       = "ollama"
$env:OPENAI_BASE_URL      = "$ollamaUrl/v1"
$env:SKILLSPECTOR_MODEL   = $model

# 3. Run the security scan
if (-not $Target) { $Target = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path } }
Write-Host "Running SkillSpector scan of '$Target'..." -ForegroundColor Green
skillspector scan $Target
$exitCode = $LASTEXITCODE

if ($exitCode -eq 1) { Write-Host "SkillSpector returned DO_NOT_INSTALL findings." -ForegroundColor Red }
Read-Host "`nPress Enter to exit"
exit $exitCode