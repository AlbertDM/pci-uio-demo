#!/bin/bash
sudo systemctl start docker
docker run -it --privileged pci-uio-demo


