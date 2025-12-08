#!/bin/bash
#@Autor(es): Emmanuel Jimenez / Jesus Tenorio
#@Fecha creación: 20/09/2025
#@Descripción: Script para creación del diccionario de datos

echo "Creación del diccionario de datos"

mkdir /tmp/dd-logs

cd $ORACLE_HOME/rdbms/admin
perl -I $ORACLE_HOME/rdbms/admin \
$ORACLE_HOME/rdbms/admin/catcdb.pl \
--logDirectory /tmp/dd-logs \
--logFilename dd.log \
--logErrorsFilename dderror.log

echo "LISTO! Verificar la correcta creación del DD"

sqlplus -s sys/system0 as sysdba << EOF
set serveroutput on
exec dbms_dictionary_check.full
EOF

echo "Listo"