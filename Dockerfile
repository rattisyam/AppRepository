FROM node

RUN apt-get update && apt-get upgrade -y \
    && apt-get clean

ADD . /app
#RUN mkdir /app
WORKDIR /app

#COPY package.json /app/
RUN npm install

EXPOSE 3000

CMD [ "nodejs", "./index.js" ]
