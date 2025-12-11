--@Autor(es):       Emmanuel Jimenez / Jesus Tenorio
--@Fecha creación:  11/12/2025
--@Descripción:     Script para validar consultas de la configuracion de cdb y
--                  pdbs

Prompt Conectando como sys en cdb$root
connect sys/system0 as sysdba
alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';

Prompt A
select host_name, instance_name, version, status, database_status, 
  active_state, con_id 
from v$instance;

Prompt B
select name, created, log_mode, open_mode, platform_name, current_scn, 
  flashback_on, cdb 
from v$database;

Prompt C
select con_id, name, open_mode, round(total_size/1024/1024/1024, 2) 
  as total_size_gb
from v$pdbs;

Prompt D
select tablespace_name, status, contents, extent_management, 
  segment_space_management, retention, bigfile, encrypted, con_id
from cdb_tablespaces
order by con_id, tablespace_name;

Prompt E
select con_id, tablespace_name, file_id, file_name, 
  round(bytes/1024/1024, 2) as size_mb, autoextensible, online_status
from cdb_data_files
order by con_id, file_id;

Prompt F
select group#, sequence#, members, archived, status, con_id
from v$log
order by group#;

Prompt G
select group#, status, type, member, is_recovery_dest_file, con_id
from v$logfile
order by group#;

Prompt H
select con_id, status, name, is_recovery_dest_file
from v$controlfile;

Prompt I
select recid, name, dest_id, sequence#, completion_time, 
  is_recovery_dest_file, backup_count, con_id
from v$archived_log
order by sequence#, dest_id;

Prompt J
select file_type, percent_space_used, percent_space_reclaimable, 
  number_of_files, con_id
from v$recovery_area_usage;

Prompt K
select p.recid,
  decode(s.backup_type,
    'D','D-FULL BACKUP',
    'L','L-WITH ARC LOGS',
    'I','I-INCREMENTAL',
    s.backup_type) as backup_type,
  p.tag, s.controlfile_included, s.pieces as total_pieces,
  p.piece#, p.copy#, p.device_type,
  to_char(p.completion_time,'yyyy-mm-dd hh24:mi:ss') as completion_time,
  round(p.bytes/1024/1024,2) as mbs, p.handle
from v$backup_piece p, v$backup_set s
where s.set_stamp = p.set_stamp and s.set_count = p.set_count
order by completion_time desc;

Prompt L
select decode(s.backup_type,
    'D','D-FULL BACKUP',
    'L','L-WITH ARC LOGS',
    'I','I-INCREMENTAL',
    s.backup_type) as backup_type,
  s.incremental_level,
  count(*) as num_backups,
  round(sum(p.bytes)/1024/1024/1024, 2) as total_gb
from v$backup_set s
join v$backup_piece p on s.set_stamp = p.set_stamp and s.set_count = p.set_count
group by s.backup_type, s.incremental_level
order by 1, 2;

Prompt M
select tag, count(*) as "count(*)", 
  round(sum(output_bytes)/1024/1024, 0) as total_mb
from v$backup_copy_details
group by tag
order by tag;

Prompt N
select username, account_status, default_tablespace, temporary_tablespace,
  local_temp_tablespace, created, last_login, con_id
from cdb_users
where oracle_maintained = 'N'
order by username;

Prompt O
select q.username, q.tablespace_name, 
  round(q.bytes/1024/1024, 2) as charged_mb, 
  q.max_bytes, q.con_id
from cdb_ts_quotas q, cdb_users u
where q.username = u.username 
and q.con_id = u.con_id
and u.oracle_maintained = 'N'
order by q.username, q.tablespace_name;

Prompt P
select s.tablespace_name, s.owner, 
  count(*) as total_segmentos, 
  sum(s.extents) as total_extensiones,
  round(sum(s.bytes)/1024/1024, 2) as total_mb, 
  s.con_id
from cdb_segments s, cdb_users u
where s.owner = u.username
and s.con_id = u.con_id
and u.oracle_maintained = 'N'
group by s.tablespace_name, s.owner, s.con_id
order by s.tablespace_name;

Prompt Q
select round(sum(s.bytes)/1024/1024, 2) as total_mb
from cdb_segments s, cdb_users u
where s.owner = u.username
and s.con_id = u.con_id
and u.oracle_maintained = 'N';

Prompt listo
exit