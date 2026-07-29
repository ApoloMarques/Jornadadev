# Exercício 02 – Estrutura da Tabela ZA1 (Pets)

## a. Estrutura da tabela ZA1

A tabela ZA1 foi definida para armazenar o cadastro de pets e posteriormente implementada no Configurador do Protheus com os seguintes campos:

| Campo       | Tipo     | Tamanho |
|-------------|----------|---------|
| ZA1_FILIAL  | Caracter | 2       |
| ZA1_NOME    | Caracter | 30      |
| ZA1_RACADO  | Caracter | 30      |
| ZA1_DATA    | Data     | 8       |
| ZA1_CLIENT  | Caracter | 30      |

O campo `ZA1_FILIAL` é obrigatório, pois identifica a filial à qual o registro pertence.

---

## b. Que índice faria sentido para a ZA1? Justifique.

Um índice pelo campo `ZA1_NOME` faz sentido, pois facilita a localização rápida dos pets cadastrados. Assim como em uma lista telefônica, o índice organiza os registros e torna a pesquisa mais eficiente.

---

## c. Por que o prefixo da tabela é "Z"?

O prefixo `Z` indica que a tabela é uma customização do cliente. Essa convenção evita conflitos com as tabelas padrão do Protheus e facilita a identificação de objetos desenvolvidos especificamente para o ambiente.

---

## d. Por que os campos começam com ZA1_?

Os campos utilizam o prefixo da tabela para manter um padrão de identificação dentro do Protheus. Dessa forma, fica claro a qual tabela cada campo pertence, evitando conflitos e facilitando a organização e a manutenção do sistema.