--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  08/12/2025
--@Descripción:     Script para la creacion de todos los tablespaces definidos
--                  

Prompt Conectando como sys
connect sys/system0 as sysdba

--pdb: proveedores
whenever sqlerror continue;
Prompt conectando a pdb proveedores
alter session set container = proveedores;

/*
Prompt eliminando tablespaces existentes en proveedores
drop tablespace proveedores_c1_data_ts including contents and datafiles cascade constraints;
drop tablespace proveedores_c0_idx_ts including contents and datafiles cascade constraints;
drop tablespace proveedores_c0_lob_hot_ts including contents and datafiles cascade constraints;
drop tablespace proveedores_c2_lob_warm_ts including contents and datafiles cascade constraints;
drop tablespace proveedores_c3_hist_ts including contents and datafiles cascade constraints;
drop tablespace proveedores_c1_encrypt_ts including contents and datafiles cascade constraints;
drop tablespace undo_prov including contents and datafiles cascade constraints;
drop tablespace temp_prov including contents and datafiles cascade constraints;
drop tablespace users_prov including contents and datafiles cascade constraints;
*/

whenever sqlerror exit rollback;

Prompt creando tablespaces básicos para proveedores

create undo tablespace undo_prov
  datafile '/unam/bda/pf/c2/d101/undo_prov.dbf' size 100m
  autoextend on next 10m maxsize unlimited;

drop tablespace undo including contents and datafiles cascade constraints;

create temporary tablespace temp_prov
  tempfile '/unam/bda/pf/c0/d101/temp_prov_01.dbf' size 50m,
           '/unam/bda/pf/c0/d102/temp_prov_02.dbf' size 50m,
           '/unam/bda/pf/c0/d103/temp_prov_03.dbf' size 50m
  autoextend on next 10m maxsize unlimited;

drop tablespace temp including contents and datafiles cascade constraints;

alter database default temporary tablespace temp_prov;
alter system set undo_tablespace = undo_prov scope=both;

Prompt creando tablespaces del módulo proveedores

create bigfile tablespace proveedores_c1_data_ts
  datafile '/unam/bda/pf/c1/d101/proveedores_c1_data_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace proveedores_c0_idx_ts
  datafile '/unam/bda/pf/c0/d104/proveedores_c0_idx_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace proveedores_c0_lob_hot_ts
  datafile '/unam/bda/pf/c0/d105/proveedores_c0_lob_hot_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  blocksize 8192
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace proveedores_c2_lob_warm_ts
  datafile '/unam/bda/pf/c2/d102/proveedores_c2_lob_warm_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  blocksize 8192
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace proveedores_c3_hist_ts
  datafile '/unam/bda/pf/c3/d101/proveedores_c3_hist_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

-- pdb: servicios
whenever sqlerror continue;
Prompt conectando a pdb servicios
alter session set container = servicios;

/*
drop tablespace servicios_c0_data_ts including contents and datafiles cascade constraints;
drop tablespace servicios_c0_idx_ts including contents and datafiles cascade constraints;
drop tablespace servicios_c0_lob_hot_ts including contents and datafiles cascade constraints;
drop tablespace servicios_c3_hist_ts including contents and datafiles cascade constraints;
drop tablespace servicios_c0_encrypt_ts including contents and datafiles cascade constraints;
drop tablespace undo_serv including contents and datafiles cascade constraints;
drop tablespace temp_serv including contents and datafiles cascade constraints;
drop tablespace users_serv including contents and datafiles cascade constraints;
*/

whenever sqlerror exit rollback;

Prompt creando tablespaces básicos para servicios

create bigfile undo tablespace undo_serv
  datafile '/unam/bda/pf/c2/d201/undo_serv.dbf' size 100m 
  autoextend on next 10m maxsize unlimited;

drop tablespace undo including contents and datafiles cascade constraints;

create temporary tablespace temp_serv
  tempfile '/unam/bda/pf/c0/d201/temp_serv_01.dbf' size 50m,
           '/unam/bda/pf/c0/d202/temp_serv_02.dbf' size 50m,
           '/unam/bda/pf/c0/d203/temp_serv_03.dbf' size 50m
  autoextend on next 10m maxsize unlimited;

drop tablespace temp including contents and datafiles cascade constraints;

alter database default temporary tablespace temp_serv;
alter system set undo_tablespace = undo_serv scope=both;

Prompt creando tablespaces del módulo servicios

create bigfile tablespace servicios_c0_data_ts
  datafile '/unam/bda/pf/c0/d204/servicios_c0_data_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace servicios_c0_idx_ts
  datafile '/unam/bda/pf/c0/d205/servicios_c0_idx_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace servicios_c0_lob_hot_ts
  datafile '/unam/bda/pf/c0/d206/servicios_c0_lob_hot_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  blocksize 8192
  extent management local autoallocate
  segment space management auto;

create bigfile tablespace servicios_c3_hist_ts
  datafile '/unam/bda/pf/c3/d201/servicios_c3_hist_ts.dbf' size 500m
  autoextend on next 10m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

Prompt listo
exit;