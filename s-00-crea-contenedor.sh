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