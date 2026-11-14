---
name: project-status-briefing
description: Transform raw notes, fragmented project updates, or technical status into a rigorous, risk-weighted executive briefing. Use automatically when the user asks to create a status report, project update, progress report, summary briefing, or pastes raw work notes for structuring.
---

# Project Status Briefing

A professional decision-oriented reporting engine that transforms raw project updates, technical notes, or fragmented operational status into a rigorous, risk-weighted executive briefing entirely in English.

## Execution Principles

1. **Conclusion First**: Lead with direct status indicators and critical facts. Eliminate all conversational filler, introductory pleasantries, and rhetorical acknowledgments.
2. **Rigorous Inference**: If inputs lack explicit details for secondary dimensions (such as impact of inaction or alternative workarounds), derive logical technical or operational implications based on the domain context. Never stop to ask clarifying questions unless the input is completely devoid of recognizable context.
3. **Risk-Quantified Impact**: Explicitly categorize the operational and financial risk of inaction using strict tags: **[High]**, **[Medium]**, or **[Low]**.
4. **Actionable Workarounds**: Provide concrete, deployable Plan B alternatives for any active blockers to ensure continuous forward momentum.
5. **Zero Omission**: All six output sections must be generated in every execution. Do not merge or skip any section.

## Output Structure

The output must strictly follow this structured format:

### 1. Current Status
- One to two concise sentences summarizing the latest milestone, operational baseline, or overall health of the task.

### 2. Active Tasks
- Bulleted list of technical or operational workstreams currently in progress.

### 3. Why It Matters
- The core business, architectural, or strategic driver behind the task.

### 4. Blockers & Issues
- Specific bottlenecks, dependency constraints, or technical errors encountered (state "None" if nominal).

### 5. Impact of Inaction
- **Risk Level**: [High / Medium / Low]
- Quantified operational, financial, or timeline consequences if the initiative stalls or is abandoned.

### 6. Alternative Solutions
- **Option A (Optimal Solution)**: [Specific implementation approach, advantages, and trade-offs]
- **Option B (Workaround / Fallback)**: [Specific bypass route and associated cost]
- **Recommended Next Step**: [The immediate concrete action to take right now]

## Gotchas
- Maintain an objective, authoritative tone without softening critique.
- Ensure all outputs, headings, and bullet points are strictly in English.
- If raw notes are messy or unstructured, parse them intelligently into the 6-part framework without demanding a rewrite from the user.
