-- ========================================================
-- FICHIER : queries.sql
-- OBJECTIF :
-- Étape 3 — Vérifier la bonne intégration du stockage
-- ========================================================


-- Vérifier les tables créées
SELECT name
FROM sqlite_master
WHERE type = 'table';


-- Compter les lignes par table
SELECT COUNT(*) AS nb_products FROM dim_product;
SELECT COUNT(*) AS nb_stores FROM dim_store;
SELECT COUNT(*) AS nb_orders FROM fact_orders;
SELECT COUNT(*) AS nb_inventory FROM fact_inventory;
SELECT COUNT(*) AS nb_events FROM fact_events;
SELECT COUNT(*) AS nb_reviews FROM agg_reviews;
SELECT COUNT(*) AS nb_stock_risk FROM fact_stock_risk;


-- Afficher quelques lignes
SELECT * FROM dim_product LIMIT 5;
SELECT * FROM dim_store LIMIT 5;
SELECT * FROM fact_orders LIMIT 5;
SELECT * FROM fact_inventory LIMIT 5;


-- Vérifier les doublons potentiels sur les commandes
SELECT order_id, COUNT(*) AS nb
FROM fact_orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Vérifier les valeurs nulles importantes
SELECT COUNT(*) AS null_product_id
FROM fact_orders
WHERE product_id IS NULL;

SELECT COUNT(*) AS null_store_id
FROM fact_orders
WHERE store_id IS NULL;


-- Vérifier la table analytique finale
SELECT * FROM fact_stock_risk LIMIT 10;

SELECT stockout_risk, COUNT(*) AS nb
FROM fact_stock_risk
GROUP BY stockout_risk;