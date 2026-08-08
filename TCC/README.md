# Controle de Fornecimento e Ocorrências de Fornecedores

> Solução desenvolvida em ADVPL para controle de certificações, ocorrências e não conformidades de fornecedores no Protheus MP8.11.

**Autor:** José Apolo Marques Nascimento  
**Formação:** Jornada DEV START  
**Área:** Desenvolvimento Protheus e ADVPL  
**Módulo:** Compras — SIGACOM  
**Ambiente:** Teste/Matriz — Empresa 99  
**Status:** Concluído e validado  
**Conclusão:** Agosto de 2026  

---

## 📌 Visão Geral

Este projeto foi desenvolvido como Trabalho de Conclusão de Curso da **Jornada DEV START**, aplicando conhecimentos de desenvolvimento ADVPL, configuração do Dicionário de Dados e personalização do ERP Protheus.

A solução implementa um processo de **Controle de Fornecimento**, permitindo controlar certificações de fornecedores, acompanhar seus vencimentos, registrar ocorrências de fornecimento e analisar o percentual de não conformidade em relação à tolerância estabelecida para cada controle.

As rotinas foram integradas ao módulo de **Compras — SIGACOM** e testadas diretamente no ambiente **Protheus MP8.11**.

---

## 🎯 Objetivos do Projeto

O projeto tem como principais objetivos:

- controlar certificações de fornecedores;
- acompanhar a validade dos certificados;
- relacionar fornecedores aos controles de fornecimento;
- registrar ocorrências associadas aos controles;
- relacionar produtos cadastrados no Protheus;
- registrar quantidades conformes e não conformes;
- calcular automaticamente os valores financeiros;
- calcular o percentual de não conformidade;
- comparar o percentual encontrado com a tolerância definida;
- apresentar indicadores visuais para facilitar a identificação de situações críticas;
- centralizar funções comuns em uma biblioteca reutilizável;
- aplicar tratamento estruturado de erros;
- organizar uma entrega reproduzível e compatível com correção automatizada.

---

# 🗃️ Dicionário de Dados

Foram criadas duas tabelas customizadas para implementação da solução:

| Tabela | Descrição |
|---|---|
| `ZZ1` | Controle de Fornecimento |
| `ZZ2` | Ocorrências do Fornecedor |

Além das tabelas, foram configurados:

- campos;
- índices;
- validações;
- gatilhos;
- consultas padrão;
- campos virtuais;
- inicializadores;
- formatos;
- regras de negócio.

O Dicionário de Dados foi atualizado e validado no ambiente após as configurações finais.

---

# 🟦 Controle de Fornecimento — ZZ1

A rotina principal está implementada no fonte:

```text
STTZZ1.PRW
```

Ela utiliza `mBrowse` e disponibiliza as principais operações de manutenção dos registros.

### Funcionalidades

- Pesquisar;
- Visualizar;
- Incluir;
- Alterar;
- Excluir;
- Consultar ocorrências vinculadas ao controle selecionado.

A rotina utiliza:

```advpl
PRIVATE aRotina := {;
    {"Pesquisar"  , "AxPesqui"    , 0, 1},;
    {"Visualizar" , "AxVisual"    , 0, 2},;
    {"Incluir"    , "AxInclui"    , 0, 3},;
    {"Alterar"    , "AxAltera"    , 0, 4},;
    {"Excluir"    , "AxDeleta"    , 0, 5},;
    {"Ocorrencias", "U_STTZZ1OCO", 0, 6};
}
```

O botão **Ocorrências** abre a rotina da ZZ2 filtrando os registros pelo Controle de Fornecimento selecionado.

---

## 🚦 Situação dos Certificados

O browse da ZZ1 apresenta indicadores visuais de acordo com a validade do certificado.

| Indicador | Situação |
|---|---|
| 🟢 Verde | Certificado válido |
| 🟡 Amarelo | Certificado com vencimento nos próximos 30 dias |
| 🔴 Vermelho | Certificado vencido |

