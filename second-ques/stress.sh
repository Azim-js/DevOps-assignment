#!/bin/bash
sudo apt-get install stress
stress --cpu 2 --io 1 --vm 1 --vm-bytes 128M --timeout 60s