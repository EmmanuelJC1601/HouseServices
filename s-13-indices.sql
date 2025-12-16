--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  09/12/2025
--@Descripción:     Script para la creacion de los indices restantes de las tablas
--                  

Prompt Creando indices non unique para las PDBs

Prompt Conectando como sys en Proveedores
connect prov_admin/1234@proveedores

--indices para foreign keys
create index proveedor_entidad_id_ix on proveedor(entidad_id)
  tablespace proveedores_c0_idx_ts;
create index proveedor_nivel_estudios_id_ix on proveedor(nivel_estudios_id)
  tablespace proveedores_c0_idx_ts;
create index proveedor_proveedor_principal_id_ix on 
  proveedor(proveedor_principal_id)
  tablespace proveedores_c0_idx_ts;
create index cuenta_bancaria_proveedor_id_ix on cuenta_bancaria(proveedor_id)
  tablespace proveedores_c0_idx_ts;
create index tipo_servicio_proveedor_id_ix on tipo_servicio(proveedor_id)
  tablespace proveedores_c0_idx_ts;
create index tipo_servicio_servicio_id_ix on tipo_servicio(servicio_id)
  tablespace proveedores_c0_idx_ts;
create index comprobante_tipo_servicio_id_ix on comprobante(tipo_servicio_id)
  tablespace proveedores_c0_idx_ts;
create index calificacion_proveedor_id_ix on calificacion(proveedor_id)
  tablespace proveedores_c0_idx_ts;

Prompt Conectando como sys en Servicios
connect serv_admin/1234@servicios

--indices para foreign keys
create index tarjeta_credito_cliente_id_ix on tarjeta_credito(cliente_id)
  tablespace servicios_c0_idx_ts;
create index servicio_solicitud_tarjeta_credito_id_ix on 
  servicio_solicitud(tarjeta_credito_id)
  tablespace servicios_c0_idx_ts;
create index servicio_solicitud_estatus_solicitud_id_ix on 
  servicio_solicitud(estatus_solicitud_id)
  tablespace servicios_c0_idx_ts;
create index historico_estatus_solicitud_servicio_solicitud_id_ix on 
  historico_estatus_solicitud(servicio_solicitud_id)
  tablespace servicios_c0_idx_ts;
create index historico_estatus_solicitud_estatus_solicitud_id_ix on 
  historico_estatus_solicitud(estatus_solicitud_id)
  tablespace servicios_c0_idx_ts;
create index servicio_contrato_servicio_solicitud_id_ix on 
  servicio_contrato(servicio_solicitud_id)
  tablespace servicios_c0_idx_ts;
create index proveedor_deposito_servicio_contrato_id_ix 
  on proveedor_deposito(servicio_contrato_id)
  tablespace servicios_c0_idx_ts;
