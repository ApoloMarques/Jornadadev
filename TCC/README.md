# Controle de Fornecimento e Ocorrências de Fornecedor

> Solução desenvolvida em ADVPL para controle de certificações, ocorrências e não conformidades de fornecedores no Protheus MP8.11.

**Autor:** José Apolo Marques Nascimento  
**Formação:** Jornada DEV  
**Área:** Desenvolvimento Protheus e ADVPL  
**Módulo:** Compras — SIGACOM  
**Status:** Concluído e validado  
**Conclusão:** Agosto de 2026  

---

## Visão geral

Este projeto foi desenvolvido como Trabalho de Conclusão de Curso da Jornada DEV, aplicando conhecimentos de desenvolvimento ADVPL e personalização do ERP Protheus.

A solução permite controlar certificações de fornecedores, acompanhar seus vencimentos, registrar ocorrências de fornecimento e comparar o percentual de não conformidade com a tolerância definida para cada controle.

O projeto foi integrado ao módulo de Compras e pode ser acessado diretamente pelo menu do SIGACOM.

---

## Principais resultados

- criação das tabelas personalizadas `ZZ1` e `ZZ2`;
- configuração de campos, índices, validações e gatilhos;
- desenvolvimento de rotinas de manutenção com `mBrowse`;
- integração das rotinas ao menu do módulo de Compras;
- preenchimento automático de fornecedor, produto, data e hora;
- cálculo automático do percentual de não conformidade;
- indicadores visuais para certificados e ocorrências;
- consulta filtrada das ocorrências por controle;
- modularização por meio de biblioteca reutilizável;
- tratamento controlado de erros e geração de log;
- organização completa dos fontes, dados e evidências.

---

## Funcionalidades

### Controle de Fornecimento — ZZ1

A rotina `STTZZ1.PRW` permite:

- pesquisar, visualizar, incluir, alterar e excluir controles;
- relacionar fornecedores e certificados;
- acompanhar a validade das certificações;
- identificar visualmente a situação de cada certificado;
- consultar as ocorrências vinculadas ao controle selecionado.

### Ocorrências do Fornecedor — ZZ2

A rotina `STTZZ2.PRW` permite:

- pesquisar, visualizar, incluir, alterar e excluir ocorrências;
- relacionar produtos ao controle de fornecimento;
- registrar automaticamente data e hora;
- calcular o percentual de não conformidade;
- comparar o resultado com a tolerância cadastrada;
- consultar todas as ocorrências ou somente as de um controle.

### Biblioteca — STTZZLIB

O fonte `STTZZLIB.PRW` centraliza funções reutilizáveis para:

- consultar o nome do fornecedor;
- consultar a descrição do produto;
- calcular o percentual de não conformidade;
- verificar certificados próximos do vencimento;
- registrar informações técnicas de erros.

---

## Regras de negócio

### Situação dos certificados

| Indicador | Regra |
|---|---|
| 🟢 Verde | Certificado válido por mais de 30 dias |
| 🟡 Amarelo | Vencimento dentro dos próximos 30 dias |
| 🔴 Vermelho | Certificado vencido |

O sistema também impede a inclusão de novos certificados com validade anterior à data-base do ambiente.

### Não conformidade

O percentual é calculado pela seguinte regra:

```text
Percentual = (Quantidade não conforme / Quantidade total) × 100
```

| Indicador | Regra |
|---|---|
| 🟢 Verde | Percentual dentro da tolerância |
| 🔴 Vermelho | Percentual acima da tolerância |

A tolerância utilizada na análise é obtida no Controle de Fornecimento relacionado à ocorrência.

---

## Automatizações e validações

Foram configurados recursos no Dicionário de Dados para:

- validar a existência do controle;
- validar o fornecedor informado;
- validar o produto informado;
- preencher automaticamente o nome do fornecedor;
- preencher automaticamente a descrição do produto;
- preencher data e hora da ocorrência;
- calcular o percentual de não conformidade;
- impedir novas inclusões com certificado vencido;
- relacionar corretamente as ocorrências à tabela principal.

