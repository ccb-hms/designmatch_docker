# gurobi_designmatch
A Docker containerized approach for a one-and-done R environment with Gurobi Optimizer and the design match package pre-installed.

### Installation

(TODO: make a note about the gurobi.lic file, which will need to be created by each user. This repo is PRIVATE and will remain as such until the .lic file is updated to be blank.)

1. Building the Docker image:
   ```sh
   docker build -t gurobi .
   ```

2. Running the container interactively:
   ```sh
   docker run -it gurobi  
   ```

3. Install the remotes package within the interactive R session:
   ```sh
   install.packages('remotes')
   ```

4. Install the designmatch package within the interactive R session:
   ```sh
   remotes::install_cran('designmatch')
   ```
   
5. Install the slam package within the interactive R session:
   ```sh
   install.packages('slam')
   ```

You are now set up to use and run R, designmatch, and Gurobi for your research purposes.
