FROM cimg/node:24.13-browsers

RUN sudo apt-get -o Acquire::AllowInsecureRepositories=true update && \
    sudo apt-get --allow-unauthenticated install -y zstd xvfb
# Install corepack and yarn
RUN sudo corepack enable && sudo corepack prepare yarn@4.10.3 --activate
