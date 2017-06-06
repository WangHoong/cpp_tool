FROM ruby:2.3.1

MAINTAINER topdmc <liangyali@topdmc.com>

# 安装系统依赖包
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev  mysql-client

# 使用tmp目录方式对bundle install 进行cache
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

# app存放目录
RUN mkdir -p /app
WORKDIR /app
ADD . $app

VOLUME ["/app/log"]

# 用户配置数据存储目录
EXPOSE 3000

# 启动入口
CMD rails s -b 0.0.0.0
