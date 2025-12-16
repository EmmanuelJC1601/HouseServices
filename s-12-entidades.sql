--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  08/12/2025
--@Descripción:     Script para la creacion de las tablas en cada PDB
--                  

Prompt Conectando como sys en Proveedores
connect prov_admin/1234@proveedores

drop table if exists calificacion;
drop table if exists evidencia;
drop table if exists comprobante;
drop table if exists tipo_servicio;
drop table if exists cuenta_bancaria;
drop table if exists proveedor;
drop table if exists servicio;
drop table if exists nivel_estudios;
drop table if exists entidad;

create table entidad(
  entidad_id number(2,0) constraint entidad_pk primary key
    using index tablespace proveedores_c0_idx_ts,
  nombre varchar2(40) not null,
  descripcion varchar2(400) not null
) tablespace proveedores_c1_data_ts nologging;

create table nivel_estudios(
  nivel_estudios_id number(2,0) constraint nivel_estudios_pk primary key
    using index tablespace proveedores_c0_idx_ts,
  nivel varchar2(40) not null,
  descripcion varchar2(400) not null
) tablespace proveedores_c1_data_ts nologging;

create table servicio(
  servicio_id number(10,0) constraint servicio_pk primary key
    using index tablespace proveedores_c0_idx_ts,
  nombre varchar2(40) not null,
  descripcion varchar2(400) not null
) tablespace proveedores_c1_data_ts;

create table proveedor(
  proveedor_id number(10,0) constraint proveedor_pk primary key
    using index tablespace proveedores_c0_idx_ts,
  nombre varchar2(40) not null,
  ap_paterno varchar2(40) not null,
  ap_materno varchar2(40) not null,
  foto blob not null,
  fecha_nacimiento date not null,
  direccion varchar2(100) not null,
  email varchar2(100) not null,
  telefono_casa varchar2(14) not null,
  telefono_movil varchar2(14) not null,
  identificacion blob not null,
  comprobante_domicilio blob not null,
  entidad_id not null constraint proveedor_entidad_id_fk 
    references entidad(entidad_id),
  nivel_estudios_id not null constraint proveedor_nivel_estudios_id_fk
    references nivel_estudios(nivel_estudios_id),
  proveedor_principal_id constraint proveedor_proveedor_principal_id_fk
    references proveedor(proveedor_id),
  constraint proveedor_email_uk unique(email)
    using index tablespace proveedores_c0_idx_ts,
  constraint proveedor_telefono_casa_uk unique(telefono_casa)
    using index tablespace proveedores_c0_idx_ts,
  constraint proveedor_telefono_movil_uk unique(telefono_movil)
    using index tablespace proveedores_c0_idx_ts
) pctfree 10 tablespace proveedores_c1_data_ts
lob (foto) store as securefile proveedor_foto_lob (
  tablespace proveedores_c0_lob_hot_ts
  index proveedor_foto_lob_ix (tablespace proveedores_c0_idx_ts)
)
lob (identificacion) store as securefile proveedor_identificacion_lob (
  tablespace proveedores_c2_lob_warm_ts
  index proveedor_identificacion_lob_ix (tablespace proveedores_c0_idx_ts)
)
lob (comprobante_domicilio) store as securefile proveedor_comprobante_domicilio_lob (
  tablespace proveedores_c2_lob_warm_ts
  index proveedor_comprobante_domomicilio_lob_ix (tablespace proveedores_c0_idx_ts)
);

create table cuenta_bancaria(
  cuenta_bancaria_id number(10,0) constraint cuenta_bancaria_pk primary key
    using index tablespace proveedores_c0_idx_ts,
  clabe varchar2(18) not null,
  banco varchar2(40) not null,
  proveedor_id not null constraint cuenta_bancaria_proveedor_id_fk
    references proveedor(proveedor_id),
  constraint cuenta_bancaria_clabe_uk unique(clabe)
    using index tablespace proveedores_c0_idx_ts
) pctfree 10 tablespace proveedores_c1_data_ts;

create table tipo_servicio(
  tipo_servicio_id number(10,0) constraint tipo_servicio_pk primary key
    using index tablespace proveedores_c0_idx_ts,
  anios_experiencia number(2,0) not null,
  proveedor_id not null constraint tipo_servicio_proveedor_id_fk
    references proveedor(proveedor_id),
  servicio_id not null constraint tipo_servicio_servicio_id_fk
    references servicio(servicio_id)
) pctfree 10 tablespace proveedores_c1_data_ts;

