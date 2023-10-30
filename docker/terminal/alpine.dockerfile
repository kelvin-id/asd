# Use the Alpine base image
FROM alpine:latest

# Update the package list and install necessary dependencies
RUN apk update && apk add --upgrade \
    git \
    make \
    just \
    curl \
    zsh \
    alpine-zsh-config \
    ttyd \
    docker \
    lazydocker \
    sudo \
    # Clean up unnecessary packages and files to reduce image siz
    && apk del \
    &&rm -rf /var/cache/apk/*

# Create a new group with a specific GID
RUN addgroup -g 1000 developer

# Create a new user with a specific UID, and add it to the group
RUN adduser -D -u 1000 -G developer developer

# Create the sudoers.d directory and grant the user sudo privileges
RUN mkdir -p /etc/sudoers.d && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer

# Switch to the new user
USER developer

# Set a working directory
WORKDIR /home/developer
