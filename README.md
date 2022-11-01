<div id="top"></div>


<!-- PROJECT LOGO -->
<br />
<div align="center">

  <h3 align="center">Designmatch - Dockerized</h3>

  <p align="center">
    A Dockerized approach for a one-and-done R environment with Gurobi Optimizer and the designmatch R package pre-installed.
    <br />
    <br />
    <a href="https://github.com/ccb-hms/designmatch_docker/issues">Report Bug</a>
    ·
    <a href="https://github.com/ccb-hms/designmatch_docker/issues">Request Feature</a>
  </p>
</div>


<!-- ABOUT THE PROJECT -->
## About The Project

This project was created as a way to efficiently supply HMS researchers with the tools they need without spending hours toiling with installing libraries and dependencies. This project is a collaboration between HMS' Center for Computational Biomedicine (CCB) and the center for Health Care Policy (HCP).

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

[Ensure you have Docker installed and running on your machine.](https://docs.docker.com/get-docker/)
If you're not familiar with Docker, you can find a tutorial [here](https://docs.docker.com/get-started/)! Experience
with Docker is not a necessarry prerequisite to running this code, but will be helpful if you would like to make modifications. 

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- Installation -->
## Installation

1. Clone this repo by navigating into your desired base directory, and executing the following command:
   ```sh
   git clone https://github.com/ccb-hms/designmatch_docker.git
   ```

2. Once cloned, head to https://www.gurobi.com/downloads/end-user-license-agreement-academic/ to register for an Academic License of Gurobi Optimizer. 

3. After you have registered for an academic license, navigate to https://license.gurobi.com/manager/licenses to login. 

4. Once logged in to the Web Licensing Service, you will be able to download a gurobi.lic file (necessary to complete this process) by selecting "Licenses" > "Download". Save the file inside of the designmatch directory.

5. Open a terminal.

6. Build the Docker image by running the following command:
   ```sh
   docker build -t designmatch-docker .
   ```
   
7. Run the container 
   **Note: you will need to change the two -v options before running, please see below for details**:
   ```sh
   docker run --name designmatch-docker \
   -v ~/Desktop/designmatch:/HostData \
   -v ~/Desktop/designmatch/gurobi.lic:/opt/gurobi/gurobi.lic \
   -it \
   --privileged \
   --cgroupns=host \
   designmatch-docker
   ```
    * **-v ~/Desktop/designmatch:/HostData**: This option is bind-mounting a directory on your local machine (In this case, 'Desktop/designmatch') to a directory inside the Docker container. This means that when you complete actions inside the container, those actions are mirrored in your local machine as well. This parameter should be the name of the directory where you have cloned this repository, e.g. "-v {directory you cloned into}:/HostData".

    * **-v ~/Desktop/designmatch/gurobi.lic:/opt/gurobi/gurobi.lic**: This option is bind-mounting the directory where you saved your gurobi license file to a directory within the container. This parameter should be the name of the directory where the gurobi.lic file is saved, e.g. "-v {saved location}:/opt/gurobi/gurobi.lic"

    
**Congratulations!** You are now set up to use and run R, designmatch, and Gurobi for your research purposes.

**TODO: confirm with Jose if he wants an interactive R session to open, or if he wants to be able to run R scripts without running the interactive session**
