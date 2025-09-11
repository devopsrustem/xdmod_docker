#!/bin/bash

# Скрипт для добавления GPU заданий в базу SLURM

echo "Добавление GPU заданий в SLURM базу данных..."

# Подключение к базе SLURM
mysql -h localhost -u slurm -pslurm_password slurm_acct_db << 'EOF'

-- Добавляем GPU задания
INSERT INTO tcluster01_job_table (
    jobid, associd, wckey, wckeyid, uid, gid, `user`, `group`, account, 
    partition, blockid, cluster, `time_submit`, `time_start`, `time_end`,
    timelimit, nodelist, alloc_cpus, alloc_nodes, `state`, exitcode,
    priority, req_cpus, req_mem, req_nodes, kill_requid, qos, qosid,
    tres_alloc, tres_req
) VALUES 
-- GPU задание 1: 4 GPU
(100, 1, '', 1, 1000, 1000, 'user1', 'users', 'default', 'gpu', '', 'tcluster01',
 UNIX_TIMESTAMP('2024-09-01 10:00:00'), UNIX_TIMESTAMP('2024-09-01 10:05:00'), UNIX_TIMESTAMP('2024-09-01 12:05:00'),
 7200, 'gpu01', 8, 1, 3, 0, 100, 8, '32G', 1, 0, 'normal', 1,
 '1=8,2=32768,4=4,1001=1', '1=8,2=32768,4=4,1001=1'),

-- GPU задание 2: 2 GPU
(101, 1, '', 1, 1001, 1000, 'user2', 'users', 'default', 'gpu', '', 'tcluster01',
 UNIX_TIMESTAMP('2024-09-01 14:00:00'), UNIX_TIMESTAMP('2024-09-01 14:05:00'), UNIX_TIMESTAMP('2024-09-01 16:05:00'),
 7200, 'gpu02', 4, 1, 3, 0, 100, 4, '16G', 1, 0, 'normal', 1,
 '1=4,2=16384,4=2,1001=1', '1=4,2=16384,4=2,1001=1'),

-- GPU задание 3: 8 GPU (2 ноды)
(102, 1, '', 1, 1002, 1000, 'user3', 'users', 'default', 'gpu', '', 'tcluster01',
 UNIX_TIMESTAMP('2024-09-02 09:00:00'), UNIX_TIMESTAMP('2024-09-02 09:05:00'), UNIX_TIMESTAMP('2024-09-02 13:05:00'),
 14400, 'gpu[01-02]', 16, 2, 3, 0, 100, 16, '64G', 2, 0, 'normal', 1,
 '1=16,2=65536,4=8,1001=2', '1=16,2=65536,4=8,1001=2');

EOF

echo "GPU задания добавлены в базу SLURM"