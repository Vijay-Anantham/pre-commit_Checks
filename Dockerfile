# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Update and install basic Linux utilities
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    openjdk-8-jdk \
    pip

# Make port 80 available to the world outside this container
EXPOSE 2468

# Run a basic command when the container launches
CMD ["echo", "The docker worker is running"]