A legenda é controlada pela validade informada no registro e pela função compartilhada:

```advpl
U_CERTIFICADOVENCENDO()
```

Os três estados foram testados e comprovados no ambiente Protheus.

---

## ✅ Validações da ZZ1

Entre as regras testadas estão:

### Validade do certificado

O sistema bloqueia uma validade anterior à data-base permitida pelo ambiente.

### Tolerância

O campo de tolerância aceita somente valores dentro do intervalo:

```text
0 a 100
```

Durante os testes, o valor:

```text
101
```

foi corretamente bloqueado.

### Fornecedor

O fornecedor e a loja são validados utilizando o cadastro padrão `SA2`.

Também foi validado o preenchimento automático do nome do fornecedor.

---

# 🟩 Ocorrências do Fornecedor — ZZ2

A rotina está implementada no fonte:

```text
STTZZ2.PRW
```

A solução permite tanto uma consulta geral da ZZ2 quanto uma consulta filtrada pelo Controle de Fornecimento selecionado na ZZ1.

### Funcionalidades

- Pesquisar;
- Visualizar;
- Incluir;
- Alterar;
- Excluir;
- Consultar todas as ocorrências;
- Consultar ocorrências filtradas por controle;
- Relacionar fornecedor e loja;
- Relacionar produto;
- Registrar data;
- Registrar hora;
- Registrar quantidades conformes;
- Registrar quantidades não conformes;
- Informar valor unitário;
- Calcular valores financeiros;
- Comparar percentual de não conformidade com a tolerância;
- Exibir legenda visual de conformidade.

---

## 🔗 Integração ZZ1 → ZZ2

A partir do Controle de Fornecimento selecionado na ZZ1, a rotina chama:

```advpl
U_STTZZ2FLT(cCodigo)
```

A ZZ2 aplica o filtro correspondente ao controle:

```advpl
cFiltro := "AllTrim(ZZ2->ZZ2_CONFOR) == '" + ;
           cCodigoZZ1 + "'"
```

Esse relacionamento foi testado diretamente no Protheus.

---

## 🔍 Validação do Controle

O campo de controle da ZZ2 foi configurado para consultar registros existentes da ZZ1.

Foram realizados dois testes:

### Controle válido

```text
000004
```

Resultado:

- código aceito;
- fornecedor preenchido;
- loja preenchida;
- nome do fornecedor preenchido;
- fluxo liberado para os demais campos.

### Controle inexistente

```text
999999
```

Resultado:

```text
Não existe registro relacionado a este código.
```

O valor foi corretamente bloqueado pelo Protheus.

---

# 📦 Validação de Produto

O produto da ocorrência é relacionado ao cadastro padrão:

```text
SB1 = Produto
```

Foi utilizada Consulta Padrão da `SB1`, permitindo localizar produtos cadastrados.

Produto utilizado nos testes:

```text
PROD001
```

Descrição cadastrada:

```text
PRODUTO TESTE ISO 9001
```

A validação foi testada diretamente na inclusão da ocorrência.

---

# 🕒 Data e Hora

Os campos de data e hora possuem inicialização automática.

A hora utiliza:

```advpl
TIME()
```

Durante a inclusão de ocorrências, os valores foram carregados automaticamente.

---

# 💰 Cálculos Financeiros

A ZZ2 possui campos para:

```text
Quantidade Conforme
Quantidade Não Conforme
Valor Unitário
R$ Conforme
R$ Não Conforme
```

Os totais são calculados automaticamente.

### R$ Conforme

```advpl
M->ZZ2_QTDOK * M->ZZ2_VLRUNI
```

### R$ Não Conforme

```advpl
M->ZZ2_QTDNOK * M->ZZ2_VLRUNI
```

---

## 🖥️ Campos Virtuais no Browse

Os campos financeiros são virtuais.

Para que também fossem apresentados corretamente durante a navegação do `mBrowse`, foram configurados inicializadores específicos para o browse.

### ZZ2_TOTOK

Inicializador padrão:

