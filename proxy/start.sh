#!/bin/sh

envsub() {
  eval "cat <<EOF
$(cat "$1")
EOF
" 2>/dev/null
}

# shellcheck disable=SC2005
echo "$(envsub traefik.yaml)" >traefik.yaml

until [ -f /etc/certs/backend/ca.pem ]; do
  echo "Waiting for backend certificates..."
  sleep 1
done

cat /etc/certs/backend/ca.pem >>/etc/ssl/certs/ca-certificates.crt

until [ -f /etc/certs/frontend/cert.pem ] && [ -f /etc/certs/frontend/key.pem ]; do
  echo "Waiting for frontend certificates..."
  sleep 1
done

/entrypoint.sh traefik --configFile=traefik.yaml
