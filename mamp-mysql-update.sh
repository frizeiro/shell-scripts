#!/bin/sh

version="5.6" # 5.6, 5.7

echo "Updating to version $version"

if [ "$version" = "5.6" ]
then
    wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.26-osx10.9-x86_64.tar.gz
elif [ "$version" = "5.7" ]
    wget http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.15-osx10.11-x86_64.tar.gz
then
    echo "Only versions 5.6 and 5.7 are supported"
    exit;
fi

tar xfvz mysql-$version*

echo "Stopping MAMP"
sudo /Applications/MAMP/bin/stop.sh
sudo killall httpd mysqld

echo "Creating MAMP backup"
sudo rsync -arv --progress /Applications/MAMP ~/Desktop/MAMP-Backup

echo "Coping bin"
sudo rsync -arv --progress mysql-$version.*/bin/* /Applications/MAMP/Library/bin/ --exclude=mysqld_multi --exclude=mysqld_safe 

echo "Coping share"
sudo rsync -arv --progress mysql-$version.*/share/* /Applications/MAMP/Library/share/

echo "Fixing permissions"
sudo chmod -R o+rw  /Applications/MAMP/db/mysql/
sudo chmod -R o+rw  /Applications/MAMP/tmp/mysql/
sudo chmod -R o+rw  "/Library/Application Support/appsolute/MAMP PRO/db/mysql/"

echo "Starting MAMP"
sudo /Applications/MAMP/bin/start.sh

echo "Wating 3 seconds"
sleep 3

echo "Making symlink"
sudo ln -s /Applications/MAMP/tmp/mysql/mysql.sock /tmp/mysql.sock

echo "Migrating to new version"
/Applications/MAMP/Library/bin/mysql_upgrade -u root --password=root -h 127.0.0.1 --force