```advpl
M->ZZ2_QTDOK*M->ZZ2_VLRUNI
```

Inicializador do browse:

```advpl
ZZ2->ZZ2_QTDOK*ZZ2->ZZ2_VLRUNI
```

### ZZ2_TOTNOK

Inicializador padrão:

```advpl
M->ZZ2_QTDNOK*M->ZZ2_VLRUNI
```

Inicializador do browse:

```advpl
ZZ2->ZZ2_QTDNOK*ZZ2->ZZ2_VLRUNI
```

O mesmo princípio foi aplicado ao nome do fornecedor para garantir sua apresentação correta durante a navegação dos registros.

Após a configuração, os valores passaram a ser apresentados corretamente no browse.

---

# 📊 Percentual de Não Conformidade

O percentual é calculado pela biblioteca compartilhada.

A regra utilizada é:

```text
Percentual =
Quantidade Não Conforme
------------------------ × 100
Quantidade Total
```

onde:

```text
Quantidade Total =
Quantidade Conforme + Quantidade Não Conforme
```

Em ADVPL:

```advpl
RETURN IIF(nOk + nNok > 0, ;
           (nNok / (nOk + nNok)) * 100, 0)
```

A função também evita divisão por zero.

---

# 🚦 Legenda de Não Conformidade

A ZZ2 compara o percentual de não conformidade da ocorrência com a tolerância cadastrada na ZZ1.

| Indicador | Situação |
|---|---|
| 🟢 Verde | Percentual dentro da tolerância |
| 🔴 Vermelho | Percentual acima da tolerância |

A tolerância é recuperada diretamente do Controle de Fornecimento relacionado.

---

## 🧪 Cenários de Teste

### Cenário 1

```text
Quantidade Conforme:     90
Quantidade Não Conforme: 10
Valor Unitário:          25,00
```

Resultado:

```text
R$ Conforme:     2.250,00
R$ Não Conforme:   250,00
```

Percentual de não conformidade:

```text
10%
```

Resultado visual:

```text
🔴 Vermelho
```

---

### Cenário 2

```text
Quantidade Conforme:     99
Quantidade Não Conforme: 1
Valor Unitário:          25,00
```

Resultado:

```text
R$ Conforme:     2.475,00
R$ Não Conforme:    25,00
```

Percentual de não conformidade:

```text
1%
```

Resultado visual:

```text
🟢 Verde
```

Os dois cenários foram gravados e validados no browse da ZZ2.

---

# 🧩 Biblioteca Compartilhada — STTZZLIB

O fonte:

```text
STTZZLIB.PRW
```

centraliza funções utilizadas pelas rotinas principais.

### Funções implementadas

#### NomeFornecedor()

Consulta o nome do fornecedor na tabela `SA2`.

```advpl
USER FUNCTION NomeFornecedor(cFornec, cLoja)
```

---

#### NomeProduto()

Consulta a descrição do produto na tabela `SB1`.

```advpl
USER FUNCTION NomeProduto(cCodPro)
```

---

#### PercNaoConforme()

Calcula o percentual de não conformidade.

```advpl
USER FUNCTION PercNaoConforme(nOk, nNok)
```

---

#### CertificadoVencendo()

Identifica certificados cuja validade está dentro dos próximos 30 dias.

```advpl
USER FUNCTION CertificadoVencendo(dValCer)
```

---

#### GravarLogTCC()

Registra informações técnicas relacionadas aos erros tratados pelas rotinas.

```advpl
USER FUNCTION GravarLogTCC(cFuncao, oErro)
```

A centralização dessas funções reduz duplicação de código e melhora a manutenção da solução.

---

# 🛡️ Tratamento de Erros

As rotinas principais utilizam tratamento estruturado de erros.

Entre os recursos aplicados estão:

```advpl
ErrorBlock()
BEGIN SEQUENCE
RECOVER USING oError
GetArea()
RestArea()
```

Exemplo utilizado na rotina:

