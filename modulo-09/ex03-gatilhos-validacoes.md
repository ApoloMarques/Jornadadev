# Exercício 03 — Gatilhos, Campos Virtuais e Validações Cruzadas

## Objetivo

Configurar a tabela `SZ2 — Interações` para:

- preencher automaticamente data, hora e usuário;
- validar se o contato informado existe na tabela `SZ1`;
- exibir dados relacionados ao contato por meio de campos virtuais.

## Configurações realizadas

### 1. Validação cruzada do contato

No campo `Z2_CONTAT`, foi configurada uma validação para permitir somente códigos existentes na tabela `SZ1`.

Expressão utilizada:

```advpl
ExistCpo("SZ1", M->Z2_CONTAT, 1)
```

Durante o teste, o sistema aceitou o contato existente `000001` e recusou um código inexistente.

---

### 2. Preenchimento automático da data

No campo `Z2_DATA`, foi configurado o preenchimento automático com a data do sistema.

Expressão utilizada:

```advpl
dDataBase
```

---

### 3. Preenchimento automático da hora

No campo `Z2_HORA`, foi configurado o preenchimento automático da hora durante a inclusão.

Expressão utilizada:

```advpl
IF(INCLUI, Time(), SZ2->Z2_HORA)
```

---

### 4. Preenchimento automático do usuário

No campo `Z2_USUAR`, foi configurado o preenchimento automático com o usuário conectado ao sistema.

Expressão utilizada:

```advpl
cNomUsr
```

---

### 5. Campo virtual — Código do contato

O campo virtual `Z2_CODIGO` foi configurado para buscar o código do contato na tabela `SZ1`.

Inicializador padrão:

```advpl
POSICIONE("SZ1", 1, XFILIAL("SZ1") + M->Z2_CONTAT, "Z1_CODIGO")
```

Inicializador do browse:

```advpl
POSICIONE("SZ1", 1, XFILIAL("SZ1") + SZ2->Z2_CONTAT, "Z1_CODIGO")
```

---

### 6. Campo virtual — Assunto

O campo virtual `Z2_ASSUNT` foi configurado para buscar o assunto do contato na tabela `SZ1`.

Inicializador padrão:

```advpl
POSICIONE("SZ1", 1, XFILIAL("SZ1") + M->Z2_CONTAT, "Z1_ASSUNTO")
```

Inicializador do browse:

```advpl
POSICIONE("SZ1", 1, XFILIAL("SZ1") + SZ2->Z2_CONTAT, "Z1_ASSUNTO")
```

---

## Testes realizados

Durante a inclusão de uma nova interação, o sistema:

- aceitou o contato existente `000001`;
- recusou um código de contato inexistente;
- preencheu automaticamente a data;
- preencheu automaticamente a hora;
- preencheu automaticamente o usuário;
- exibiu no browse o código do contato;
- exibiu no browse o assunto `TESTE JORNADA DEV`.

## Resultado obtido

As validações, os preenchimentos automáticos e os campos virtuais funcionaram corretamente.

O relacionamento entre as tabelas `SZ1 — Contatos` e `SZ2 — Interações` foi validado com sucesso.

## Status

✅ Exercício concluído com sucesso.