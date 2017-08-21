FROM ruby:2.3.1

MAINTAINER liangyali <liangyali@topdmc.com>

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

# 用户配置数据存储目录
EXPOSE 3000

# 系统环境变量
ENV RAILS_ENV production
ENV app /app
ENV ARYA-API_DATABASE_PASSWORD $%windows2010
ENV SECRET_KEY_BASE b203283e743d6dcaadbeeef4e0da4fbe91afb7893c623eaf3e994769727a2978912e930766636b8ce246187de17382e10ca702677caa734143714dcb141c5f14

# 启动入口
CMD rails s -b 0.0.0.0