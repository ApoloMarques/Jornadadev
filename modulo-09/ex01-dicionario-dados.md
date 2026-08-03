# Exercício 01 - Dicionário de Dados

## Objetivo

Configurar o dicionário de dados do projeto de Contatos e Interações no Protheus.

## Tabelas criadas

### SZ1 - Contatos

Tabela destinada ao cadastro de contatos.

### SZ2 - Interações

Tabela destinada ao registro das interações realizadas com cada contato.

## Campos configurados

### SZ2

- Z2_FILIAL
- Z2_CONTAT
- Z2_SEQUEN
- Z2_TIPO
- Z2_DESCRI
- Z2_DATA
- Z2_HORA
- Z2_USUAR
- Z2_CODIGO (Virtual)
- Z2_ASSUNT (Virtual)

## Índices

### SZ1

Ordem 1

```
Z1_FILIAL + Z1_CODIGO
```

### SZ2

Ordem 1

```
Z2_FILIAL + Z2_CONTAT + Z2_SEQUEN
```

## Tabela Genérica (SX5)

Criado o domínio **Z2** contendo os tipos de interação:

| Código | Descrição |
|--------|-----------|
| E | Email |
| L | Ligação |
| R | Reunião |
| V | Visita |
| W | WhatsApp |

## Evidências

As imagens deste exercício encontram-se na pasta de evidências do módulo.