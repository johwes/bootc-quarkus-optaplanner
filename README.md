# bootc-quarkus-optaplanner


- A trivial [podman-systemd unit](blob/main/usr/share/containers/sytsemd/hello.container) that runs
  an instance of the Caddy webserver (just to have a service to talk to)
- A quarkus application built from quarkus examples (Optaplanner) using another [podman-systemd unit](blob/main/usr/share/containers/sytsemd/quarkus-optaplanner.container)
- [Automatic updates enabled by default](usr/lib/systemd/system/autoupdate-host.timer)

## Demo image

`quay.io/jwesterl/bootc-quarkus-optaplanner`



