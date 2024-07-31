#!/usr/bin/env bash

case "${script_type}" in
  route-up)
    ip route add default via "$route_vpn_gateway" table "$dev"
    ;;
  route-pre-down)
    ;;
  *)
    echo "Unsupported script_type: '$script_type'"
    ;;
esac
