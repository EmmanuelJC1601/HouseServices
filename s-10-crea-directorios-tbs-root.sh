#!/bin/bash
#@Autor(es): Emmanuel Jimenez / Jesus Tenorio
#@Fecha creación: 08/12/2025
#@Descripción: Script para creación de directorios para las pdbs

echo "Verificando existencia de directorio para data files de los tablespaces"

echo "Creando directorios para C0"

if [ -d "/unam/bda/pf/c0/d01" ]; then
  echo "Directorio c0/d01 ya existe"
else 
  mkdir -p /unam/bda/pf/c0/d01
  chown -R oracle:oinstall /unam/bda/pf/c0
  chmod -R 750 /unam/bda/pf/c0
fi;

if [ -d "/unam/bda/pf/c0/d02" ]; then
  echo "Directorio c0/d02 ya existe"
else 
  mkdir -p /unam/bda/pf/c0/d02
  chown -R oracle:oinstall /unam/bda/pf/c0
  chmod -R 750 /unam/bda/pf/c0
fi;

echo "Creando directorios para C1"

if [ -d "/unam/bda/pf/c1/d01" ]; then
  echo "Directorio c1/d01 ya existe"
else 
  mkdir -p /unam/bda/pf/c1/d01
  chown -R oracle:oinstall /unam/bda/pf/c1
  chmod -R 750 /unam/bda/pf/c1
fi;

if [ -d "/unam/bda/pf/c1/d02" ]; then
  echo "Directorio c1/d02 ya existe"
else 
  mkdir -p /unam/bda/pf/c1/d02
  chown -R oracle:oinstall /unam/bda/pf/c1
  chmod -R 750 /unam/bda/pf/c1
fi;

echo "4. Creando directorios para C2"

if [ -d "/unam/bda/pf/c2/d01" ]; then
  echo "Directorio c2/d01 ya existe"
else 
  mkdir -p /unam/bda/pf/c2/d01
  chown -R oracle:oinstall /unam/bda/pf/c2
  chmod -R 750 /unam/bda/pf/c2
fi;

if [ -d "/unam/bda/pf/c2/d02" ]; then
  echo "Directorio c2/d02 ya existe"
else 
  mkdir -p /unam/bda/pf/c2/d02
  chown -R oracle:oinstall /unam/bda/pf/c2
  chmod -R 750 /unam/bda/pf/c2
fi;

echo "Creando directorios para C3"

if [ -d "/unam/bda/pf/c3/d01" ]; then
  echo "Directorio c3/d01 ya existe"
else 
  mkdir -p /unam/bda/pf/c3/d01
  chown -R oracle:oinstall /unam/bda/pf/c3
  chmod -R 750 /unam/bda/pf/c3
fi;

if [ -d "/unam/bda/pf/c3/d02" ]; then
  echo "Directorio c3/d02 ya existe"
else 
  mkdir -p /unam/bda/pf/c3/d02
  chown -R oracle:oinstall /unam/bda/pf/c3
  chmod -R 750 /unam/bda/pf/c3
fi;

echo "Mostrando directorios para Tablespaces"
ls -R /unam/bda/pf/c*

read -p "Eliminando contenido de datafiles antiguos en caso de existir [Enter] para continuar"

rm -f /unam/bda/pf/c0/d01/*.dbf
rm -f /unam/bda/pf/c0/d02/*.dbf
rm -f /unam/bda/pf/c1/d01/*.dbf
rm -f /unam/bda/pf/c1/d02/*.dbf
rm -f /unam/bda/pf/c2/d01/*.dbf
rm -f /unam/bda/pf/c2/d02/*.dbf
rm -f /unam/bda/pf/c3/d01/*.dbf
rm -f /unam/bda/pf/c3/d02/*.dbf
