-- Sanitized PL/SQL example for public documentation.
-- This file illustrates the APEX CLOB rendering pattern only.

CREATE OR REPLACE PACKAGE app_ia_alertas_pq AS
  FUNCTION dashboard_sugerencias_clob (
    p_no_cia          IN VARCHAR2,
    p_centros         IN VARCHAR2 DEFAULT NULL,
    p_modulo          IN VARCHAR2 DEFAULT 'FACTURACION',
    p_dashboard_scope IN VARCHAR2 DEFAULT 'GENERAL',
    p_usuario         IN VARCHAR2 DEFAULT NULL,
    p_limite          IN NUMBER DEFAULT 5
  ) RETURN CLOB;
END app_ia_alertas_pq;
/

CREATE OR REPLACE PACKAGE BODY app_ia_alertas_pq AS
  FUNCTION esc (
    p_text IN VARCHAR2
  ) RETURN VARCHAR2 IS
  BEGIN
    RETURN apex_escape.html(p_text);
  END esc;

  FUNCTION dashboard_sugerencias_clob (
    p_no_cia          IN VARCHAR2,
    p_centros         IN VARCHAR2 DEFAULT NULL,
    p_modulo          IN VARCHAR2 DEFAULT 'FACTURACION',
    p_dashboard_scope IN VARCHAR2 DEFAULT 'GENERAL',
    p_usuario         IN VARCHAR2 DEFAULT NULL,
    p_limite          IN NUMBER DEFAULT 5
  ) RETURN CLOB IS
    l_html CLOB;
  BEGIN
    DBMS_LOB.CREATETEMPORARY(l_html, TRUE);

    DBMS_LOB.APPEND(l_html, '<section id="vlim-ai-suggestions">');
    DBMS_LOB.APPEND(l_html, '<h2>Sugerencias IA</h2>');

    FOR r IN (
      SELECT titulo,
             mensaje,
             severidad,
             accion_sugerida,
             url_redireccion,
             fecha_generada_ia
        FROM ai_alertas
       WHERE no_cia = p_no_cia
         AND estado = 'ACTIVA'
         AND modulo = UPPER(p_modulo)
         AND dashboard_scope = UPPER(p_dashboard_scope)
         AND (usuario_destino IS NULL OR UPPER(usuario_destino) = UPPER(p_usuario))
       ORDER BY fecha_generada_ia DESC NULLS LAST,
                fecha_detectada DESC
       FETCH FIRST p_limite ROWS ONLY
    ) LOOP
      DBMS_LOB.APPEND(l_html, '<article class="vlim-ai-suggestion">');
      DBMS_LOB.APPEND(l_html, '<strong>' || esc(r.titulo) || '</strong>');
      DBMS_LOB.APPEND(l_html, '<p>' || esc(r.mensaje) || '</p>');
      DBMS_LOB.APPEND(l_html, '<p><b>Accion sugerida:</b> ' || esc(r.accion_sugerida) || '</p>');

      IF r.url_redireccion IS NOT NULL THEN
        DBMS_LOB.APPEND(
          l_html,
          '<a href="' || apex_escape.html_attribute(r.url_redireccion) || '">Revisar</a>'
        );
      END IF;

      DBMS_LOB.APPEND(l_html, '</article>');
    END LOOP;

    DBMS_LOB.APPEND(l_html, '</section>');
    RETURN l_html;
  END dashboard_sugerencias_clob;
END app_ia_alertas_pq;
/

