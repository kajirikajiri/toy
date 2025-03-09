#!/bin/bash

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
pid=$(lsof -ti :4673)
[ -n "$pid" ] && { kill "$pid"; sleep 1; }
nohup python3 app.py >/dev/null 2>&1 &
