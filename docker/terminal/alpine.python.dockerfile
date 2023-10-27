# Use the Alpine base image
FROM alpine:latest

# Update the package list and install necessary dependencies
RUN apk update && apk add --upgrade \
    git \
    make \
    just \
    curl \
    zsh \
    ttyd \
    docker \
    lazydocker \
    sudo \
    # Clean up unnecessary packages and files to reduce image siz
    && apk del \
    &&rm -rf /var/cache/apk/*

# Create the sudoers.d directory, a new user with no password, and grant it sudo privileges
RUN mkdir -p /etc/sudoers.d && \
    adduser -D developer && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer

# Optionally, add the new user to the wheel group (accordig to convention)
RUN addgroup developer wheel

# Switch to the new user
USER developer

# Set a working directory
WORKDIR /home/developer
