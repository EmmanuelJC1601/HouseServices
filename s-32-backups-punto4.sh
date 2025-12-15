#!/usr/bin/env bash
# ========================================================================
# @Autor(es):       Emmanuel Jimenez / Jesus Tenorio
# @Fecha creación:  12/12/2025
# @Descripción:     Simula ciclo semanal de backups

echo "==> Martes semana 2"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 70);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 100);
EOF

rman target / <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag s2_l1d_mar;
}
list backup summary;
EOF

echo "==> Miercoles semana 2"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 70);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 100);
EOF

rman target / <<'EOF'
run{
  backup as backupset incremental level 1 cumulative database plus archivelog tag s2_l1c_mie;
}
list backup summary;
EOF

echo "==> Jueves semana 2"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 1);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 1);
EOF



echo "==> Viernes semana 2"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 1);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 1);
EOF



echo "==> Sabado semana 2"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 1);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 1);
EOF

rman target / <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag s2_l1d_sab;
}
list backup summary;
EOF


rman target / <<'EOF'
run{
  restore datafile 24 preview;
  restore datafile 18 preview;

  report obsolete;
  report need backup;

}
EOF
