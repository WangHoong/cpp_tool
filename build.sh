#!/usr/bin/env bash

docker build -t registry.topdmc.com/cpp/api:1.0.0 .
docker push registry.topdmc.com/cpp/api:1.0.0