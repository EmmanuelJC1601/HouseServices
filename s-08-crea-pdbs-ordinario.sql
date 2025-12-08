--@Autor(es): Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación: 08/12/2025
--@Descripción: Script para clonar las PDBs por módulo

Prompt Conectando como sys
connect sys/system0 as sysdba

create pluggable database proveedores
  admin user proveedores_admin identified by proveedores_admin
  path_prefix = '/opt/oracle/oradata/FREE'
  file_name_convert = ('/pdbseed/', '/proveedores/');

Prompt Abrir la PDB proveedores
alter pluggable database proveedores open;

Prompt Guardar el estado de la PDB
alter pluggable database proveedores save state;

create pluggable database servicios
  admin user servicios_admin identified by servicios_admin
  path_prefix = '/opt/oracle/oradata/FREE'
  file_name_convert = ('/pdbseed/', '/servicios/');

Prompt Abrir la PDB servicios
alter pluggable database servicios open;

Prompt Guardar el estado de la PDB
alter pluggable database servicios save state;