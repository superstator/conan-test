FROM debian:12.4-slim as builder

RUN apt-get update && apt-get install -y build-essential python3-full curl
RUN mkdir tools
WORKDIR /tools
RUN curl -L "https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-linux-x86_64.tar.gz" -o cmake.tgz &&\
    tar xf cmake.tgz &&\
    cp ./cmake-3.28.3-linux-x86_64/bin/* /usr/bin/ &&\
    cp -r ./cmake-3.28.3-linux-x86_64/share/* /usr/share/

RUN curl -L https://github.com/ninja-build/ninja/archive/refs/tags/v1.11.1.tar.gz -o ninja.tgz &&\
    tar xf ninja.tgz &&\
    cd ninja-1.11.1 &&\
    cmake . &&\
    make &&\
    make install

RUN python3 -m venv .pybuild
ENV PATH=/tools/.pybuild/bin:${PATH}
RUN pip3 install conan

RUN curl -L https://raw.githubusercontent.com/conan-io/cmake-conan/f6464d1/conan_provider.cmake > conan_provider.cmake

FROM builder as build

RUN mkdir /build
WORKDIR /build

COPY main.cpp .
COPY CMakeLists.txt .
COPY conanfile.txt .

RUN conan profile detect
RUN cp /tools/conan_provider.cmake .
RUN conan install . --build=missing --output-folder=cmake-build
RUN cmake . -G Ninja -DCMAKE_PROJECT_TOP_LEVEL_INCLUDES=conan_provider.cmake -DCMAKE_BUILD_TYPE=Release
RUN cmake --build .
RUN ./testproj
