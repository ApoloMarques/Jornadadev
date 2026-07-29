# Exercício 03 – Recriando a ZA1 no Configurador

## Objetivo

Recriar a tabela customizada ZA1 no Configurador do Protheus, forçar seu reconhecimento pelo framework e validar sua criação no MPSDU.

## Passos realizados

1. Acessei o Configurador (SIGACFG).

2. Cadastrei a tabela customizada ZA1 no dicionário de dados (SX2).

3. Cadastrei os campos da tabela no SX3:

- `ZA1_FILIAL`
- `ZA1_NOME`
- `ZA1_RACADO`
- `ZA1_DATA`
- `ZA1_CLIENT`

A estrutura cadastrada corresponde à definição apresentada no Exercício 02.

4. No SIGAMDI, acessei o Cadastro de Fórmulas.

5. Criei a fórmula abaixo para forçar o reconhecimento da tabela pelo framework:

```advpl
dbSelectArea("ZA1")