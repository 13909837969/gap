#!/bin/sh
# deploy-supervise.sh 
# supervise.war 项目部署及备份

if [ -d "/opt/storage" ]; then
echo "文件夹已经存在"
else
mkdir /opt/storage
fi

if [ -d "/opt/storage/appbak" ]; then
echo "文件夹已经存在"
else
mkdir /opt/storage/appbak
fi

if [ -e "/opt/supervise.war" ]; then
mv /opt/server/apache-tomcat-8.5.24/webapps/supervise.war /opt/storage/appbak/
rm -rf /opt/server/apache-tomcat-8.5.24/webapps/supervise
mv /opt/supervise.war /opt/server/apache-tomcat-8.5.24/webapps/
echo $HOSTNAME " supervise.war 部署完成"
else
echo $HOSTNAME " supervise.war 文件不存在，部署失败"
fi

