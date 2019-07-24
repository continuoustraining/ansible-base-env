FROM node:10
WORKDIR /usr/src/app
COPY package*.json ./
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN npm install
RUN apt update && apt install -y ssh
RUN mkdir -p /var/run/sshd
COPY . .
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
CMD ["node", "server.js"]

