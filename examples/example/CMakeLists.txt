cmake_minimum_required(VERSION 3.11)
project(example)

# add raylib from external ./libs/raylib
add_subdirectory($ENV{RAYLIB_SOURCE_DIR})
# or use find_package for native linux builds
#find_package(raylib REQUIRED)

# This is the main part:
add_executable(${PROJECT_NAME} core_basic_window.c)

#set(raylib_VERBOSE 1)
target_link_libraries(${PROJECT_NAME} raylib)

# Checks if OSX and links appropriate frameworks (Only required on MacOS)
if (APPLE)
    target_link_libraries(${PROJECT_NAME} "-framework IOKit")
    target_link_libraries(${PROJECT_NAME} "-framework Cocoa")
    target_link_libraries(${PROJECT_NAME} "-framework OpenGL")
endif()
