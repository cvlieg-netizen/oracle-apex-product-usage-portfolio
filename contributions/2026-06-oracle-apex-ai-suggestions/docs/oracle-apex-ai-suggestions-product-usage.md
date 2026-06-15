# Oracle APEX AI Suggestions Product Usage

## Objective

Document a practical Oracle APEX integration that displays AI-assisted
operational suggestions inside ERP dashboards and workflow pages.

The focus is Oracle APEX product usage. The AI engine is an external service;
Oracle APEX, Oracle Database, and PL/SQL provide the enterprise application
layer.

## Products Used

- Oracle APEX
- Oracle Database
- PL/SQL
- SQL
- SQLcl
- DBMS_SCHEDULER
- UTL_HTTP
- ORDS

## Functional Flow

1. ERP rules detect an operational case.
2. PL/SQL registers the alert in `AI_ALERTAS`.
3. The alert starts as `PENDIENTE_IA`.
4. A scheduler job processes pending alerts.
5. PL/SQL calls the external AI service.
6. The response is normalized into title, message, severity, and suggested
   action.
7. The alert becomes `ACTIVA`.
8. Oracle APEX renders active suggestions in a Dynamic Content region.
9. The user reviews the suggestion and continues through the normal ERP screen.

## Why This Is an Oracle APEX Usage Example

- APEX provides the user interface and Page Designer configuration.
- APEX session state provides user, tenant, and page context.
- PL/SQL renders the region as CLOB for APEX Dynamic Content.
- Oracle Database stores the alert lifecycle.
- DBMS_SCHEDULER prevents long-running AI calls from blocking the APEX page.
- SQL and PL/SQL enforce visibility and business rules.

## Security Notes

- The model does not receive database credentials.
- The model does not query Oracle tables directly.
- The payload is built by PL/SQL after applying ERP filters.
- APEX shows only active alerts visible to the current user.
- AI suggestions do not execute transactions.
- Final decisions remain inside the normal ERP workflow.

## Video Evidence Plan

Show:

- GitHub repository documentation.
- APEX App Builder or Page Designer.
- Dynamic Content region configuration.
- PL/SQL function returning CLOB.
- SQL example for the alert table.
- Running APEX page with the suggestion card.
- Explanation of what was learned.

