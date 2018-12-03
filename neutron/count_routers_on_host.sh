#!/bin/bash

#set -x

# count the number of routers per host
# optional argument of ACTIVE_ONLY -- which will count routers on active L3 agents only

echo "Router count per host. Gathering data. Be patient."

if [ "$1" == "ACTIVE_ONLY" ]; then
    AGENTS=$(neutron agent-list --column id --column agent_type --column host --format csv --quote minimal --column admin_state_up --column alive | grep ':-)' | grep True | grep L3 | cut -f1 -d',')
else
    AGENTS=$(neutron agent-list --column id --column agent_type --column host --format csv --quote minimal | grep L3 | cut -f1 -d',')
fi

for agent in ${AGENTS}; do
    COUNT=$(neutron router-list-on-l3-agent -f value  ${agent} |wc -l)
    ROUTER_HOST=$(openstack network agent show ${agent} -c host -f value)
    echo "${ROUTER_HOST} (${agent}): ${COUNT}"
done
