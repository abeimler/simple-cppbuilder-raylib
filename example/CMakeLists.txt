cmake_minimum_required(VERSION 3.11)
project(example)
if (EMSCRIPTEN)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -s USE_GLFW=3 -s ASSERTIONS=1 -s WASM=1 -s ASYNCIFY")
    set(CMAKE_EXECUTABLE_SUFFIX ".html") # This line is used to set your executable to build with the emscripten html template so taht you can directly open it.
endif ()

# add raylib from external ./libs/raylib
add_subdirectory($ENV{RAYLIB_SOURCE_DIR})
# or use find_package for native linux builds
#find_package(raylib REQUIRED)

# This is the main part:
if (EMSCRIPTEN)
    add_executable(${PROJECT_NAME} core_basic_window_web.c)
else()
    add_executable(${PROJECT_NAME} core_basic_window.c)
endif()

#set(raylib_VERBOSE 1)
target_link_libraries(${PROJECT_NAME} raylib)

# Checks if OSX and links appropriate frameworks (Only required on MacOS)
if (APPLE)
    target_link_libraries(${PROJECT_NAME} "-framework IOKit")
    target_link_libraries(${PROJECT_NAME} "-framework Cocoa")
    target_link_libraries(${PROJECT_NAME} "-framework OpenGL")
endif()
