#!/bin/bash

  HILN()
    {
      echo -e "\n\e[33m>>> ${1}\e[0m"
    }

  while true
  do
    HILN "`date`"
    df -k /docker
    HILN ""
    du -sh /docker/docker-data/devicemapper/devicemapper/data
    du -sh /docker/docker-data/volumes/elk-stack_elasticsearch/_data/nodes/0/indices
    echo -e "\n"
    sleep 3600
  done
