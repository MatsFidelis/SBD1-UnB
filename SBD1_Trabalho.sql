PRAGMA foreign_keys = ON;

CREATE TABLE ENDERECO (
  idEndereco INTEGER PRIMARY KEY, 
  complemento TEXT, 
  cidade TEXT NOT NULL, 
  pais TEXT NOT NULL, 
  estado TEXT NOT NULL, 
  numero INTEGER NOT NULL, 
  rua TEXT NOT NULL, 
  cep INTEGER NOT NULL
);


CREATE TABLE TELEFONE (
  numero INTEGER, 
  ddd TEXT, 
  idTelefone INTEGER PRIMARY KEY
);


-- Tabela Loja
CREATE TABLE LOJA (
	nomeLoja TEXT,
	endereco INTEGER NOT NULL,
	gerenteResponsavel TEXT,
	cnpj TEXT PRIMARY KEY,
	FOREIGN KEY (endereco) REFERENCES ENDERECO(idEndereco)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);


-- Tabela de especialização: LOJA_FISICA
CREATE TABLE LOJA_FISICA (
    cnpj TEXT PRIMARY KEY, 
    servicos TEXT,            
    FOREIGN KEY (cnpj) REFERENCES LOJA(cnpj)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);


-- Tabela de especialização: LOJA_DIGITAL
CREATE TABLE LOJA_DIGITAL (
    cnpj TEXT PRIMARY KEY,  
    idEquipExclusivos TEXT,    
    FOREIGN KEY (cnpj) REFERENCES LOJA(cnpj)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);


-- Tabela Funcionario
CREATE TABLE FUNCIONARIO (
	cpf TEXT PRIMARY KEY,
	nomeFuncionario TEXT NOT NULL,
	dataNascimento  DATE,
	salario REAL NOT NULL,
	loja TEXT NOT NULL,
	cargo TEXT NOT NULL,
	endereco INTEGER NOT NULL,
	telefone INTEGER,
	FOREIGN KEY (loja) REFERENCES LOJA(cnpj)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (endereco) REFERENCES ENDERECO(idEndereco)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (telefone) REFERENCES TELEFONE(idTelefone)
		ON DELETE SET NULL
		ON DELETE CASCADE
);


-- Tabela Gerencia
CREATE TABLE GERENCIA (
	cpf TEXT PRIMARY KEY,
	setor TEXT NOT NULL,
	FOREIGN KEY (cpf) REFERENCES FUNCIONARIO(cpf)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);


-- Tabela Produto musical
CREATE TABLE PRODUTO_MUSICAL (
	idProduto INTEGER PRIMARY KEY,
	nomeProduto TEXT NOT NULL,
	categoria TEXT,
	preco REAL NOT NULL,
	cor TEXT
);


-- Tabela Estoque
CREATE TABLE ESTOQUE (
	idProduto INTEGER,
	nomeProduto TEXT NOT NULL,
  	quantidade INTEGER NOT NULL,
  	FOREIGN KEY (idProduto) REFERENCES PRODUTO_MUSICAL(idProduto)
    	ON DELETE RESTRICT
    	ON UPDATE CASCADE
  );


-- Tabela Cliente
CREATE TABLE CLIENTE (
	cpf TEXT PRIMARY KEY,
	nomePessoa TEXT NOT NULL,
	dataNascimento DATE,
	endereco INTEGER NOT NULL,
	telefone INTEGER,
	FOREIGN KEY (endereco) REFERENCES ENDERECO(idEndereco)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (telefone) REFERENCES TELEFONE(idTelefone)
		ON DELETE SET NULL
		ON DELETE CASCADE
);
	

