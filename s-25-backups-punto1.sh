#!/usr/bin/env bash
# ========================================================================
# @Autor(es):       Emmanuel Jimenez / Jesus Tenorio
# @Fecha creación:  12/12/2025
# @Descripción:     Simula ciclo semanal de backups

echo "==> Full inicial semana 1"
rman target / <<'EOF'
run{
  backup database plus archivelog tag s1_house_full_inicial;
}
list backup summary;
EOF

echo "==> Domingo 2"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 1);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 1);
EOF

rman target / <<'EOF'
run{
  backup as backupset incremental level 0 database plus archivelog tag s1_l0_dom2;
}
list backup summary;
EOF

echo "==> Lunes 3"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 70);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 60);
EOF

rman target / <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag s1_l1d_lun3;
}
list backup summary;
EOF

#Ejecutar Punto de control

rman target / <<'EOF'
run{
  restore datafile 24 preview;
  restore datafile 18 preview;

  report obsolete;
  report need backup;
}
EOF
