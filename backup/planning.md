# Planejamento de Backup - GearHub

## Estratégia
A estratégia adotada para o banco de dados `gearhub` é o **Backup Lógico Completo (Full Backup)** diário. 
A ferramenta escolhida para a extração dos dados é o utilitário `mysqldump` nativo do MySQL, que gera um script DDL e DML completo para restauração do banco. 
Por questões de segurança, a extração utiliza a flag `--no-tablespaces`. 
Isso garante que o backup seja executado com sucesso pelo usuário local (`admin_gh`) 
sem a necessidade de conceder privilégios globais e perigosos (`PROCESS`) no servidor, restringindo o acesso estritamente aos dados do nosso minimundo.

## Automação e Execução Contínua
Para garantir a execução contínua sem intervenção manual e padronizar o processo, 
o comando de extração e a rotina de limpeza foram encapsulados no script executável `backup.sh`. 

## Retenção
O script conta com uma política de retenção que deleta automaticamente os arquivos de backup com mais de 7 dias. 
Otimizando assim o espaço em disco do servidor e mantendo apenas o histórico recente.