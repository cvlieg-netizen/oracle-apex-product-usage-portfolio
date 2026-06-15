# Oracle APEX AI Suggestions Product Usage

## Objective

This document explains a practical Oracle APEX integration that displays
AI-assisted operational suggestions inside ERP dashboards and workflow pages.

The important part is not the AI engine by itself. The important part is how
Oracle APEX and Oracle Database turn the recommendation into a controlled,
secure and useful ERP experience.

## Products Used

- Oracle APEX
- Oracle Database
- PL/SQL
- SQL
- SQLcl
- DBMS_SCHEDULER
- UTL_HTTP
- ORDS

## What the User Sees

The user sees a compact `Sugerencias IA` section inside an APEX dashboard. Each
card explains the operational issue, shows the severity, and suggests the next
action. The user can review the recommendation and continue in the normal ERP
screen.

## What Happens Behind the Page

1. ERP rules detect an operational case.
2. PL/SQL registers the alert in `AI_ALERTAS`.
3. The alert starts as `PENDIENTE_IA`.
4. A scheduler job processes pending alerts in the background.
5. PL/SQL sends a controlled payload to the external AI service.
6. The response is normalized into title, message, severity, and suggested
   action.
7. The alert becomes `ACTIVA`.
8. Oracle APEX renders active suggestions in a Dynamic Content region.
9. The user reviews the suggestion and continues through the normal ERP process.

## Why This Is an Oracle APEX Usage Example

- APEX provides the user interface and Page Designer configuration.
- APEX session state provides user, tenant, and page context.
- PL/SQL renders the region as CLOB for APEX Dynamic Content.
- Oracle Database stores the alert lifecycle.
- DBMS_SCHEDULER keeps long-running processing out of the interactive APEX page.
- SQL and PL/SQL enforce visibility and business rules.

## Security Notes

- The model does not receive database credentials.
- The model does not query Oracle tables directly.
- The payload is built by PL/SQL after applying ERP filters.
- APEX shows only active alerts visible to the current user.
- AI suggestions do not execute transactions.
- Final decisions remain inside the normal ERP workflow.

## Screenshot Evidence

The `screenshots/` folder includes evidence for:

- Oracle APEX Page Designer configuration.
- Oracle APEX runtime dashboard with suggestions.
- Public GitHub repository documentation.
- Oracle Database alert rules in SQL Developer.
- Oracle Scheduler job used for background processing.
