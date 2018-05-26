#!/bin/sh
# deploy-user.sh 
# user.war 项目部署及备份

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
if [ -e "/opt/user.war" ]; then
mv /opt/server/apache-tomcat-8.5.24/webapps/user.war /opt/storage/appbak/
rm -rf /opt/server/apache-tomcat-8.5.24/webapps/user
mv /opt/user.war /opt/server/apache-tomcat-8.5.24/webapps/
echo $HOSTNAME " user.war 部署完成"
else
echo $HOSTNAME " user.war 文件不不存在，部署失败"
fi
