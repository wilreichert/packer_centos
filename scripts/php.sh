echo $1

yum install -y httpd mariadb-server mariadb php php-mysql
systemctl start httpd.service mariadb.service
systemctl enable httpd.service mariadb.service
echo '<?php phpinfo(); ?>' > /var/www/html/info.php
