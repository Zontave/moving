#!/bin/bash

# Créer la structure du projet
echo "Création de la structure du projet..."

# Dossiers du frontend
mkdir -p project/frontend/src/components
mkdir -p project/frontend/public
mkdir -p project/frontend/public/uploads

# Dossiers du backend
mkdir -p project/backend/app/static/uploads
mkdir -p project/backend/app
mkdir -p project/backend

# Créer tous les fichiers du frontend
echo "Création des fichiers du frontend..."
cat <<EOL > project/frontend/package.json
{
  "name": "moving-app-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "qrcode.react": "^1.0.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  }
}
EOL

cat <<EOL > project/frontend/src/index.js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import './styles.css';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
EOL

cat <<EOL > project/frontend/src/App.js
import React, { useState } from 'react';
import BoxForm from './components/BoxForm';
import BoxList from './components/BoxList';
import './styles.css';

const App = () => {
  const [boxes, setBoxes] = useState([]);

  const addBox = (box) => {
    setBoxes([...boxes, box]);
  };

  return (
    <div className="app">
      <h1>Gestion des cartons</h1>
      <BoxForm addBox={addBox} />
      <BoxList boxes={boxes} />
    </div>
  );
};

export default App;
EOL

cat <<EOL > project/frontend/src/components/BoxForm.js
import React, { useState } from 'react';

const BoxForm = ({ addBox }) => {
  const [content, setContent] = useState('');
  const [originRoom, setOriginRoom] = useState('');
  const [storageLocation, setStorageLocation] = useState('');
  const [photos, setPhotos] = useState(null);

  const handleSubmit = (e) => {
    e.preventDefault();

    const newBox = {
      id: Date.now(),
      content,
      originRoom,
      storageLocation,
      creationDate: new Date().toLocaleString(),
      photos: photos ? URL.createObjectURL(photos) : '',
    };

    addBox(newBox);
    setContent('');
    setOriginRoom('');
    setStorageLocation('');
    setPhotos(null);
  };

  return (
    <form className="box-form" onSubmit={handleSubmit}>
      <h2>Ajouter un carton</h2>
      <input
        type="text"
        placeholder="Contenu"
        value={content}
        onChange={(e) => setContent(e.target.value)}
        required
      />
      <input
        type="text"
        placeholder="Pièce d'origine"
        value={originRoom}
        onChange={(e) => setOriginRoom(e.target.value)}
        required
      />
      <input
        type="text"
        placeholder="Lieu de stockage"
        value={storageLocation}
        onChange={(e) => setStorageLocation(e.target.value)}
        required
      />
      <input
        type="file"
        onChange={(e) => setPhotos(e.target.files[0])}
      />
      <button type="submit">Ajouter</button>
    </form>
  );
};

export default BoxForm;
EOL

cat <<EOL > project/frontend/src/components/BoxList.js
import React, { useState } from 'react';
import QRCodeLabel from './QRCodeLabel';

const BoxList = ({ boxes }) => {
  const [searchTerm, setSearchTerm] = useState('');

  const filteredBoxes = boxes.filter((box) =>
    box.content.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="box-list">
      <h2>Liste des cartons</h2>
      <input
        type="text"
        placeholder="Rechercher un carton..."
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
      />
      <div className="box-table">
        {filteredBoxes.map((box) => (
          <div key={box.id} className="box-item">
            <h3>Carton #{box.id}</h3>
            <p>Contenu : {box.content}</p>
            <p>Pièce d'origine : {box.originRoom}</p>
            <p>Lieu de stockage : {box.storageLocation}</p>
            <p>Date de création : {box.creationDate}</p>
            {box.photos && <img src={box.photos} alt="Carton" />}
            <QRCodeLabel id={box.id} content={box.content} />
          </div>
        ))}
      </div>
    </div>
  );
};

export default BoxList;
EOL

cat <<EOL > project/frontend/src/components/QRCodeLabel.js
import React from 'react';
import QRCode from 'qrcode.react';

const QRCodeLabel = ({ id, content }) => {
  return (
    <div className="qr-code-label">
      <QRCode value={`Carton ID: ${id}, Contenu: ${content}`} size={128} />
      <p>Carton #{id}</p>
    </div>
  );
};

export default QRCodeLabel;
EOL

cat <<EOL > project/frontend/src/styles.css
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  background-color: #f9f9f9;
  color: #333;
}

