# Screenshots Checklist

Add sanitized screenshots that show the Oracle product usage without exposing
customer data, private users, emails, fiscal documents, endpoints, or passwords.

Recommended evidence:

1. `01-apex-session-context.png`
   - Oracle APEX page or debug-safe view showing the use of session context
     values such as tenant, center, and role scope.

2. `02-apex-menu-role-security.png`
   - APEX or SQL Developer screenshot showing menu-to-role metadata or a
     sanitized role access configuration.

3. `03-apex-secured-report-filter.png`
   - APEX report or Page Designer source showing filters by `NO_CIA` and
     `CENTRO`.

4. `04-oracle-database-security-metadata.png`
   - SQL Developer or SQLcl evidence of the security metadata tables used for
     roles, users, menus, or page access.

5. `05-apex-runtime-secure-navigation.png`
   - Runtime APEX screenshot showing that the user only sees the allowed menu or
     workflow options.

Before publishing screenshots:

- Blur or remove real user names and emails.
- Blur tenant/company names if they are customer-specific.
- Do not show passwords, tokens, connection strings, wallets, or endpoints.
- Do not expose fiscal identifiers or customer records.
- Prefer sample or QA data when possible.