create table comprobante(
  comprobante_id number(10,0) constraint comprobante_pk primary key
    using index tablespace proveedores_c0_idx_ts,
  documento blob not null,
  tipo_servicio_id not null constraint comprobante_tipo_servicio_id_fk
    references tipo_servicio(tipo_servicio_id)
) tablespace proveedores_c1_data_ts
lob (documento) store as securefile comprobante_documento_lob (
  tablespace proveedores_c2_lob_warm_ts
  index comprobante_documento_lob_ix (tablespace proveedores_c0_idx_ts)
);

create table evidencia(
  numero_evidencia number(2,0) not null,
  tipo_servicio_id constraint evidencia_tipo_servicio_id_fk 
    references tipo_servicio(tipo_servicio_id),
  descripcion varchar2(500) not null,
  imagen blob not null,
  constraint evidencia_pk primary key(tipo_servicio_id, numero_evidencia)
    using index tablespace proveedores_c0_idx_ts
) tablespace proveedores_c1_data_ts
lob (imagen) store as securefile evidencia_imagen_lob (
  tablespace proveedores_c0_lob_hot_ts
  index evidencia_imagen_lob_ix (tablespace proveedores_c0_idx_ts)
);

create table calificacion(
  calificacion_id number(10,0) constraint calificacion_pk primary key
    using index tablespace proveedores_c0_idx_ts,
  evaluacion number(1,0) not null,
  comentario varchar2(400) not null,
  proveedor_id not null constraint calificacion_proveedor_id_fk
    references proveedor(proveedor_id),
  servicio_contrato_rid number(10,0) not null,
  constraint calificacion_evaluacion_chk check(
    evaluacion between 1 and 5
  )
) tablespace proveedores_c1_data_ts;

Prompt Conectando como sys en Servicios
connect serv_admin/1234@servicios

drop table if exists proveedor_deposito;
drop table if exists servicio_pago;
drop table if exists servicio_contrato;
drop table if exists historico_estatus_solicitud;
drop table if exists servicio_solicitud;
drop table if exists estatus_solicitud;
drop table if exists tarjeta_credito;
drop table if exists cliente_particular;
drop table if exists cliente_empresa;
drop table if exists cliente;

create table cliente(
  cliente_id number(10,0) constraint cliente_pk primary key
    using index tablespace servicios_c0_idx_ts,
  fecha_registro date not null,
  usuario varchar2(40) not null,
  contrasenia varchar2(40) not null,
  email varchar2(40) not null,
  telefono varchar2(14) not null,
  direccion varchar2(100) not null,
  tipo char(1) not null,
  constraint cliente_email_uk unique(email)
    using index tablespace servicios_c0_idx_ts,
  constraint cliente_usuario_uk unique(usuario)
    using index tablespace servicios_c0_idx_ts,
  constraint cliente_telefono_uk unique(telefono)
    using index tablespace servicios_c0_idx_ts,
  constraint cliente_tipo_chk check(tipo in('P','E'))
) pctfree 10 tablespace servicios_c0_data_ts;

create table cliente_empresa(
  cliente_id constraint cliente_empresa_pk primary key
    using index tablespace servicios_c0_idx_ts,
  nombre varchar2(40) not null,
  descripcion varchar2(400) not null,
  logo blob not null,
  num_empleados number(4,0) not null,
  constraint cliente_empresa_cliente_id_fk foreign key (cliente_id)
    references cliente(cliente_id)
) pctfree 10 tablespace servicios_c0_data_ts
lob (logo) store as securefile cliente_empresa_logo_lob (
  tablespace servicios_c0_lob_hot_ts
  index cliente_empresa_logo_lob_ix (tablespace servicios_c0_idx_ts)
);

create table cliente_particular(
  cliente_id constraint cliente_particular_pk primary key
    using index tablespace servicios_c0_idx_ts,
  nombre varchar2(40) not null,
  curp varchar2(18) not null,
  foto blob not null,
  fecha_nacimiento date not null,
  constraint cliente_particular_cliente_id_fk foreign key (cliente_id)
    references cliente(cliente_id),
  constraint cliente_particular_curp_uk unique(curp)
    using index tablespace servicios_c0_idx_ts
) pctfree 10 tablespace servicios_c0_data_ts
lob (foto) store as securefile cliente_particular_foto_lob (
  tablespace servicios_c0_lob_hot_ts
  index cliente_particular_foto_lob_ix (tablespace servicios_c0_idx_ts)
);

