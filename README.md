# bootc-quarkus-optaplanner


- A trivial [podman-systemd unit](usr/share/containers/systemd/hello.container) that runs
  an instance of the Caddy webserver (just to have a service to talk to)
- A quarkus application built from quarkus examples (Optaplanner) using another [podman-systemd unit](usr/share/containers/systemd/quarkus-optaplanner.container)
- [Automatic updates enabled by default](usr/lib/systemd/system/autoupdate-host.timer)

## Demo image

`quay.io/jwesterl/bootc-quarkus-optaplanner:latest`
`quay.io/jwesterl/bootc-quarkus-optaplanner:no-cloud-init`

Built using,
```
podman build -f Containerfile.no-cloud-init -t quay.io/jwesterl/bootc-quarkus-optaplanner:no-cloud-init .
podman build -f Containerfile -t quay.io/jwesterl/bootc-quarkus-optaplanner:latest .
```

## Use Image

To boot this I'll share 2 ways I've been using.
I'm running Fedora 39 Silverblue on x86

First way is to use an netinstall iso and use anaconda and a kickstart file.
Make sure to update the command with the correct path to your kickstart file / ISO.
```
virt-install --connect qemu:///system --name vm-name --memory 4096 --vcpus 2 --os-variant fedora-unknown --cdrom <path-to>/Fedora-Everything-netinst-x86_64-39-1.5.iso --video virtio --graphics spice --noautoconsole --disk size=10 --initrd-inject=<path-to>example.ks --extra-args "inst.ks=file:/example.ks" --location <path-to>/Fedora-Everything-netinst-x86_64-39-1.5.iso

```

In this git repo the example kickstart file installs the bootc-quarkus-optaplanner:no-cloud-init image
and creates a user called jwesterl with password redhat and a public ssh key.

Second way, is by converting the container image to a qcow2 image and booting it using libvirt/kvm

Converting, using osbuild, https://github.com/osbuild/bootc-image-builder, create a config.json according to instructions then run,
```
sudo podman run \
    --rm \
    -it \
    --privileged \
    --pull=newer \
    --security-opt label=type:unconfined_t \
    -v $(pwd)/config.json:/config.json \
    -v $(pwd)/output:/output \
    quay.io/centos-bootc/bootc-image-builder:latest \
    --type qcow2 \
    --config /config.json \
    quay.io/jwesterl/bootc-quarkus-optaplanner:no-cloud-init
```


and then let's boot our image and inject some cloud-init data
```
virt-install --connect qemu:///system --name vm-name --memory 4096 --vcpus 2 --os-variant fedora-unknown --video virtio --graphics spice --noautoconsole --import --disk <path-to>/disk.qcow2
```
