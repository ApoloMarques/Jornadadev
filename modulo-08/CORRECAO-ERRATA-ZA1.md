# Correção da errata — tabela ZA1 e validação do cliente

## Contexto da entrega

Durante a execução do Módulo 8, tentei inicialmente desenvolver o cadastro de Pets utilizando a tabela `ZA1`, conforme indicado no material. Entretanto, a inclusão era bloqueada durante a validação do cliente, mesmo após a revisão dos campos e das expressões configuradas no dicionário de dados.

Para concluir o objetivo prático do exercício e comprovar o funcionamento do CRUD no ambiente Protheus MP8.11, reconstruí a solução utilizando a tabela `ZA2`, preservando a estrutura e a finalidade propostas. A rotina ADVPL foi compilada e executada com sucesso por meio do `AxCadastro`, permitindo visualizar, incluir, alterar e excluir registros. Os fontes e as evidências do funcionamento foram mantidos no repositório.

## Compreensão da errata publicada em 03/08

Após a publicação da errata, foi possível identificar a causa do bloqueio ocorrido na implementação original.

A chave utilizada para validar o cliente é composta pelos campos:

```text
ZA1_CLIENT + ZA1_LOJA
```

Como `ZA1_LOJA` é preenchido depois de `ZA1_CLIENT`, a validação definitiva deve ser configurada no último campo da composição, ou seja, em `ZA1_LOJA`.

### Validação correta em ZA1_LOJA

```advpl
ExistCpo("SA1", xFilial("SA1") + M->ZA1_CLIENT + M->ZA1_LOJA, 1)
```

Caso também seja necessária uma validação em `ZA1_CLIENT`, ela deve permitir que a loja ainda esteja vazia:

```advpl
Empty(M->ZA1_LOJA) .Or. ExistCpo("SA1", xFilial("SA1") + M->ZA1_CLIENT + M->ZA1_LOJA, 1)
```

Essa configuração evita que a validação seja executada com uma chave incompleta antes de o usuário informar a loja.

## Correção do campo virtual ZA1_NOMCLI

Durante a exclusão de um registro, o conteúdo de `M->ZA1_CLIENT` pode estar vazio. Portanto, a relação do campo virtual `ZA1_NOMCLI` deve ser protegida antes da execução do `POSICIONE`:

```advpl
IIf(Empty(M->ZA1_CLIENT), "", POSICIONE("SA1",1,xFilial("SA1")+M->ZA1_CLIENT+M->ZA1_LOJA,"A1_NOME"))
```

Essa proteção evita que o Protheus tente pesquisar um cliente utilizando uma chave vazia durante a exclusão.

## Chamada da validação ADVPL

Quando utilizada a função `VALCLI001`, a chamada configurada no `X3_VALID` deve conter o prefixo de função de usuário:

```advpl
U_VALCLI001()
```

Implementação correspondente:

```advpl
#include "protheus.ch"

USER FUNCTION VALCLI001()

    IF !ExistCpo("SA1", ;
                 xFilial("SA1") + M->ZA1_CLIENT + M->ZA1_LOJA, ;
                 1)

        MsgAlert("Cliente não cadastrado!", "Atenção")
        RETURN .F.

    ENDIF

RETURN .T.
```

A função deve estar compilada e incluída no projeto do DevStudio. A expressão também deve permanecer em uma única linha quando for inserida pelo Configurador, evitando quebras invisíveis provenientes da cópia do PDF.

## Rotina correspondente à tabela ZA1

A versão alinhada à nomenclatura corrigida do material seria:

```advpl
#include "protheus.ch"

USER FUNCTION STTIP001()

    PRIVATE cCadastro := "Pets"

    dbSelectArea("ZA1")
    dbSetOrder(1)

    AxCadastro("ZA1", "Pets", , "1", , , , .F.)

RETURN NIL
```

## Resultado alcançado

O objetivo prático do exercício foi alcançado na implementação entregue:

* criação e configuração de tabela customizada;
* configuração dos campos e índices;
* relacionamento do Pet com o cadastro de clientes;
* desenvolvimento e compilação da rotina ADVPL;
* execução do CRUD com `AxCadastro`;
* inclusão, consulta, alteração e exclusão de registros;
* registro das evidências do sistema funcionando.

A utilização da tabela `ZA2` foi uma adaptação técnica realizada para contornar o bloqueio existente antes da publicação da errata. A correção oficial foi compreendida e está documentada neste arquivo, incluindo a posição correta da validação da chave composta e a proteção necessária para o campo virtual durante a exclusão.
