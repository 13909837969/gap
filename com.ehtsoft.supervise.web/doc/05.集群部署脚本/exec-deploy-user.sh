#!/bin/sh
# 执行远程 user.war 部署（部署前自动备份到 /opt/storage/appbak/中）

# 远程执行命令
ssh root@10.12.15.129 /opt/server/deploy-user.sh
ssh root@10.12.15.130 /opt/server/deploy-user.sh
ssh root@10.12.15.131 /opt/server/deploy-user.sh
ssh root@10.12.15.132 /opt/server/deploy-user.sh
ssh root@10.12.15.133 /opt/server/deploy-user.sh
ssh root@10.12.15.134 /opt/server/deploy-user.sh
ssh root@10.12.15.135 /opt/server/deploy-user.sh
ssh root@10.12.15.136 /opt/server/deploy-user.sh
ssh root@10.12.15.137 /opt/server/deploy-user.sh
ssh root@10.12.15.138 /opt/server/deploy-user.sh
echo "user.war 远程部署完成！"

