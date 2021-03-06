#!/bin/bash

# convenience script to destroy any running containers, rebuild (with cache) and output notifications from script watching/syncing source files
sudo docker rm -f devmysql
sudo docker rm -f plugindevwp
sudo docker build -t leonstafford/wordpress-static-html-plugin:latest . 
sudo docker run --name devmysql -e MYSQL_ROOT_PASSWORD=banana -d mariadb
sudo docker run --name plugindevwp --link devmysql:mysql -p 8088:80 -d -v $(pwd):/app leonstafford/wordpress-static-html-plugin
sudo docker exec plugindevwp sh /post_launch.sh
sudo docker exec -it plugindevwp sh /watch_source_files.sh
