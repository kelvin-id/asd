# Use the official Alpine-based Node image as a starting point
FROM node:18-alpine

# Metadata as described by the OCI image spec
LABEL org.opencontainers.image.title="Alpine code-server" \
      org.opencontainers.image.description="VS Code running on Alpine with code-server" \
      org.opencontainers.image.source="https://github.com/coder/code-server"

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

# Remove user node so we can use UID:1000
RUN deluser node

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

# Set the default command to run code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:7682", "--auth", "none"]
