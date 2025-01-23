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

