FROM quay.io/centos-boot/fedora-boot-cloud:eln
# Copy our OS configuration - this adds automatic updates
ADD usr usr
RUN ostree container commit

