#!/bin/bash
#@Autor(es): Emmanuel Jimenez / Jesus Tenorio
#@Fecha creación: 07/12/2025
#@Descripción: Script para creación de un PFILE
echo "1. Creando un archivo de parámetros básico"
export ORACLE_SID=free
pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora

if [ -f "${pfile}" ]; then
  read -p "El archivo ${pfile} ya existe, [enter] para sobrescribir"
fi;

echo \
"db_name=${ORACLE_SID}
memory_target=1G
db_domain=fi.unam
enable_pluggable_database=true
control_files=(
  '/unam/bda/pf/disks/d01/app/oracle/oradata/${ORACLE_SID^^}/control01.ctl',
  '/unam/bda/pf/disks/d02/app/oracle/oradata/${ORACLE_SID^^}/control02.ctl',
  '/unam/bda/pf/disks/d03/app/oracle/oradata/${ORACLE_SID^^}/control03.ctl'
)
db_recovery_file_dest='/unam/bda/pf/disks/d03/app/oracle/oradata'
db_recovery_file_dest_size=1G
db_flashback_retention_target=1440
" >$pfile

echo "Listo"
echo "Comprobando la existencia y contenido del PFILE"
echo ""
cat ${pfile}

echo "Comprobando la creación del archivo"
ls -l $ORACLE_HOME/dbs/init${ORACLE_SID}.ora