---

## Integração com o Protheus

As rotinas foram adicionadas ao módulo de Compras no caminho:

```text
Atualizações > Cadastros
```

Itens configurados:

| Item do menu | Programa | Tabela |
|---|---|---|
| Controle de Fornecimento | `STTZZ1` | `ZZ1` |
| Ocorrências de Fornecedor | `STTZZ2` | `ZZ2` |

A rotina principal também possui o botão **Ocorrências**, que abre a `STTZZ2` filtrando os registros pelo controle selecionado.

---

## Tratamento de erros

As rotinas utilizam:

- `ErrorBlock()`;
- `BEGIN SEQUENCE`;
- `RECOVER USING`;
- `GetArea()` e `RestArea()`;
- mensagens controladas para o usuário;
- registro técnico em arquivo de log.

O log pode registrar data, hora, função, usuário, empresa, filial, descrição do erro, procedimento, linha, subsistema e operação.

---

## Estrutura do projeto

```text
TCC
├── Dados-e-Dicionario
│   ├── arquivos SX2, SX3, SX7 e SIX
│   ├── tabelas físicas ZZ1 e ZZ2
│   ├── índices CDX
│   └── menu SIGACOM.XNU
│
├── evidencias
│   └── configurações, desenvolvimento, testes e validações
│
├── fontes
│   ├── STTZZ1.PRW
│   ├── STTZZ2.PRW
│   └── STTZZLIB.PRW
│
├── Projeto-TCC.PRJ
└── README.md
```

---

## Testes realizados

A solução foi validada nos seguintes cenários:

- acesso às rotinas pelo menu do SIGACOM;
- inclusão e manutenção de controles;
- inclusão e manutenção de ocorrências;
- validação de fornecedor e produto;
- preenchimento automático de descrições;
- preenchimento automático de data e hora;
- cálculo do percentual de não conformidade;
- bloqueio de certificados vencidos;
- indicadores verde, amarelo e vermelho na `ZZ1`;
- indicadores verde e vermelho na `ZZ2`;
- consulta das ocorrências pelo controle selecionado;
- acesso direto à rotina de ocorrências;
- compilação dos fontes sem mensagens;
- funcionamento após a integração da biblioteca;
- restauração e validação final do Dicionário de Dados.

---

## Tecnologias e ferramentas

- Protheus MP8.11;
- ADVPL;
- MP8 IDE;
- Configurador Protheus;
- Dicionário de Dados;
- módulo de Compras — SIGACOM;
- Visual Studio Code;
- Git e GitHub;
- Windows.

---

## Competências demonstradas

Este projeto evidencia conhecimentos práticos em:

- análise de requisitos;
- modelagem de tabelas personalizadas;
- configuração do Dicionário de Dados;
- criação de campos, índices e gatilhos;
- desenvolvimento de rotinas ADVPL;
- utilização de `mBrowse` e `aRotina`;
- aplicação de regras de negócio;
- modularização e reutilização de código;
- tratamento de erros;
- depuração e testes funcionais;
- documentação técnica;
- organização profissional de evidências.

---

## Resultado

A solução foi concluída e validada no ambiente **Teste/Matriz**, empresa **99**, demonstrando uma personalização funcional e integrada ao Protheus MP8.11.

O resultado atende ao objetivo de controlar certificações de fornecedores, registrar ocorrências, automatizar cálculos e facilitar a identificação de riscos por meio de indicadores visuais.

---

## Autor

### José Apolo Marques Nascimento

Responsável pela análise, configuração, desenvolvimento, testes, correções, documentação e organização da entrega.

Projeto desenvolvido como parte da **Jornada DEV**, com foco em desenvolvimento Protheus, programação ADVPL e construção de soluções alinhadas às necessidades de negócio.