# --- installation des dépendances ---
# Copier l'application et installer les dépendances

# Utilisation de l'image Node.js 18 comme base pour les étapes suivantes
FROM node:18 AS base                  
WORKDIR /app     # Définir le répertoire de travail dans le conteneur

# Copier seulement le fichier package.json pour l'installation des dépendances
COPY package.json ./ 

# Installer les dépendances nécessaires en utilisant npm
RUN npm install                    

# --- développement ---
# Démarrer un environnement de développement

FROM base AS dev
# Copier tous les fichiers du projet dans le conteneur pour le développement
COPY ./ ./                           

# Exécuter la commande pour démarrer le serveur en mode développement
CMD ["npm", "run", "start:dev"]    

# --- compilation ---
# Créer le build du projet

FROM base AS build
# Copier le code source dans le conteneur pour la compilation
COPY ./ ./   

# Exécuter la commande pour créer le build de production
RUN npm run build                  

# --- production ---
# Préparer l'environnement de production

# Utiliser une version plus légère de l'image Node.js (basée sur Alpine) pour la production
FROM node:18-alpine AS prod
WORKDIR /app

# Copier les fichiers compilés depuis l'étape build dans le conteneur de production
COPY --from=build /app/dist ./dist

# Copier le fichier package.json de l'étape de base pour pouvoir installer les dépendances
COPY --from=base /app/package.json ./ 

# Installer uniquement les dépendances nécessaires pour la production
RUN npm install --production

# Commande pour démarrer l'application en production
CMD ["node", "dist/main"]
