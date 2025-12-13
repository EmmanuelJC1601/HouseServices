--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  09/12/2025
--@Descripción:     Script para  guardar una copia de cada grupo de los redo 
--                  logs en la FRA

Prompt Conectando como sys en cdb$root
connect sys/system0 as sysdba

alter database add logfile group 4 size 50m blocksize 512;
alter database add logfile group 5 size 50m blocksize 512;
alter database add logfile group 6 size 50m blocksize 512;

--miembros para el grupo 4
alter database add logfile member '/unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo04a.log' to group 4;
alter database add logfile member '/unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo04b.log' to group 4;
--miembros para el grupo 5
alter database add logfile member '/unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo05a.log' to group 5;
alter database add logfile member '/unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo05b.log' to group 5;
--miembros para el grupo 6
alter database add logfile member '/unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo06a.log' to group 6;
alter database add logfile member '/unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo06b.log' to group 6;

/*
Ejecutar las siguientes instrucciones hasta que los grupos 1,2 y 3 estén inactive
verificar con select * from v$log; los que no lo estén
alter system switch logfile;
alter system checkpoint;

posteriormente ejecutar:
alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;

Eliminar archivos a nivel operativo, en oracle 

rm /unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo01a.log
rm /unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo01b.log
rm /unam/bda/pf/disks/d03/app/oracle/oradata/FREE/redo01c.log

rm /unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo02a.log
rm /unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo02b.log
rm /unam/bda/pf/disks/d03/app/oracle/oradata/FREE/redo02c.log

rm /unam/bda/pf/disks/d01/app/oracle/oradata/FREE/redo03a.log
rm /unam/bda/pf/disks/d02/app/oracle/oradata/FREE/redo03b.log
rm /unam/bda/pf/disks/d03/app/oracle/oradata/FREE/redo03c.log

Reiniciar instancia y rezar por que no haya errores
*/