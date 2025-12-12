#!/bin/bash
#@Autor(es): Emmanuel Jimenez / Jesus Tenorio
#@Fecha creación: 08/12/2025
#@Descripción: Script para creación de directorios para las pdbs

echo "Verificando existencia de directorio para data files de los tablespaces"

echo "Creando directorios para C0"

if [ -d "/unam/bda/pf/c0/d101" ]; then
  echo "Directorio c0/d101 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d101
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d102" ]; then
  echo "Directorio c0/d102 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d102
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d103" ]; then
  echo "Directorio c0/d103 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d103
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d104" ]; then
  echo "Directorio c0/d104 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d104
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d105" ]; then
  echo "Directorio c0/d105 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d105
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d201" ]; then
  echo "Directorio c0/d201 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d201
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d202" ]; then
  echo "Directorio c0/d202 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d202
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d203" ]; then
  echo "Directorio c0/d203 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d203
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d204" ]; then
  echo "Directorio c0/d204 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d204
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d205" ]; then
  echo "Directorio c0/d205 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d205
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

if [ -d "/unam/bda/pf/c0/d206" ]; then
  echo "Directorio c0/d206 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c0/d206
  chown -R oracle:oinstall c0
  chmod -R 750 c0
fi;

echo "Creando directorios para C1"

if [ -d "/unam/bda/pf/c1/d101" ]; then
  echo "Directorio c1/d101 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c1/d101
  chown -R oracle:oinstall c1
  chmod -R 750 c1
fi;

echo "4. Creando directorios para C2"

if [ -d "/unam/bda/pf/c2/d101" ]; then
  echo "Directorio c2/d101 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c2/d101
  chown -R oracle:oinstall c2
  chmod -R 750 c2
fi;

if [ -d "/unam/bda/pf/c2/d102" ]; then
  echo "Directorio c2/d102 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c2/d102
  chown -R oracle:oinstall c2
  chmod -R 750 c2
fi;

if [ -d "/unam/bda/pf/c2/d201" ]; then
  echo "Directorio c2/d201 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c2/d201
  chown -R oracle:oinstall c2
  chmod -R 750 c2
fi;

echo "Creando directorios para C3"

if [ -d "/unam/bda/pf/c3/d101" ]; then
  echo "Directorio c3/d101 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c3/d101
  chown -R oracle:oinstall c3
  chmod -R 750 c3
fi;

if [ -d "/unam/bda/pf/c3/d201" ]; then
  echo "Directorio c3/d201 ya existe"
else 
  cd /unam/bda/pf
  mkdir -p c3/d201
  chown -R oracle:oinstall c3
  chmod -R 750 c3
fi;

echo "Mostrando directorios para Tablespaces"
ls -R /unam/bda/pf/c*

read -p "Eliminando contenido de datafiles antiguos en caso de existir [Enter] para continuar"

rm -f /unam/bda/pf/c0/d101/*.dbf
rm -f /unam/bda/pf/c0/d102/*.dbf
rm -f /unam/bda/pf/c0/d103/*.dbf
rm -f /unam/bda/pf/c0/d104/*.dbf
rm -f /unam/bda/pf/c0/d105/*.dbf
rm -f /unam/bda/pf/c0/d201/*.dbf
rm -f /unam/bda/pf/c0/d202/*.dbf
rm -f /unam/bda/pf/c0/d203/*.dbf
rm -f /unam/bda/pf/c0/d204/*.dbf
rm -f /unam/bda/pf/c0/d205/*.dbf
rm -f /unam/bda/pf/c0/d206/*.dbf

rm -f /unam/bda/pf/c1/d101/*.dbf

rm -f /unam/bda/pf/c2/d101/*.dbf
rm -f /unam/bda/pf/c2/d102/*.dbf
rm -f /unam/bda/pf/c2/d201/*.dbf

rm -f /unam/bda/pf/c3/d101/*.dbf
rm -f /unam/bda/pf/c3/d201/*.dbf

echo "Creando directorios para Archivelogs"

if [ -d "/unam/bda/pf/archivelogs" ]; then
  echo "Directorio archivelogs ya existe"
else 
  cd /unam/bda/pf
  mkdir -p archivelogs
  chown -R oracle:oinstall archivelogs
  chmod -R 750 archivelogs
fi;

echo "Creando directorios para FRA"

if [ -d "/unam/bda/pf/fast-reco-area" ]; then
  echo "Directorio fast-reco-area ya existe"
else 
  cd /unam/bda/pf
  mkdir -p fast-reco-area
  chown -R oracle:oinstall fast-reco-area
  chmod -R 750 fast-reco-area
fi;