```advpl
BEGIN SEQUENCE

    // processamento da rotina

RECOVER USING oError

    U_GRAVARLOGTCC("STTZZ1", oError)

    MsgStop("Ocorreu um erro no Controle de Fornecimento.",;
            "Controle de Fornecimento")

END SEQUENCE
```

O tratamento permite apresentar uma mensagem amigável ao usuário e registrar informações técnicas separadamente.

---

# 📝 Log Técnico

A função:

```advpl
U_GRAVARLOGTCC()
```

pode registrar informações como:

- data;
- hora;
- função;
- usuário;
- empresa;
- filial;
- descrição do erro;
- procedimento;
- linha;
- subsistema;
- operação.

O arquivo é gerado na estrutura do ambiente Protheus.

---

# 🛒 Integração com o SIGACOM

As rotinas foram disponibilizadas no módulo:

```text
Compras — SIGACOM
```

dentro de:

```text
Atualizações > Cadastros
```

Itens configurados:

| Item | Programa | Tabela |
|---|---|---|
| Controle de Fornecimento | `STTZZ1` | `ZZ1` |
| Ocorrências de Fornecimento | `STTZZ2` | `ZZ2` |

As rotinas foram testadas através dos itens de menu configurados no SIGACOM.

---

# 📁 Estrutura Final da Entrega

```text
TCC/
│
├── AUTOAVALIACAO.md
├── README.md
│
├── Dados-e-Dicionario/
│   ├── converte-dicionario.prg
│   │
│   ├── sa2990.dbf
│   ├── sb1990.dbf
│   ├── sigacom.xnu
│   │
│   ├── six990.dbf
│   ├── six990.csv
│   │
│   ├── sx2990.dbf
│   ├── sx2990.csv
│   │
│   ├── sx3990.dbf
│   ├── sx3990.csv
│   │
│   ├── sx7990.dbf
│   ├── sx7990.csv
│   │
│   ├── sxb990.dbf
│   ├── sxb990.csv
│   │
│   ├── zz1990.dbf
│   ├── zz1990.csv
│   │
│   ├── zz2990.dbf
│   └── zz2990.csv
│
├── evidencias/
│   ├── evidencia-01-estrutura-final-tabela-zz2.png
│   ├── evidencia-02-indices-finais-tabela-zz2.png
│   ├── evidencia-03-estrutura-final-tabela-zz1.png
│   ├── evidencia-04-indices-finais-tabela-zz1.png
│   ├── evidencia-05-consulta-sb1-produto-final.png
│   ├── evidencia-06-consulta-zz1-controle-fornecimento-final.png
│   ├── evidencia-07-compilacao-final-fontes-tcc-sem-erros.png
│   ├── evidencia-08-sttzz1-browse-legendas-funcionais.png
│   ├── evidencia-09-zz2-ocorrencia-gravada-com-calculos.png
│   ├── evidencia-10-zz2-legenda-nao-conformidade-vermelho-verde.png
│   └── evidencia-11-zz1-legenda-status-certificados.png
│
└── fontes/
    ├── STTZZ1.PRW
    ├── STTZZ2.PRW
    ├── STTZZLIB.PRW
    └── TCC.PRJ
```

---

# 📚 Arquivos de Dados e Dicionário

A pasta:

```text
Dados-e-Dicionario
```

contém os arquivos necessários para análise da configuração e dos dados utilizados no projeto.

---

## Massa de Teste

### SA2990

```text
sa2990.dbf
```

Contém o fornecedor utilizado nos testes do TCC.

Fornecedor utilizado:

```text
Código: 000001
Loja:   01
Nome:   FORNECEDOR TESTE TCC
```

---

### SB1990

```text
sb1990.dbf
```

Contém o produto utilizado nas ocorrências.

Produto utilizado:

```text
Código:    PROD001
Descrição: PRODUTO TESTE ISO 9001
```

---

# 📖 Arquivos do Dicionário

## SX2 — Definição das Tabelas

```text
sx2990.dbf
sx2990.csv
```

---

## SX3 — Definição dos Campos

