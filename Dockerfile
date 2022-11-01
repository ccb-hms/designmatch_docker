#
# Designmatch / Gurobi Optimizer Docker Image
# Author: Sam Pullman
# Harvard Medical School Center for Computational Biomedicine
#
#latest stable release of rocker/r-ver
FROM rocker/r-ver:4.0.3

COPY setup.R .
RUN Rscript setup.R

# This could be overridden when building, this is the latest stable release of gurobi optimizer 
ARG GRB_VERSION=9.1.2
ARG GRB_SHORT_VERSION=9.1
ARG PYTHON_VERSION=3.8

# based on https://github.com/Gurobi/docker-optimizer/blob/master/9.1.2/Dockerfile
WORKDIR /opt

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        binfmt-support \
        ca-certificates \
        libpython${PYTHON_VERSION}-stdlib \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-minimal \
        python${PYTHON_VERSION}-venv  \
        wget \
        glpk-utils \
    && update-ca-certificates \
    && wget -v https://packages.gurobi.com/${GRB_SHORT_VERSION}/gurobi${GRB_VERSION}_linux64.tar.gz \
    && tar -xvf gurobi${GRB_VERSION}_linux64.tar.gz  \
    && rm -f gurobi${GRB_VERSION}_linux64.tar.gz \
    && mv -f gurobi* gurobi \
    && rm -rf gurobi/linux64/docs

#run the setup

WORKDIR /opt/gurobi/linux64
RUN python${PYTHON_VERSION} setup.py install

# now install the R package
ENV GUROBI_HOME /opt/gurobi/linux64
ENV PATH "$PATH:$GUROBI_HOME/bin"
ENV LD_LIBRARY_PATH $GUROBI_HOME/lib 

#------------------------------------------------------------------------------
# Install R packages
#------------------------------------------------------------------------------
RUN Rscript -e 'install.packages("/opt/gurobi/linux64/R/gurobi_9.1-2_R_4.0.2.tar.gz",repos = NULL)'
RUN Rscript -e "install.packages('lattice')"
RUN Rscript -e "install.packages('mass')"
RUN Rscript -e "install.packages('slam')"
RUN Rscript -e "install.packages('gurobi',dependencies=TRUE, repos='http://cran.rstudio.com/')" 
RUN R -e "install.packages('designmatch',dependencies=TRUE)"

WORKDIR /code

# Command used to start the application
CMD ["R"]
