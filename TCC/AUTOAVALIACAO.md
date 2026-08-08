# AUTOAVALIAÇÃO — TCC Jornada DEV START

## Projeto
**Controle de Fornecimento e Ocorrências de Fornecedores — Protheus MP8.11**

---

## 1. Dicionário de Dados

- [x] Tabela customizada ZZ1 — Controle de Fornecimento criada e configurada.
- [x] Tabela customizada ZZ2 — Ocorrências do Fornecedor criada e configurada.
- [x] Campos, tipos, tamanhos, decimais e formatos revisados.
- [x] Índices necessários configurados.
- [x] Gatilhos configurados e testados.
- [x] Consultas padrão configuradas para os relacionamentos necessários.
- [x] Validações de usuário configuradas e testadas.
- [x] Campos virtuais configurados para inclusão e visualização no browse.
- [x] Dicionário atualizado e validado no ambiente.

### Testes realizados

Foram realizados testes funcionais diretamente no Protheus MP8.11, incluindo:

- Validação de fornecedor existente.
- Validação de controle ZZ1 existente.
- Validação de produto cadastrado na SB1.
- Bloqueio de códigos inexistentes.
- Bloqueio de data futura nas ocorrências.
- Bloqueio de validade de certificado inválida.
- Validação da tolerância entre 0 e 100.
- Preenchimento automático de fornecedor, loja e nome.
- Preenchimento automático de data e hora.
- Cálculo dos valores conforme e não conforme.

---

## 2. Rotina STTZZ1 — Controle de Fornecimento

- [x] Rotina desenvolvida utilizando mBrowse.
- [x] Pesquisa de registros.
- [x] Visualização.
- [x] Inclusão.
- [x] Alteração.
- [x] Exclusão.
- [x] Acesso às ocorrências relacionadas ao controle selecionado.
- [x] Legenda visual de situação do certificado.

### Legendas validadas

- Verde — certificado válido.
- Amarelo — certificado próximo do vencimento.
- Vermelho — certificado vencido.

Os três cenários foram testados no Protheus e registrados nas evidências do projeto.

---

## 3. Rotina STTZZ2 — Ocorrências do Fornecedor

- [x] Rotina desenvolvida utilizando mBrowse.
- [x] Consulta geral de ocorrências.
- [x] Consulta filtrada pelo controle de fornecimento selecionado na ZZ1.
- [x] Inclusão de ocorrência.
- [x] Alteração.
- [x] Exclusão.
- [x] Integração com fornecedor e produto.
- [x] Cálculo automático dos valores financeiros.
- [x] Campos virtuais corretamente apresentados no browse.
- [x] Legenda de não conformidade comparada à tolerância cadastrada na ZZ1.

### Testes da tolerância

Foram cadastrados cenários distintos para validar a regra:

- 90 itens conformes e 10 não conformes → acima da tolerância → vermelho.
- 99 itens conformes e 1 não conforme → dentro da tolerância → verde.

Os cálculos e as duas legendas foram confirmados diretamente no browse da rotina.

---

## 4. Biblioteca STTZZLIB

Foi criada uma biblioteca centralizando funções comuns e evitando duplicação de código.

Funções implementadas:

- [x] `NomeFornecedor()`
- [x] `NomeProduto()`
- [x] `PercNaoConforme()`
- [x] `CertificadoVencendo()`
- [x] `GravarLogTCC()`

A função de percentual também trata a possibilidade de divisão por zero.

---

## 5. Tratamento de Erros

As rotinas principais possuem tratamento estruturado de erros utilizando:

- [x] `ErrorBlock()`
- [x] `BEGIN SEQUENCE`
- [x] `RECOVER USING oError`
- [x] Mensagem amigável ao usuário.
- [x] Registro técnico através de `U_GRAVARLOGTCC()`.
- [x] Restauração da área de trabalho com `RestArea()`.

A rotina de ocorrências também garante a finalização do filtro do browse em caso de erro.

---

## 6. Qualidade dos Fontes

Os fontes foram organizados em:

- `STTZZ1.PRW`
- `STTZZ2.PRW`
- `STTZZLIB.PRW`
- `TCC.PRJ`

Boas práticas aplicadas:

- [x] Código organizado e indentado.
- [x] Funções separadas por responsabilidade.
- [x] Reaproveitamento de código através de biblioteca.
- [x] Documentação utilizando padrão `Protheus.doc`.
- [x] Tratamento de erros.
- [x] Preservação das áreas de trabalho.
- [x] Fontes compilados com sucesso.

---

## 7. Dados e Dicionário

A entrega contém os dados necessários para reprodução e correção do projeto.

Foram incluídos:

- [x] SA2990 — fornecedor utilizado nos testes.
- [x] SB1990 — produto utilizado nos testes.
- [x] SIX990 — índices.
- [x] SX2990 — tabelas.
- [x] SX3990 — campos.
- [x] SX7990 — gatilhos.
- [x] SXB990 — consultas padrão.
- [x] ZZ1990 — dados do Controle de Fornecimento.
- [x] ZZ2990 — dados das Ocorrências.
- [x] SIGACOM.XNU — configuração de menu.

Para facilitar a leitura automática da entrega, os arquivos relevantes foram disponibilizados também em formato CSV, além dos DBFs originais.

Foi incluído ainda:

`converte-dicionario.prg`

utilizado para gerar os arquivos CSV a partir dos DBFs finais.

---

## 8. Evidências

Foram registradas apenas evidências relevantes para demonstrar a evolução e o funcionamento final do projeto.

Entre os cenários comprovados estão:

- Criação e configuração das estruturas do dicionário.
- Compilação dos fontes.
- Funcionamento da rotina ZZ1.
- Funcionamento da rotina ZZ2.
- Cadastro e relacionamento com fornecedor.
- Consulta e validação de produto.
- Cálculos financeiros.
- Ocorrências dentro e fora da tolerância.
- Legendas verde, amarela e vermelha.
- Validações de regras de negócio.

---

## 9. Resultado Final

Considero que os principais requisitos propostos para o TCC foram atendidos.

O projeto foi desenvolvido e testado no ambiente Protheus MP8.11, contemplando dicionário de dados, rotinas ADVPL, integração entre tabelas, regras de negócio, validações, gatilhos, consultas padrão, campos virtuais, tratamento de erros, biblioteca de funções e documentação da solução.

Durante o desenvolvimento também foram realizados testes de cenários válidos e inválidos, permitindo identificar e corrigir problemas de relacionamento, validação e apresentação dos dados antes da entrega final.

O resultado é uma solução funcional de Controle de Fornecimento e Ocorrências de Fornecedores, com foco em organização, rastreabilidade e aplicação prática dos conhecimentos desenvolvidos durante a Jornada DEV START.