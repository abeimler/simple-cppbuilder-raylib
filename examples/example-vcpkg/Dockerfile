FROM abeimler/simple-cppbuilder-raylib:linux as linux-build
ENV CMAKE_TOOLCHAIN_FILE "/home/project/vcpkg/scripts/buildsystems/vcpkg.cmake"
COPY . .
CMD ["./docker-build.sh"]


FROM abeimler/simple-cppbuilder-raylib:x64-mingw-w64 as windows-build
ENV CMAKE_TOOLCHAIN_FILE "/home/project/vcpkg/scripts/buildsystems/vcpkg.cmake"
ENV ADDITIONAL_CMAKE_ARGS -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}"
COPY . .
CMD ["./docker-build.sh"]


FROM abeimler/simple-cppbuilder-raylib:web as web-build
ENV CMAKE_TOOLCHAIN_FILE "/home/project/vcpkg/scripts/buildsystems/vcpkg.cmake"
ENV ADDITIONAL_CMAKE_ARGS -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}"
COPY . .
CMD ["./docker-build.sh"]


FROM abeimler/simple-cppbuilder-raylib:rpi3 as rpi-build
ENV CMAKE_TOOLCHAIN_FILE "/home/project/vcpkg/scripts/buildsystems/vcpkg.cmake"
ENV ADDITIONAL_CMAKE_ARGS -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}"
COPY . .
CMD ["./docker-build.sh"]

FROM abeimler/simple-cppbuilder-raylib:rpi4 as rpi4-build
ENV CMAKE_TOOLCHAIN_FILE "/home/project/vcpkg/scripts/buildsystems/vcpkg.cmake"
ENV ADDITIONAL_CMAKE_ARGS -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}"
COPY . .
CMD ["./docker-build.sh"]

FROM abeimler/simple-cppbuilder-raylib:rpi4-desktop as rpi4-desktop-build
ENV CMAKE_TOOLCHAIN_FILE "/home/project/vcpkg/scripts/buildsystems/vcpkg.cmake"
ENV ADDITIONAL_CMAKE_ARGS -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}"
COPY . .
CMD ["./docker-build.sh"]