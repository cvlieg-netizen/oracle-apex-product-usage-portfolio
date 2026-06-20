-- Sanitized Oracle APEX multi-tenant security metadata example.
-- This script is documentation-oriented. Adjust names and data types to your
-- own environment before using it.

create table seg_apex_roles_example (
  rol_id          number generated always as identity primary key,
  role_code       varchar2(80) not null,
  role_name       varchar2(200) not null,
  active_flag     varchar2(1) default 'Y' not null,
  created_on      timestamp default systimestamp not null,
  constraint seg_apex_roles_example_ck1
    check (active_flag in ('Y', 'N')),
  constraint seg_apex_roles_example_u1
    unique (role_code)
);

create table seg_apex_users_example (
  user_id         number generated always as identity primary key,
  username        varchar2(150) not null,
  active_flag     varchar2(1) default 'Y' not null,
  created_on      timestamp default systimestamp not null,
  constraint seg_apex_users_example_ck1
    check (active_flag in ('Y', 'N')),
  constraint seg_apex_users_example_u1
    unique (username)
);

create table seg_apex_user_role_example (
  user_id         number not null,
  rol_id          number not null,
  no_cia          varchar2(30) not null,
  centro          varchar2(30),
  active_flag     varchar2(1) default 'Y' not null,
  created_on      timestamp default systimestamp not null,
  constraint seg_apex_user_role_example_pk
    primary key (user_id, rol_id, no_cia, centro),
  constraint seg_apex_user_role_example_fk1
    foreign key (user_id) references seg_apex_users_example (user_id),
  constraint seg_apex_user_role_example_fk2
    foreign key (rol_id) references seg_apex_roles_example (rol_id),
  constraint seg_apex_user_role_example_ck1
    check (active_flag in ('Y', 'N'))
);

create table seg_apex_menu_example (
  menu_id         number generated always as identity primary key,
  app_id          number not null,
  page_id         number not null,
  menu_label      varchar2(200) not null,
  parent_menu_id  number,
  active_flag     varchar2(1) default 'Y' not null,
  constraint seg_apex_menu_example_fk1
    foreign key (parent_menu_id) references seg_apex_menu_example (menu_id),
  constraint seg_apex_menu_example_ck1
    check (active_flag in ('Y', 'N'))
);

create table seg_apex_menu_role_example (
  menu_id         number not null,
  rol_id          number not null,
  active_flag     varchar2(1) default 'Y' not null,
  constraint seg_apex_menu_role_example_pk
    primary key (menu_id, rol_id),
  constraint seg_apex_menu_role_example_fk1
    foreign key (menu_id) references seg_apex_menu_example (menu_id),
  constraint seg_apex_menu_role_example_fk2
    foreign key (rol_id) references seg_apex_roles_example (rol_id),
  constraint seg_apex_menu_role_example_ck1
    check (active_flag in ('Y', 'N'))
);

-- Example page/menu authorization query.
select 1
  from seg_apex_menu_example m
  join seg_apex_menu_role_example mr
    on mr.menu_id = m.menu_id
 where m.app_id = :APP_ID
   and m.page_id = :APP_PAGE_ID
   and m.active_flag = 'Y'
   and mr.active_flag = 'Y'
   and mr.rol_id in (
         select to_number(column_value)
           from table(apex_string.split(:GLOBAL_ROL, ','))
       )
 fetch first 1 row only;

-- Example row-level ERP data filter.
select d.document_id,
       d.document_number,
       d.status,
       d.created_on
  from erp_document_example d
 where d.no_cia = :GLOBAL_CIA
   and d.centro in (
         select column_value
           from table(apex_string.split(:GLOBAL_CENTRO, ':'))
       );
