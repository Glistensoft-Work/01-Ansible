#!/bin/bash
echo `export SENSU_BACKEND_CLUSTER_ADMIN_USERNAME=admin`
echo `SENSU_BACKEND_CLUSTER_ADMIN_PASSWORD=admin`
sensu-backend init
