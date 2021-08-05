FROM abeimler/simple-cppbuilder-raylib:linux as linux-build
COPY . .
CMD ["./docker-build.sh"]


FROM abeimler/simple-cppbuilder-raylib:x64-mingw-w64 as windows-build
COPY . .
CMD ["./docker-build.sh"]


FROM abeimler/simple-cppbuilder-raylib:web as web-build
COPY . .
CMD ["./docker-build.sh"]


FROM abeimler/simple-cppbuilder-raylib:rpi3 as rpi-build
COPY . .
CMD ["./docker-build.sh"]

FROM abeimler/simple-cppbuilder-raylib:rpi4 as rpi4-build
COPY . .
CMD ["./docker-build.sh"]

FROM abeimler/simple-cppbuilder-raylib:rpi4-desktop as rpi4-desktop-build
COPY . .
CMD ["./docker-build.sh"]