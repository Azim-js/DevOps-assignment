#!/bin/bash
wget https://github.com/prometheus/prometheus/releases/download/v2.26.0/prometheus-2.26.0.linux-amd64.tar.gz
tar xvf prometheus-2.26.0.linux-amd64.tar.gz
cd prometheus-2.26.0.linux-amd64
./prometheus --config.file=prometheus.yml &
