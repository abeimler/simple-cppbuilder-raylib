cmake_minimum_required(VERSION 3.15)
# Setup the project and settings
project(examples)

# @FIXME: CMake Warning (dev) at libs/raylib/cmake/GlfwImport.cmake:13 (if):
# Policy CMP0054 is not set: Only interpret if() arguments as variables or
# keywords when unquoted.  Run "cmake --help-policy CMP0054" for policy
# details.  Use the cmake_policy command to set the policy and suppress this warning.
# Quoted variables like "DRM" will no longer be dereferenced when the policy
# is set to NEW.  Since the policy is not set the OLD behavior will be used.
if (NOT ${CMAKE_VERSION} VERSION_LESS "3.1.0")
    cmake_policy(SET CMP0054 NEW)
endif ()

# add raylib from external ./libs/raylib
add_subdirectory($ENV{RAYLIB_SOURCE_DIR})
# or use find_package for native linux builds
#find_package(raylib REQUIRED)
message(STATUS "Platform: ${PLATFORM}")

# Directories that contain examples
set(example_dirs
    audio
    core
    models
    others
    shaders
    shapes
    text
    textures
    )

# Next few lines will check for existence of symbols or header files
# They are needed for the physac example and threads examples
set(CMAKE_REQUIRED_DEFINITIONS -D_POSIX_C_SOURCE=199309L)
include(CheckSymbolExists)
check_symbol_exists(CLOCK_MONOTONIC time.h HAVE_CLOCK_MONOTONIC)
check_symbol_exists(QueryPerformanceCounter windows.h HAVE_QPC)
set(CMAKE_REQUIRED_DEFINITIONS)

if (HAVE_QPC OR HAVE_CLOCK_MONOTONIC)
    set(example_dirs ${example_dirs} physac)
endif ()

include(CheckIncludeFile)
CHECK_INCLUDE_FILE("stdatomic.h" HAVE_STDATOMIC_H)
set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
find_package(Threads)
if (CMAKE_USE_PTHREADS_INIT AND HAVE_STDATOMIC_H)
    add_if_flag_compiles("-std=c11" CMAKE_C_FLAGS)
    if (THREADS_HAVE_PTHREAD_ARG)
        add_if_flag_compiles("-pthread" CMAKE_C_FLAGS)
    endif ()
    if (CMAKE_THREAD_LIBS_INIT)
        link_libraries("${CMAKE_THREAD_LIBS_INIT}")
    endif ()
endif ()

if (APPLE AND NOT CMAKE_SYSTEM STRLESS "Darwin-18.0.0")
    add_definitions(-DGL_SILENCE_DEPRECATION)
    MESSAGE(AUTHOR_WARNING "OpenGL is deprecated starting with macOS 10.14 (Mojave)!")
endif ()

