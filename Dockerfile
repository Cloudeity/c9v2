FROM node:6-alpine

RUN apk add --no-cache  \
        build-base \
        python \
        git

# Add a ec2-user user so that we we are not running as root
RUN addgroup ec2-user && \
    adduser -D -u 1000 ec2-user && \
    usermod -a -G ec2-user root && \
    echo 'ec2-user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    
RUN git clone https://github.com/exsilium/cloud9.git && \
    chown -R ec2-user /cloud9
WORKDIR /cloud9
RUN npm install
USER ec2-user
VOLUME /workspace
EXPOSE 3131

CMD ["bin/cloud9.sh", "-w", "/workspace", "-l", "0.0.0.0"]
