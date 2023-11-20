# bootc-quarkus-optaplanner


- A trivial [podman-systemd unit](usr/share/containers/systemd/hello.container) that runs
  an instance of the Caddy webserver (just to have a service to talk to)
- A quarkus application built from quarkus examples (Optaplanner) using another [podman-systemd unit](usr/share/containers/systemd/quarkus-optaplanner.container)
- [Automatic updates enabled by default](usr/lib/systemd/system/autoupdate-host.timer)

## Demo image

`quay.io/jwesterl/bootc-quarkus-optaplanner`

Built using,
podman build -t quay.io/jwesterl/bootc-quarkus-optaplanner .

## Use Image

To boot this I'll share 2 ways I've been using.
I'm running Fedora 39 Silverblue on x86

First way, is by converting the container image and booting it using libvirt/kvm

Converting, running as root,
`podman run --rm -ti --security-opt label=disable --device /dev/kvm -v $(pwd):/srv -w /srv ghcr.io/cgwalters/osbuildbootc:latest build-qcow2 -I quay.io/jwesterl/bootc-quarkus-optaplanner example.qcow2`

and then let's boot our image and inject some cloud-init data
`virt-install --connect qemu:///system --name vm-name --memory 4096 --vcpus 2 --os-variant fedora-unknown --video virtio --graphics spice --noautoconsole --disk <path-to>/example.qcow2 --cloud-init user-data=<path-to>/cloud-config-user`
