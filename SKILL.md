---
name: automating-github-repositories
description: Automate GitHub repositories using GitHub Actions, CI/CD, scheduled cron jobs, automated repository maintenance, dependency updates, and dynamic documentation generation. Use when AI agents or users need to implement, configure, or execute GitHub automation workflows.
---

# Automating GitHub Repositories

## Overview
This skill defines standardized workflows, pipeline templates, and maintenance automation patterns for GitHub repositories. It enables AI agents to autonomously design, validate, and integrate GitHub Actions workflows.

---

## Core Automation Capabilities

### 1. Continuous Integration & Continuous Deployment (CI/CD)
* **Automated Testing & Linting**: Trigger pipelines on `push` or `pull_request` to run unit tests, integration checks, and linters (ESLint, Prettier, Flake8).
* **Builds & Cross-Compilation**: Compile source code, build multi-architecture Docker images, or package binaries across Linux, Windows, and macOS runners.
* **Continuous Deployment**:
  * Automatically publish static sites or documentation to GitHub Pages.
  * Push web applications or backend services to target platforms (Vercel, Cloudflare Pages, AWS, Azure, GCP).

### 2. Scheduled Jobs & Data Scraping (Cron)
* **Scheduled Data Fetching**: Use cron schedules (`schedule: - cron: '0 0 * * *'`) to execute data processing or web-scraping scripts (Python/Node.js) and automatically commit changes back to the repository.
* **Automated Telemetry & Notifications**: Query external APIs (finance, RSS, system health) and forward structured summaries to communication channels (Discord, Telegram, Slack, Email).
* **Sync & Backup**: Periodically mirror external repositories, back up database dumps, or run automated maintenance tasks.

### 3. Repository Maintenance & Collaboration
* **Issue & PR Triage**: Automatically assign labels, route reviewers, or post welcome comments on new issues and pull requests.
* **Dependency Management**: Integrate Dependabot or Renovate configurations to automatically scan and open update PRs for vulnerable or outdated packages.
* **Code Formatting Enforcement**: Utilize automated pre-commit hooks or GitHub Actions to auto-format and commit styling fixes.

### 4. Dynamic Documentation Generation
* **API Documentation**: Generate or update API documentation from code annotations on every push to the main branch.
* **Dynamic README Updates**: Insert real-time repository stats, metrics, or recent activity feeds into `README.md` via scheduled workflows.

---

## Standard Workflow Template

When asked to create an automated repository workflow, use the following production-ready template located at `.github/workflows/automation.yml`:

```yaml
name: Automated Repository Sync and Task
on:
  schedule:
    - cron: '0 8 * * *' # Daily at 08:00 UTC
  workflow_dispatch:

jobs:
  execute-automation:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Set Up Python Environment
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install Dependencies
        run: |
          python -m pip install --upgrade pip
          pip install requests

      - name: Run Automation Script
        run: python scripts/main.py

      - name: Commit and Push Changes
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: "chore: autonomous repository update via workflow"
          branch: main