```text
sx3990.dbf
sx3990.csv
```

---

## SIX — Índices

```text
six990.dbf
six990.csv
```

---

## SX7 — Gatilhos

```text
sx7990.dbf
sx7990.csv
```

---

## SXB — Consultas Padrão

```text
sxb990.dbf
sxb990.csv
```

Esse arquivo contempla as Consultas Padrão utilizadas nas integrações do projeto.

---

# 🗄️ Dados das Tabelas Customizadas

## ZZ1

```text
zz1990.dbf
zz1990.csv
```

Contém os registros do Controle de Fornecimento utilizados durante os testes.

---

## ZZ2

```text
zz2990.dbf
zz2990.csv
```

Contém as ocorrências utilizadas para validação dos cálculos e das legendas.

---

# 🤖 Compatibilidade com Correção Automatizada

Além dos arquivos originais em formato `DBF`, os principais arquivos utilizados pela solução também foram disponibilizados em formato `CSV`.

Essa estratégia permite que o conteúdo seja analisado mesmo quando uma ferramenta de correção não possui suporte direto ao formato DBF utilizado pelo Protheus MP8.11.

Foram disponibilizados em **DBF + CSV**:

```text
SIX990
SX2990
SX3990
SX7990
SXB990
ZZ1990
ZZ2990
```

---

## Utilitário de Conversão

Também foi incluído o fonte:

```text
Dados-e-Dicionario/converte-dicionario.prg
```

O utilitário foi desenvolvido em Harbour para exportar os DBFs para CSV.

Os arquivos foram convertidos após a preparação final do Dicionário de Dados e da massa de teste.

---

# 📸 Evidências

A pasta:

```text
evidencias/
```

contém **11 evidências finais**, selecionadas para demonstrar os principais requisitos e resultados do projeto.

| Nº | Evidência |
|---|---|
| 01 | Estrutura final da tabela ZZ2 |
| 02 | Índices finais da tabela ZZ2 |
| 03 | Estrutura final da tabela ZZ1 |
| 04 | Índices finais da tabela ZZ1 |
| 05 | Consulta padrão SB1 — Produto |
| 06 | Consulta padrão ZZ1 — Controle de Fornecimento |
| 07 | Compilação final dos fontes sem erros |
| 08 | Browse STTZZ1 e funcionamento das legendas |
| 09 | Ocorrência ZZ2 gravada com cálculos |
| 10 | Legenda de não conformidade vermelho/verde |
| 11 | Status dos certificados na ZZ1 |

As evidências foram selecionadas priorizando telas que demonstram efetivamente o funcionamento final da solução.

---

# 🧪 Testes Realizados

A solução foi validada em diferentes cenários, incluindo:

- acesso às rotinas pelo SIGACOM;
- inclusão de Controle de Fornecimento;
- alteração de registros;
- pesquisa;
- visualização;
- exclusão disponível nas rotinas;
- inclusão de ocorrência;
- gravação de ocorrência;
- relacionamento ZZ1 → ZZ2;
- consulta filtrada das ocorrências;
- validação de fornecedor;
- validação de fornecedor + loja;
- preenchimento automático do nome do fornecedor;
- validação de Controle de Fornecimento existente;
- bloqueio de Controle de Fornecimento inexistente;
- consulta padrão do Controle de Fornecimento;
- consulta padrão da SB1;
- validação de produto;
- preenchimento automático de data;
- preenchimento automático de hora;
- registro de quantidade conforme;
- registro de quantidade não conforme;
- registro de valor unitário;
- cálculo de R$ Conforme;
- cálculo de R$ Não Conforme;
- apresentação correta dos campos virtuais no browse;
- validação de validade do certificado;
- validação de tolerância entre 0 e 100;
- certificado válido;
- certificado próximo do vencimento;
- certificado vencido;
- ocorrência dentro da tolerância;
- ocorrência acima da tolerância;
- legenda verde;
- legenda amarela;
- legenda vermelha;
- integração das rotinas com a biblioteca;
- tratamento de erros;
- compilação final dos fontes.

