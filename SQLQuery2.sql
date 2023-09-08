/*Criando a tabela usuário*/
  CREATE TABLE Usuario (
  id_usuario INT IDENTITY (1,1) PRIMARY KEY,
  Login VARCHAR(255) NOT NULL,
  Senha VARCHAR(255) NOT NULL,  
);
/*Criando a tabela Pessoa*/
CREATE TABLE Pessoa (
  idPessoa INT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  logradouro VARCHAR(255) NOT NULL,
  cidade VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL,
  telefone VARCHAR(255),
  email VARCHAR(255) NOT NULL,

);

/*Criando a tabela PessoaFisica*/
CREATE TABLE PessoaFisica (
  idPessoaFisica INT PRIMARY KEY,
  cpf VARCHAR(11) NOT NULL,
  idPessoa INT FOREIGN KEY REFERENCES Pessoa(idPessoa)
);

/*Criando a tabela PessoaJuridica*/
CREATE TABLE PessoaJuridica (
  idPessoaJuridica INT PRIMARY KEY,
  cnpj VARCHAR(14) NOT NULL,
  idPessoa INT FOREIGN KEY REFERENCES Pessoa(idPessoa)
);

/*Criando a tabela Produto*/
CREATE TABLE Produto (
  idProduto INT PRIMARY KEY,
  nome VARCHAR(255)NOT NULL,
  quantidade INT NOT NULL,  
  precoVenda NUMERIC(20, 2) NOT NULL,
);


/*Criando a tabela Movimentação*/
CREATE TABLE Movimentacao(
  id_movimento INT PRIMARY KEY,
  valor_unitario NUMERIC(20, 2) NOT NULL,
  quantidade INT NOT NULL,
  tipo CHAR NOT NULL,
  idPessoa INT FOREIGN KEY REFERENCES Pessoa(idPessoa),
  idProduto INT FOREIGN KEY REFERENCES Produto(idProduto),
  idUsuario INT FOREIGN KEY REFERENCES Usuario(idUsuario),

);


