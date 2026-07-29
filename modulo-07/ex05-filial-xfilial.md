# Exercício 05 – A1_FILIAL e xFilial()

## a) Por que existe o campo A1_FILIAL?

O campo A1_FILIAL identifica a filial à qual cada registro pertence. Como o Protheus pode ser utilizado por empresas com várias filiais, esse campo permite separar corretamente os dados de cada unidade. Por esse motivo, toda tabela do sistema, inclusive tabelas customizadas como a ZA1, deve possuir um campo de filial.

## b) O que faz a função xFilial()?

A função xFilial() retorna automaticamente a filial correta para a tabela utilizada, de acordo com o ambiente em que o usuário está trabalhando. Dessa forma, o sistema grava e consulta os dados na filial correta.

Se um programa informasse a filial manualmente, poderiam ocorrer erros caso a empresa, a filial ou a configuração do ambiente fossem alteradas. O uso da função xFilial() evita esses problemas e torna o código mais seguro e compatível com diferentes ambientes do Protheus.