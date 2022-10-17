#
# Designmatch / Gurobi Optimizer Image
# Author: Sam Pullman
# Copyright: Harvard Medical School
#
FROM hmsccb/rstudio-server:4.2.0

#------------------------------------------------------------------------------
# Install Gurobi Optimizer (referencing https://github.com/Gurobi/docker-optimizer/blob/master/9.5.2/Dockerfile)
#------------------------------------------------------------------------------

ARG GRB_VERSION=9.5.2
ARG GRB_SHORT_VERSION=9.5

# install gurobi package and copy the files
WORKDIR /opt

RUN apt-get update \
    && apt-get install --no-install-recommends -y\
       ca-certificates  \
       wget \
    && update-ca-certificates \
    && wget -v https://packages.gurobi.com/${GRB_SHORT_VERSION}/gurobi${GRB_VERSION}_linux64.tar.gz \
    && tar -xvf gurobi${GRB_VERSION}_linux64.tar.gz  \
    && rm -f gurobi${GRB_VERSION}_linux64.tar.gz \
    && mv -f gurobi* gurobi \
    && rm -rf gurobi/linux64/docs

ARG GRB_VERSION=9.5.2

LABEL vendor="Gurobi"
LABEL version=${GRB_VERSION}

# update system and certificates
RUN apt-get update \
    && apt-get install --no-install-recommends -y\
       ca-certificates  \
       p7zip-full \
       zip \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/gurobi/linux64


#------------------------------------------------------------------------------
# Install R packages (referencing https://github.com/ccb-hms/docker-r-command-line/blob/main/4.2.0.Dockerfile)
#------------------------------------------------------------------------------
RUN Rscript -e 'install.packages("/opt/gurobi/linux64/R/gurobi_9.5-2_R_4.2.0.tar.gz",repos = NULL)'

RUN Rscript -e 'install.packages("remotes")'

RUN Rscript -e 'install.packages("Rgplk")'

RUN Rscript -e "remotes::install_cran('slam')"

RUN Rscript -e "remotes::install_cran('designmatch')"


#------------------------------------------------------------------------------
# Final odds and ends
#------------------------------------------------------------------------------

# Set default kerberos configuration
COPY krb5.conf /etc/krb5.conf
