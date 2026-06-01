FROM node:20-alpine as build
WORKDIR /app

COPY package.json ./
# Minimal setup; lockfile not provided in this scaffold
RUN npm install --no-audit --no-fund

COPY src ./src
RUN npm run build

FROM nginx:1.27-alpine
# Non-root nginx is not default; keep container hardened via k8s securityContext.
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 3000

