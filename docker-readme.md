README - Docker Setup
=====================

Docker ensures that your software can be compiled and executed on any system with the OS and package configuration of 
your choice. Docker helps complex software projects in the following ways:

1. Solves dependency conflicts among multiple projects on the same machine.
2. Lets your collaborators execute your software and obtain its results in the exact way you intend. 
3. Is free of charge and open source!

The configuration is specified in a Dockerfile which contains commands similar to those you would enter into a terminal 
window or bash script to configure your machine. The Dockefile is then "built" into an "image" that contains your software 
and all of its dependencies including datasets. A "container" of that image can then be "run" to execute your software.
Collaboration happens by sharing either Dockerfiles or the built images themselves.

Instructions
--------------

1. Follow the [Docker installation instructions](https://docs.docker.com/engine/installation/) for your system. 
On Ubuntu, follow the instructions until "Install the Latest Version." You may also want to follow "Manage Docker as a Non-`root` User"
2. Open a terminal. (On Mac and Windows, use the Docker Quickstart Terminal application)
3. Access GTSAM:

    `git clone git@bitbucket.org:gtborg/gtsam.git`
    `cd gtsam`

5. Build the Docker image according to the included Dockerfile in the GTSAM root directory:

    `docker build -t gtsam_example_image .`

6. Execute the Docker image built in the previous step:

    `docker run -it --rm gtsam_example_image`
     
7. In the future, you will want to use the existing Dockerfile as a template to write your own Dockerfiles specific to the needs
   of your projects. You may wish to read the exaplanations in the included Dockerfile as well as the [Docker reference](https://docs.docker.com/engine/reference/builder/).