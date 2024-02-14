# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Set the working directory in the container to /app
WORKDIR /app

# Run a basic command when the container launches
CMD ["echo", "The docker worker is running"]