# Collect all source files and resource files
# into a CMake variable
set(example_sources)
set(example_resources)
foreach (example_dir ${example_dirs})
    # Get the .c files
    file(GLOB sources ${example_dir}/*.c)
    list(APPEND example_sources ${sources})
    
    # Any any resources
    file(GLOB resources ${example_dir}/resources/*)
    list(APPEND example_resources ${resources})
endforeach ()

if(NOT CMAKE_USE_PTHREADS_INIT OR NOT HAVE_STDATOMIC_H)
    # Items requiring pthreads
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_loading_thread.c)
endif ()

if (PLATFORM STREQUAL "Android")
    include_directories(BEFORE SYSTEM $ENV{NATIVE_APP_GLUE_PATH})

    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/others/rlgl_standalone.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/others/standard_lighting.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_3d_picking.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_vr_simulator.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_3d_camera_free.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_3d_camera_first_person.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_world_screen.c)
    
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_mesh_picking.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_material_pbr.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_cubicmap.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_skybox.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_mesh_picking.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_mesh_generation.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_heightmap.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_billboard.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_rlgl_solar_system.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_rlgl_full_solar_system.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_solar_system.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_obj_viewer.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_animation.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_first_person_maze.c)
    
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_custom_uniform.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_model_shader.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_postprocessing.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_raymarching.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_palette_switch.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_basic_lighting.c)

    message(STATUS "Android, include_directories: $ENV{NATIVE_APP_GLUE_PATH}")
elseif (PLATFORM STREQUAL "Web")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Os -s USE_GLFW=3 -s ASSERTIONS=1 -s WASM=1 -s ASYNCIFY")
    # Since WASM is used, ALLOW_MEMORY_GROWTH has no extra overheads
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -s ALLOW_MEMORY_GROWTH=1 --no-heap-copy")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --shell-file ${CMAKE_SOURCE_DIR}/src/shell.html")
    set(CMAKE_EXECUTABLE_SUFFIX ".html")
    
    # Remove the -rdynamic flag because otherwise emscripten
    # does not generate HTML+JS+WASM files, only a non-working
    # and fat HTML
    string(REPLACE "-rdynamic" "" CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "${CMAKE_SHARED_LIBRARY_LINK_C_FLAGS}")

    message(STATUS "Web, CMAKE_C_FLAGS: ${CMAKE_C_FLAGS}")
elseif (PLATFORM STREQUAL "DRM" OR PLATFORM STREQUAL "Raspberry Pi")
    if (PLATFORM STREQUAL "Raspberry Pi")
        include_directories(BEFORE SYSTEM /opt/vc/include /opt/vc/include/interface/vmcs_host/linux /opt/vc/include/interface/vcos/pthreads $ENV{ARCHLINUX_ARM_INCLUDES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_INCLUDES_DIR})
        link_directories(BEFORE /opt/vc/lib $ENV{ARCHLINUX_ARM_LIBRARIES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_LIBRARIES_DIR})
    endif()
    if (PLATFORM STREQUAL "DRM")
        include_directories(BEFORE SYSTEM $ENV{ARCHLINUX_ARM_INCLUDES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_INCLUDES_DIR} $ENV{ARCHLINUX_ARM_LIBDRM_INCLUDES_DIR})
        link_directories(BEFORE $ENV{ARCHLINUX_ARM_LIBRARIES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_LIBRARIES_DIR})
    endif()

    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/others/rlgl_standalone.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/others/standard_lighting.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_3d_picking.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_vr_simulator.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_3d_camera_free.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_3d_camera_first_person.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/core/core_world_screen.c)
    
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_mesh_picking.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_material_pbr.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_cubicmap.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_skybox.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_mesh_picking.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_mesh_generation.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_heightmap.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_billboard.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_rlgl_solar_system.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_rlgl_full_solar_system.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_solar_system.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_obj_viewer.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_animation.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/models/models_first_person_maze.c)
    
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_custom_uniform.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_model_shader.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_postprocessing.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_raymarching.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_palette_switch.c)
    list(REMOVE_ITEM example_sources ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shaders_basic_lighting.c)

    message(STATUS "DRM/RPI, include_directories: /opt/vc/include $ENV{ARCHLINUX_ARM_INCLUDES_DIR} $ENV{ARCHLINUX_ARM_LOCAL_INCLUDES_DIR} $ENV{ARCHLINUX_ARM_LIBDRM_INCLUDES_DIR}")
endif ()

include_directories(BEFORE SYSTEM others/external/include)

# Do each example
foreach (example_source ${example_sources})
    # Create the basename for the example
    get_filename_component(example_name ${example_source} NAME)
    string(REPLACE ".c" "" example_name ${example_name})
    
    # Setup the example
    add_executable(${example_name} ${example_source})
    
    target_link_libraries(${example_name} raylib)
    
    string(REGEX MATCH ".*/.*/" resources_dir ${example_source})
    string(APPEND resources_dir "resources")
    
    if (NOT PLATFORM STREQUAL "Web")
        set(THREADS_PREFER_PTHREAD_FLAG ON)
        find_package(Threads)
    endif()
    if (PLATFORM STREQUAL "Web" AND EXISTS ${resources_dir})
        # The local resources path needs to be mapped to /resources virtual path
        string(APPEND resources_dir "@resources")
        set_target_properties(${example_name} PROPERTIES LINK_FLAGS "--preload-file ${resources_dir}")
    elseif (PLATFORM STREQUAL "Windows")
        target_link_libraries(${example_name} opengl32 gdi32 winmm Threads::Threads)
    elseif (PLATFORM STREQUAL "Linux")
        target_link_libraries(${example_name} dl m rt Threads::Threads)
    elseif (PLATFORM STREQUAL "DRM")
        target_link_libraries(${example_name} brcmGLESv2 brcmEGL rt m bcm_host dl Threads::Threads)
    elseif (PLATFORM STREQUAL "Raspberry Pi")
        target_link_libraries(${example_name} EGL rt m gbm drm dl Threads::Threads)
    endif ()
endforeach ()

# Copy all of the resource files to the destination
file(COPY ${example_resources} DESTINATION "resources/")
