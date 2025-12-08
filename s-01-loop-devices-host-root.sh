#!/bin/bash
#@Autor(es): Emmanuel Jimenez / Jesus Tenorio
#@Fecha creación: 16/09/2025
#@Descripción: Script para creación de loop devices para el proyecto

echo "Creando ${UNAM_HOME}/bda/pf/disk-images"
mkdir -p ${UNAM_HOME}/bda/pf/disk-images

cd ${UNAM_HOME}/bda/pf/disk-images

echo "Creando disk1.img de 1 Gb"
dd if=/dev/zero of=disk1.img bs=100M count=10

echo "Creando disk2.img de 1 Gb"
dd if=/dev/zero of=disk2.img bs=100M count=10

echo "Creando disk3.img de 1 Gb"
dd if=/dev/zero of=disk3.img bs=100M count=10

echo "Mostrando la creación de los archivos"
du -sh disk*.img

echo "Creando loop device para disk1.img"
losetup -fP disk1.img

echo "Creando loop device para disk2.img"
losetup -fP disk2.img

echo "Creando loop device para disk3.img"
losetup -fP disk3.img

echo "Mostrando la creación de loop devices"
losetup -a

echo "Dando formato ext4 a disk1.img"
mkfs.ext4 disk1.img

echo "Dando formato ext4 a disk2.img"
mkfs.ext4 disk2.img

echo "Dando formato ext4 a disk3.img"
mkfs.ext4 disk3.img

echo "Crear los directorios donde los loop devices serán montados"
mkdir -p ${UNAM_HOME}/bda/pf/disks/d01
mkdir -p ${UNAM_HOME}/bda/pf/disks/d02
mkdir -p ${UNAM_HOME}/bda/pf/disks/d03