.app {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

h1 {
  text-align: center;
  color: #4CAF50;
}

form, .box-list {
  background: #fff;
  padding: 20px;
  margin: 20px 0;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

input[type="text"], input[type="file"] {
  width: 100%;
  padding: 10px;
  margin: 10px 0;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button {
  background-color: #4CAF50;
  color: white;
  border: none;
  padding: 10px 15px;
  cursor: pointer;
  border-radius: 4px;
}

button:hover {
  background-color: #45a049;
}

.box-item {
  border: 1px solid #ddd;
  padding: 10px;
  margin: 10px 0;
  border-radius: 4px;
}

.qr-code-label {
  display: inline-block;
  text-align: center;
  margin-top: 10px;
}
EOL

# Créer tous les fichiers du backend
echo "Création des fichiers du backend..."
cat <<EOL > project/backend/requirements.txt
Flask==2.2.2
Flask-SQLAlchemy==3.0.1
Flask-Cors==3.0.10
psycopg2-binary==2.9.6
qrcode==7.4.2
EOL

cat <<EOL > project/backend/manage.py
from app import create_app, db
from app.models import Box

app = create_app()

@app.cli.command('create-db')
def create_db():
    """Créer la base de données."""
    db.create_all()
    print("Base de données créée avec succès.")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
EOL

cat <<EOL > project/backend/app/__init__.py
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)

    # Configuration de la base de données
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:password@db:5432/moving_app'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    # Initialisation des extensions
    db.init_app(app)
    CORS(app)

    # Enregistrement des routes
    from .routes import bp as api_bp
    app.register_blueprint(api_bp, url_prefix='/api')

    return app
EOL

cat <<EOL > project/backend/app/models.py
from . import db
from datetime import datetime

class Box(db.Model):
    __tablename__ = 'boxes'

    id = db.Column(db.Integer, primary_key=True)
    creation_date = db.Column(db.DateTime, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    origin_room = db.Column(db.String(100), nullable=False)
    storage_location = db.Column(db.String(100), nullable=False)
    photos = db.Column(db.Text)  # Stocke le chemin ou l'URL des photos
    qr_code = db.Column(db.Text)  # Chemin vers l'image du QR Code
EOL

cat <<EOL > project/backend/app/routes.py
from flask import Blueprint, request, jsonify
from . import db
from .models import Box
from .utils import generate_qr_code
import os

bp = Blueprint('api', __name__)

UPLOAD_FOLDER = 'app/static/uploads'

@bp.route('/boxes', methods=['GET'])
def get_boxes():
    """Récupérer tous les cartons."""
    boxes = Box.query.all()
    return jsonify([{
        'id': box.id,
        'creation_date': box.creation_date,
        'content': box.content,
        'origin_room': box.origin_room,
        'storage_location': box.storage_location,
        'photos': box.photos,
        'qr_code': box.qr_code,
    } for box in boxes])

@bp.route('/boxes', methods=['POST'])
def add_box():
    """Créer un nouveau carton."""
    data = request.form
    file = request.files.get('photo')

    # Sauvegarder la photo si elle existe
    photo_path = None
    if file:
        photo_path = os.path.join(UPLOAD_FOLDER, file.filename)
        file.save(photo_path)

    # Générer un QR code
    qr_code_path = generate_qr_code(data['content'])

    # Créer le carton
    new_box = Box(
        content=data['content'],
        origin_room=data['origin_room'],
        storage_location=data['storage_location'],
        photos=photo_path,
        qr_code=qr_code_path
    )
    db.session.add(new_box)
    db.session.commit()

    return jsonify({'message': 'Carton créé avec succès.'}), 201

@bp.route('/boxes/<int:id>', methods=['DELETE'])
def delete_box(id):
    """Supprimer un carton."""
    box = Box.query.get(id)
    if not box:
        return jsonify({'error': 'Carton non trouvé'}), 404

    db.session.delete(box)
    db.session.commit()
    return jsonify({'message': 'Carton supprimé avec succès.'})
EOL

cat <<EOL > project/backend/app/utils.py
import qrcode
import os

def generate_qr_code(content):
    """Générer un QR Code pour un contenu donné."""
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(content)
    qr.make(fit=True)

    # Chemin pour sauvegarder le QR Code
    qr_code_path = f'app/static/uploads/{content}_qr.png'
    qr_code_image = qr.make_image(fill_color="black", back_color="white")
    qr_code_image.save(qr_code_path)

    return qr_code_path
EOL

cat <<EOL > project/backend/Dockerfile.backend
# Utiliser une image Python légère
FROM python:3.11-slim

# Définir le dossier de travail
WORKDIR /app

# Copier les fichiers nécessaires
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Exposer le port
EXPOSE 8000

# Commande de démarrage
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
EOL

cat <<EOL > project/backend/README.md
# Backend - Moving App

## Installation locale
1. Créez un environnement virtuel :
   ```bash
   python -m venv venv
   source venv/bin/activate
