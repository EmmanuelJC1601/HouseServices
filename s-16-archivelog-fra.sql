--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  09/12/2025
--@Descripción:     Script para habilitar modo archivelog y terminar de 
--                  configurar la fra

Prompt Conectando como sys en cdb$root
connect sys/system0 as sysdba

Prompt Deteniendo la instancia
shutdown immediate

Prompt Iniciando instancia en modo mount
startup mount

Prompt Habilitando modo archivelog
alter database archivelog;

Prompt Rutas
alter system set log_archive_dest_1='LOCATION=/unam/bda/pf/archivelogs' scope=both;
alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST' scope=both;
alter system set log_archive_format='arch_%t_%s_%r.arc' scope=spfile;

Prompt Abriendo la base de datos
alter database open;

Prompt Habilitando Flashback Database
alter database Flashback on;