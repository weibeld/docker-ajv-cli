FROM node:18.2.0-alpine3.15
RUN npm install -g ajv-cli@5.0.0 ajv-formats@2.1.1
CMD ["sh"]
