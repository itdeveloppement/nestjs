# Multi-staging

Transformer un projet NestJS en multi-staging

## Objectifs pédagogiques

- Appliquer les principes de multi-staging

## Etapes

- Créer un projet NestJS à partir d'un template :

```bash  
npm i -g @nestjs/cli
nest new project-name
```

- Créer un Dockerfile sans multi-staging pour le faire fonctionner en local
- Créer un Dockerfile avec multi-staging pour le faire fonctionner en production (build + serve)
- Réunir les deux Dockerfile en un seul grace au multi-staging
- Comparer les statistiques des images avec [Dive](https://github.com/wagoodman/dive)


## Prés-requis

- Docker et docker compose installé en local

## NestJS

NestJS est un framework Node.js progressif conçu pour créer des applications côté serveur efficaces, fiables et évolutives. Il est développé avec TypeScript (tout en prenant également en charge JavaScript) et s'inspire fortement de l'architecture d'Angular, ce qui en fait un excellent choix pour les développeurs déjà familiers avec le système de modules et d'injection de dépendances d'Angular.

Instal 
npm install -g @nestjs/cli      -> instal
nest -v                         -> verifi que l installation est installer
nest new mon-projet             -> créer un nouveau projet
npm run start:dev               -> démarrer le serveur en mode développement (avec rechargement automatique à chaque modification)
npm run build                   -> Compiler en production


## Structure du projet NestJS sous forme d'arborescence
.vscode
nestjs-app/
    ├── node_modules/              # Dépendances installées
    ├── dist/                      # Fichiers compilés en JavaScript
    ├── src/                       # Code source de l'application
    │   ├── app.controller.ts
    │   ├── app.service.ts
    │   ├── app.module.ts
    │   └── main.ts
    ├── test/                      # Tests unitaires
    ├── package.json               # Dépendances et scripts NPM
    ├── tsconfig.json              # Configuration TypeScript
    ├── .eslintrc.js               # Configuration ESLint
    ├── .prettierrc                # Configuration Prettier
    ├── .gitignore                 # Fichiers à ignorer par Git
    ├── .dockerignore              # Fichiers à ignorer par Docker (à ajouter ici)
    ├── docker-compose.yml         # Configuration Docker Compose
├── Dockerfile                 # Dockerfile
├── README.md                  # Documentation du projet


## NestJS avec docker compose

Dockerfile
1. From image node (base)
   1. definir l'espace de taravail
   2. integrer les dependance packet.json
   3. Lancer installation
2. From base as dev
   1. copier les fichiers de l'espace de travail vers ele conteneur
   2. lancer la commande npm / run start sur dev
3. Build
   1. copier les fichiers de l espace de travail vers le conteneur
   2. lancer le build
4. From image node alpine (prod)
   1. Definir l espace de travail
   2. copier les fichiers builder en local dans .dist dans le conteneur
   3. commande demarrer l'appplication

Docker compose


Commandes

Pour construire l'image
    docker build -t nestjs-app .                -> a executer dans le dossier ou se trouve le dockerfile
    docker build --target dev .                 -> a executer dans le dossier ou se trouve le dockerfile pour construire l image de dev

Démarrer le container
    docker-compose up                           -> a executer au niveau du docker compose
