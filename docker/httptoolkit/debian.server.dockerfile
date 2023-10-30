# Start from a base Debian Slim image
FROM linuxcontainers/debian-slim:latest

# Update the package list and install wget and tar
RUN apt-get update && \
    apt-get install -y wget tar

WORKDIR app

# Download the binary tarball
RUN wget https://github.com/httptoolkit/httptoolkit-server/releases/download/v1.14.7/httptoolkit-server-v1.14.7-linux-x64.tar.gz \
    && tar -xzf httptoolkit-server-v1.14.7-linux-x64.tar.gz \
    && rm httptoolkit-server-v1.14.7-linux-x64.tar.gz

EXPOSE 45456

# Command to run the httptoolkit-server binary
CMD ["/bin/bash", "-c", "/app/httptoolkit-server/bin/httptoolkit-server start"]
