#!/usr/bin/env puma

#rails的运行环境
environment 'development'
threads 2, 3
workers 1
port 40000
#项目名
app_name         = "cpp-tool"
#项目路径
application_path = "/srv/www/cpp-tool"
#这里一定要配置为项目路径下地current
directory "#{application_path}"

#下面都是 puma的配置项
pidfile "#{application_path}/tmp/pids/puma.pid"
state_path "#{application_path}/tmp/sockets/puma.state"
stdout_redirect "#{application_path}/log/puma.stdout.log", "#{application_path}/log/puma.stderr.log"
bind "unix://#{application_path}/tmp/sockets/puma.sock"
activate_control_app "unix://#{application_path}/tmp/sockets/pumactl.sock"

#后台运行
# daemonize true
on_restart do
  puts 'On restart...'
end
# preload_app!
