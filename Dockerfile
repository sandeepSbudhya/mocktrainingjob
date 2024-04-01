FROM ubuntu:latest

WORKDIR /app

RUN mkdir sendmessages
RUN apt-get -y update
RUN apt-get -y install curl

ADD sendmessages sendmessages

RUN chmod +x /app/sendmessages/sendMessage.sh
RUN chmod +x /app/sendmessages/sendMessageToKafka.sh

ENTRYPOINT ["/bin/bash","./sendmessages/sendMessage.sh"]