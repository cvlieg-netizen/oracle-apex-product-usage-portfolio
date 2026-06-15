# Contribution Notes

This repository is meant to grow over time as a public Oracle APEX portfolio.
Every contribution should be useful on its own: a reviewer should be able to
open the folder, understand the Oracle product usage, review the screenshots,
and see the sanitized technical artifacts.

## Before Adding a Contribution

Confirm:

- The work was created after the relevant ACE Apprentice acceptance date.
- The contribution is aligned with Oracle technologies.
- The screenshots and documentation explain the work clearly.
- Code examples do not contain secrets or customer-specific data.
- The contribution adds practical value beyond a basic product screenshot.

## Suggested Folder Name

Use:

```text
contributions/YYYY-MM-short-topic
```

Examples:

```text
contributions/2026-06-oracle-apex-ai-suggestions
contributions/2026-07-oracle-apex-workflow-dashboard
contributions/2026-08-oracle-apex-rest-integration
```

## Minimum Files Per Contribution

```text
README.md
docs/
screenshots/
sql/
plsql/
apex/
```

## Sanitization Checklist

- Remove passwords, tokens, keys, and wallet details.
- Remove private IPs or internal hostnames when not necessary.
- Replace customer names with neutral sample names.
- Replace fiscal identifiers, invoice numbers, CUFE values, emails, and phone
  numbers.
- Do not publish `.env`, exports with credentials, raw logs, or production data.
- Keep only the minimal code needed to explain the Oracle product usage.
