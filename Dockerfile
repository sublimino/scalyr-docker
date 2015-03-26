FROM debian:latest

RUN \
    apt-get update && \
    apt-get -y install apt-transport-https wget procps && \
    cd /tmp && \
    wget --no-check-certificate https://www.scalyr.com/scalyr-repo/stable/latest/install-scalyr-agent-2.sh

ENV SCALYR_API_KEY your-key-here

RUN \
    cd /tmp && \
    bash ./install-scalyr-agent-2.sh --set-api-key "${SCALYR_API_KEY}" && \
    chown daemon:daemon /etc/scalyr-agent-2 /var/log/scalyr-agent-2 /var/lib/scalyr-agent-2 -R && \
    sed "/logs: \[/a\\\t{ path: \"/var/log/host/journal\", attributes: {parser: \"systemLog\"} }" -i /etc/scalyr-agent-2/agent.json && \
    cat /etc/scalyr-agent-2/agent.json

USER daemon

CMD ["scalyr-agent-2", "--verbose", "--no-fork", "start"]
