-- Database expected by DBConnection: jdbc:mysql://localhost:3306/taptapsend
CREATE DATABASE IF NOT EXISTS taptapsend CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE taptapsend;

CREATE TABLE IF NOT EXISTS client (
    numtel         VARCHAR(32)  PRIMARY KEY,
    nom            VARCHAR(255) NOT NULL,
    sexe           VARCHAR(32),
    pays           VARCHAR(128),
    solde          INT          NOT NULL DEFAULT 0,
    mail           VARCHAR(255) NOT NULL,
    password       VARCHAR(255),
    date_naissance DATE         NULL
);

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
