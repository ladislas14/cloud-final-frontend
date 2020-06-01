FROM node:12-alpine

WORKDIR /app

ADD package.json /app/package.json

RUN npm config set registry http://registry.npmjs.org

RUN npm install

ADD . /app

RUN npm run build

# expose 5000 on container
EXPOSE 80

# set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0
# set app port
ENV NUXT_PORT=80

CMD ["npm", "run", "start"].