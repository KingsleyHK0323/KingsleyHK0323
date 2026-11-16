# Made by GitHub@KingsleyHK0323
# Non-AI.ps1 - SkillSpector static scan only (no LLM)
#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$Target = ""
)

# 1. Run a static security scan (without LLM)
if (-not $Target) { $Target = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path } }
Write-Host "Running SkillSpector static scan of '$Target'..." -ForegroundColor Green
skillspector scan $Target --no-llm
$exitCode = $LASTEXITCODE

if ($exitCode -eq 1) { Write-Host "SkillSpector returned DO_NOT_INSTALL findings." -ForegroundColor Red }
Read-Host "`nPress Enter to exit"
exit $exitCode