:: Made by GitHub@KingsleyHK0323
@echo off
setlocal
echo ==========================================
echo Checking prerequisites and SkillSpector...
echo ==========================================

:: 1. Check if uv is installed
where uv >nul 2>&1
if %errorlevel% neq 0 (
    echo uv is not installed. Installing uv now...
    powershell -NoProfile -Command "irm [https://astral.sh/uv/install.ps1](https://astral.sh/uv/install.ps1) | iex"
)

:: 2. Check if git is installed
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo [Error] git is not installed. Please install git from [https://git-scm.com/download/win](https://git-scm.com/download/win)
    pause
    exit /b 1
)

:: 3. Refresh PATH for uv shims
set "PATH=%USERPROFILE%\.local\bin;%PATH%"

:: 4. Install or update SkillSpector
echo Checking for SkillSpector updates...
uv tool install --reinstall "skillspector[mcp] @ git+[https://github.com/NVIDIA/SkillSpector.git](https://github.com/NVIDIA/SkillSpector.git)"
if %errorlevel% neq 0 (
    echo [Error] SkillSpector installation/update failed.
    pause
    exit /b %errorlevel%
)

echo.
echo ==========================================
echo SkillSpector update/installation completed successfully!
echo ==========================================
pause
endlocal