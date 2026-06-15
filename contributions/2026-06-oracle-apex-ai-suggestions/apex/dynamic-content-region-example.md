# APEX Dynamic Content Region Example

This is a sanitized configuration note for the Oracle APEX page.

## Region

- Region Type: Dynamic Content
- Title: Sugerencias IA
- Static ID: `vlim-ai-suggestions`
- Template: Standard or a dashboard-compatible template
- Purpose: render active operational suggestions generated in background

## PL/SQL Source

```plsql
RETURN app_ia_alertas_pq.dashboard_sugerencias_clob(
  p_no_cia          => :GLOBAL_CIA,
  p_centros         => :GLOBAL_CENTRO,
  p_modulo          => 'FACTURACION',
  p_dashboard_scope => 'GENERAL',
  p_usuario         => :APP_USER,
  p_limite          => 5
);
```

## APEX Session Context

- `GLOBAL_CIA`: tenant
- `GLOBAL_CENTRO`: operating company or branch context
- `APP_USER`: current user
- `GLOBAL_ACTUAL_WF`: optional ERP process context when the dashboard is filtered by an active workflow

## Empty State

Recommended no-data message:

```text
No hay recomendaciones operativas pendientes para los criterios actuales.
```

## Notes

The region does not call the AI service directly. It only displays suggestions
already stored in Oracle Database.

