cmake_minimum_required(VERSION 3.27)
project(testproj)

set(CMAKE_CXX_STANDARD 17)

find_package(OpenSSL REQUIRED)
include_directories(${openssl_INCLUDE_DIR})

# doctest is header only, so no need to link below
find_package(doctest REQUIRED)
include_directories(${doctest_INCLUDE_DIR})

add_executable(testproj main.cpp)

target_link_libraries(testproj openssl::openssl)