# Usage
# 1. Docker build
# docker build -t pci-uio-demo .
# 2. Docker run
# docker run -it --privileged pci-uio-demo
# docker run -it pcie-kernel-driver
# 3. Exit the container 
# exit
# Docker stop
# docker stop pcie-kernel-driver
# 4. Clean up 
# docker ps -a 
# docker rm <container_id>
# https://docs.fedoraproject.org/en-US/iot/build-docker/

# Use a base image with your preferred Linux distribution
# Example: Ubuntu 20.04
# FROM ubuntu:20.04
FROM fedora:latest

# Install necessary dependencies and tools for kernel module development
# RUN dnf -y update && \
#     dnf -y install git kernel-devel kernel-headers gcc make && \
#     dnf clean all
RUN dnf -y update && \ 
    dnf -y install kernel-devel gcc make && \ 
    dnf clean all

# Include kernel headers to the INCLUDE environment variable
ENV INCLUDE=/usr/src/kernels/:/usr/include

# Copy your project files into the container
COPY . /pci-uio-demo

# Set the working directory
WORKDIR /pci-uio-demo

# Build the kernel module
RUN make
# Set the --stop-on-failure flag for the RUN instruction
# RUN --stop-on-failure=on-failure make
# Build the kernel module with a conditional script
# RUN chmod a+x make_kernel_module.sh
# RUN ./make_kernel_module.sh

# Expose any necessary ports or configure environment variables, if needed
# EXPOSE 80

# Define the command to run when the container starts (e.g., run your tests)
CMD ["/bin/bash"]

