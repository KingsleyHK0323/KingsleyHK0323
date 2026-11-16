# 1. Automatically check for and update SkillSpector (sync with the latest version from GitHub)
Write-Host "Checking for SkillSpector updates..." -ForegroundColor Cyan
uv tool install --force 'skillspector[mcp] @ git+https://github.com/NVIDIA/SkillSpector.git'

# 2. Set Ollama parameter environment variables
$env:SKILLSPECTOR_PROVIDER="openai"
$env:SKILLSPECTOR_BASE_URL="http://localhost:11434/v1"
$env:SKILLSPECTOR_MODEL="qwen2.5-coder:7b"

# 3. Perform a security scan
Write-Host "Running SkillSpector scan..." -ForegroundColor Green
skillspector scan ./