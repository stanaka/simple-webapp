FROM ubuntu:12.04
RUN apt-get update && apt-get -y install ruby1.9.3 curl unzip
#RUN curl -L -o /tmp/mackerel-agent_latest.all.deb http://file.mackerel.io/agent/deb/mackerel-agent_latest.all.deb && dpkg -i /tmp/mackerel-agent_latest.all.deb
#RUN curl -L -o /tmp/serf.zip https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip && unzip -d /usr/bin /tmp/serf.zip
RUN gem install bundler
#RUN gem install mackerel-client
ADD . /src
RUN cd /src && bundle install
EXPOSE 4567
WORKDIR /src
#CMD echo APIKEY=\"$APIKEY\" > /etc/default/mackerel-agent && echo OTHER_OPTS="-role=sample:${ROLE:-app2}" >> /etc/default/mackerel-agent && /etc/init.d/mackerel-agent start && env MACKEREL_APIKEY=$APIKEY mkr host status --host-id `cat /var/lib/mackerel-agent/id` --status working && rackup -p4567
# CMD echo OTHER_OPTS="-role=sample:${ROLE:-app}" >> /etc/default/mackerel-agent && /etc/init.d/mackerel-agent start && sleep 3 && ./mackerel-update-status.sh standby && rackup -p4567
# CMD /etc/init.d/mackerel-agent start && (/usr/bin/serf agent -event-handler=/src/serf-handler.sh -log-level=debug &) ; rackup -p4567
# CMD /etc/init.d/mackerel-agent start
#CMD ["rackup", "-p4567"]
CMD cd /src && rackup -p4567
#
