# Use Python 2.7 Slim
FROM python:2.7-slim

# Update Repos
RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends build-essential sudo git wget curl nmap ruby \
  && apt-get clean

# Install Python dependecies
RUN pip install requests

# Install poison
RUN git clone https://github.com/anonp0ison/poison.git \
  && cd poison \
  && chmod +x install.sh \
  && ./install.sh

# Change workdir
WORKDIR /root/.poison/

# Hack to keep the container running
CMD python -c "import signal; signal.pause()"
