
--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  08/12/2025
--@Descripción: Crea usuarios admin de DIRECTORY y define directorys

--Asegurarse que el usario Oracle tiene permiso de escritura en la rurta de los directorys

whenever sqlerror exit rollback

prompt ==> Conectando como sysdba en proveedores
connect sys/system0@proveedores as sysdba

prompt ==> Creando usuario administrador de directorios en proveedores
drop user if exists admin_files_prov cascade;
create user admin_files_prov identified by admin_files_prov
  default tablespace users quota 10m on users;
grant create session, create any directory to admin_files_prov;

prompt ==> Conectando como admin_files_prov
connect admin_files_prov/admin_files_prov@proveedores

prompt ==> Creando objetos DIRECTORY con RUTAS Absolutas (sin uso de PATH PREFIX) en proveedores
define hs_base = '/opt/oracle/oradata/FREE/files//unam/bda/pf/blobs_prov';

create or replace directory PROVEEDOR_FOTO             as '&hs_base/proveedor_imgs';
create or replace directory PROVEEDOR_IDENTIFICACION   as '&hs_base/proveedor_pdfs';
create or replace directory PROVEEDOR_COMPROBANTE      as '&hs_base/comprobantes_pdfs';
create or replace directory COMPROBANTE_DOCUMENTO      as '&hs_base/documentos_pdfs';
create or replace directory EVIDENCIA_IMAGEN           as '&hs_base/evidencias_imgs';

prompt ==> Otorgando permisos de LECTURA al usuario prov_admin
grant read on directory PROVEEDOR_FOTO           to prov_admin;
grant read on directory PROVEEDOR_IDENTIFICACION to prov_admin;
grant read on directory PROVEEDOR_COMPROBANTE    to prov_admin;
grant read on directory COMPROBANTE_DOCUMENTO    to prov_admin;
grant read on directory EVIDENCIA_IMAGEN         to prov_admin;

prompt ==> Conectando como sysdba en servicios
connect sys/system0@servicios as sysdba

prompt ==> Creando usuario administrador de directorios en servicios
drop user if exists admin_files_serv cascade;
create user admin_files_serv identified by admin_files_serv
  default tablespace users quota 10m on users;
grant create session, create any directory to admin_files_serv;

prompt ==> Conectando como admin_files_serv
connect admin_files_serv/admin_files_serv@servicios

prompt ==> Creando objetos DIRECTORY con RUTAS Absolutas (sin uso de PATH PREFIX) en proveedores
define hs_base = '/opt/oracle/oradata/FREE/files//unam/bda/pf/blobs_serv';

create or replace directory SERVICIO_SOLICITUD_DETALLES    as '&hs_base/detalles_pdfs';
create or replace directory SERVICIO_CONTRATO_PROTOTIPO    as '&hs_base/contratos_pdfs';
create or replace directory PROVEEDOR_DEPOSITO_COMPROBANTE as '&hs_base/comprobante_pdfs';
create or replace directory CLIENTE_EMPRESA_LOGO           as '&hs_base/logo_imgs';
create or replace directory CLIENTE_PARTICULAR_FOTO        as '&hs_base/fotos_imgs';

prompt ==> Otorgando permisos de LECTURA al usuario serv_admin
grant read on directory SERVICIO_SOLICITUD_DETALLES    to serv_admin;
grant read on directory SERVICIO_CONTRATO_PROTOTIPO    to serv_admin;
grant read on directory PROVEEDOR_DEPOSITO_COMPROBANTE to serv_admin;
grant read on directory CLIENTE_EMPRESA_LOGO           to serv_admin;
grant read on directory CLIENTE_PARTICULAR_FOTO        to serv_admin;

prompt ==> Listo
disconnect
