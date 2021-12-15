#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi4" \
    --build-arg raylib_platform="DRM" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    --build-arg get_arch_linux_arm_os="http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-4-latest.tar.gz" \
    --build-arg get_arch_linux_arm_mesa="http://mirror.archlinuxarm.org/armv7h/extra/mesa-21.1.6-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libdrm="http://mirror.archlinuxarm.org/armv7h/extra/libdrm-2.4.107-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libx11="http://mirror.archlinuxarm.org/armv7h/extra/libx11-1.7.2-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_glu="http://mirror.archlinuxarm.org/armv7h/extra/glu-9.0.2-1-armv7h.pkg.tar.xz" \
    -t abeimler/simple-cppbuilder-raylib:rpi4 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi4" \
    --build-arg raylib_platform="Desktop" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON -DOPENGL_VERSION=2.1" \
    --build-arg get_arch_linux_arm_os="http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-4-latest.tar.gz" \
    --build-arg get_arch_linux_arm_mesa="http://mirror.archlinuxarm.org/armv7h/extra/mesa-21.1.6-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libdrm="http://mirror.archlinuxarm.org/armv7h/extra/libdrm-2.4.107-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libx11="http://mirror.archlinuxarm.org/armv7h/extra/libx11-1.7.2-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_glu="http://mirror.archlinuxarm.org/armv7h/extra/glu-9.0.2-1-armv7h.pkg.tar.xz" \
    -t abeimler/simple-cppbuilder-raylib:rpi4-desktop .


docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi3" \
    --build-arg raylib_platform="Raspberry Pi" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    --build-arg get_arch_linux_arm_os="http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz" \
    --build-arg get_arch_linux_arm_mesa="http://mirror.archlinuxarm.org/armv7h/extra/mesa-21.1.6-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libdrm="http://mirror.archlinuxarm.org/armv7h/extra/libdrm-2.4.107-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libx11="http://mirror.archlinuxarm.org/armv7h/extra/libx11-1.7.2-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_glu="http://mirror.archlinuxarm.org/armv7h/extra/glu-9.0.2-1-armv7h.pkg.tar.xz" \
    -t abeimler/simple-cppbuilder-raylib:rpi3 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi2" \
    --build-arg raylib_platform="Raspberry Pi" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    --build-arg get_arch_linux_arm_os="http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz" \
    --build-arg get_arch_linux_arm_mesa="http://mirror.archlinuxarm.org/armv7h/extra/mesa-21.1.6-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libdrm="http://mirror.archlinuxarm.org/armv7h/extra/libdrm-2.4.107-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libx11="http://mirror.archlinuxarm.org/armv7h/extra/libx11-1.7.2-1-armv7h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_glu="http://mirror.archlinuxarm.org/armv7h/extra/glu-9.0.2-1-armv7h.pkg.tar.xz" \
    -t abeimler/simple-cppbuilder-raylib:rpi2 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg image_tag="rpi1" \
    --build-arg raylib_platform="Raspberry Pi" \
    --build-arg raylib_cmake_args="-DCMAKE_CROSSCOMPILING:BOOL=ON" \
    --build-arg get_arch_linux_arm_os="http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-latest.tar.gz" \
    --build-arg get_arch_linux_arm_mesa="http://mirror.archlinuxarm.org/armv6h/extra/mesa-21.1.6-1-armv6h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libdrm="http://mirror.archlinuxarm.org/armv6h/extra/libdrm-2.4.107-1-armv6h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_libx11="http://mirror.archlinuxarm.org/armv6h/extra/libx11-1.7.2-1-armv6h.pkg.tar.xz" \
    --build-arg get_arch_linux_arm_glu="http://mirror.archlinuxarm.org/armv6h/extra/glu-9.0.2-1-armv6h.pkg.tar.xz" \
    -t abeimler/simple-cppbuilder-raylib:rpi1 .
