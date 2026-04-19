# 📦 Projet E2 — Pipeline Data Engineering & Machine Learning

## 🎯 Objectif du projet

Ce projet a pour objectif de concevoir un pipeline complet de traitement de données permettant :

* l’ingestion de données hétérogènes (CSV, JSON, JSONL) ;
* leur transformation et leur nettoyage (ETL) ;
* la construction d’une table analytique ;
* le développement d’un modèle de machine learning pour prédire le risque de rupture de stock (`stockout_risk`) ;
* la mise en place de tests de validation du pipeline.

---

## 🧱 Architecture du projet

```
bloc2_exam_train/
│
├── data/
│   ├── raw/              # Données sources (CSV, JSON, JSONL)
│   └── processed/        # Données transformées + outputs
│
├── scripts/
│   ├── ingest.py         # Ingestion des données
│   ├── etl.py            # Transformation / nettoyage / agrégation
│   ├── train.py          # Modèle de machine learning
│   └── visualize.py      # Visualisations
│
├── tests/
│   └── test_pipeline.py  # Tests du pipeline
│
├── models/
│   └── model.pkl         # Modèle entraîné
│
├── logs/
│   ├── ingest.log
│   ├── etl.log
│   └── train.log
│
└── README.md
```

---

## ⚙️ Pipeline de traitement

### 1. Ingestion des données

Script : `scripts/ingest.py`

* Chargement des fichiers :

  * CSV : orders, products, stores
  * JSON : inventory, events
  * JSONL : reviews
* Vérification des données (dimensions, colonnes)
* Journalisation des erreurs

---

### 2. Transformation (ETL)

Script : `scripts/etl.py`

#### Étapes réalisées :

* Nettoyage des données :

  * suppression des doublons
  * conversion des types
  * gestion des valeurs manquantes

* Normalisation :

  * catégories produits
  * régions

* Agrégations :

  * `sales_7d`, `sales_30d`
  * `avg_rating`
  * `web_signal`

* Jointures :

  * produits + magasins + stock + ventes + avis + événements

* Création de la table finale :

```
fact_stock_risk
```

#### Variable cible :

```
stockout_risk = 1 si stock faible ET demande récente élevée
```

---

### 3. Machine Learning

Script : `scripts/train.py`

#### Modèle utilisé :

* RandomForestClassifier

#### Justification :

* robuste
* rapide à entraîner
* adapté à un contexte d’examen
* peu sensible aux outliers

#### Étapes :

* préparation des données
* encodage des variables catégorielles
* séparation train / test
* entraînement
* évaluation
* sauvegarde du modèle (`model.pkl`)

---

### 4. Visualisations

Script : `scripts/visualize.py`

Visualisations générées :

* distribution du risque (`stockout_risk`)
* relation ventes vs stock
* ventes moyennes par région

Objectif :

* valider la cohérence des données
* interpréter les features

---

### 5. Tests

Script : `tests/test_pipeline.py`

Tests réalisés :

* présence des fichiers
* validation des colonnes
* existence de la table finale
* absence de doublons
* cohérence des valeurs

Résultat :

```
9 passed
```

---

## ▶️ Exécution du pipeline

### Activation de l’environnement :

```bash
source .venv/bin/activate
```

### Lancement complet :

```bash
python scripts/ingest.py
python scripts/etl.py
python scripts/train.py
python scripts/visualize.py
pytest -v
```

---

## 📊 Résultats

* Dataset final : `fact_stock_risk.csv`
* Modèle sauvegardé : `model.pkl`
* Visualisations générées (PNG)

### Performance modèle :

* Accuracy : 1.00

⚠️ Attention :

* le dataset est déséquilibré (peu de cas de rupture)
* la métrique doit être interprétée avec prudence

---

## ⚠️ Limites

* déséquilibre des classes (`stockout_risk`)
* cible simplifiée (règle métier basique)
* peu de features avancées
* pas de validation croisée
* pas d’optimisation d’hyperparamètres

---

## 🚀 Améliorations possibles

* enrichir les données (web, météo, promotions)
* améliorer la définition du risque
* tester d’autres modèles (Logistic Regression, XGBoost)
* ajouter du feature engineering
* mettre en place une validation croisée

---

## 🔐 Sécurité & RGPD

* aucune donnée personnelle sensible utilisée
* anonymisation implicite des identifiants
* logs limités aux erreurs techniques
* respect des bonnes pratiques de traitement des données

---

## 🌱 Sobriété & performance

* modèle frugal (RandomForest simple)
* pipeline optimisé (pandas)
* pas de surconsommation de ressources
* approche adaptée à un contexte réel et scalable

---

## ✅ Conclusion

Le pipeline développé permet :

* une ingestion fiable des données
* une transformation cohérente
* une construction analytique pertinente
* une première modélisation prédictive

Ce projet constitue une base solide pour un système de prévision des ruptures de stock en environnement réel.
