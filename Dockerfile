FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
    pkg-config \
    libbz2-dev \
    libstxxl-dev \
    libstxxl-doc \
    libstxxl1 \
    libxml2-dev \
    libzip-dev \
    libboost-all-dev \
    lua5.1 \
    liblua5.1-0-dev \
    libluabind-dev \
    libtbb-dev \
    wget

# Build and install routing machine, osrm.
RUN git clone https://github.com/Project-OSRM/osrm-backend.git
RUN cd osrm-backend; \
    mkdir -p build; \
    cd build; \
    cmake .. -DCMAKE_BUILD_TYPE=Release; \
    cmake --build .; \
    sudo cmake --build . --target install;

# All future RUN, CMD, etc from here.
WORKDIR osrm-backend/build

# Set the mode of routing and get the data set up.
# Choices: foot, car, bicycle
ENV mode foot
RUN ln -s ../profiles/${mode}.lua profile.lua; \
    wget http://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf; \
    ./osrm-extract -p profile.lua massachusetts-latest.osm.pbf; \
    ./osrm-contract massachusetts-latest.osrm;

# Expose port 5000, where the routed API will be listening.
EXPOSE 5000

ENTRYPOINT ["osrm-routed", "massachusetts-latest.osrm"]