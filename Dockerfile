# Build image with name (tag) gcat-blockcodes-demo:
# $ docker build --tag gcat-blockcodes-demo .
# Run image in container: 
# $ docker run -p 8042:8042 gcat-blockcodes-demo
# The app will keep running until it is stopped with: $ docker stop gcat-blockcodes-demo
# Use web app in browser:
# http://<ip-address>:8042/StrongC3

# Tip: docker installation on Ubuntu: 
# https://linux.how2shout.com/use-snap-to-install-docker-on-ubuntu-24-04-lts-linux/#google_vignette	

# Take this image for Julia:
FROM julia:1.12.6-trixie

# My stuff:
RUN mkdir /usr/local/bioblockcodes
RUN mkdir /usr/local/bioblockcodes/src

# Important: apparently docker only sees files in the build directory.	
COPY Project.toml /usr/local/bioblockcodes
COPY *.sh /usr/local/bioblockcodes
COPY src/*.jl /usr/local/bioblockcodes/src

RUN chmod +x /usr/local/bioblockcodes/intro_docker.sh

# Build the Julia project (install packages etc.). Takes a while.
RUN julia --project=/usr/local/bioblockcodes /usr/local/bioblockcodes/src/StrongC3InitDocker.jl

EXPOSE 8042
CMD ["/usr/local/bioblockcodes/intro_docker.sh"]
