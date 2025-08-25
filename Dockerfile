FROM python:3.10-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y sshpass openssh-client git sudo curl && \
    pip install ansible ansible-lint && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /ansible

# Entrypoint script to run any playbook dynamically
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD ansible-playbook --version || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
