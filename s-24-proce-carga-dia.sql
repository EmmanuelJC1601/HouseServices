
--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  10/12/2025
--@Descripción:     procediientos para simular un día de trabajo en el módulo Proveedores y servicios

Prompt Conectando como prov_admin
connect prov_admin/1234@proveedores

set serveroutput on
set echo on
whenever sqlerror continue none

create or replace procedure simula_carga_dia_prov (
  p_num_proveedores      in number default 1,
  p_evidencias_por_ts    in number default 25,  
  p_porcentaje_telefonos in number default 10,  
  p_rid_sc_min           in number default 1,
  p_rid_sc_max           in number default 999
)
is
  v_proveedor_id       number;
  v_cuenta_id          number;
  v_tipo_servicio_id   number;
  v_comprobante_id     number;
  v_calificacion_id    number;

  v_entidad_id entidad.entidad_id%type;
  v_nivel_id   nivel_estudios.nivel_estudios_id%type;

  v_servicio_id  number;
  v_query_rand_servicio  varchar2(1000);

  v_q_ins_proveedor   varchar2(4000);
  v_q_ins_cuenta      varchar2(2000);
  v_q_ins_tipo_serv   varchar2(2000);
  v_q_ins_comprobante varchar2(2000);
  v_q_ins_evidencia   varchar2(2000);
  v_q_upd_tel         varchar2(2000);
  v_q_ins_calif       varchar2(2000);

begin
  
  select NVL(max(proveedor_id),0)+1 into v_proveedor_id     from proveedor;
  select NVL(max(cuenta_bancaria_id),0)+1 into v_cuenta_id  from cuenta_bancaria;
  select NVL(max(tipo_servicio_id),0)+1   into v_tipo_servicio_id from tipo_servicio;
  select NVL(max(comprobante_id),0)+1     into v_comprobante_id   from comprobante;
  select NVL(max(calificacion_id),0)+1    into v_calificacion_id  from calificacion;

  select min(entidad_id) into v_entidad_id from entidad;
  select min(nivel_estudios_id) into v_nivel_id from nivel_estudios;
  if v_entidad_id is null or v_nivel_id is null then
    raise_application_error(-20001, 'Faltan catálogos: entidad / nivel_estudios');
  end if;

  v_query_rand_servicio := '
    select servicio_id
    from (
      select servicio_id from servicio order by dbms_random.value
    )
    where rownum = 1';

  
  v_q_ins_proveedor := '
    insert into proveedor(
      proveedor_id, nombre, ap_paterno, ap_materno, foto,
      fecha_nacimiento, direccion, email, telefono_casa, telefono_movil,
      identificacion, comprobante_domicilio, entidad_id, nivel_estudios_id, proveedor_principal_id
    ) values (
      :1, :2, :3, :4, empty_blob(),
      :5, :6, :7, :8, :9,
      empty_blob(), empty_blob(), :10, :11, null
    )';

  v_q_ins_cuenta := '
    insert into cuenta_bancaria(
      cuenta_bancaria_id, clabe, banco, proveedor_id
    ) values (
      :1, :2, :3, :4
    )';

  v_q_ins_tipo_serv := '
    insert into tipo_servicio(
      tipo_servicio_id, anios_experiencia, proveedor_id, servicio_id
    ) values (
      :1, :2, :3, :4
    )';

  v_q_ins_comprobante := '
    insert into comprobante(
      comprobante_id, documento, tipo_servicio_id
    ) values (
      :1, empty_blob(), :2
    )';

  v_q_ins_evidencia := '
    insert into evidencia(
      numero_evidencia, tipo_servicio_id, descripcion, imagen
    ) values (
      :1, :2, :3, empty_blob()
    )';

  v_q_upd_tel := '
    update proveedor
       set telefono_movil = :1
     where proveedor_id = :2';

  v_q_ins_calif := '
    insert into calificacion(
      calificacion_id, evaluacion, comentario, proveedor_id, servicio_contrato_rid
    ) values (
      :1, :2, :3, :4, :5
    )';

 
  for i in 1 .. p_num_proveedores loop
    execute immediate v_q_ins_proveedor using
      v_proveedor_id,
      'Prov'||trunc(dbms_random.value(10000,99999)),
      'AP'||i,
      'AM'||i,
      date '1985-01-01' + trunc(dbms_random.value(0, 15000)),
      'Calle '||i||' #123, Col. Simulada',
      'prov_'||v_proveedor_id||'@mail.com',
      lpad(to_char(5500000000 + v_proveedor_id), 10, '0'),
      lpad(to_char(5510000000 + v_proveedor_id), 10, '0'),
      v_entidad_id,
      v_nivel_id;

    execute immediate v_q_ins_cuenta using
      v_cuenta_id,
      lpad(to_char(300000000000000000 + v_cuenta_id), 18, '0'),
      'Banco'||trunc(dbms_random.value(100,999)),
      v_proveedor_id;

    for t in 1 .. 2 loop
      execute immediate v_query_rand_servicio into v_servicio_id;
      execute immediate v_q_ins_tipo_serv using
        v_tipo_servicio_id,
        trunc(dbms_random.value(1, 30)),
        v_proveedor_id,
        v_servicio_id;

      execute immediate v_q_ins_comprobante using
        v_comprobante_id,
        v_tipo_servicio_id;

      for e in 1 .. p_evidencias_por_ts loop
        execute immediate v_q_ins_evidencia using
          e,
          v_tipo_servicio_id,
          'Evidencia '||e||' (TS '||v_tipo_servicio_id||')';
      end loop;

      v_tipo_servicio_id := v_tipo_servicio_id + 1;
      v_comprobante_id   := v_comprobante_id + 1;
    end loop;

    v_proveedor_id := v_proveedor_id + 1;
    v_cuenta_id    := v_cuenta_id + 1;
  end loop;

  
  for r in (
    select proveedor_id
      from proveedor
     where mod(proveedor_id, 100) < p_porcentaje_telefonos
  ) loop
    execute immediate v_q_upd_tel using
      lpad(to_char(5520000000 + r.proveedor_id), 10, '0'),
      r.proveedor_id;
  end loop;

  
  for r in (
    select proveedor_id
      from proveedor
     where email like 'prov_%@mail.com'
       and to_number(substr(email, instr(email, '_')+1, instr(email, '@')-instr(email, '_')-1)) 
           >= (v_proveedor_id - p_num_proveedores)
  ) loop
    for c in 1 .. least(3, trunc(dbms_random.value(1,4))) loop
      execute immediate v_q_ins_calif using
        v_calificacion_id,
        trunc(dbms_random.value(1,6)),  -- 1..5
        'Calif '||c||' al prov '||r.proveedor_id,
        r.proveedor_id,
        trunc(dbms_random.value(p_rid_sc_min, p_rid_sc_max+1));
      v_calificacion_id := v_calificacion_id + 1;
    end loop;
  end loop;

  commit;
  dbms_output.put_line('PROVEEDORES: Inserción OK ('||p_num_proveedores||' provs) + evidencias/comprobantes + calificaciones.');
