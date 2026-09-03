#!/usr/bin/bash
docker build --tag gcat-blockcodes-demo .
# Run image in container: 
docker run -p 8042:8042 gcat-blockcodes-demo