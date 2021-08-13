# Simple C++ Docker Builder for raylib

<img align="left" src="https://github.com/abeimler/simple-cppbuilder-raylib/blob/main/img/logo.png" width="288px">

Simple C/C++ Builder with compilers, buildtools, dependency manager and [raylib](https://github.com/raysan5/raylib)

---

<br>

![docker-image-size](https://img.shields.io/docker/image-size/abeimler/simple-cppbuilder-raylib) ![automated](https://img.shields.io/docker/automated/abeimler/simple-cppbuilder-raylib) ![pulls](https://img.shields.io/docker/pulls/abeimler/simple-cppbuilder-raylib) ![license](https://img.shields.io/github/license/abeimler/simple-cppbuilder-raylib) ![stars](https://img.shields.io/docker/stars/abeimler/simple-cppbuilder-raylib)

## Features

- Pre-installed Compilers and Tools
- Ready to use build scripts ([docker-build.sh](https://github.com/abeimler/simple-cppbuilder-raylib/blob/main/scripts/docker-build.sh) and [docker-test.sh](https://github.com/abeimler/simple-cppbuilder-raylib/blob/main/scripts/docker-test.sh))
- **[raylib](https://github.com/raysan5/raylib)**

## What's included

Based on [simple-cppbuilder](https://hub.docker.com/r/abeimler/simple-cppbuilder)

- **Compilers:** clang, gcc or cross-compiler
- **Buildtools:** cmake, make and ninja
- **Dependency Manager:** conan and/or vcpkg
- **More Tools:** python, pip, ccache, cppcheck, doxygen and more
- **Libraries:** **[raylib](https://github.com/raysan5/raylib)**

## How to use this image

You can find a basic core project example [here](https://github.com/abeimler/simple-cppbuilder-raylib/tree/main/example/example).

### Create a `Dockerfile` in your C/C++ raylib project

```Dockerfile
FROM abeimler/simple-cppbuilder-raylib as build
COPY . .
CMD ["./docker-build.sh"]
```

You can then build and run the Docker image:

```bash
$ docker build -t my-raylib-project .
$ docker run -it --rm --name my-raylib my-cppraylib-project
```


### Run a single file

```bash
$ docker run -it --rm --name my-raylib-project -v "$PWD":/home/project -w /home/project abeimler/simple-cppbuilder-raylib ./docker-build.sh
```


## Image Variants

### `:latest`

Default image with gcc, buildtools and [raylib](https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux) (Platform: `Desktop`).  
_More infos [here](https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux)_

### `:x64-mingw-w64`, `x86-mingw-w64`

Default image with mingw-w64-cross-compiler and [raylib](https://github.com/raysan5/raylib/wiki/Working-on-Windows) (Platform: `Desktop`).  
_More infos [here](https://github.com/raysan5/raylib/wiki/Working-on-Windows)_

### Cross-Compiler (experimental)

_Not fully tested_

#### `:web`

Default image with emscripten and [raylib](https://github.com/raysan5/raylib/wiki/Working-for-Web-(HTML5)) (Platform: `Web`).  
_More infos [here](https://github.com/raysan5/raylib/wiki/Working-for-Web-(HTML5))_

#### `:rpi4`, `:rpi3`, `:rpi2`

Default image with arm-cross-compiler and [raylib](https://github.com/raysan5/raylib/wiki/Working-on-Raspberry-Pi) (Platform: `DRM`, `Raspberry Pi`).  
_More infos [here](https://github.com/raysan5/raylib/wiki/Working-on-Raspberry-Pi)_

##### `:rpi4-desktop`

Default image with arm-cross-compiler and [raylib](https://github.com/raysan5/raylib/wiki/Working-on-Raspberry-Pi) (Platform: `Desktop` and `OPENGL_VERSION=2.1`).  
_More infos [here](https://github.com/raysan5/raylib/wiki/Working-on-Raspberry-Pi)_

#### `:arm-android`, `:arm64-android`, `:x86-android`, `:x64-android`

Default image with android-ndk and [raylib](https://github.com/raysan5/raylib/wiki/Working-for-Android-(on-Linux)) (Platform: `Android`).  
_More infos [here](https://github.com/raysan5/raylib/wiki/Working-for-Android)_


## Environment Variables

### `CC`

C Compiler, default:  `gcc`.
Can also be `clang`.  

### `CXX`

C++ Compiler, default:  `g++`.
Can also be `clang++`.  

### `CMAKE_GENERATOR`

CMake Generator `cmake -G`, default: `Ninja`.
Can also be `Unix Makefiles`.  

### `BUILD_TYPE`

CMake BuildType `-DCMAKE_BUILD_TYPE`, default: `Release`.
Can also be `Debug`, `RelWithDebInfo` or `MinSizeRel`.  

### `TARGET`

target run by cmake `cmake --target`, default: `all`.  

### `TOOLCHAIN_FILE`

CMake Toolchain File `-DCMAKE_TOOLCHAIN_FILE`.

### `RAYLIB_ADDITIONAL_CMAKE_ARGS`

Custom CMake Arguments for raylib, e.g. `-DUSE_AUDIO:BOOL=OFF` or `-DSUPPORT_GESTURES_SYSTEM:BOOL=OFF -DSUPPORT_MOUSE_GESTURES:BOOL=OFF` (see [CMake Build Options](https://github.com/raysan5/raylib/wiki/CMake-Build-Options)).  

## `CMAKE_ARGS`, `ADDITIONAL_CMAKE_ARGS`

Custom CMake Arguments, e.g. `-DENABLE_COVERAGE:BOOL=ON`.


## Troubleshooting

For raylib troubleshooting, please check the [raylib wiki](https://github.com/raysan5/raylib/wiki)

### Android (Cross compiling)

#### `android_native_app_glue.h: No such file or directory`

add the `<ANDROID_NDK_HOME>/sources/android/native_app_glue`-path into your `include_directories`.
_use env. variable `NATIVE_APP_GLUE_PATH`_

```cmake
if (${PLATFORM} MATCHES "Android")
    include_directories($ENV{NATIVE_APP_GLUE_PATH})
endif()
```

### Raspberry Pi (Cross compiling)

#### `GLES2/gl2.h`, `bcm_host.h` and other Raspberry Pi includes/libraries are missing

add the `/opt/vc/include`-path into your `include_directories`.

```cmake
if (PLATFORM STREQUAL "Raspberry Pi")
    include_directories(BEFORE SYSTEM /opt/vc/include /opt/vc/include/interface/vmcs_host/linux /opt/vc/include/interface/vcos/pthreads $ENV{ARCHLINUX_ARM_INCLUDES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_INCLUDES_DIR})
    link_directories(BEFORE /opt/vc/lib $ENV{ARCHLINUX_ARM_LIBRARIES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_LIBRARIES_DIR})
endif()
```

#### `drm.h`, `gbm.h` and native system includes/libraries are missing

add the Arch Linux ARM include- and library-directories.
_use env. variables `ARCHLINUX_ARM_<LOCAL>_<INCLUDES/LIBRARIES>_DIR`_

```cmake
if (PLATFORM STREQUAL "DRM")
    include_directories(BEFORE SYSTEM $ENV{ARCHLINUX_ARM_INCLUDES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_INCLUDES_DIR} $ENV{ARCHLINUX_ARM_LIBDRM_INCLUDES_DIR})
    link_directories(BEFORE $ENV{ARCHLINUX_ARM_LIBRARIES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_LIBRARIES_DIR})
endif()
```

## More Examples

### Using vcpkg

Set `TOOLCHAIN` to `$VCPKG_TOOLCHAIN_FILE` and set `-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${CHAINLOAD_TOOLCHAIN_FILE}"` into `ADDITIONAL_CMAKE_ARGS`.  

```Dockerfile
FROM abeimler/simple-cppbuilder-raylib as build
COPY . .
ENV TOOLCHAIN $VCPKG_TOOLCHAIN_FILE
ENV ADDITIONAL_CMAKE_ARGS -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${CHAINLOAD_TOOLCHAIN_FILE}"
CMD ["./docker-build.sh"]
```


## License

View [license information](https://github.com/abeimler/simple-cppbuilder-raylib/blob/main/LICENSE) for this image.  

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).  

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.


### Links

- [simple-cppbuilder-raylib DockerHub](https://hub.docker.com/r/abeimler/simple-cppbuilder)
- [simple-cppbuilder-raylib GitHub](https://github.com/abeimler/simple-cppbuilder-raylib)
- [simple-cppbuilder GitHub](https://github.com/abeimler/simple-cppbuilder)
- [raylib](https://github.com/raysan5/raylib)
