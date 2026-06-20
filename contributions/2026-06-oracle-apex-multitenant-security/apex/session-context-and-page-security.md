# APEX Session Context and Page Security Notes

## Purpose

This note explains the Oracle APEX side of the multi-tenant security pattern.
The goal is to make tenant, company, and role scope available to APEX pages in a
consistent way.

## Session Items

The implementation uses application-level session items similar to:

| Item | Purpose |
| --- | --- |
| `GLOBAL_CIA` | Current tenant or company group. |
| `GLOBAL_CENTRO` | Allowed operating company, branch, or center scope. |
| `GLOBAL_ROL` | Roles available in the current session. |
| `APP_USER` | Current APEX user. |

These values are consumed by reports, LOVs, dashboards, Dynamic Content
regions, and page processes.

## Page Query Pattern

APEX regions should not query ERP data without tenant scope. A common pattern is:

```sql
select x.document_id,
       x.document_number,
       x.status,
       x.created_by,
       x.created_on
  from erp_document_example x
 where x.no_cia = :GLOBAL_CIA
   and x.centro in (
         select column_value
           from table(apex_string.split(:GLOBAL_CENTRO, ':'))
       )
```

## LOV Pattern

LOVs also need tenant and company filters. This prevents users from selecting
values outside their authorized scope.

```sql
select c.display_name d,
       c.centro r
  from erp_center_example c
 where c.no_cia = :GLOBAL_CIA
   and c.centro in (
         select column_value
           from table(apex_string.split(:GLOBAL_CENTRO, ':'))
       )
 order by c.display_name
```

## Menu Authorization Pattern

Navigation entries are controlled through metadata that relates menu entries to
roles. A simplified condition can be expressed as:

```sql
exists (
  select 1
    from seg_apex_custom_menu m
    join seg_apex_menu_rol r
      on r.id_menu = m.id
   where m.app_id = :APP_ID
     and m.page_id = :APP_PAGE_ID
     and r.rol_id in (
           select column_value
             from table(apex_string.split(:GLOBAL_ROL, ','))
         )
)
```

## Practical Checks

Before publishing or changing a secured APEX page:

- Confirm the page is reachable only through the intended menu/role metadata.
- Confirm reports filter by `NO_CIA`.
- Confirm company, center, branch, or warehouse filters use the APEX session
  context.
- Confirm LOVs do not expose values from another tenant or center.
- Confirm workflow pages also respect assignment or role-based visibility when
  required.
