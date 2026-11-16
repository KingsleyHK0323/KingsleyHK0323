<div align="center">

# 🚀 Commands Branch
### Automation scripts and utility command runners for development environments.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PowerShell](https://img.shields.io/badge/Shell-PowerShell-5391FE?logo=powershell&logoColor=white)](https://microsoft.com/PowerShell)
[![SkillSpector](https://img.shields.io/badge/Tool-SkillSpector-orange)](https://github.com/NVIDIA/SkillSpector)

[Overview](#-overview) • [Features](#-features) • [Prerequisites](#-prerequisites) • [Commands Reference](#-commands-reference) • [License](#-license)

</div>

---

## 📖 Overview

A collection of automation workflows and environment maintenance scripts. This branch currently includes core maintenance and security scanning commands, with more utilities to be added as development continues.

> "Automate repetitive workflows to focus purely on core development."

---

## ⚡ Key Features

<table>
<tr>
<td width="50%">
  <h3>🔄 Auto-Sync & Update</h3>
  <p>Automatically checks for updates and forcefully reinstalls the latest version of SkillSpector using <code>uv</code>.</p>
</td>
<td width="50%">
  <h3>🛡️ Automated Security Scan</h3>
  <p>Configures local Ollama parameters and runs targeted security scans across the workspace[cite: 1].</p>
</td>
</tr>
</table>

---

## 📋 Prerequisites

Before running the PowerShell scripts in this branch, ensure your environment has the following tools installed:
* **PowerShell** (v7.x or higher recommended)
* **uv** (An extremely fast Python package and tool installer)
* **Ollama** (Required if running local model scans)

---

## ⚙️ Commands Reference

The current scripts included in this branch are structured below:

<details>
<summary><b>1. AI.ps1 — Full Environment Sync & Scan (with Ollama Configuration)</b>[cite: 1]</summary>

```powershell
# 1. Automatically check for and update SkillSpector (sync with the latest version from GitHub)
Write-Host "Checking for SkillSpector updates..." -ForegroundColor Cyan
uv tool install --force 'skillspector[mcp] @ git+[https://github.com/NVIDIA/SkillSpector.git](https://github.com/NVIDIA/SkillSpector.git)'

# 2. Set Ollama parameter environment variables
$env:SKILLSPECTOR_PROVIDER="openai"
$env:SKILLSPECTOR_BASE_URL="http://localhost:11434/v1"
$env:SKILLSPECTOR_MODEL="qwen2.5-coder:7b"

# 3. Perform a security scan
Write-Host "Running SkillSpector scan..." -ForegroundColor Green
skillspector scan ./
