FROM node
MAINTAINER Robert Brem <brem_robert@hotmail.com>

RUN npm install -g bower
RUN useradd -ms /bin/bash node

RUN mkdir /usr/src/app
RUN cd /usr/src/app
WORKDIR /usr/src/app
RUN chown -R node /usr/src

USER node

EXPOSE 8000

CMD ["npm", "start"]