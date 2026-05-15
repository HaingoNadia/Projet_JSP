-- Run as OS admin: sudo mysql < setup-mysql-dev.sql
-- Creates app user, database, tables, and sample data for local development.

CREATE DATABASE IF NOT EXISTS taptapsend CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'taptapsend'@'localhost' IDENTIFIED BY 'taptapsend';
GRANT ALL PRIVILEGES ON taptapsend.* TO 'taptapsend'@'localhost';
FLUSH PRIVILEGES;

USE taptapsend;

CREATE TABLE IF NOT EXISTS client (
    numtel         VARCHAR(32)  PRIMARY KEY,
    nom            VARCHAR(255) NOT NULL,
    sexe           VARCHAR(32),
    pays           VARCHAR(128),
    solde          DECIMAL(15,2) NOT NULL DEFAULT 0,
    mail           VARCHAR(255) NOT NULL,
    password       VARCHAR(255),
    date_naissance DATE         NULL
);
-- Bases existantes : conserve les centimes du solde (ex. 1.04 €).
ALTER TABLE client MODIFY COLUMN solde DECIMAL(15,2) NOT NULL DEFAULT 0;

-- Si la table client existait déjà sans date_naissance, ajoute la colonne.
SET @exists := (
  SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'client' AND COLUMN_NAME = 'date_naissance'
);
SET @sqlstmt := IF(@exists = 0, 'ALTER TABLE client ADD COLUMN date_naissance DATE NULL', 'SELECT 1');
PREPARE stmt FROM @sqlstmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS taux (
    idtaux   VARCHAR(64) PRIMARY KEY,
    montant1 INT NOT NULL,
    montant2 INT NOT NULL
);
ALTER TABLE taux MODIFY COLUMN idtaux VARCHAR(64) NOT NULL;

CREATE TABLE IF NOT EXISTS frais_envoi (
    idfrais  VARCHAR(64) PRIMARY KEY,
    montant1 INT NOT NULL,
    montant2 INT NOT NULL,
    frais    INT NOT NULL
);
ALTER TABLE frais_envoi MODIFY COLUMN idfrais VARCHAR(64) NOT NULL;

CREATE TABLE IF NOT EXISTS envoyer (
    idEnv        VARCHAR(64) PRIMARY KEY,
    numEnvoyeur  VARCHAR(32) NOT NULL,
    numRecepteur VARCHAR(32) NOT NULL,
    montant      INT NOT NULL,
    date         DATETIME NOT NULL,
    raison       VARCHAR(512)
);
ALTER TABLE envoyer MODIFY COLUMN idEnv VARCHAR(64) NOT NULL;

DELETE FROM envoyer;
DELETE FROM frais_envoi;
DELETE FROM taux;
DELETE FROM client;

INSERT INTO client (numtel, nom, sexe, pays, solde, mail, password, date_naissance) VALUES
('0340000001', 'Admin Demo', 'M', 'Madagascar', 500000, 'admin@demo.local', 'admin123', '1985-06-15'),
('0340000002', 'Marie Rasoa', 'F', 'Madagascar', 120000, 'marie@demo.local', 'demo123', '1992-03-22'),
('0340000003', 'Jean Rakoto', 'M', 'Madagascar', 80000, 'jean@demo.local', 'demo123', '1988-11-01'),
('+33601020304', 'Bernard Rakoto', 'M', 'France', 3500, 'bernard@demo.local', 'demo123', '1986-04-10');

INSERT INTO taux (idtaux, montant1, montant2) VALUES
('EUR-MGA', 1, 4800);

INSERT INTO frais_envoi (idfrais, montant1, montant2, frais) VALUES
('F1', 0, 50000, 2000),
('F2', 50001, 200000, 5000),
('F3', 200001, 1000000, 12000);

INSERT INTO envoyer (idEnv, numEnvoyeur, numRecepteur, montant, date, raison) VALUES
('ENV001', '0340000001', '+33601020304', 25000, '2026-05-01 10:30:00', 'Aide famille'),
('ENV002', '0340000002', '+33601020304', 15000, '2026-05-05 14:00:00', 'Remboursement');
