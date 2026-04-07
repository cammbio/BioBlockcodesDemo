#!/usr/bin/bash
docker build --tag bioblockcodes .
# Run image in container: 
docker run -p 8042:8042 bioblockcodes