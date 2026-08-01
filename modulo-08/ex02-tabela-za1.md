# Exercício 2 — Completando a tabela ZA2

A tabela ZA2 foi configurada no dicionário de dados do Protheus para realizar o cadastro de pets vinculados a um cliente da tabela SA1.

## Estrutura criada

Foram configurados os seguintes campos:

- ZA2_FILIAL
- ZA2_COD
- ZA2_CLIENT
- ZA2_LOJA
- ZA2_NOMCLI
- ZA2_NOME
- ZA2_RACA
- ZA2_DTNASC

O campo `ZA2_NOMCLI` foi definido como virtual.

## Índices

Foram configurados os seguintes índices:

1. `ZA2_FILIAL + ZA2_COD`
2. `ZA2_FILIAL + ZA2_CLIENT + ZA2_LOJA`

## Evidências

- [SX2 — Tabela ZA2](evidencias/01-sx2-tabela-za2.png)
- [SX3 — Campos da ZA2](evidencias/02-sx3-campos-za2.png)
- [SIX — Índices da ZA2](evidencias/03-six-indices-za2.png)

## Observação

Para a realização deste exercício foi utilizada a tabela **ZA2**, mantendo a mesma estrutura, campos, índices e funcionalidades solicitadas para a **ZA1** no enunciado, conforme a configuração disponível no ambiente utilizado.