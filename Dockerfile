# Image Node

# --- Étape de base : installation des dépendances ---

# Utilisation de l'image Node.js 18
FROM node:18 AS base 
# Définition du répertoire de travail                  
WORKDIR /app     
# Copie des fichiers package.json et package-lock.json
COPY package.json ./ 
# Installation des dépendances
RUN npm install                    

# --- Étape de développement ---

FROM base AS dev
# Copie de tous les fichiers du projet
COPY . .                           
CMD ["npm", "run", "start:dev"]    

# --- Étape de build : compilation du projet ---

FROM base AS build
# Copie du code source
COPY . .   
# Compilation du projet NestJS
RUN npm run build                  

# --- Étape de production : image optimisée ---

# Utilisation d'une image légère pour la prod
FROM node:18-alpine AS prod
# Définition du répertoire de travail
WORKDIR /app
# Copie des fichiers compilés de l'étape build
COPY --from=build /app/dist ./dist
# Copie du package.json et package-lock.json (pour installer les dépendances en production)
COPY --from=base /app/package.json ./ 
# Installation des dépendances de prod uniquement
RUN npm install --production
# Démarrage de l'application en mode production
CMD ["node", "dist/main"]