# Works on Linux, macOS (Intel and Apple Silicon) and Windows (Docker Desktop).
# The commands below are identical in bash, zsh, PowerShell and cmd.
#
# Build image with name (tag) gcat-blockcodes-demo:
# $ docker build --tag gcat-blockcodes-demo .
# Run image in container:
# $ docker run --rm --name gcat-blockcodes-demo -p 8042:8042 gcat-blockcodes-demo
# The app will keep running until it is stopped with: $ docker stop gcat-blockcodes-demo
# Use web app in browser:
# http://localhost:8042/StrongC3 (or http://<ip-address>:8042/StrongC3 from another machine)
#
# Publish a multi-platform image (x86-64 and ARM64, e.g. Apple Silicon) to Docker Hub:
# $ docker buildx build --platform linux/amd64,linux/arm64 --tag cammbio/gcat-blockcodes-demo:latest --push .

# Tip: docker installation on Ubuntu:
# https://linux.how2shout.com/use-snap-to-install-docker-on-ubuntu-24-04-lts-linux/#google_vignette

# Take this image for Julia (official multi-arch image: linux/amd64 and linux/arm64):
FROM julia:1.13.2-trixie

# My stuff:
WORKDIR /usr/local/bioblockcodes

# Important: apparently docker only sees files in the build directory.
COPY Project.toml ./
COPY src/*.jl ./src/

# Build the Julia project (install packages etc.). Takes a while.
RUN julia --project=. src/StrongC3InitDocker.jl

EXPOSE 8042
# Julia is started directly (no shell script), so Windows line endings (CRLF)
# or missing executable bits from a Windows checkout cannot break the container.
# Optional arguments (host, port) can be appended to "docker run ... gcat-blockcodes-demo".
ENTRYPOINT ["julia", "--project=.", "src/StrongC3Prod.jl"]
CMD ["0.0.0.0", "8042"]
