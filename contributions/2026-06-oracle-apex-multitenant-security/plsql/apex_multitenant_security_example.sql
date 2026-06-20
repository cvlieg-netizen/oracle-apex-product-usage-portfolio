create or replace package apex_multitenant_security_example as
  function user_can_access_page(
    p_app_id       in number,
    p_page_id      in number,
    p_role_list    in varchar2
  ) return varchar2;

  function center_is_visible(
    p_center       in varchar2,
    p_center_list  in varchar2
  ) return varchar2;
end apex_multitenant_security_example;
/

create or replace package body apex_multitenant_security_example as
  function user_can_access_page(
    p_app_id       in number,
    p_page_id      in number,
    p_role_list    in varchar2
  ) return varchar2
  is
    l_allowed number;
  begin
    select count(*)
      into l_allowed
      from seg_apex_menu_example m
      join seg_apex_menu_role_example mr
        on mr.menu_id = m.menu_id
     where m.app_id = p_app_id
       and m.page_id = p_page_id
       and m.active_flag = 'Y'
       and mr.active_flag = 'Y'
       and mr.rol_id in (
             select to_number(column_value)
               from table(apex_string.split(p_role_list, ','))
           );

    return case when l_allowed > 0 then 'Y' else 'N' end;
  exception
    when value_error then
      return 'N';
  end user_can_access_page;

  function center_is_visible(
    p_center       in varchar2,
    p_center_list  in varchar2
  ) return varchar2
  is
    l_allowed number;
  begin
    select count(*)
      into l_allowed
      from table(apex_string.split(p_center_list, ':')) c
     where c.column_value = p_center;

    return case when l_allowed > 0 then 'Y' else 'N' end;
  end center_is_visible;
end apex_multitenant_security_example;
/

show errors package apex_multitenant_security_example
show errors package body apex_multitenant_security_example
