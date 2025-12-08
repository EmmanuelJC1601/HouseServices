#!/bin/bash
#@Autor(es): Emmanuel Jimenez / Jesus Tenorio
#@Fecha creación: 07/12/2025
#@Descripción: Script para creación de archivo de passwords

echo "1. Configurando ORACLE_SID"
export ORACLE_SID=free

echo "ORACLE_SID: ${ORACLE_SID}"

echo "2. Crear el archivo de passwords solo con sys y su contraseña"

if [ -f "${ORACLE_HOME}/dbs/orapw${ORACLE_SID}" ]; then
  read -p "El archivo de passwords ya existe, [enter] para sobrescribir"
fi;

orapwd FORCE=Y \
  FILE="${ORACLE_HOME}/dbs/orapw${ORACLE_SID}"\
  FORMAT=12.2 \
  SYS=password password=Hola1234*

echo "Comprobando la creación del archivo"
ls -l $ORACLE_HOME/dbs/orapw${ORACLE_SID}