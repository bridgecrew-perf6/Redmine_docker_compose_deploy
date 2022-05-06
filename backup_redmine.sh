#!/bin/bash

work_dir=/docker/redmine_test
back_name=redmine-test
cur_date=$(date '+%Y-%m-%d')
vol_path=./volumes
exclude=./volumes/database
mysql_db=redmine
mysql_user=$MYSQL_USER_NAME
mysql_pass=$MYSQL_PWD
cont_name=redmine_test_mysql_1

cd $work_dir

docker exec $cont_name /usr/bin/mysqldump -u $mysql_user --password=$mysql_pass $mysql_db > "$back_name-$cur_date.sql"

tar -czvf "$back_name-$cur_date.tar.gz" --exclude=$exclude $vol_path "$back_name-$cur_date.sql"
rm "$back_name-$cur_date.sql"
find . -maxdepth 1 -type f -name "redmine*.tar.gz" -mtime +30 -delete
echo Done!
