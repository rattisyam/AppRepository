FROM node

RUN apt-get update && apt-get upgrade -y \
    && apt-get clean

ADD . .
#RUN mkdir /app
#WORKDIR /app

#COPY package.json /app/
RUN npm install

EXPOSE 3000

CMD [ "npm", "start" ]
