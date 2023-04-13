# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

WORKDIR /app
# copy necessary files
COPY . .

# install packages
RUN R -e 'install.packages(pkgs=c("random", "shiny", "shinythemes", "ggplot2", "tidyverse", "plotly", "dplyr", "leaflet", "airportr","shinyWidgets", "geosphere", "sp", "shinyjs", "htmltools", "leaflegend"))'

#expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]