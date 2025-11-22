# Minimundo – Sistema GearHub

O projeto visa desenvolver o banco de dados do GearHub, um sistema web de gestão de frotas corporativas utilizado por organizações que precisam controlar veículos, filiais, manutenções e documentos de forma centralizada. O sistema opera em arquitetura multiempresa, permitindo que várias empresas utilizem a plataforma simultaneamente, cada uma com seus próprios dados segregados.

Cada empresa cadastrada no GearHub pode registrar suas sedes ou filiais, informando endereço, nome e documentos visuais. As sedes são responsáveis por abrigar e administrar os veículos da frota. Um veículo pertence sempre a uma única sede, mas a sede pode possuir vários veículos. Para cada veículo são armazenados dados como placa, marca, modelo, ano, foto e descrição.

O sistema também controla componentes e manutenções realizadas em cada veículo. São monitorados itens como pneus, baterias, óleo e autonomia de combustível. Para cada componente são registrados dados específicos, por exemplo: data de instalação, quilometragem, marca, modelo, fotos e informações de garantia. Um veículo pode possuir vários registros de troca de pneus, baterias ou óleo ao longo de sua vida útil, permitindo o rastreamento histórico completo.

Além disso, o GearHub gerencia documentos relacionados aos veículos, como licenciamento, comprovantes de pagamento, seguros e outros. Para cada documento são registrados o arquivo em si, o ano de referência, a data de upload, a data de pagamento, o tipo do documento e seu status. Cada documento está sempre vinculado a somente um veículo.

O banco de dados deve garantir integridade referencial, permitindo rastrear com precisão a qual empresa, sede e veículo cada manutenção, documento ou componente pertence. O sistema deve oferecer histórico detalhado, consistência entre registros e fácil recuperação das informações.