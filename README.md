# moving
App de déménagement avec frontend et backend

Sous Ubuntu 24, configuration du système :

Étape 1 : Installer les dépendances système

# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Installer Docker et Docker Compose
sudo apt install -y docker.io docker-compose

# Installer les dépendances supplémentaires pour Python et QR Code
sudo apt install -y python3 python3-pip libpq-dev python3-dev build-essential libjpeg-dev zlib1g-dev

# Installer Tailscale pour sécuriser l'accès au serveur (si nécessaire)
curl -fsSL https://tailscale.com/install.sh | sh

# Ajouter votre utilisateur au groupe Docker
sudo usermod -aG docker $USER

Redémarrez votre session pour que les modifications prennent effet.
Étape 2 : Organisation et synchronisation du projet

    Créer les dossiers nécessaires :

    mkdir -p ~/projects/moving && cd ~/projects/moving

    Naviguer vers le dossier cloné : Supposons que votre projet est déjà cloné dans ~/projects/moving.

Étape 3 : Configurer Docker pour l’application

Créez un fichier Dockerfile pour construire l’image de l’application web :

# Utiliser une image Python
FROM python:3.9-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Exposer le port de l'application (exemple : 8000)
EXPOSE 8000

# Commande pour lancer l'application
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

Ajoutez un fichier docker-compose.yml :

version: '3.9'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/app
    environment:
      - DJANGO_SETTINGS_MODULE=moving.settings

Étape 4 : Installer les dépendances Python

Dans votre projet, créez un fichier requirements.txt avec les dépendances nécessaires (exemple pour Django) :

django
djangorestframework
django-qrcode
Pillow

Ensuite, construisez l’image Docker :

docker-compose build
docker-compose up -d

Plan général

    Technologies principales à utiliser :
        Backend : Python avec FastAPI ou Django pour une API rapide et sécurisée.
        Frontend : React.js ou Vue.js pour une interface dynamique.
        Base de données : PostgreSQL pour des fonctionnalités relationnelles avancées.
        Authentification sécurisée : JWT (JSON Web Token) pour la gestion des utilisateurs.
        Génération de QR Code : Bibliothèque Python comme qrcode ou équivalent pour le frontend.
        Docker : Conteneuriser l’application pour un déploiement facile.

    Fonctionnalités à implémenter :
        Gestion des cartons :
            Création d’un carton (avec date, contenu, pièce d’origine, lieu de stockage).
            Upload de photos pour chaque carton.
            Génération automatique de QR Code.
        Authentification :
            Inscription et connexion sécurisées avec JWT.
        Recherche dynamique :
            Un tableau avec des filtres en temps réel pour rechercher des cartons par contenu, pièce, etc.

Structure Dockerisée

Créons une image Docker pour tout cela.

    Fichiers nécessaires :
        Dockerfile : Instructions pour construire l’image.
        docker-compose.yml : Orchestration pour inclure base de données, backend et frontend.
        Code pour votre application.

Backend : Exemple avec FastAPI
Installation des dépendances

Créez un fichier requirements.txt avec les bibliothèques nécessaires :

fastapi
uvicorn
sqlalchemy
databases
psycopg2-binary
pillow
python-jose[cryptography]
passlib[bcrypt]
qrcode

Points clés du backend

    Authentification JWT : Implémentez des endpoints pour inscrire et connecter les utilisateurs avec des tokens JWT.

Frontend avec React.js
Points clés :

    Authentification : Utiliser un gestionnaire de state (comme Redux) pour stocker le JWT.
    Tableau dynamique : Utiliser une librairie comme DataGrid de Material-UI.
    Uploader des photos : Intégrer un champ de téléchargement d’images.
    Scan QR Code (optionnel) : Ajouter une librairie comme react-qr-reader pour scanner les QR codes.

Étapes finales

    Construisez les images Docker :

docker-compose build

Démarrez les conteneurs :

docker-compose up

Accédez à :

    Frontend : http://localhost:3000
    Backend : http://localhost:8000/docs (Swagger auto-généré)
