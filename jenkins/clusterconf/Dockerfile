FROM jenkins/inbound-agent:latest

# Set user to root to install additional tools
USER root
RUN apk add --no-cache \
    git \
    curl \
    zip \
    python3 \
    py3-pip \
    python3-venv \
    && pip3 install --upgrade pip

# Install additional packages for testing and linting (replace with your specific packages)
RUN pip3 install pytest flake8
# Install desired tools, utilities, and dependencies
# RUN apt-get update && apt-get install -y \
#     git \
#     curl \
#     zip \
#     # Add any other tools you might need for your builds, for example:
#     # build-essential \
#     python3 \
#     python3-pip \
#     python3-venv \
#     && rm -rf /var/lib/apt/lists/*

# Create and activate a virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install required Python packages
RUN pip install pytest flake8
# Install flake8
# RUN pip3 install pytest bazel flake8 --verbose

# If you need to install Docker (to run Docker commands within this agent, which requires Docker-out-of-Docker setup):
# RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# If you need to install Docker (to run Docker commands within this agent, which requires Docker-out-of-Docker setup):
# RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# Drop back to the Jenkins user
USER jenkins

# Set the entrypoint (optional, as the base image already includes an entrypoint)
ENTRYPOINT ["jenkins-agent"]