---

# ✅ Compilação

Os três principais fontes foram compilados com sucesso:

```text
STTZZ1.PRW
STTZZ2.PRW
STTZZLIB.PRW
```

A compilação final foi realizada sem erros.

O projeto utilizado está disponível em:

```text
fontes/TCC.PRJ
```

---

# 🧹 Qualidade do Código

Durante o desenvolvimento foram aplicadas boas práticas como:

- organização e indentação;
- separação de responsabilidades;
- reaproveitamento de funções;
- biblioteca compartilhada;
- documentação no padrão `Protheus.doc`;
- preservação das áreas de trabalho;
- utilização de `GetArea()` e `RestArea()`;
- tratamento estruturado de erros;
- mensagens amigáveis;
- registro técnico de exceções;
- validações no Dicionário de Dados;
- código modularizado.

---

# 🛠️ Tecnologias e Ferramentas

- Protheus MP8.11;
- ADVPL;
- Harbour;
- MP8 IDE;
- Configurador Protheus;
- Dicionário de Dados;
- Compras — SIGACOM;
- Visual Studio Code;
- Git;
- GitHub;
- Windows.

---

# 💡 Competências Demonstradas

O desenvolvimento deste TCC envolveu conhecimentos práticos em:

- análise de requisitos;
- desenvolvimento ADVPL;
- arquitetura e funcionamento do Protheus;
- configuração do Dicionário de Dados;
- criação de tabelas customizadas;
- criação e configuração de campos;
- índices;
- gatilhos;
- consultas padrão;
- validações;
- campos virtuais;
- inicializadores de browse;
- `mBrowse`;
- `aRotina`;
- relacionamento entre tabelas;
- integração com tabelas padrão;
- regras de negócio;
- modularização;
- reutilização de código;
- tratamento de erros;
- geração de logs;
- depuração;
- testes funcionais;
- análise de erros;
- correção de configurações;
- Git e GitHub;
- documentação técnica;
- organização de evidências;
- preparação de entrega reproduzível.

---

# 🏁 Resultado Final

A solução foi concluída, compilada e validada no ambiente:

```text
Teste/Matriz — Empresa 99
```

O projeto implementa uma personalização funcional para o **Controle de Fornecimento e Ocorrências de Fornecedores**, integrando dados customizados e cadastros padrão do Protheus.

A solução permite controlar certificações, acompanhar vencimentos, registrar ocorrências, relacionar fornecedores e produtos, automatizar informações, calcular valores e identificar situações críticas através de indicadores visuais.

Durante os testes finais foram identificados e corrigidos pontos relacionados a:

- validações;
- consultas padrão;
- gatilhos;
- relacionamentos;
- campos virtuais;
- apresentação de informações no browse;
- cálculo de valores;
- exportação dos arquivos da entrega.

A versão disponibilizada neste repositório representa o estado final validado do projeto.

A entrega inclui:

```text
Fontes ADVPL
Projeto de compilação
Dicionário de Dados
Tabelas customizadas
Massa de teste
Menu SIGACOM
Arquivos DBF
Arquivos CSV
Utilitário de conversão
Evidências funcionais
Autoavaliação
Documentação técnica
```

---

# 👨‍💻 Autor

## José Apolo Marques Nascimento

Responsável pela análise, configuração, desenvolvimento, testes, correções, documentação e organização da entrega.

Projeto desenvolvido como parte da **Jornada DEV START**, com foco em desenvolvimento Protheus, programação ADVPL e construção de soluções aplicadas às necessidades de negócio.

---

## 📌 Status do Projeto

```text
TCC FINALIZADO ✅
FONTES COMPILADOS ✅
DICIONÁRIO VALIDADO ✅
ROTINAS TESTADAS ✅
EVIDÊNCIAS ORGANIZADAS ✅
DBF + CSV DISPONIBILIZADOS ✅
DOCUMENTAÇÃO FINALIZADA ✅
```