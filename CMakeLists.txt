cmake_minimum_required(VERSION 3.15)
project(gpu_compiler_verification_suite VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)

set(SOURCES
    src/ptx_interpreter.cpp
    src/verification_engine.cpp
    src/main.cpp
)

add_executable(nv_verify_engine ${SOURCES})

# Compiler warnings for rigorous verification code quality
if(MSVC)
    target_compile_options(nv_verify_engine PRIVATE /W4 /EHsc)
else()
    target_compile_options(nv_verify_engine PRIVATE -Wall -Wextra -Wpedantic)
endif()
