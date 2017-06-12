# cpp_tool
运营工具线下平台


bundle exec puma -C config/puma_pro.rb -d

bundle exec pumactl --state tmp/sockets/puma.state stop

bundle exec pumactl --state tmp/sockets/puma.state restart

##开启sentry线上日志跟踪

```bash

SENTRY_DSN=https://35d28096b67a4dbfa0ca4c4aec0e4232:5c80e9d259a343e396ef307ccfad9ef9@sentry.io/178551 rails s

```