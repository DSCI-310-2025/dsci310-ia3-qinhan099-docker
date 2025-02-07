# Use rocker/rstudio:4.4.2 as the base image
FROM rocker/rstudio:4.4.2

# Set the working directory
WORKDIR /home/rstudio

# Copy the renv.lock file into the container
COPY renv.lock /tmp/renv.lock

# The run commands are actually bash commands typed in terminal - Install the renv package manager
RUN Rscript -e "install.packages('renv', repos='https://cloud.r-project.org')"

# Restore packages from renv.lock
RUN Rscript -e "renv::restore(lockfile = '/tmp/renv.lock')"

# Copy the renv directory (if available) for caching
COPY renv/ /home/rstudio/renv/

# Ensure renv is activated when R starts
RUN echo 'source(\"renv/activate.R\")' >> /home/rstudio/.Rprofile

# 🔹 Fix user permissions (replace fix-permissions)
RUN chown -R rstudio:rstudio /home/rstudio && chmod -R 777 /home/rstudio

# Clean up unnecessary files
RUN Rscript -e "renv::clean()"

# Expose the default RStudio Server port
EXPOSE 8787

# Set environment variable to define the RStudio password
ENV PASSWORD="pass"

# Start RStudio Server when the container runs
CMD ["/init"]
