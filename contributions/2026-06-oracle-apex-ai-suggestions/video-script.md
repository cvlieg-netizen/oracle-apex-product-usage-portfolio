# Video Walkthrough Script

Recommended duration: 5 to 8 minutes.

## 1. Introduction

```text
In this demo I am showing hands-on Oracle APEX product usage. The use case is
an ERP dashboard that displays AI-assisted operational suggestions using Oracle
APEX, Oracle Database, PL/SQL and SQLcl.
```

## 2. Repository

Show this GitHub repository and explain:

- Contribution folder.
- Product usage documentation.
- SQL and PL/SQL examples.
- Screenshot checklist.

## 3. Oracle APEX Page Designer

Show:

- The APEX application.
- The dashboard or workflow page.
- The Dynamic Content region.
- The PL/SQL call that returns CLOB.

Suggested narration:

```text
The APEX page does not call the AI service directly. It renders suggestions
that were already generated in the database background process.
```

## 4. Database and PL/SQL

Show:

- `AI_ALERTAS` table or sanitized SQL example.
- PL/SQL package function that returns the APEX region HTML.
- Scheduler job concept.

Suggested narration:

```text
Oracle Database stores the lifecycle of each suggestion. PL/SQL controls the
business context, tenant filters, security rules and rendering logic.
```

## 5. Runtime APEX Demo

Show:

- The APEX dashboard running as a user.
- Suggestion card.
- Severity badge.
- Suggested action.
- Review link or navigation behavior.

## 6. Learning Summary

```text
Through this work I practiced an Oracle APEX integration pattern where AI text
is processed in the background and APEX remains fast and focused on the user
experience. I also learned how to document the integration safely for a public
technical contribution.
```

