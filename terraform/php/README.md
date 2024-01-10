# Php server
This is a demonstration of `PHP` server using `EC2` and `RDS`
## Prerequisites
## Start
### 1. Clone repo
```
git clone https://github.com/haquocdat543/terra.git ~/terra
cd ~/terra/php
```
### 2. Initialize
```
terraform init
terraform apply --auto-approve
```
Enter ter yoy `ssh key`.

### 3. Config PHP server
SSH to `ec2-instance`. 
```
vi /var/www/inc
```
```
<?php

define('DB_SERVER', 'db_instance_endpoint');
define('DB_USERNAME', 'tutorial_user');
define('DB_PASSWORD', 'master password');
define('DB_DATABASE', 'sample');
?>
```
### 4. Connect sql server and add database
Replace `$endpoint`, `$port` and `$username` follow you custom.
* endpoint: Know after apply terraform
* port: In `main.tf` file
* username: In `main.tf` file
```
mysql -h $endpoint -P $port -u $username -p
```
Then enter your password to access `SQL server`
* password: In `main.tf` file
```
source ./db.sql
```
### 5. Access php page on browser
Copy `php-server-public-ip/SamplePage.php`
### 6. Destroy
```
terraform destroy --auto-approve
```
Press `Enter` key to destroy.
