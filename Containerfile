FROM quay.io/centos-bootc/fedora-bootc-cloud:eln
# Copy our OS configuration - this adds automatic updates
ADD usr usr
RUN ostree container commit

