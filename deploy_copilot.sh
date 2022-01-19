#!/bin/bash
echo "--- Deploy OpenTaxii Service ---"


copilot init --app taxii \
  --name taxii-service \
  --type 'Load Balanced Web Service' \
  --dockerfile './Dockerfile' \
  --port 80 \
  --deploy