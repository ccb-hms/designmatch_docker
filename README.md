<div id="top"></div>


<!-- PROJECT LOGO -->
<br />
<div align="center">

  <h3 align="center">designmatch dockerized</h3>

  <p align="center">
    A Docker one-and-done approach to easily install and work with the designmatch package and the Gurobi optimizer in R.
    <br />
    <br />
    <a href="https://github.com/ccb-hms/designmatch_docker/issues">Report Bug</a>
    ·
    <a href="https://github.com/ccb-hms/designmatch_docker/issues">Request Feature</a>
  </p>
</div>


<!-- ABOUT THE PROJECT -->
## About the Project

This project was created simplify the installation and use of the designmatch package for R, without separately installing the required libraries and dependencies. This project is a collaboration between the Center for Computational Biomedicine (CCB) and Department of Health Care Policy (HCP) at Harvard Medical School.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

[Ensure you have Docker installed and running on your machine.](https://docs.docker.com/get-docker/)
If you're not familiar with Docker, you can find a tutorial [here](https://docs.docker.com/get-started/)! Experience
with Docker is not a necessarry prerequisite to running this code, but will be helpful if you would like to make modifications. 

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- Installation -->
## Installing designmatch and its dependencies

1. Select a working directory, open a terminal, and execute the following command:
   ```sh
   git clone https://github.com/ccb-hms/designmatch_docker.git
   ```

2. Go to https://pages.gurobi.com/registration/ to register for an Academic License of Gurobi Optimizer. If you are already registered for an academic license, continue to step 3.

3. After you have registered for an academic license, navigate to https://license.gurobi.com/manager/licenses to login. 

4. Once logged in to the Web Licensing Service, you will be able to download a gurobi.lic file (necessary to complete this process) by selecting "Licenses" > "Download". If you already have an academic license, it will ask if you'd like to create a new one, answer YES. **NOTE:** Remember where you have saved this file, as the location will be referenced later.

5. Open the Docker application. No actions need to be take, the program just needs to be running.

6. Build the Docker image by running the following command in your terminal:
   ```sh
   docker build -t designmatch-docker .
   ```
   
<!-- Using designmatch -->
## Using designmatch

7. Run the container 
   **Note: you will need to change the two -v options before running, please see below for details**:
   ```sh
   docker run \
   --name designmatch-docker \
   -v /Users/sam/dev/designmatch_docker:/HostData \
   -v /Users/sam/Desktop/designmatch/gurobi.lic:/opt/gurobi/gurobi.lic \
   -it \
   --rm \
   --privileged \
   --cgroupns=host \
   designmatch-docker
   ```
    * **-v /Users/Sam/dev/designmatch_docker:/HostData**: This option is bind-mounting a directory on your local machine (In this case, '/Users/Sam/dev/designmatch') to a directory inside the Docker container. This means that when you complete actions inside the container, those actions are mirrored in your local machine as well. This parameter should be the name of the directory where you have cloned this repository, e.g. "-v {directory you cloned into}:/HostData".

    * **-v /Desktop/designmatch/gurobi.lic:/opt/gurobi/gurobi.lic**: This option is bind-mounting the directory where you saved your gurobi license file to a directory within the container. This parameter should be the name of the directory where the gurobi.lic file is saved, e.g. "-v {saved location}:/opt/gurobi/gurobi.lic"
    * **--privileged and --cgroupns=host**: These are required as the latest versions of some Docker host systems have switched to cgroups v2 which causes a conflict with Gurobi's Web License Service (WLS). This issue is present in all Gurobi versions up to 9.5.0. For details see [Gurobi's Documentation] (https://support.gurobi.com/hc/en-us/articles/4416277022353-Error-10024-Web-license-service-only-available-for-container-environments).

8. An interactive R shell will open. **Congratulations!** You are now set up to use and run R, designmatch, and Gurobi for your research purposes. To test your installation, run the included sample file using:
   ```sh
   > setwd('/HostData/')
   > source('tutorial.R')
   ```
