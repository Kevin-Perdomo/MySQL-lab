-- Data Definition Language (DDL) for GearHub Database

-- ===========================
-- CRIAÇÃO DO BANCO
-- ===========================
DROP DATABASE IF EXISTS gearhub;

CREATE DATABASE gearhub
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE gearhub;

-- ===========================
-- EMPRESAS
-- ===========================
CREATE TABLE gh_empresas (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    cnpj CHAR(14) NOT NULL UNIQUE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    logo LONGBLOB,
    nome VARCHAR(150) NOT NULL,
    nome_arquivo_logo VARCHAR(255)
);

-- ===========================
-- SEDES
-- ===========================
CREATE TABLE gh_sedes (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    endereco VARCHAR(255) NOT NULL,
    foto LONGBLOB,
    nome VARCHAR(150) NOT NULL,
    nome_arquivo_foto VARCHAR(255),
    empresa_id BIGINT NOT NULL,

    FOREIGN KEY (empresa_id) REFERENCES gh_empresas(id)
    ON DELETE CASCADE
);

-- ===========================
-- VEÍCULOS
-- ===========================
CREATE TABLE gh_veiculos (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ano_modelo SMALLINT NOT NULL,
    capacidade_reserva_litros DOUBLE,
    capacidade_tanque_litros DOUBLE,
    combustivel_recomendado VARCHAR(50),
    descricao TEXT,
    foto LONGBLOB,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    nome_arquivo_foto VARCHAR(255),
    placa CHAR(7) NOT NULL UNIQUE,
    sede_id BIGINT NOT NULL,

    FOREIGN KEY (sede_id) REFERENCES gh_sedes(id)
    ON DELETE CASCADE
);

-- ===========================
-- BATERIAS
-- ===========================
CREATE TABLE gh_baterias (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    capacidade_ah VARCHAR(20),
    data_instalacao DATE,
    fim_garantia DATE,
    foto LONGBLOB,
    km_instalacao INT,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    nome_arquivo_foto VARCHAR(255),
    voltagem VARCHAR(20),
    veiculo_id BIGINT NOT NULL,

    FOREIGN KEY (veiculo_id) REFERENCES gh_veiculos(id)
    ON DELETE CASCADE
);

-- ===========================
-- PNEUS
-- ===========================
CREATE TABLE gh_pneus (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    data_instalacao DATE,
    foto LONGBLOB,
    km_instalacao INT,
    marca VARCHAR(50),
    medida VARCHAR(30),
    modelo VARCHAR(100),
    nome_arquivo_foto VARCHAR(255),
    posicao VARCHAR(50),
    veiculo_id BIGINT NOT NULL,

    FOREIGN KEY (veiculo_id) REFERENCES gh_veiculos(id)
    ON DELETE CASCADE
);

-- ===========================
-- DOCUMENTOS DO VEÍCULO
-- ===========================
CREATE TABLE gh_documentos (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ano_referencia INT NOT NULL,
    arquivo_pdf LONGBLOB,
    data_pagamento DATE,
    data_upload DATETIME DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT,
    nome_arquivo VARCHAR(255),
    status VARCHAR(50),
    tipo_documento VARCHAR(100),
    veiculo_id BIGINT NOT NULL,

    FOREIGN KEY (veiculo_id) REFERENCES gh_veiculos(id)
    ON DELETE CASCADE
);

-- ===========================
-- TROCAS DE ÓLEO
-- ===========================
CREATE TABLE gh_oleos (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    data_troca DATE,
    foto LONGBLOB,
    nome_arquivo_foto VARCHAR(255),
    quantidade_litros DOUBLE,
    quilometragem INT,
    tipo_oleo VARCHAR(100),
    trocou_filtro BIT(1),
    veiculo_id BIGINT NOT NULL,

    FOREIGN KEY (veiculo_id) REFERENCES gh_veiculos(id)
    ON DELETE CASCADE
);
