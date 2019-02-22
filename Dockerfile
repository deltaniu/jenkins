###########
# build:
#    docker build --force-rm -t  isam2016/node .
# Usage:
#  
#   docker run -it -v <project-resource-directory>:/workspace \
#                  --name <container-name> [image-name]
#
#   docker run -it --name test-nvm isam2016/node 
#   docker run -it --name test-nvm isam2016/node bash(注意bash)
#  制作前端镜像 包含 nvm node expect
FROM  centos
MAINTAINER isam2016
RUN yum -y update  
RUN yum -y install tar git
RUN yum -y install tcl-devel
RUN yum -y install expect


RUN mkdir -p  /usr/local/nvm
# 配置环境变量
ENV NVM_DIR /usr/local/nvm  
ENV NODE_VERSION 10.11.0  
ENV WORK_DIR /workspace


#ssh 
RUN ssh-keygen  -t rsa -P '' -f /root/.ssh/id_rsa

# scp   ~/.ssh/id_rsa.pub root@47.104.95.186:/root/.ssh/authorized_keys
# ssh  -o stricthostkeychecking=no root@47.104.95.186
# scp -r  -o  StrictHostKeyChecking=no ./id_rsa root@47.104.95.186:/home

# 下载和配置Node.js环境
# 这些命令一定要写在一起, 否则`nvm`命令会找不到
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \ 
    && source $NVM_DIR/nvm.sh \
    && nvm install v$NODE_VERSION \
    && nvm use v$NODE_VERSION \
    && nvm alias default v$NODE_VERSION    
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules  
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


# 设置工作目录
WORKDIR $WORK_DIR
# 公开镜像的80端口
EXPOSE 80
