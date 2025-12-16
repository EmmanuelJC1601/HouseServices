
#!/usr/bin/env bash
# ========================================================================
# @Autor(es):       Emmanuel Jimenez / Jesus Tenorio
# @Fecha creación:  12/12/2025
# @Descripción:     Simula ciclo semanal de backups

echo "==> Martes 4"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 70);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 100);
EOF

rman target / <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag s1_l1d_mie5;
}
list backup summary;
EOF


echo "==> Miercoles 5"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 70);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 100);
EOF

rman target / <<'EOF'
run{
  backup as backupset incremental level 1 database plus archivelog tag s1_l1d_mie5;
}
list backup summary;
EOF

echo "==> Jueves 6"
sqlplus -s prov_admin/1234@proveedores <<'EOF'
  exec simula_carga_dia_prov(p_num_proveedores => 7);
EOF

sqlplus -s serv_admin/1234@servicios <<'EOF'
  exec simula_dia_serv(p_porcentaje => 10);
EOF

rman target / <<'EOF'
run{
  backup as backupset incremental level 1 cumulative database plus archivelog tag s1_l1c_jue6;
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
