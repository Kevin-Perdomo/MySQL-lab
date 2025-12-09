-- Data Manipulation Language (DML) for GearHub Database

-- Inserindo Empresas
INSERT INTO gh_empresas (cnpj, nome) VALUES 
('12345678000199', 'Logística Norte Fluminense'),
('98765432000100', 'TransCargas Sudeste');

-- Inserindo Sedes (Vinculadas às empresas acima)
INSERT INTO gh_sedes (empresa_id, nome, endereco) VALUES 
(1, 'Matriz Campos', 'Av. 28 de Março, 500, Campos dos Goytacazes - RJ'),
(1, 'Filial Macaé', 'Rodovia Amaral Peixoto, km 100, Macaé - RJ'),
(2, 'Base Vitória', 'Av. Dante Michelini, 100, Vitória - ES');

-- Inserindo Veículos (Vinculados às sedes)
INSERT INTO gh_veiculos (sede_id, placa, marca, modelo, ano_modelo, descricao) VALUES 
(1, 'KRA1234', 'Toyota', 'Hilux', 2022, 'Caminhonete de apoio operacional'),
(1, 'LMN5678', 'Fiat', 'Fiorino', 2020, 'Transporte de pequenas cargas'),
(2, 'RIO2023', 'Volkswagen', 'Constellation', 2023, 'Caminhão toco'),
(3, 'ESP9999', 'Ford', 'Ranger', 2021, 'Veículo da gerência');

-- Inserindo Autonomia
INSERT INTO gh_autonomia (veiculo_id, capacidade_tanque_litros, capacidade_reserva_litros, combustivel_recomendado) VALUES 
(1, 80.0, 10.0, 'Diesel S10'),
(2, 55.0, 8.0, 'Gasolina'),
(3, 275.0, 30.0, 'Diesel S10'),
(4, 76.0, 9.0, 'Diesel S10');

-- Inserindo Baterias
INSERT INTO gh_baterias (veiculo_id, marca, modelo, capacidade_ah, voltagem, data_instalacao, km_instalacao, fim_garantia) VALUES 
(1, 'Moura', 'M60GD', '60Ah', '12V', '2023-05-15', 40000, '2025-05-15'),
(2, 'Heliar', 'SL60PD', '60Ah', '12V', '2022-08-10', 30000, '2024-08-10'),
(3, 'ACDelco', 'ADR100', '100Ah', '12V', '2023-01-10', 5000, '2025-01-10'),
(4, 'Moura', 'M50JD', '50Ah', '12V', '2021-03-20', 25000, '2023-03-20');

-- Inserindo Documentos
INSERT INTO gh_documentos (veiculo_id, tipo_documento, ano_referencia, status, data_pagamento, descricao) VALUES 
(1, 'IPVA', 2024, 'Pendente', NULL, 'IPVA do veículo KRA1234'),
(2, 'Licenciamento', 2024, 'Pago', '2024-02-15', 'Licenciamento anual'),
(3, 'Seguro Obrigatório', 2023, 'Vencido', '2023-01-10', 'DPVAT vencido'),
(4, 'IPVA', 2024, 'Pendente', NULL, 'IPVA do veículo ESP9999');

-- Inserindo Trocas de Óleo (Serve como histórico de KM também)
INSERT INTO gh_oleos (veiculo_id, tipo_oleo, quilometragem, data_troca, trocou_filtro) VALUES 
(1, '5W30 Sintético', 55000, '2024-03-10', 1),
(2, '15W40 Mineral', 60000, '2024-04-01', 1),
(3, '15W40 Diesel', 12000, '2024-02-28', 0),
(4, '5W30 Sintético', 30000, '2023-12-15', 1);

-- Inserindo Histórico de Pneus
INSERT INTO gh_pneus (veiculo_id, marca, modelo, medida, posicao, data_instalacao, km_instalacao) VALUES 
(1, 'Michelin', 'LTX Force', '265/65R17', 'Dianteiro Esquerdo', '2024-01-20', 45000),
(1, 'Michelin', 'LTX Force', '265/65R17', 'Dianteiro Direito', '2024-01-20', 45000),
(1, 'Michelin', 'LTX Force', '265/65R17', 'Traseiro Esquerdo', '2024-01-20', 45000),
(1, 'Michelin', 'LTX Force', '265/65R17', 'Traseiro Direito', '2024-01-20', 45000);