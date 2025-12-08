--@Autor(es): Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación: 07/12/2025
--@Descripción: Creación de una CDB emplenado instrucción create database

Prompt Conectando como sys por medio del archivo de passwords
connect sys/Hola1234* as sysdba

Prompt Iniciando la instancia en modo nomount
startup nomount

Prompt 1.Ejecutando la instrucción create database
whenever sqlerror exit rollback

create database free
  user sys identified by system0
  user system identified by system0
  logfile group 1 (
    '/unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo01a.log',
    '/unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo01b.log',
    '/unam/bda/pf/disks/d03/app/oracle/oradata/FREE/redo01c.log') size 50m blocksize 512,
  group 2 (
    '/unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo02a.log',
    '/unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo02b.log',
    '/unam/bda/pf/disks/d03/app/oracle/oradata/FREE/redo02c.log') size 50m blocksize 512,
  group 3 (
    '/unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo03a.log',
    '/unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo03b.log',
    '/unam/bda/pf/disks/d03/app/oracle/oradata/FREE/redo03c.log') size 50m blocksize 512
  maxloghistory 1
  maxlogfiles 16
  maxlogmembers 3
  maxdatafiles 1024
  character set AL32UTF8
  national character set AL16UTF16
  extent management local
    datafile '/opt/oracle/oradata/FREE/system01.dbf'
    size 500m autoextend on next 10m maxsize unlimited
  sysaux datafile '/opt/oracle/oradata/FREE/sysaux01.dbf'
    size 300m autoextend on next 10m maxsize unlimited
  default tablespace users
    datafile '/opt/oracle/oradata/FREE/users01.dbf'
    size 50m autoextend on next 10m maxsize unlimited
  default temporary tablespace temp
    tempfile '/opt/oracle/oradata/FREE/temp01.dbf'
    size 20m autoextend on next 1m maxsize unlimited
  undo tablespace undo
    datafile '/opt/oracle/oradata/FREE/undo01.dbf'
    size 100m autoextend on next 5m maxsize unlimited
  enable pluggable database
    seed
      file_name_convert = ('/opt/oracle/oradata/FREE',
                          '/opt/oracle/oradata/FREE/pdbseed')
    system datafiles size 250m autoextend on next 10m maxsize unlimited
    sysaux datafiles size 200m autoextend on next 10m maxsize unlimited
  local undo on
;

Prompt 2.Homologando passwords
alter user sys identified by system0;
alter user system identified by system0;

exit