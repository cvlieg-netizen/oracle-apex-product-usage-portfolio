# Oracle APEX Multi-Tenant Security Product Usage

## Scenario

VLIM ERP is a multi-tenant ERP built with Oracle APEX and Oracle Database. A
single application must support multiple business contexts while keeping each
user limited to the companies, branches, menus, and workflow pages they are
authorized to use.

The security pattern described here focuses on four practical questions:

- Which tenant is the user working in?
- Which operating companies or branches can the user access?
- Which APEX menus and pages should the user see?
- Which ERP rows should queries return for that user?

## Oracle Product Usage

### Oracle APEX

Oracle APEX is used as the application layer, page runtime, session-state layer,
and user interface. APEX session items hold the selected ERP context, such as:

- `GLOBAL_CIA`: current tenant.
- `GLOBAL_CENTRO`: one or more operating companies or branches.
- `GLOBAL_ROL`: roles assigned to the current user session.

APEX pages use these values in reports, dashboards, LOVs, Dynamic Actions, and
page processes.

### Oracle Database

Oracle Database stores the security metadata and operational ERP data. The
security model is database-backed so access rules can be reused across modules
instead of being duplicated inside each page.

Typical metadata areas include:

- Users.
- Roles.
- Menu entries.
- Menu-to-role assignments.
- User-to-role assignments.
- Tenant and company context.

### PL/SQL

PL/SQL is used for reusable checks, page access helpers, and centralized ERP
security logic. This keeps the security behavior consistent across APEX pages,
reports, dashboards, and workflow screens.

## Security Layers

### 1. Session Context

The first layer is the Oracle APEX session context. After login, the application
resolves the tenant, company/branch scope, and roles available to the user.

This avoids relying on page-level assumptions and gives each report or process a
consistent source of truth.

### 2. Menu and Page Authorization

The second layer controls which navigation entries and workflow pages are
available to the user. The application uses database metadata to match menus and
pages with roles.

This allows functional access to be changed through metadata without changing
every individual APEX page.

### 3. Row-Level ERP Visibility

The third layer is query visibility. Even when a user can access a page, the
page query still filters rows by tenant and company scope.

Example:

```sql
where x.no_cia = :GLOBAL_CIA
  and x.centro in (
        select column_value
        from table(apex_string.split(:GLOBAL_CENTRO, ':'))
      )
```

This prevents users from seeing operational data outside their assigned scope.

### 4. Workflow and Operational Context

Some ERP screens also depend on workflow responsibility, assignment, creator, or
role-based override. In those cases, tenant and company filters are not enough;
the query must also validate the workflow visibility rule for the document.

## Why This Matters

ERP security is not only page security. A user can have access to an APEX page
and still need row-level limits based on tenant, company, branch, warehouse,
workflow assignment, or role.

This pattern keeps those responsibilities explicit:

- APEX manages the session and user experience.
- Oracle Database stores and enforces metadata.
- PL/SQL centralizes reusable checks.
- SQL queries protect operational data at runtime.

## What Was Sanitized

The public examples avoid:

- Real users.
- Real customer names.
- Real company identifiers.
- Private endpoints.
- Passwords, tokens, or wallet details.
- Full proprietary ERP logic.

The contribution is intended to share the architecture and implementation
pattern, not production data.
