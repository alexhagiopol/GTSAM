# Select the OS for this container. Note this is *not* the host OS of the host machine,
# but rather the OS in which you want your software to run.
FROM ubuntu:16.04

# Create a gtsam directory inside the container.
RUN mkdir /gtsam

# Copy all files from the gtsam root directory on the host machine to the /gtsam directory in the container.
# Individual files can be copied with multple uses of the COPY command.
COPY . /gtsam

# Set the working directory as /gtsam. Every command will be relative to this path.
WORKDIR /gtsam

# Install prerequisites.
RUN apt-get update -y -qq --fix-missing
RUN apt-get install -y -qq libboost-all-dev
RUN apt-get install -y -qq cmake
# Multiple packages can be installed in one RUN command like so:
RUN apt-get install -y -qq gcc g++
RUN apt-get install -y -qq libtbb-dev
# An option is to install all of the prerequisites in one layer like so:
# RUN apt-get install -y -qq \
#    libboost-all-dev \
#    cmake \
#    gcc \
#    g++ \
#    cmake \
#    libtbb-dev
# Read more about Docker layers here: https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/
# Making a change "above" a layer in the Dockerfile means the cache for that layer will be invalidated and the
# commands beneath the change will have to be repeated. For large projects this could consume lots of time.
# Use multiple layers if you expect to frequently change your configuration. Use a single layer if you're confident
# your configuration is as you want it to be.

# Compile and install GTSAM inside the container. Commands are done with one use of RUN because
# multiple RUN commands would be relative to the workdir, not the "current dir" as one would
# expect in a terminal.
RUN mkdir build && cd build && cmake .. && make -j$(nproc) check && make -j$(nproc) install

# Import a non-GTSAM project that depends on GTSAM. To illustrate using GTSAM for your own projects, we make
# gtsam/examples/SFMExampleExpressions.cpp into its own project and clone it into the Docker container:
RUN mkdir /my_project
WORKDIR /my_project
RUN