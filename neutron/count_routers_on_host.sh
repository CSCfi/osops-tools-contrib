#!/bin/bash

#set -x

# count the number of routers per host
# optional argument of ACTIVE_ONLY -- which will count routers on active L3 agents only


AGENTS=$(openstack network agent list --agent-type l3 -c ID -f value)
for agent in ${AGENTS}; do
  ROUTER_HOST=$(openstack network agent show ${agent} -c host -f value)
  COUNT=$(neutron router-list-on-l3-agent -f value  ${agent} |wc -l)
  echo  "${ROUTER_HOST} (${agent}): ${COUNT}"
done
