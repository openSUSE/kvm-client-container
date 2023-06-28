# SPDX-License-Identifier: MIT
# Define the tags for OBS and build script builds:
#!BuildTag: %%TAGPREFIX%%/kvm-client:latest
#!BuildTag: %%TAGPREFIX%%/kvm-client:%%PKG_VERSION%%
#!BuildTag: %%TAGPREFIX%%/kvm-client:%%PKG_VERSION%%-%RELEASE%

FROM opensuse/tumbleweed

LABEL INSTALL="/usr/bin/podman run --env IMAGE=IMAGE --rm --privileged -v /:/host IMAGE /bin/bash /container/label-install"
LABEL UNINSTALL="/usr/bin/podman run --env IMAGE=IMAGE --rm --privileged -v /:/host IMAGE /bin/bash /container/label-uninstall"

# Mandatory labels for the build service:
#   https://en.opensuse.org/Building_derived_containers
# labelprefix=%%LABELPREFIX%%
LABEL org.opencontainers.image.title="KVM client tooling container"
LABEL org.opencontainers.image.description="Client tooling container for the KVM virtualization stack"
LABEL org.opencontainers.image.created="%BUILDTIME%"
LABEL org.opencontainers.image.version="%%PKG_VERSION%%.%RELEASE%"
LABEL org.opencontainers.image.url="https://build.opensuse.org/package/show/SUSE:ALP:Workloads/kvm-client-container"
LABEL org.openbuildservice.disturl="%DISTURL%"
LABEL org.opensuse.reference="%%REGISTRY%%/%%TAGPREFIX%%/kvm-client:%%PKG_VERSION%%.%RELEASE%"
LABEL org.openbuildservice.disturl="%DISTURL%"
LABEL com.suse.supportlevel="techpreview"
LABEL com.suse.eula="beta"
LABEL com.suse.image-type="application"
LABEL com.suse.release-stage="prototype"
# endlabelprefix

# Don't forget to edit label-install/uninstall scripts when modifying installed packages
RUN zypper install --no-recommends -y \
              libvirt-client \
              libvirt-client-qemu \
              openssh-clients \
              python3-lxml \
              python3-pvirsh \
              python3-virt-scenario \
              qemu-tools \
              vim-small \
              virt-install \
              virt-top \
              xorriso
RUN zypper clean --all

COPY label-install label-uninstall kvm-client-wrapper /container/
RUN chmod +x /container/{label-install,label-uninstall,kvm-client-wrapper}

CMD [ "/usr/bin/virsh", "-c", "qemu:///system" ]


