# 🏠 Moving App

Une application web pour gérer facilement vos cartons de déménagement. Cette application offre une interface simple et intuitive pour créer, organiser et rechercher des cartons, avec des fonctionnalités comme des QR codes, l'ajout de photos et une authentification sécurisée.

---

## 📖 Description

**Moving App** vous aide à organiser vos cartons lors d'un déménagement en :
- Créant des cartons avec des informations détaillées comme le contenu, la pièce d'origine et le lieu de stockage.
- Générant des QR codes pour chaque carton, ce qui facilite leur suivi.
- Permettant une recherche dynamique pour localiser rapidement un carton.
- Authentifiant les utilisateurs pour garantir la sécurité des données.

---

## 🛠️ Technologies Utilisées

### **Frontend :**
- **Vue.js** : Framework JavaScript pour construire l'interface utilisateur.
- **Vite** : Outil de développement rapide pour Vue.js.

### **Backend :**
- **Flask** : Framework Python pour créer des API RESTful.
- **Flask-SQLAlchemy** : ORM pour gérer la base de données.
- **Flask-Login** : Gestion de l'authentification utilisateur.
- **QRCode** : Génération de QR codes.
- **Gunicorn** : Serveur HTTP performant pour le backend.

### **Autres :**
- **Docker** : Conteneurisation des applications.
- **docker-compose** : Orchestration des conteneurs.

---

## ✨ Fonctionnalités Principales

1. **Authentification sécurisée** : Connexion et gestion des utilisateurs.
2. **Création de cartons** : 
   - Ajoutez un contenu, une pièce d'origine et un lieu de stockage.
   - Générez un QR code unique.
3. **Recherche dynamique** : Localisez rapidement un carton grâce à la recherche en temps réel.
4. **Organisation avancée** :
   - Ajoutez des photos pour mieux documenter les cartons.
   - Affichez tous les cartons dans une interface intuitive.

---

## 🚀 Installation et Démarrage

### 1️⃣ **Prérequis**
Assurez-vous d'avoir les outils suivants installés sur votre machine :
- **Docker** (version ≥ 20.x)
- **docker-compose** (version ≥ 1.29.x)

---

### 2️⃣ **Cloner le Projet**
Clonez ce dépôt sur votre machine locale :
```bash
git clone https://github.com/username/moving-app.git
cd moving-app

3️⃣ Structure du Projet

Le projet est divisé en deux parties :

    frontend/ : Le code de l'interface utilisateur (Vue.js).
    backend/ : L'API Flask pour la logique métier et la gestion des données.

4️⃣ Lancer les Conteneurs

Utilisez docker-compose pour construire et lancer l'application :

docker-compose up --build

5️⃣ Accéder à l'Application

    Frontend : http://localhost:3000
    Backend API : http://localhost:5000

🗂️ Structure du Projet

moving-app/
├── backend/         # API Flask (Backend)
│   ├── app/         # Dossier principal de l'application Flask
│   │   ├── static/         # Fichiers statiques (QR codes, uploads)
│   │   ├── __init__.py     # Initialisation Flask
│   │   ├── models.py       # Modèles pour les cartons et utilisateurs
│   │   ├── routes.py       # Endpoints de l'API
│   │   ├── utils.py        # Génération de QR Codes et utilitaires
│   └── wsgi.py             # Point d'entrée pour le serveur Flask
├── frontend/        # Application Vue.js (Frontend)
│   ├── public/             # Fichiers publics (index.html, favicon)
│   ├── src/                # Code source Vue.js
│   │   ├── assets/         # Styles/CSS
│   │   ├── components/     # Composants Vue.js
│   │   ├── views/          # Pages (Home, Create Box, etc.)
│   │   ├── App.vue         # Entrée Vue.js
│   │   └── main.js         # Point d'entrée Vue.js
├── docker-compose.yml       # Orchestration des conteneurs
└── README.md                # Documentation du projet

📸 Captures d'Écran (Facultatif)

Ajoutez ici des captures d'écran de l'interface utilisateur pour illustrer les fonctionnalités.
📋 Commandes Utiles
Backend

    Lancer le backend localement :

    cd backend
    flask run

Frontend

    Lancer le frontend localement :

    cd frontend
    npm install
    npm run dev

Docker

    Reconstruire les conteneurs :

    docker-compose up --build

🧑‍💻 Contribuer

Les contributions sont les bienvenues ! Suivez ces étapes pour contribuer :

    Fork le projet.
    Créez une branche pour votre fonctionnalité :

    git checkout -b feature/ma-fonctionnalite

    Faites vos changements et soumettez un PR.

📜 Licence

Ce projet est sous licence MIT. Vous êtes libre de l'utiliser, de le modifier et de le partager.
🤝 Remerciements

Merci d'utiliser Moving App ! N'hésitez pas à partager vos retours ou vos idées pour améliorer le projet.


---

### **Personnalisation**
- Remplacez `https://github.com/username/moving-app.git` par l'URL réelle du dépôt GitHub si nécessaire.
- Ajoutez des captures d'écran si vous le souhaitez pour illustrer les fonctionnalités.

Besoin d'autres sections ou précisions ? 😊
