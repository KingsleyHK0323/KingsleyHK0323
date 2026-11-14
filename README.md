# Project Status Briefing (AI Skill)

A professional decision-oriented reporting engine designed as an AI agent skill. It transforms raw project updates, technical notes, or fragmented operational status into a rigorous, risk-weighted executive briefing.

---

## Features

- **Conclusion First**: Eliminates conversational filler and leads directly with critical status indicators.
- **Rigorous Inference**: Automatically bridges missing inputs using domain context without halting for clarification.
- **Risk Quantization**: Explicitly categorizes inaction impacts into **[High] / [Medium] / [Low]** risk levels.
- **Actionable Workarounds**: Delivers optimal solutions, fallback workarounds, and concrete next steps.
- **Fully Structured**: Guarantees a strict 6-section output format for every execution.

---

## Output Structure

The generated briefing strictly adheres to the following layout:

1. **Current Status**: 1–2 concise sentences summarizing the operational baseline.
2. **Active Tasks**: Bulleted list of workstreams currently in progress.
3. **Why It Matters**: Core business, architectural, or strategic driver.
4. **Blockers & Issues**: Specific bottlenecks or technical errors encountered.
5. **Impact of Inaction**: Risk level and quantified operational/financial consequences.
6. **Alternative Solutions**: Option A (Optimal), Option B (Workaround), and Recommended Next Step.

---

## Installation & Usage

1. Place the `SKILL.md` file inside your AI agent's skill directory.
2. Trigger the skill by providing raw notes, progress logs, or asking for a project status update.

---

## Contributing

Contributions, issues, and feature requests are welcome. Feel free to check the [issues page](../../issues).

---

## License

Distributed under the **MIT License**. See `LICENSE` for more information.