create table tarjeta_credito(
  tarjeta_credito_id number(10,0) constraint tarjeta_credito_pk primary key
    using index tablespace servicios_c0_idx_ts,
  numero_bancario number(16,0) not null, 
  numero_tarjeta number(1,0) not null,
  anio_expiracion varchar2(2) not null,
  mes_expiracion varchar2(2) not null,
  cvv varchar2(3) not null,
  banco varchar2(40) not null,
  cliente_id not null constraint tarjeta_credito_cliente_id_fk
    references cliente(cliente_id),
  constraint tarjeta_credito_numero_bancario_uk unique(numero_bancario)
    using index tablespace servicios_c0_idx_ts
) pctfree 10 tablespace servicios_c0_data_ts;

create table estatus_solicitud(
  estatus_solicitud_id number(10,0) constraint estatus_solicitud_pk primary key
    using index tablespace servicios_c0_idx_ts,
  clave varchar2(40) not null,
  descripcion varchar2(400) not null,
  activo number(1,0) not null,
  constraint estatus_solicitud_activo_chk check(
    activo in(1,0)
  )
) tablespace servicios_c0_data_ts nologging;

create table servicio_solicitud(
  servicio_solicitud_id number(10,0) constraint servicio_solicitud_pk primary key
    using index tablespace servicios_c0_idx_ts,
  fecha_servicio date not null,
  descripcion varchar2(1000) not null,
  detalles blob,
  fecha_status date not null,
  tarjeta_credito_id not null constraint servicio_solicitud_tarjeta_credito_id_fk
    references tarjeta_credito(tarjeta_credito_id),
  estatus_solicitud_id not null constraint servicio_solicitud_estatus_solicitud_id_fk
    references estatus_solicitud(estatus_solicitud_id),
  tipo_servicio_rid number(10,0) not null
) pctfree 10 tablespace servicios_c0_data_ts
lob (detalles) store as securefile servicio_solicitud_detalles_lob (
  tablespace servicios_c0_lob_hot_ts
  index servicio_solicitud_detalles_lob_ix (tablespace servicios_c0_idx_ts)
);

create table historico_estatus_solicitud(
  historico_estatus_solicitud_id number(10,0) constraint historico_estatus_solicitud_pk primary key
    using index tablespace servicios_c0_idx_ts,
  fecha_estatus date not null,
  servicio_solicitud_id not null constraint historico_estatus_solicitud_servicio_solicitud_id_fk
    references servicio_solicitud(servicio_solicitud_id),
  estatus_solicitud_id not null constraint historico_estatus_solicitud_estatus_solicitud_id_fk
    references estatus_solicitud(estatus_solicitud_id)
) tablespace servicios_c0_data_ts;

create table servicio_contrato(
  servicio_contrato_id number(10,0) constraint servicio_contrato_pk primary key
    using index tablespace servicios_c0_idx_ts,
  precio number(8,2) not null,
  descripcion varchar2(400) not null,
  mensualidades number(2,0),
  prototipo blob,
  servicio_solicitud_id not null constraint servicio_contrato_servicio_solicitud_id_fk
    references servicio_solicitud(servicio_solicitud_id)
) pctfree 10 tablespace servicios_c0_data_ts
lob (prototipo) store as securefile servicio_contrato_prototipo_lob (
  tablespace servicios_c0_lob_hot_ts
  index servicio_contrato_prototipo_lob_ix (tablespace servicios_c0_idx_ts)
);

create table servicio_pago(
  numero_pago number(2,0) not null,
  servicio_contrato_id constraint servicio_pago_servicio_contrato_id_fk
    references servicio_contrato(servicio_contrato_id),
  fecha date not null,
  importe number(8,2) not null,
  comision number(8,2) not null,
  constraint servicio_pago_pk primary key(servicio_contrato_id, numero_pago)
    using index tablespace servicios_c0_idx_ts
) tablespace servicios_c0_data_ts;

create table proveedor_deposito(
  proveedor_deposito_id number(10,0) constraint proveedor_deposito_pk primary key
    using index tablespace servicios_c0_idx_ts,
  importe number(5,2) not null,
  fecha date not null,
  comprobante blob not null,
  servicio_contrato_id not null constraint proveedor_deposito_servicio_contrato_id_fk
    references servicio_contrato(servicio_contrato_id),
  cuenta_bancaria_rid number(10,0) not null
) tablespace servicios_c0_data_ts
lob (comprobante) store as securefile proveedor_deposito_comprobante_lob (
  tablespace servicios_c0_lob_hot_ts
  index proveedor_deposito_comprobante_lob_ix (tablespace servicios_c0_idx_ts)
);