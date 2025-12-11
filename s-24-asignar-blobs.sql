
-- s-24-carga-blobs-proveedores-pk1.sql
--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  08/12/2025
--@Descripción: Carga blobs en las tablas de modulo 1, una por tabla
              
whenever sqlerror exit rollback

prompt ==> Conectando como prov_admin en proveedores
connect prov_admin/1234@proveedores
set serveroutput on

prompt ==> Creando procedimiento: carga_blobs_proveedores_pk1
create or replace procedure carga_blobs_proveedores_pk1 is
  v_bfile bfile;
  v_blob  blob;
  v_amt   number;
begin
 
 --para proveedor -> 

  select foto into v_blob
    from proveedor
   where proveedor_id = 1
   for update;

  v_bfile := bfilename('PROVEEDOR_FOTO', '1.jpg');
  if dbms_lob.fileexists(v_bfile) = 0 then
    raise_application_error(-20001,'1.jpg no existe en PROVEEDOR_FOTO');
  end if;

  dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);
  v_amt := dbms_lob.getlength(v_bfile);
  if v_amt <= 0 then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20011,'1.jpg está vacío (amount=0)');
  end if;
  dbms_lob.loadfromfile(v_blob, v_bfile, v_amt);
  if dbms_lob.getlength(v_blob) <> v_amt then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20002,'Longitudes no coinciden al cargar PROVEEDOR.foto');
  end if;
  dbms_lob.fileclose(v_bfile);

  -- Para proveedor -> identificacion

  select identificacion into v_blob
    from proveedor
   where proveedor_id = 1
   for update;

  v_bfile := bfilename('PROVEEDOR_IDENTIFICACION', '1.pdf');
  if dbms_lob.fileexists(v_bfile) = 0 then
    raise_application_error(-20003,'1.pdf no existe en PROVEEDOR_IDENTIFICACION');
  end if;

  dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);
  v_amt := dbms_lob.getlength(v_bfile);
  if v_amt <= 0 then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20012,'1.pdf está vacío (amount=0)');
  end if;
  dbms_lob.loadfromfile(v_blob, v_bfile, v_amt);
  if dbms_lob.getlength(v_blob) <> v_amt then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20004,'Longitudes no coinciden al cargar PROVEEDOR.identificacion');
  end if;
  dbms_lob.fileclose(v_bfile);

  --proveedor -> comprobante
  select comprobante_domicilio into v_blob
    from proveedor
   where proveedor_id = 1
   for update;

  v_bfile := bfilename('PROVEEDOR_COMPROBANTE', '1.pdf');
  if dbms_lob.fileexists(v_bfile) = 0 then
    raise_application_error(-20005,'1.pdf no existe en PROVEEDOR_COMPROBANTE');
  end if;

  dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);
  v_amt := dbms_lob.getlength(v_bfile);
  if v_amt <= 0 then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20013,'1.pdf está vacío (amount=0)');
  end if;
  dbms_lob.loadfromfile(v_blob, v_bfile, v_amt);
  if dbms_lob.getlength(v_blob) <> v_amt then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20006,'Longitudes no coinciden al cargar PROVEEDOR.comprobante_domicilio');
  end if;
  dbms_lob.fileclose(v_bfile);

  --comprobate -> documento
  select documento into v_blob
    from comprobante
   where comprobante_id = 1
   for update;

  v_bfile := bfilename('PROVEEDOR_COMPROBANTE', '1.pdf');
  if dbms_lob.fileexists(v_bfile) = 0 then
    raise_application_error(-20015,'1.pdf no existe en PROVEEDOR_COMPROBANTE');
  end if;

  dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);
  v_amt := dbms_lob.getlength(v_bfile);
  if v_amt <= 0 then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20016,'1.pdf está vacío (amount=0)');
  end if;
  dbms_lob.loadfromfile(v_blob, v_bfile, v_amt);
  if dbms_lob.getlength(v_blob) <> v_amt then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20017,'Longitudes no coinciden al cargar COMPROBANTE.documento');
  end if;
  dbms_lob.fileclose(v_bfile);

  -- evidencia -> imagen
  select imagen into v_blob
    from evidencia
   where tipo_servicio_id = 1
     and numero_evidencia = 1
   for update;

  v_bfile := bfilename('EVIDENCIA_IMAGEN', '1.jpg');
  if dbms_lob.fileexists(v_bfile) = 0 then
    raise_application_error(-20018,'1.jpg no existe en EVIDENCIA_IMAGEN');
  end if;

  dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);
  v_amt := dbms_lob.getlength(v_bfile);
  if v_amt <= 0 then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20019,'1.jpg está vacío (amount=0)');
  end if;
  dbms_lob.loadfromfile(v_blob, v_bfile, v_amt);
  if dbms_lob.getlength(v_blob) <> v_amt then
    dbms_lob.fileclose(v_bfile);
    raise_application_error(-20020,'Longitudes no coinciden al cargar EVIDENCIA.imagen');
  end if;
  dbms_lob.fileclose(v_bfile);

end;
/
show errors

prompt ==> Ejecutando carga_blobs_proveedores_pk1 (PK=1 en todas las tablas)
begin
  carga_blobs_proveedores_pk1;
end;
/
prompt ==> Confirmando cambios
commit;

prompt ==> Validación (PK=1)
select proveedor_id,
       round(dbms_lob.getlength(foto)/1024,2)                 as foto_kb,
       round(dbms_lob.getlength(identificacion)/1024,2)       as identificacion_kb,
       round(dbms_lob.getlength(comprobante_domicilio)/1024,2) as comp_dom_kb
from proveedor
where proveedor_id = 1;

select comprobante_id,
       round(dbms_lob.getlength(documento)/1024,2) as documento_kb
from comprobante
where comprobante_id = 1;

select tipo_servicio_id, numero_evidencia,
       round(dbms_lob.getlength(imagen)/1024,2) as imagen_kb
from evidencia
where tipo_servicio_id = 1
  and numero_evidencia = 1;

prompt ==> Listo
