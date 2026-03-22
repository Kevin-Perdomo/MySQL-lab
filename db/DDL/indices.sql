-- Índices para otimizar buscas frequentes e joins no GearHub

-- Busca de empresas por CNPJ
CREATE INDEX idx_empresa_cnpj ON gh_empresas(cnpj);

-- Busca de veículos por placa
CREATE INDEX idx_veiculo_placa ON gh_veiculos(placa);

-- Otimização de Joins (Chaves Estrangeiras)
CREATE INDEX idx_veiculo_sede ON gh_veiculos(sede_id);
CREATE INDEX idx_pneus_veiculo ON gh_pneus(veiculo_id);
CREATE INDEX idx_documentos_veiculo ON gh_documentos(veiculo_id);