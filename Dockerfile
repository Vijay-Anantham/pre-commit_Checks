# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set the working directory in the container to /app
WORKDIR /app

# Update and install basic Linux utilities
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    pip \
    python3

RUN python3 --version

# Make port 80 available to the world outside this container
EXPOSE 2468

# Run a basic command when the container launches
CMD ["echo", "The docker worker is running"]