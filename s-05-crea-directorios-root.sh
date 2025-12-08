#!/bin/bash
#@Autor(es): Emmanuel Jimenez / Jesus Tenorio
#@Fecha creación: 07/12/2025
#@Descripción: Script para creación de directorios para la CDB

echo "Verificando existencia de directorio para data files"

if [ -d "/opt/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para data files ya existe, se omite creación"
else 
  echo "1. Creando directorios para data files de cdb$root"
  cd /opt/oracle
  mkdir -p oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall oradata
  chmod -R 750 oradata
fi;

echo "Verificando existencia de directorio para pdb$seed"

if [ -d "/opt/oracle/oradata/${ORACLE_SID^^}/pdbseed" ]; then
  echo "Directorio para data files ya existe, se omite creación"
else 
  echo "1. Creando directorios para data files de pdbseed"
  cd /opt/oracle/oradata/${ORACLE_SID^^}
  mkdir pdbseed
  chown oracle:oinstall pdbseed
  chmod 750 pdbseed
fi;

echo "2. Creando directorios para Redo Logs y Control Files"

if [ -d "/unam/bda/pf/disks/d01/app/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para control files y redo logs d01 ya existe"
else 
  cd /unam/bda/pf/disks/d01
  mkdir -p app/oracle/oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall app
  chmod -R 750 app
fi;

if [ -d "/unam/bda/pf/disks/d02/app/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para control files y redo logs d02 ya existe"
else 
  cd /unam/bda/pf/disks/d02
  mkdir -p app/oracle/oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall app
  chmod -R 750 app
fi;

if [ -d "/unam/bda/pf/disks/d03/app/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para control files y redo logs d03 ya existe"
else 
  cd /unam/bda/pf/disks/d03
  mkdir -p app/oracle/oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall app
  chmod -R 750 app
fi;

echo "Mostrando directorio de data files"
ls -l /opt/oracle/oradata

echo "Mostrando directorios para control files y Redo Logs"
ls -l /unam/bda/pf/disks/d0*/app/oracle/oradata

read -p "Eliminando contenido de directorios en caso de existir [Enter] para continuar"
rm -f /unam/bda/pf/disks/d01/app/oracle/oradata/FREE/*
rm -f /unam/bda/pf/disks/d02/app/oracle/oradata/FREE/*
rm -f /unam/bda/pf/disks/d03/app/oracle/oradata/FREE/*

rm -f /opt/oracle/oradata/${ORACLE_SID^^}/*.dbf
rm -f /opt/oracle/oradata/${ORACLE_SID^^}/pdbseed/*.dbf