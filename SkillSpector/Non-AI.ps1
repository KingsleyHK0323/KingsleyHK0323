# 1. Automatically check for and update SkillSpector (sync with the latest version from GitHub)
Write-Host "Checking for SkillSpector updates..." -ForegroundColor Cyan
uv tool install --force 'skillspector[mcp] @ git+https://github.com/NVIDIA/SkillSpector.git'

# 2. Perform a security scan
Write-Host "Running SkillSpector scan..." -ForegroundColor Green
skillspector scan ./