--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  08/12/2025
--@Descripción:     Script para la creacion de los usuarios para las PDBs
--                  

Prompt Conectando como sys en Proveedores
connect sys/system0@proveedores as sysdba

Prompt Crear usuario admin
drop user if exists prov_admin cascade;
create user prov_admin identified by 1234  
  quota unlimited on proveedores_c1_data_ts
  quota unlimited on proveedores_c0_idx_ts
  quota unlimited on proveedores_c0_lob_hot_ts
  quota unlimited on proveedores_c2_lob_warm_ts;

grant create session, create table, create procedure to prov_admin;

Prompt Crear usuario para backups
drop user if exists prov_backups cascade;
create user prov_backups identified by 1234 quota unlimited on 
  proveedores_c3_hist_ts;

grant sysbackup to prov_backups;

Prompt Conectando como sys en Servicios
connect sys/system0@servicios as sysdba

Prompt Crear usuario admin
drop user if exists serv_admin cascade;
create user serv_admin identified by 1234 
  quota unlimited on servicios_c0_data_ts
  quota unlimited on servicios_c0_idx_ts
  quota unlimited on servicios_c0_lob_hot_ts;

grant create session, create table, create procedure to serv_admin;

Prompt Crear usuario para backups
drop user if exists serv_backups cascade;
create user serv_backups identified by 1234 quota unlimited on 
  servicios_c3_hist_ts;

grant sysbackup to serv_backups;