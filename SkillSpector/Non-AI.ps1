# 1. Check if uv is installed
if (-not (Get-Command "uv" -ErrorAction SilentlyContinue)) {
    Write-Error "uv is not installed. Please install it first by running: irm https://astral.sh/uv/install.ps1 | iex"
    exit 1
}

# 2. Auto-install or update SkillSpector from GitHub
Write-Host "Checking for SkillSpector updates..." -ForegroundColor Cyan
if (Get-Command "skillspector" -ErrorAction SilentlyContinue) {
    uv tool upgrade skillspector
} else {
    uv tool install "skillspector[mcp] @ git+https://github.com/NVIDIA/SkillSpector.git"
}

# 3. Perform a static security scan (without LLM)
Write-Host "Running SkillSpector scan..." -ForegroundColor Green
skillspector scan ./ --no-llm