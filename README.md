# cpp_tool
运营工具线下平台


bundle exec puma -C config/puma_pro.rb -d

bundle exec pumactl --state tmp/sockets/puma.state stop

bundle exec pumactl --state tmp/sockets/puma.state restart
