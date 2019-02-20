# Copyright (c) 2017-2019 Cisco and/or its affiliates.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

apt-get update && apt-get install -y \
    git cmake build-essential bison flex \
    libpcre3-dev libev-dev libavl-dev \
    libprotobuf-c-dev protobuf-c-compiler

git clone -b v0.16-r2 https://github.com/CESNET/libyang.git
cp Packaging.cmake PackagingLibYang.cmake libyang/CMakeModules/
cd libyang; git apply ../libyang.diff
mkdir -p build
cd build
cmake -D CMAKE_BUILD_TYPE:String="Release" -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
make package
dpkg -i  libyang_0.16-r2_amd64.deb

git clone -b v0.7.7 https://github.com/sysrepo/sysrepo.git
cp Packaging.cmake PackagingSysRepo.cmake sysrepo/CMakeModules/
cd sysrepo; git apply ../sysrepo.diff
mkdir -p build
cd build
cmake -D CMAKE_BUILD_TYPE:String="Release" -DCMAKE_INSTALL_PREFIX:PATH=/usr -DBUILD_EXAMPLES:BOOL=FALSE ..
make package