CREATE TABLE VENDA (
  idVenda TEXT PRIMARY KEY,
  funcionario TEXT,
  cliente TEXT NOT NULL,
  dataVenda DATE NOT NULL,
  loja TEXT NOT NULL,
  preco REAL NOT NULL,
  produto INTEGER NOT NULL,
   FOREIGN KEY (loja) REFERENCES LOJA(cnpj)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
   FOREIGN KEY (cliente) REFERENCES CLIENTE(cpf)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (funcionario) REFERENCES FUNCIONARIO(cpf)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (produto) REFERENCES PRODUTO_MUSICAL(idProduto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

	
CREATE TABLE BONUS (
  cpf TEXT PRIMARY KEY, 
  valor INTEGER NOT NULL, 
  data DATE,
  FOREIGN KEY (cpf) REFERENCES FUNCIONARIO(cpf)
);

INSERT INTO ENDERECO (idEndereco, complemento, cidade, pais, estado, numero, rua, cep) VALUES
(1, 'Apartamento 101', 'São Paulo', 'Brasil', 'SP', 100, 'Rua das Flores', '01001-000'),
(2, 'Casa', 'Rio de Janeiro', 'Brasil', 'RJ', 20, 'Avenida Atlântica', '22010-000'),
(3, 'Sala 305', 'Belo Horizonte', 'Brasil', 'MG', 300, 'Rua da Bahia', '30110-000'),
(4, 'Conjunto 42', 'Curitiba', 'Brasil', 'PR', 15, 'Rua XV de Novembro', '80020-000'),
(5, 'Loja 12', 'Porto Alegre', 'Brasil', 'RS', 250, 'Rua Padre Chagas', '90570-000'),
(6, 'Apartamento 501', 'Recife', 'Brasil', 'PE', 400, 'Rua da Aurora', '50050-000'),
(7, 'Fundos', 'Fortaleza', 'Brasil', 'CE', 350, 'Rua dos Tabajaras', '60165-010'),
(8, 'Apartamento 703', 'Salvador', 'Brasil', 'BA', 80, 'Avenida Sete de Setembro', '40080-001'),
(9, 'Ponto 2', 'Manaus', 'Brasil', 'AM', 120, 'Rua Eduardo Ribeiro', '69010-020'),
(10, 'Cobertura', 'Florianópolis', 'Brasil', 'SC', 25, 'Rua Bocaiúva', '88015-530'),
(11, 'Casa', 'Natal', 'Brasil', 'RN', 230, 'Avenida Engenheiro Roberto Freire', '59080-400'),
(12, 'Sala 403', 'João Pessoa', 'Brasil', 'PB', 98, 'Rua das Trincheiras', '58010-000'),
(13, 'Sobrado', 'Campinas', 'Brasil', 'SP', 14, 'Rua Barão de Jaguara', '13015-001'),
(14, 'Casa', 'Belém', 'Brasil', 'PA', 45, 'Avenida Nazaré', '66035-170'),
(15, 'Galpão', 'São Luís', 'Brasil', 'MA', 78, 'Rua Grande', '65020-000'),
(16, 'Ponto Comercial', 'Maceió', 'Brasil', 'AL', 320, 'Rua do Comércio', '57020-000'),
(17, 'Apartamento 405', 'Teresina', 'Brasil', 'PI', 360, 'Rua Simplício Mendes', '64000-000'),
(18, 'Prédio Inteiro', 'Aracaju', 'Brasil', 'SE', 75, 'Rua São Cristóvão', '49010-000'),
(19, 'Casa', 'Goiânia', 'Brasil', 'GO', 450, 'Avenida Goiás', '74015-010'),
(20, 'Sala Comercial', 'Cuiabá', 'Brasil', 'MT', 50, 'Rua 13 de Junho', '78005-010'),
(21, 'Sobrado', 'Campo Grande', 'Brasil', 'MS', 120, 'Rua 14 de Julho', '79002-002'),
(22, 'Loja 4', 'Vitória', 'Brasil', 'ES', 85, 'Avenida Vitória', '29015-900'),
(23, 'Apartamento 902', 'Boa Vista', 'Brasil', 'RR', 11, 'Rua Floriano Peixoto', '69301-030'),
(24, 'Casa', 'Palmas', 'Brasil', 'TO', 99, 'Rua NS 02', '77001-080'),
(25, 'Sala Comercial', 'Macapá', 'Brasil', 'AP', 72, 'Rua Cândido Mendes', '68900-110'),
(26, 'Prédio', 'Rio Branco', 'Brasil', 'AC', 410, 'Rua Marechal Deodoro', '69900-350'),
(27, 'Galpão', 'Porto Velho', 'Brasil', 'RO', 30, 'Avenida Jorge Teixeira', '76801-180'),
(28, 'Sala 202', 'Brasília', 'Brasil', 'DF', 100, 'SCS Quadra 2', '70000-000'),
(29, 'Sobrado', 'Sorocaba', 'Brasil', 'SP', 40, 'Rua São Bento', '18010-001'),
(30, 'Apartamento 602', 'Ribeirão Preto', 'Brasil', 'SP', 33, 'Avenida Independência', '14025-000'),
(31, 'Casa', 'Santos', 'Brasil', 'SP', 19, 'Rua General Câmara', '11010-000'),
(32, 'Sala 303', 'Uberlândia', 'Brasil', 'MG', 50, 'Rua Dom Pedro II', '38400-000'),
(33, 'Ponto Comercial', 'São José dos Campos', 'Brasil', 'SP', 112, 'Avenida São João', '12245-000'),
(34, 'Loja 5', 'Jundiaí', 'Brasil', 'SP', 86, 'Rua Barão de Jundiaí', '13200-000'),
(35, 'Cobertura', 'Londrina', 'Brasil', 'PR', 105, 'Rua Pará', '86020-000'),
(36, 'Apartamento 801', 'Joinville', 'Brasil', 'SC', 74, 'Rua Princesa Isabel', '89201-250'),
(37, 'Casa', 'Blumenau', 'Brasil', 'SC', 95, 'Rua XV de Novembro', '89010-000'),
(38, 'Sobrado', 'Caxias do Sul', 'Brasil', 'RS', 120, 'Rua Sinimbu', '95000-000'),
(39, 'Sala 104', 'Niterói', 'Brasil', 'RJ', 80, 'Rua Visconde de Sepetiba', '24020-206'),
(40, 'Apartamento 302', 'Duque de Caxias', 'Brasil', 'RJ', 102, 'Rua Nilo Peçanha', '25010-000'),
(41, 'Loja 7', 'Campos dos Goytacazes', 'Brasil', 'RJ', 60, 'Rua 13 de Maio', '28010-040'),
(42, 'Casa', 'Vitória da Conquista', 'Brasil', 'BA', 99, 'Avenida Brumado', '45000-200'),
(43, 'Sala Comercial', 'Canoas', 'Brasil', 'RS', 200, 'Avenida Guilherme Schell', '92010-000'),
(44, 'Ponto Comercial', 'Pelotas', 'Brasil', 'RS', 400, 'Rua Andrade Neves', '96010-000'),
(45, 'Apartamento 504', 'Tubarão', 'Brasil', 'SC', 60, 'Rua São Manoel', '88701-030'),
(46, 'Casa', 'Ipatinga', 'Brasil', 'MG', 70, 'Avenida Fernando Ferrari', '35160-000'),
(47, 'Loja 3', 'Marília', 'Brasil', 'SP', 50, 'Avenida Sampaio Vidal', '17500-000'),
(48, 'Apartamento 205', 'Franca', 'Brasil', 'SP', 90, 'Rua do Comércio', '14400-000'),
(49, 'Sobrado', 'Bauru', 'Brasil', 'SP', 25, 'Rua Antônio Alves', '17012-000'),
(50, 'Casa', 'Criciúma', 'Brasil', 'SC', 15, 'Rua Santa Catarina', '88800-000'),
(51, 'Sala 101', 'Itajaí', 'Brasil', 'SC', 40, 'Rua Hercílio Luz', '88301-200'),
(52, 'Loja', 'Patos de Minas', 'Brasil', 'MG', 70, 'Avenida Getúlio Vargas', '38700-000'),
(53, 'Cobertura', 'Varginha', 'Brasil', 'MG', 100, 'Rua Delfim Moreira', '37002-000'),
(54, 'Casa', 'Caruaru', 'Brasil', 'PE', 90, 'Avenida Agamenon Magalhães', '55010-000'),
(55, 'Apartamento 403', 'Juazeiro do Norte', 'Brasil', 'CE', 200, 'Rua São Pedro', '63010-000'),
(56, 'Sala 501', 'Sobral', 'Brasil', 'CE', 250, 'Avenida Dom José', '62010-000'),
(57, 'Casa', 'Petrolina', 'Brasil', 'PE', 150, 'Rua Dom Vital', '56300-000'),
(58, 'Sobrado', 'Cascavel', 'Brasil', 'PR', 70, 'Rua Paraná', '85810-000'),
(59, 'Loja 1', 'Foz do Iguaçu', 'Brasil', 'PR', 50, 'Avenida Brasil', '85851-000'),
(60, 'Sala Comercial', 'Boa Vista', 'Brasil', 'RR', 120, 'Rua Sebastião Diniz', '69301-090'),
(61, 'Casa', 'Macapá', 'Brasil', 'AP', 320, 'Rua Leopoldo Machado', '68900-020'),
(62, 'Sobrado', 'Porto Velho', 'Brasil', 'RO', 230, 'Avenida Carlos Gomes', '76800-000'),
(63, 'Sala 202', 'Rio Branco', 'Brasil', 'AC', 340, 'Rua Benjamin Constant', '69900-250'),
(64, 'Loja 2', 'Palmas', 'Brasil', 'TO', 75, 'Avenida Tocantins', '77001-030'),
(65, 'Sobrado', 'Anápolis', 'Brasil', 'GO', 280, 'Rua Engenheiro Portela', '75000-000'),
(66, 'Casa', 'Aparecida de Goiânia', 'Brasil', 'GO', 90, 'Avenida Independência', '74910-000'),
(67, 'Apartamento 301', 'Taguatinga', 'Brasil', 'DF', 85, 'Rua Comercial Norte', '72110-000'),
(68, 'Sala Comercial', 'Ceilândia', 'Brasil', 'DF', 200, 'Avenida Hélio Prates', '72215-000'),
(69, 'Loja', 'Brasília', 'Brasil', 'DF', 60, 'Rua das Farmácias', '70050-000'),
(70, 'Cobertura', 'Planaltina', 'Brasil', 'DF', 100, 'Rua Alexandre de Castro', '73300-010');


INSERT INTO TELEFONE VALUES
(999123456, '21', 1),
(998234567, '11', 2),
(997345678, '31', 3),
(996456789, '41', 4),
(995567890, '51', 5),
(994678901, '61', 6),
(993789012, '71', 7),
(992890123, '81', 8),
(991901234, '91', 9),
(990012345, '85', 10),
(988123456, '22', 11),
(987234567, '12', 12),
(986345678, '32', 13),
(985456789, '42', 14),
(984567890, '52', 15),
(983678901, '62', 16),
(982789012, '72', 17),
(981890123, '82', 18),
(980901234, '92', 19),
(979012345, '86', 20),
(978123456, '23', 21),
(977234567, '13', 22),
(976345678, '33', 23),
(975456789, '43', 24),
(974567890, '53', 25),
(973678901, '63', 26),
(972789012, '73', 27),
(971890123, '83', 28),
(970901234, '93', 29),
(969012345, '87', 30),
(968123456, '24', 31),
(967234567, '14', 32),
(966345678, '34', 33),
(965456789, '44', 34),
(964567890, '54', 35),
(963678901, '64', 36),
(962789012, '74', 37),
(961890123, '84', 38),
(960901234, '94', 39),
(959012345, '88', 40),
(958123456, '25', 41),
(957234567, '15', 42),
(956345678, '35', 43),
(955456789, '45', 44),
(954567890, '55', 45),
(953678901, '65', 46),
(952789012, '75', 47),
(951890123, '85', 48),
(950901234, '95', 49),
(949012345, '89', 50),
(948123456, '26', 51),
(947234567, '16', 52),
(946345678, '36', 53),
(945456789, '46', 54),
(944567890, '56', 55),
(943678901, '66', 56),
(942789012, '76', 57),
(941890123, '86', 58),
(940901234, '96', 59),
(939012345, '90', 60);


INSERT INTO LOJA (nomeLoja, endereco, gerenteResponsavel, cnpj) VALUES
('Loja Gourmet', 1, 'Ana Silva', '00123456000101'),
('Super Sabor', 2, 'Carlos Oliveira', '00234567000202'),
('Casa da Pizza', 3, 'Maria Ferreira', '00345678000303'),
('Empório Natural', 4, 'João Santos', '00456789000404'),
('Café Central', 5, 'Patrícia Lima', '00567891000505'),
('Delícias do Sul', 6, 'Fernando Almeida', '00678902000606'),
('Panificadora Bela', 7, 'Juliana Costa', '00789013000707'),
('Doces e Sabores', 8, 'Ricardo Machado', '00890124000808'),
('Churrasco & Cia', 9, 'Marta Souza', '00901235000909'),
('Mercado Verde', 10, 'Thiago Pereira', '01012346001010');


INSERT INTO LOJA_DIGITAL (cnpj, idEquipExclusivos) VALUES
('00123456000101', 'EQ1234'),
('00234567000202', 'EQ5678'),
('00345678000303', 'EQ91011'),
('00456789000404', 'EQ1213');

INSERT INTO LOJA_FISICA (cnpj, servicos) VALUES
('00567891000505', 'Estacionamento, Delivery'),
('00678902000606', 'Eventos, Degustação'),
('00789013000707', 'Espaço para Crianças, Wi-Fi'),
('00890124000808', 'Sala VIP, Estacionamento'),
('00901235000909', 'Área Pet, Drive-Thru'),
('01012346001010', 'Buffet, Eventos Corporativos');

INSERT INTO FUNCIONARIO (cpf, nomeFuncionario, dataNascimento, salario, loja, cargo, endereco, telefone) VALUES
('00123456000', 'Ana Clara', '1990-05-12', 3500.00, '00123456000101', 'Atendente', 11, 1),
('23456789012', 'João Pedro', '1985-08-23', 4500.00, '00234567000202', 'Gerente', 12, 2),
('34567890123', 'Maria Fernanda', '1993-03-15', 3200.00, '00345678000303', 'Caixa', 13, 3),
('45678901234', 'Carlos Henrique', '1988-11-30', 4800.00, '00456789000404', 'Chef', 14, 4),
('56789012345', 'Juliana Souza', '1995-07-08', 2900.00, '00567891000505', 'Atendente', 15, 5),
('67890123456', 'Fernando Alves', '1992-02-19', 4000.00, '00678902000606', 'Supervisor', 16, 6),
('78901234567', 'Beatriz Lima', '1997-09-25', 3000.00, '00789013000707', 'Caixa', 17, 7),
('89012345678', 'Thiago Santos', '1989-01-11', 4500.00, '00890124000808', 'Gerente', 18, 8),
('90123456789', 'Patrícia Rocha', '1994-06-20', 3100.00, '00901235000909', 'Recepcionista', 19, 9),
('01234567890', 'Rafael Mendes', '1990-12-05', 4200.00, '01012346001010', 'Atendente', 20, 10),
('12345098765', 'Lorena Carvalho', '1996-04-18', 3300.00, '00123456000101', 'Atendente', 21, 11),
('23456098765', 'Gabriel Oliveira', '1987-07-27', 4700.00, '00234567000202', 'Supervisor', 22, 12),
('34567098765', 'Carolina Ribeiro', '1998-10-02', 2800.00, '00345678000303', 'Caixa', 23, 13),
('45678098765', 'Rodrigo Costa', '1991-03-13', 5000.00, '00456789000404', 'Chef', 24, 14),
('56789098765', 'Débora Nunes', '1993-11-09', 3600.00, '00567891000505', 'Recepcionista', 25, 15),
('67890098765', 'Marcelo Pinto', '1986-08-15', 5200.00, '00678902000606', 'Gerente', 26, 16),
('78901098765', 'Isabela Farias', '1995-05-22', 2900.00, '00789013000707', 'Atendente', 27, 17),
('89012098765', 'André Matos', '1989-02-07', 4000.00, '00890124000808', 'Supervisor', 28, 18),
('90123098765', 'Tatiane Silva', '1994-09-14', 3400.00, '00901235000909', 'Caixa', 29, 19),
('01234098765', 'Lucas Araújo', '1990-06-30', 4500.00, '01012346001010', 'Gerente', 30, 20);

INSERT INTO CLIENTE (cpf, nomePessoa, dataNascimento, endereco, telefone) VALUES
('11111111111', 'Lucas Silva', '1995-06-12', 31, 21),
('22222222222', 'Mariana Costa', '1990-03-28', 32, 22),
('33333333333', 'Pedro Oliveira', '1988-12-05', 33, 23),
('44444444444', 'Ana Paula', '1997-09-15', 34, 24),
('55555555555', 'João Mendes', '1985-11-20', 35, 25),
('66666666666', 'Carla Ferreira', '1993-01-30', 36, 26),
('77777777777', 'Roberto Lima', '1992-05-18', 37, 27),
('88888888888', 'Fernanda Sousa', '1996-10-08', 38, 28),
('99999999999', 'Ricardo Alves', '1994-04-12', 39, 29),
('00000000000', 'Isabela Rocha', '1991-08-22', 40, 30),
('12345678901', 'Tatiana Nunes', '1990-07-05', 41, 31),
('23456789012', 'Gustavo Santos', '1993-03-14', 42, 32),
('34567890123', 'Juliana Martins', '1989-09-25', 43, 33),
('45678901234', 'Rodrigo Azevedo', '1995-02-19', 44, 34),
('56789012345', 'Patrícia Carvalho', '1987-12-03', 45, 35),
('67890123456', 'Thiago Fernandes', '1992-01-10', 46, 36),
('78901234567', 'Luciana Ribeiro', '1994-11-23', 47, 37),
('89012345678', 'Carlos Eduardo', '1996-08-17', 48, 38),
('90123456789', 'Débora Farias', '1988-06-21', 49, 39),
('01234567890', 'Henrique Matos', '1991-10-30', 50, 40);

INSERT INTO GERENCIA (cpf, setor) VALUES
('23456789012', 'Administração'),
('45678901234', 'Cozinha'),
('56789012345', 'Atendimento');

INSERT INTO PRODUTO_MUSICAL (idProduto, nomeProduto, categoria, preco, cor) VALUES
(1, 'Violão Acústico', 'Cordas', 750.00, 'Marrom'),
(2, 'Guitarra Elétrica', 'Cordas', 1200.00, 'Preto'),
(3, 'Teclado Musical', 'Teclas', 850.00, 'Branco'),
(4, 'Bateria Completa', 'Percussão', 2500.00, 'Vermelho'),
(5, 'Flauta Transversal', 'Sopro', 600.00, 'Prata'),
(6, 'Microfone Condensador', 'Acessórios', 450.00, 'Preto'),
(7, 'Pedal de Guitarra', 'Acessórios', 300.00, 'Cinza'),
(8, 'Amplificador de Guitarra', 'Acessórios', 950.00, 'Preto'),
(9, 'Baixo Elétrico', 'Cordas', 1300.00, 'Sunburst'),
(10, 'Pandeiro', 'Percussão', 150.00, 'Amarelo'),
(11, 'Violino', 'Cordas', 800.00, 'Marrom Escuro'),
(12, 'Clarinete', 'Sopro', 700.00, 'Preto'),
(13, 'Ukulele', 'Cordas', 400.00, 'Madeira'),
(14, 'Saxofone Alto', 'Sopro', 2000.00, 'Dourado'),
(15, 'Metronomo Digital', 'Acessórios', 120.00, 'Prata'),
(16, 'Fone de Monitoramento', 'Acessórios', 350.00, 'Preto'),
(17, 'Trompete', 'Sopro', 1200.00, 'Dourado'),
(18, 'Cajón', 'Percussão', 550.00, 'Madeira'),
(19, 'Harmônica', 'Sopro', 180.00, 'Prata'),
(20, 'Banjo', 'Cordas', 900.00, 'Madeira'),
(21, 'Cavaquinho', 'Cordas', 650.00, 'Marrom'),
(22, 'Rebolo', 'Percussão', 400.00, 'Branco'),
(23, 'Piano Digital', 'Teclas', 3000.00, 'Preto'),
(24, 'Órgão Eletrônico', 'Teclas', 4500.00, 'Madeira'),
(25, 'Prato de Bateria', 'Percussão', 200.00, 'Dourado'),
(26, 'Baqueta de Bateria', 'Acessórios', 50.00, 'Marrom'),
(27, 'Kit de Cordas Violão', 'Acessórios', 80.00, 'Prata'),
(28, 'Suporte para Partitura', 'Acessórios', 100.00, 'Preto'),
(29, 'Capa para Teclado', 'Acessórios', 150.00, 'Preto'),
(30, 'Pedal Sustain', 'Acessórios', 200.00, 'Cinza');

INSERT INTO ESTOQUE (idProduto, nomeProduto, quantidade) VALUES
(1, 'Violão Acústico', 20),
(2, 'Guitarra Elétrica', 15),
(3, 'Teclado Musical', 25),
(4, 'Bateria Completa', 5),
(5, 'Flauta Transversal', 30),
(6, 'Microfone Condensador', 50),
(7, 'Pedal de Guitarra', 40),
(8, 'Amplificador de Guitarra', 10),
(9, 'Baixo Elétrico', 12),
(10, 'Pandeiro', 60),
(11, 'Violino', 18),
(12, 'Clarinete', 22),
(13, 'Ukulele', 35),
(14, 'Saxofone Alto', 8),
(15, 'Metronomo Digital', 100),
(16, 'Fone de Monitoramento', 45),
(17, 'Trompete', 10),
(18, 'Cajón', 20),
(19, 'Harmônica', 70),
(20, 'Banjo', 14),
(21, 'Cavaquinho', 28),
(22, 'Rebolo', 25),
(23, 'Piano Digital', 4),
(24, 'Órgão Eletrônico', 3),
(25, 'Prato de Bateria', 55),
(26, 'Baqueta de Bateria', 150),
(27, 'Kit de Cordas Violão', 200),
(28, 'Suporte para Partitura', 90),
(29, 'Capa para Teclado', 35),
(30, 'Pedal Sustain', 25);


INSERT INTO VENDA (idVenda, funcionario, cliente, dataVenda, loja, preco, produto) VALUES
('V001', '00123456000', '11111111111', '2024-12-01', '00123456000101', 750.00, 1),
('V002', '12345098765', '11111111111', '2024-12-02', '00123456000101', 450.00, 6),
('V003', '23456789012', '22222222222', '2024-12-01', '00234567000202', 850.00, 3),
('V004', '23456098765', '22222222222', '2024-12-03', '00234567000202', 1200.00, 2),
('V005', '34567890123', '33333333333', '2024-12-02', '00345678000303', 400.00, 13),
('V006', '34567098765', '33333333333', '2024-12-04', '00345678000303', 800.00, 11),
('V007', '45678901234', '44444444444', '2024-12-03', '00456789000404', 2500.00, 4),
('V008', '45678098765', '44444444444', '2024-12-05', '00456789000404', 180.00, 19),
('V009', '56789012345', '55555555555', '2024-12-01', '00567891000505', 650.00, 21),
('V010', '56789098765', '55555555555', '2024-12-04', '00567891000505', 300.00, 7),
('V011', '67890123456', '66666666666', '2024-12-02', '00678902000606', 900.00, 20),
('V012', '67890098765', '66666666666', '2024-12-05', '00678902000606', 4000.00, 23),
('V013', '78901234567', '77777777777', '2024-12-03', '00789013000707', 150.00, 10),
('V014', '78901098765', '77777777777', '2024-12-06', '00789013000707', 550.00, 18),
('V015', '89012345678', '88888888888', '2024-12-01', '00890124000808', 3000.00, 23),
('V016', '89012098765', '88888888888', '2024-12-04', '00890124000808', 120.00, 15),
('V017', '90123456789', '99999999999', '2024-12-02', '00901235000909', 200.00, 25),
('V018', '90123098765', '99999999999', '2024-12-05', '00901235000909', 950.00, 8),
('V019', '01234567890', '00000000000', '2024-12-03', '01012346001010', 2800.00, 3),
('V020', '01234098765', '00000000000', '2024-12-06', '01012346001010', 3300.00, 22),
('V021', '00123456000', '12345678901', '2024-12-02', '00123456000101', 4500.00, 24),
('V022', '12345098765', '12345678901', '2024-12-04', '00123456000101', 150.00, 26),
('V023', '23456789012', '23456789012', '2024-12-01', '00234567000202', 180.00, 19),
('V024', '23456098765', '23456789012', '2024-12-05', '00234567000202', 5200.00, 16),
('V025', '34567890123', '34567890123', '2024-12-03', '00345678000303', 4700.00, 2),
('V026', '34567098765', '34567890123', '2024-12-06', '00345678000303', 3600.00, 27),
('V027', '45678901234', '45678901234', '2024-12-02', '00456789000404', 2000.00, 14),
('V028', '45678098765', '45678901234', '2024-12-04', '00456789000404', 400.00, 22),
('V029', '56789012345', '56789012345', '2024-12-01', '00567891000505', 100.00, 28),
('V030', '56789098765', '56789012345', '2024-12-05', '00567891000505', 1200.00, 17);

INSERT INTO BONUS (cpf, valor, data) VALUES
('00123456000', 500.00, '2024-01-15'),
('23456789012', 1000.00, '2024-02-10'),
('34567890123', 300.00, '2024-03-05'),
('45678901234', 700.00, '2024-01-20'),
('56789012345', 400.00, '2024-02-18'),
('67890123456', 800.00, '2024-03-10'),
('78901234567', 350.00, '2024-01-25'),
('89012345678', 900.00, '2024-02-28');

