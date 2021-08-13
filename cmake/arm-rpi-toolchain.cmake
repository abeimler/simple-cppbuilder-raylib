cmake_minimum_required(VERSION 3.15)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_CROSSCOMPILING TRUE)
#set(CMAKE_SYSROOT $ENV{CROSS_ROOT})
set(CMAKE_FIND_ROOT_PATH $ENV{CROSS_ROOT})
set(CMAKE_STAGING_PREFIX /home/stage)

set(CMAKE_C_COMPILER $ENV{CROSS_TRIPLET}-gcc)
set(CMAKE_CXX_COMPILER $ENV{CROSS_TRIPLET}-g++)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_C_STANDARD_INCLUDE_DIRECTORES "$ENV{ARCHLINUX_ARM_INCLUDES_DIR};$ENV{ARCHLINUX_ARM_LOCAL_INCLUDES_DIR}")
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORES "$ENV{ARCHLINUX_ARM_INCLUDES_DIR};$ENV{ARCHLINUX_ARM_LOCAL_INCLUDES_DIR}")
set(CMAKE_C_STANDARD_LIBRARIES_DIRECTORES "$ENV{ARCHLINUX_ARM_LIBRARIES_DIR};$ENV{ARCHLINUX_ARM_LOCAL_LIBRARIES_DIR}")
set(CMAKE_CXX_STANDARD_LIBRARIES_DIRECTORES "$ENV{ARCHLINUX_ARM_LIBRARIES_DIR};$ENV{ARCHLINUX_ARM_LOCAL_LIBRARIES_DIR}")