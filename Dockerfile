FROM node:6-alpine

RUN apk add --no-cache  \
        build-base \
        python \
        git

RUN git clone https://github.com/exsilium/cloud9.git
WORKDIR /cloud9
RUN npm install
VOLUME /workspace
EXPOSE 3131

CMD ["bin/cloud9.sh", "-w", "/workspace", "-l", "0.0.0.0"]
