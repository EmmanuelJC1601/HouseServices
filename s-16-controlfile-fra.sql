--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  09/12/2025
--@Descripción:     Script para habilitar la FRA y guardar una copia de los 
--                  control files

Prompt Conectando como sys en cdb$root
connect sys/system0 as sysdba

alter system set db_recovery_file_dest='/unam/bda/pf/fast-reco-area' scope=spfile;
alter system set db_recovery_file_dest_size=10G scope=spfile;
alter system set db_flashback_retention_target=1440 scope=spfile;

Prompt Deteniendo la instancia
shutdown immediate

Prompt Conectando como sys para hacer copia de pfile
connect sys/system0 as sysdba

Prompt Creando PFILE a partir del SPFILE
create pfile from spfile;

Prompt Iniciando instancia en modo nomount
startup nomount

Prompt reset del parametro control_files
alter system reset control_files scope=spfile;

Prompt Reiniciando en modo nomount
shutdown abort
startup nomount

/*
Ejecutar comando de rman en oracle:
rman target /
restore controlfile from '/unam/bda/pf/disks/d01/app/oracle/oradata/FREE/control01.ctl';

Verificar en la base con:
show parameter control_files

Ejecutar con usuario sys
alter system set control_files='<ruta_regresada_por_show_parameter>','/unam/bda/pf/disks/d01/app/oracle/oradata/FREE/control01.ctl','/unam/bda/pf/disks/d02/app/oracle/oradata/FREE/control02.ctl' scope=spfile;

SI todo salio correcto, con el usuario oracle ejecutar
rm /unam/bda/pf/disks/d03/app/oracle/oradata/FREE/control03.ctl

Ingresar a la base con en modo open y vericas con
select * from v$controlfile;
*/