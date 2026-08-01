# Exercício 07 - Gatilho CEP (SX7)

## a. Qual a diferença entre campo, contra-domínio e regra em um gatilho?

- **Campo:** é o campo que dispara o gatilho quando seu valor é alterado.
- **Contra-domínio:** é o campo que receberá o valor calculado pelo gatilho.
- **Regra:** é a expressão ADVPL executada para preencher o contra-domínio.

---

## b. Por que a regra usa M->A1_CEP e não SA1->A1_CEP?

Porque `M->A1_CEP` representa o valor que está sendo digitado na tela, antes da gravação no banco de dados. Já `SA1->A1_CEP` acessaria apenas o valor já gravado na tabela.

---

## c. Os CEPs estão dentro do fonte. Cite dois problemas disso em produção e como você resolveria.

### Problemas

- Sempre que um CEP precisar ser incluído ou alterado será necessário modificar o código e recompilar a rotina.
- A lista de CEPs ficará limitada e poderá ficar desatualizada rapidamente.

### Soluções

- Armazenar os CEPs em uma tabela do dicionário (SX ou tabela própria), permitindo manutenção sem alterar o código.
- Integrar o Protheus a um serviço externo de consulta de CEP (API), obtendo dados sempre atualizados.

---

## d. Se pedissem para preencher também o código do município (A1_COD_MUN), o que você faria?

Adicionaria o código do município na estrutura utilizada pela função `U_STCEP()` e criaria um novo gatilho no SX7 para preencher automaticamente o campo `A1_COD_MUN`, utilizando a mesma lógica aplicada aos campos Bairro, Município e Estado.

---

## Resultado

Foi criada a função `U_STCEP()` em ADVPL, compilada no ambiente do Protheus e configurados três gatilhos na tabela SX7 para preencher automaticamente Bairro, Município e Estado a partir do CEP informado.

### Evidência

Arquivo:

`modulo-08/evidencias/07-gatilho-cep.png`