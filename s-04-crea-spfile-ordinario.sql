--@Autor(es): Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación: 07/12/2025
--@Descripción: Script para creación de un SPFILE

Prompt Conectando como sys por medio del archivo de passwords
connect sys/Hola1234* as sysdba

Prompt Creando SPFILE a partir del PFILE
create spfile from pfile;

Prompt Verificando existencia del SPFILE
!ls ${ORACLE_HOME}/dbs/spfile${ORACLE_SID}.ora

Prompt SPFILE creado
exit