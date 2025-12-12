#!/bin/bash
#@Autor(es): Emmanuel Jimenez / Jesus Tenorio
#@Fecha creación: 07/12/2025
#@Descripción: Crea un contenedor de Docker para el proyecto
docker run -i -t \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ${UNAM_HOME}:${UNAM_HOME} \
--name c-ejc-proy-final \
--hostname h-ejc-proy-final.fi.unam \
--network bda_network \
--ip 172.22.0.22 \
--expose 1521 \
--shm-size=2gb \
-e DISPLAY=$DISPLAY ol-ejc:1.0 bash

#Configurar variables de entorno en el contenedor, en /etc/profile.d/99-custom-env.sh
#Agregar lo siguiente sin comentarios 

# Variables de entorno para Oracle.
#export ORACLE_HOSTNAME=h-ejc-proy-final.fi.unam
#export ORACLE_BASE=/opt/oracle
#export ORACLE_HOME=$ORACLE_BASE/product/23ai/dbhomeFree
#export ORA_INVENTORY=$ORACLE_BASE/oraInventory
#export ORACLE_SID=free
#export NLS_LANG=American_America.AL32UTF8
#export PATH=$ORACLE_HOME/bin:$PATH
#export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
##alias globales
#alias sqlplus='rlwrap sqlplus'

# Configurar alias de servicio en maquina host (para Mint)/etc/bash.bashrc
# agregar lo siguiente sin comentarios para acceder

#alias dockerBdaProy='docker start c-ejc-proy-final && docker attach c-ejc-proy-final'
#alias dockerBdaProyT='docker exec -it c-ejc-proy-final bash'

