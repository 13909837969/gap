#!/bin/sh

#!/bin/sh
# 执行远程 user.war 部署（部署前自动备份到 /opt/storage/appbak/中）

# 远程执行命令
ssh root@10.12.15.129 /opt/server/kill-tomcat.sh
ssh root@10.12.15.129 /opt/server/start-tomcat.sh
echo "========= 10.12.15.129 (ltrhao4) 启动完成"

ssh root@10.12.15.130 /opt/server/kill-tomcat.sh
ssh root@10.12.15.130 /opt/server/start-tomcat.sh
echo "========= 10.12.15.130 (ltrhao5) 启动完成"

ssh root@10.12.15.131 /opt/server/kill-tomcat.sh
ssh root@10.12.15.131 /opt/server/start-tomcat.sh
echo "========= 10.12.15.131 (ltrhao6) 启动完成"

ssh root@10.12.15.132 /opt/server/kill-tomcat.sh
ssh root@10.12.15.132 /opt/server/start-tomcat.sh
echo "========= 10.12.15.132 (ltrhao7) 启动完成"

ssh root@10.12.15.133 /opt/server/kill-tomcat.sh
ssh root@10.12.15.133 /opt/server/start-tomcat.sh
echo "========= 10.12.15.133 (ltrhao8) 启动完成"

ssh root@10.12.15.134 /opt/server/kill-tomcat.sh
ssh root@10.12.15.134 /opt/server/start-tomcat.sh
echo "========= 10.12.15.134 (ltrhao9) 启动完成"

ssh root@10.12.15.135 /opt/server/kill-tomcat.sh
ssh root@10.12.15.135 /opt/server/start-tomcat.sh
echo "========= 10.12.15.135 (ltrhao10) 启动完成"

ssh root@10.12.15.136 /opt/server/kill-tomcat.sh
ssh root@10.12.15.136 /opt/server/start-tomcat.sh
echo "========= 10.12.15.136 (ltrhao11) 启动完成"

ssh root@10.12.15.137 /opt/server/kill-tomcat.sh
ssh root@10.12.15.137 /opt/server/start-tomcat.sh
echo "========= 10.12.15.137 (ltrhao12) 启动完成"

ssh root@10.12.15.138 /opt/server/kill-tomcat.sh
ssh root@10.12.15.138 /opt/server/start-tomcat.sh
echo "========= 10.12.15.138 (ltrhao13) 启动完成"


