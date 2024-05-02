#!/bin/bash
echo "Ready to start the web server in debug mode"
cd /code
export INVENIO_SECRET_KEY=$(head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-' | fold -w 10 | head -n 1)
if [ -d "/opt/invenio/var/instance/python/lib/python3.9/site-packages/cernopendata" ]; then
  echo "The installation directory is still there... let's overwrite it"
  pip install -e .
fi

cernopendata run -h 0.0.0.0 --reload;