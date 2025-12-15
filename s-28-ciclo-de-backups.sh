
#!/usr/bin/env bash
# ========================================================================
# @Autor(es):       Emmanuel Jimenez / Jesus Tenorio
# @Fecha creación:  10/12/2025
# @Descripción:     Simula el ciclo semanal de backups 

# --------------- No probado aún ---------------

RMAN=${RMAN:-rman target /}

echo "==> Full inicial"
"$RMAN" <<'EOF'
run{
  backup database plus archivelog tag c0_house_service_full_bs_01;
}
list backup summary;
EOF

echo "==> Domingo"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov;
EOF

"$RMAN" <<'EOF'
run{
  backup as backupset incremental level 0 database plus archivelog tag c1_house_service_n0_Sun;
}
list backup summary;
EOF

echo "==> Lunes"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov;
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_carga_dia_serv;
EOF

"$RMAN" <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag c1_house_service_n1d_Mon;
}
list backup summary;
EOF

echo "==> Martes"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov;
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_carga_dia_serv;
EOF

"$RMAN" <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag c1_house_service_n1d_Tue;
}
list backup summary;
EOF

echo "==> Miercoles"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov;
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_carga_dia_serv;
EOF

"$RMAN" <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag c1_house_service_n1d_Wed;
}
list backup summary;
EOF

echo "==> Jueves"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov;
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_carga_dia_serv;
EOF

"$RMAN" <<'EOF'
run{
  backup as backupset incremental level 1 cumulative database plus archivelog tag c1_house_service_n1c_Thu;
}
list backup summary;
EOF

echo "==> Viernes"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov;
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_carga_dia_serv;
EOF

"$RMAN" <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag c1_house_service_n1d_Fri;
}
list backup summary;
EOF

echo "==> Sabado"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov;
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_carga_dia_serv;
EOF

"$RMAN" <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag c1_house_service_n1d_Sat;
}
list backup summary;
EOF

echo "==> Ciclo semanal completado."
