# Use the official Alpine-based Node image as a starting point
FROM node:18-alpine

# Metadata as described by the OCI image spec
LABEL org.opencontainers.image.title="Alpine code-server" \
      org.opencontainers.image.description="VS Code running on Alpine with code-server" \
      org.opencontainers.image.source="https://github.com/coder/code-server"

# Change the username of the 'node' user to 'developer'
RUN sed -i 's/^node:/developer:/' /etc/passwd

# Also change the name of the user's group if necessary
RUN sed -i 's/^node:/developer:/' /etc/group

# Yes, hacky indeed, but need the UID/GID 1000
RUN mv /home/node /home/developer

# Create the sudoers.d directory and grant the user sudo privileges
RUN mkdir -p /etc/sudoers.d && \
    echo 'developer ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer

# Install dependencies required for node-gyp, kerberos, and other tools
RUN apk add --no-cache \
    git \
    libc6-compat \
    libstdc++ \
    python3 \
    make \
    g++ \
    sudo \
    krb5-dev

# Install node-gyp globally using npm
RUN npm install -g node-gyp

# Ensure global npm binaries are in the PATH
ENV PATH="/usr/local/share/.config/yarn/global/node_modules/.bin:${PATH}"

# Install code-server globally
RUN yarn global add code-server

# Set the code-server data directory
ENV SERVICE_URL=https://open-vsx.org/vscode/gallery
ENV ITEM_URL=https://open-vsx.org/vscode/item

# Expose the code-server port
EXPOSE 7682

# Set the default command to run code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:7682", "--auth", "none"]
