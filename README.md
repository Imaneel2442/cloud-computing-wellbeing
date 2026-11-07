# Wellbeing App

Application Rails de bien-être : activités, réservations, dashboard utilisateur.

- **Ruby** 3.2 · **Rails** 7.1 · **PostgreSQL** · **Docker** · **Bootstrap 5**

---

## Lancement local (Docker Compose)

```bash
docker compose up --build
# Puis dans un autre terminal :
docker compose exec web rails db:create db:migrate db:seed
```

Accès : http://localhost:3000

---

## Déploiement sur Azure App Service (Container)

### Prérequis

- Azure CLI installé : `az login`
- Docker installé localement
- Un Azure Container Registry (ACR) créé

### 1. Variables d'environnement Azure à configurer

| Variable | Valeur |
|---|---|
| `DATABASE_URL` | `postgres://user:pass@host:5432/dbname` |
| `RAILS_MASTER_KEY` | Contenu du fichier `config/master.key` |
| `RAILS_ENV` | `production` |
| `RAILS_SERVE_STATIC_FILES` | `true` |

### 2. Build et push de l'image Docker

```bash
# Connexion à Azure Container Registry
az acr login --name <NOM_ACR>

# Build de l'image
docker build -t <NOM_ACR>.azurecr.io/wellbeing-app:latest .

# Push vers ACR
docker push <NOM_ACR>.azurecr.io/wellbeing-app:latest
```

### 3. Créer l'App Service

```bash
# Créer un plan App Service (Linux)
az appservice plan create \
  --name wellbeing-plan \
  --resource-group <RESOURCE_GROUP> \
  --is-linux \
  --sku B1

# Créer l'application Web depuis le container
az webapp create \
  --name wellbeing-app \
  --resource-group <RESOURCE_GROUP> \
  --plan wellbeing-plan \
  --deployment-container-image-name <NOM_ACR>.azurecr.io/wellbeing-app:latest
```

### 4. Configurer les variables d'environnement

```bash
az webapp config appsettings set \
  --name wellbeing-app \
  --resource-group <RESOURCE_GROUP> \
  --settings \
    DATABASE_URL="postgres://..." \
    RAILS_MASTER_KEY="<contenu de config/master.key>" \
    RAILS_ENV="production" \
    RAILS_SERVE_STATIC_FILES="true"
```

### 5. Configurer le port

```bash
az webapp config appsettings set \
  --name wellbeing-app \
  --resource-group <RESOURCE_GROUP> \
  --settings WEBSITES_PORT=3000
```

### 6. Activer la base de données PostgreSQL Azure

Créer une instance **Azure Database for PostgreSQL Flexible Server**, puis utiliser la chaîne de connexion comme valeur de `DATABASE_URL`.

### 7. Vérifier le déploiement

```bash
az webapp browse --name wellbeing-app --resource-group <RESOURCE_GROUP>
```

### 8. Voir les logs en cas d'erreur

```bash
az webapp log tail --name wellbeing-app --resource-group <RESOURCE_GROUP>
```

---

## Structure du projet

```
app/
  controllers/   # ApplicationController, ActivitiesController, ReservationsController...
  models/        # Activity, User, Reservation
  views/         # Layouts wellness + toutes les pages
config/
  database.yml   # Production lit DATABASE_URL
  routes.rb
db/
  migrate/       # Migrations (activities, users, reservations)
Dockerfile       # Image Ruby 3.2 + CMD rails server
docker-compose.yml
```

---

## Sécurité

- Authentification par session (`has_secure_password`)
- `before_action :require_login` protège dashboard, réservations, et CRUD activités
- `RAILS_MASTER_KEY` à ne jamais committer — passer en variable d'environnement Azure
