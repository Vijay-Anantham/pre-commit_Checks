FROM jenkins/inbound-agent:latest

# Set user to root to install additional tools
USER root

# Install desired tools, utilities, and dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    # Add any other tools you might need for your builds, for example:
    # build-essential \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# If you need to install Docker (to run Docker commands within this agent, which requires Docker-out-of-Docker setup):
# RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# Drop back to the Jenkins user
USER jenkins

# Set the entrypoint (optional, as the base image already includes an entrypoint)
ENTRYPOINT ["jenkins-agent"]