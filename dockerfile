FROM node:lts AS build
WORKDIR /frontend
COPY package*.json ./
RUN npm install
RUN npx ngcc --properties es2023 browser module main --first-only --create-ivy-entry-points
COPY . .
RUN npm run build
FROM nginx:stable
COPY --from=build /frontend/dist/frontend/browser/ /usr/share/nginx/html
EXPOSE 80
