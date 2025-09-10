docker compose build
docker compose up -d

docker exec -it xdmod-container bash

acl-config


Site Address: [https://localhost/] https://10.36.80.9:8443/


DB Hostname or IP: [localhost] 
DB Port: [3306] 
DB Username: [xdmod] 
DB Password: 

secure_xdmod_password_123
secure_root_password_123

5пункт
acl-config
secure_root_password_123

docker exec xdmod mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('secure_root_password_123'); FLUSH PRIVILEGES;"

tcluster01


docker compose down && docker compose build --no-cache && docker compose up -d


docker compose down && docker compose build --no-cache && docker compose up -d
docker exec -it xdmod-container bash
xdmod-setup
1
Site Address: [https://localhost/] https://10.36.80.9:8443/
Email Address: admin@local
Chromium Path: энтер
Center Logo Path: энтер
Enable Dashboard Tab (on, off)? [off] on
Overwrite config file '/usr/share/xdmod/etc/portal_settings.ini' (yes, no)? [yes] 
2
DB Hostname or IP: [localhost] 
DB Port: [3306] 
DB Username: [xdmod] 
DB Password: secure_xdmod_password_123

DB Admin Username: [root] 
DB Admin Password: secure_root_password_123

Database `mod_shredder` already exists.
Drop and recreate database (yes, no)? [no] yes

Database `mod_hpcdb` already exists.
Drop and recreate database (yes, no)? [no] yes

Database `moddb` already exists.
Drop and recreate database (yes, no)? [no] yes

Database `modw` already exists.
Drop and recreate database (yes, no)? [no] yes

4
имя вашего кластера слерм
Resource Name: tcluster01 
Formal Name: testcluster01
Resource Type (hpc, htc, dic, grid, cloud, vis, vm, tape, disk, stgrid, us, gateway): [hpc] 
Resource Allocation Type (cpu, gpu, cpunode, gpunode): [cpu] gpu
Resource Start Date, in YYYY-mm-dd format [2025-09-03] 

The number of nodes and processors are used to determine resource
utilization.

If this is a storage resource you may enter 0 for the number of nodes
and processors.

How many CPU nodes does this resource have? 2
How many total CPU processors (cpu cores) does this resource have? 512
How many GPU nodes does this resource have? 2
How many total GPUs does this resource have? 16

5
========================================================================
Create Admin User
========================================================================

Username: admin
Password: 
(confirm) Password: 
First name: Admin
Last name: User
Email address: admin@localhost

Admin user created.

Press ENTER to continue. 

xdmod-ingestor --bootstrap
acl-config



xdmod-slurm-helper -r tcluster01

xdmod-ingestor
