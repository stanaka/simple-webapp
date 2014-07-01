FROM ubuntu:12.04
RUN apt-get update
RUN apt-get -y install ruby1.9.3
RUN apt-get -y install curl unzip
RUN curl -u mackerel:saba3 https://mackerel.io/assets/files/agents/mackerel-agent_0.3.0-2_all.deb -o mackerel-agent_0.3.0-2_all.deb && dpkg -i mackerel-agent_0.3.0-2_all.deb
RUN curl -L -o /tmp/serf.zip https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip
RUN unzip -d /usr/bin /tmp/serf.zip
RUN gem install bundler
ADD . /src
RUN cd /src && bundle install
EXPOSE 4567
WORKDIR /src
CMD echo OTHER_OPTS="-role=sample:${ROLE:-app}" >> /etc/default/mackerel-agent && /etc/init.d/mackerel-agent start && sleep 3 && sudo chmod 755 /var/lib/mackerel-agent/ && ./mackerel-update-status.sh standby && rackup -p4567
# CMD /etc/init.d/mackerel-agent start && (/usr/bin/serf agent -event-handler=/src/serf-handler.sh -log-level=debug &) ; rackup -p4567
# CMD /etc/init.d/mackerel-agent start
# CMD ["rackup", "-p4567"]
