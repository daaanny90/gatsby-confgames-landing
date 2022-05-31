FROM node as builder

WORKDIR /

COPY package.json .
RUN apt-get update || : && apt-get install python -y
RUN npm install
COPY . .
RUN ["npm", "run", "build"]

FROM nginx
EXPOSE 80
COPY --from=builder /public /usr/share/nginx/html