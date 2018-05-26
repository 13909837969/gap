#!/bin/sh
# 执行远程 supervise.war 部署（部署前自动备份到 /opt/storage/appbak/中）

# 远程执行命令
ssh root@10.12.15.129 /opt/server/deploy-supervise.sh
ssh root@10.12.15.130 /opt/server/deploy-supervise.sh
ssh root@10.12.15.131 /opt/server/deploy-supervise.sh
ssh root@10.12.15.132 /opt/server/deploy-supervise.sh
ssh root@10.12.15.133 /opt/server/deploy-supervise.sh
ssh root@10.12.15.134 /opt/server/deploy-supervise.sh
ssh root@10.12.15.135 /opt/server/deploy-supervise.sh
ssh root@10.12.15.136 /opt/server/deploy-supervise.sh
ssh root@10.12.15.137 /opt/server/deploy-supervise.sh

#10.12.15.138(ltrhao13)为停留时间及报警等调度服务，
#需要单独部署，部署的war 包为 nmsf-dd 的命令
##ssh root@10.12.15.138 /opt/server/deploy-supervise.sh
echo "supervise.war 远程部署完成！"

