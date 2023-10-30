# Use Debian Slim as the base image
FROM linuxcontainers/debian-slim:latest

# Install curl, git, build-essential, python3, cmake, and libssl-dev
RUN apt-get update && \
    apt-get install -y curl git build-essential python3 cmake libssl-dev

# Install nvm (Node Version Manager)
ENV NVM_DIR /root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Source nvm in bash profile so it's available in subsequent RUN commands
RUN echo 'source $NVM_DIR/nvm.sh' >> ~/.bashrc

# Install Node.js v20.8.0 using nvm
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install 20.8.0 && nvm alias default 20.8.0 && nvm use default"

# Clone httptoolkit-server repository
RUN git clone https://github.com/httptoolkit/httptoolkit-server.git

# Change the working directory to the cloned repository
WORKDIR httptoolkit-server

# Install httptoolkit-server using npm
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && npm install"

# Expose necessary ports
EXPOSE 45456

# Command to run httptoolkit-server
CMD ["/bin/bash", "-c", "source $NVM_DIR/nvm.sh && npm start"]