end;
/
show errors


------------- Procedimiento 2 -------------------

Prompt Creación del procedimiento para simular actualizaciones (sin cargas) en SERVICIOS
connect serv_admin/1234@servicios

create or replace procedure simula_dia_serv (
  p_porcentaje   in number default 30,  -- % aproximado de filas a actualizar por tabla
  p_rid_ts_min   in number default 1,   -- rango para tipo_servicio_rid
  p_rid_ts_max   in number default 1000,
  p_rid_cb_min   in number default 1,   -- rango para cuenta_bancaria_rid
  p_rid_cb_max   in number default 999
)
is
  v_status_id   number;
  v_rand        number;

  v_q_random_status              varchar2(1000);

  v_q_upd_cliente_base           varchar2(2000);
  v_q_upd_cliente_empresa        varchar2(1000);
  v_q_upd_cliente_particular     varchar2(1000);

  v_q_upd_tarjeta                varchar2(1000);

  v_q_upd_solicitud_status       varchar2(1000);
  v_q_upd_solicitud_textos       varchar2(1000);

  v_q_upd_contrato               varchar2(1000);

  v_q_upd_pago                   varchar2(1000);

  v_q_upd_deposito               varchar2(1000);

begin
  v_q_random_status := '
    select estatus_solicitud_id
    from ( select estatus_solicitud_id from estatus_solicitud order by dbms_random.value )
    where rownum = 1';

  v_q_upd_cliente_base := '
    update cliente
       set direccion     = :1,
           contrasenia   = :2,
           fecha_registro= systimestamp
     where cliente_id    = :3';

  v_q_upd_cliente_empresa := '
    update cliente_empresa
       set descripcion   = :1,
           num_empleados = :2
     where cliente_id    = :3';

  v_q_upd_cliente_particular := '
    update cliente_particular
       set nombre           = :1,
           fecha_nacimiento = :2
     where cliente_id       = :3';

  v_q_upd_tarjeta := '
    update tarjeta_credito
       set mes_expiracion   = :1,
           anio_expiracion  = :2,
           cvv              = :3,
           banco            = :4
     where tarjeta_credito_id = :5';


  v_q_upd_solicitud_status := '
    update servicio_solicitud
       set estatus_solicitud_id = :1,
           fecha_status         = systimestamp
     where servicio_solicitud_id = :2';

  v_q_upd_solicitud_textos := '
    update servicio_solicitud
       set descripcion       = :1,
           tipo_servicio_rid = :2
     where servicio_solicitud_id = :3';

  v_q_upd_contrato := '
    update servicio_contrato
       set precio        = :1,
           descripcion   = :2,
           mensualidades = :3
     where servicio_contrato_id = :4';

  v_q_upd_pago := '
    update servicio_pago
       set importe   = :1,
           comision  = :2,
           fecha     = systimestamp
     where servicio_contrato_id = :3
       and numero_pago          = :4';

  v_q_upd_deposito := '
    update proveedor_deposito
       set importe            = :1,
           cuenta_bancaria_rid= :2,
           fecha              = systimestamp
     where proveedor_deposito_id = :3';

  for r in (
    select c.cliente_id, c.tipo
      from cliente c
     where mod(c.cliente_id, 100) < p_porcentaje
  ) loop
    execute immediate v_q_upd_cliente_base using
      'Calle '||r.cliente_id||' #45, Col. Actualizada',
      'pass_'||trunc(dbms_random.value(100000,999999)),
      r.cliente_id;

    if r.tipo = 'E' then
      execute immediate v_q_upd_cliente_empresa using
        'Empresa actualizada',
        50 + trunc(dbms_random.value(0, 500)),
        r.cliente_id;
    else
      execute immediate v_q_upd_cliente_particular using
        'Cliente_'||r.cliente_id||'_upd',
        date '1990-01-01' + trunc(dbms_random.value(0, 13000)),
        r.cliente_id;
    end if;
  end loop;

  for r in (
    select t.tarjeta_credito_id
      from tarjeta_credito t
     where mod(t.tarjeta_credito_id, 100) < p_porcentaje
  ) loop
    execute immediate v_q_upd_tarjeta using
      lpad(to_char(trunc(dbms_random.value(1,12))), 2, '0'),          
      trunc(dbms_random.value(25, 40)),                                 
      lpad(to_char(100 + trunc(dbms_random.value(0, 900))), 3, '0'),    
      'Banco'||trunc(dbms_random.value(100,999)),
      r.tarjeta_credito_id;
  end loop;


  for r in (
    select s.servicio_solicitud_id
      from servicio_solicitud s
     where mod(s.servicio_solicitud_id, 100) < p_porcentaje
  ) loop
    execute immediate v_q_random_status into v_status_id;

    execute immediate v_q_upd_solicitud_status using
      v_status_id,
      r.servicio_solicitud_id;

    v_rand := dbms_random.value(0,1);
    if v_rand < 0.5 then
      execute immediate v_q_upd_solicitud_textos using
        'Solicitud actualizada '||r.servicio_solicitud_id,
        trunc(dbms_random.value(p_rid_ts_min, p_rid_ts_max+1)),
        r.servicio_solicitud_id;
    end if;
  end loop;


  for r in (
    select sc.servicio_contrato_id
      from servicio_contrato sc
     where mod(sc.servicio_contrato_id, 100) < p_porcentaje
  ) loop
    execute immediate v_q_upd_contrato using
      round(least(dbms_random.value(100, 1500), 999.99), 2),  
      'Contrato actualizado',
      case when dbms_random.value(0,1) < 0.3 then 6 else null end,
      r.servicio_contrato_id;
  end loop;


  for r in (
    select sp.servicio_contrato_id, sp.numero_pago
      from servicio_pago sp
     where mod(sp.servicio_contrato_id*sp.numero_pago, 100) < p_porcentaje
  ) loop
    execute immediate v_q_upd_pago using
      round(least(dbms_random.value(300, 1200), 999.99), 2),
      round(least(dbms_random.value(10, 120), 99.99), 2),    
      r.servicio_contrato_id,
      r.numero_pago;
  end loop;


  for r in (
    select pd.proveedor_deposito_id
      from proveedor_deposito pd
     where mod(pd.proveedor_deposito_id, 100) < p_porcentaje
  ) loop
    execute immediate v_q_upd_deposito using
      round(least(dbms_random.value(100, 1500), 999.99), 2), 
      trunc(dbms_random.value(p_rid_cb_min, p_rid_cb_max+1)),
      r.proveedor_deposito_id;
  end loop;

   commit;
exception
  when others then
    rollback;
    raise; 
end simula_dia_serv;
/
