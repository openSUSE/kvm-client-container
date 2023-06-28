# What's inside

This project provides containerized client tooling meant for use with the [containerized KVM server](https://github.com/openSUSE/kvm-server-container) but will also work with a bare-metal installation of the KVM virtualization stack

* `Dockerfile` with the definition of the kvm client container
currently based on the openSUSE Tumbleweed BCI image.
* `kvm-client-wrapper` which will function as a wrapper around all installed client tools

# Current deployments

For each of the commands below, replace `<registry_path>` with one of the following:

* `registry.opensuse.org/suse/alp/workloads/tumbleweed_containerfiles/suse/alp/workloads/kvm-client` - The latest stable release deployed to the SUSE ALP distribution (Default)
* `registry.opensuse.org/virtualization/containerfile/suse/alp/workloads/kvm-client` - The latest development branch of the kvm client container
* `<custom-registry-path>` - Path to your OBS home project registry, local registy, or external registry

# Installation
```
# podman container runlabel install <registry_path>:latest
```
This will pull the container image and will install wrappers around the included executables. If packages are currrently installed that provide a given executable, these will not be touched.

# Wrappers for client tools
Once the wrappers for client tools are installed on the host, they will function exactly like bare-metal packages. All wrappers link to an executable named `kvm-client-wrapper` which will handle passing the program and its arguments into the container.

## List current wrappers
```
# find -L /usr -xtype l -samefile $(command -v kvm-client-wrapper)
```
