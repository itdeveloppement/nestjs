# Image Node

# --- installation des dépendances ---

# Utilisation de l'image Node.js 18
FROM node:18 AS base                  
WORKDIR /app     
COPY package.json ./ 
RUN npm install                    

# --- développement ---

FROM base AS dev
# Copie de tous les fichiers du projet
COPY ./ ./                           
CMD ["npm", "run", "start:dev"]    

# --- compilation ---

FROM base AS build
# Copie du code source
COPY ./ ./   
RUN npm run build                  

# --- prodyction ---

FROM node:18-alpine AS prod
WORKDIR /app
# Copie des fichiers compilés de l'étape build
COPY --from=build /app/dist ./dist
# Copie du package.json
COPY --from=base /app/package.json ./ 
# Installation des dépendances de prod uniquement
RUN npm install --production
CMD ["node", "dist/main"]