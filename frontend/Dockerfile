FROM node:20-alpine as build
WORKDIR /app

# Install dependencies
COPY package.json ./
# If package-lock.json exists, install with it; otherwise npm will fall back to package.json
COPY package-lock.json* ./
RUN npm ci --no-audit --no-fund || npm install --no-audit --no-fund

# Copy the full React app (CRA requires public/index.html)
COPY public ./public
COPY src ./src
RUN npm run build


FROM nginx:1.27-alpine
# Non-root nginx is not default; keep container hardened via k8s securityContext.
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 3000

