# Exercício 01 - AxCadastro x mBrowse

## a) Quando você usaria AxCadastro e quando usaria mBrowse? Dê um exemplo de cada.

**AxCadastro**

Utilizaria o AxCadastro quando fosse necessário desenvolver rapidamente um cadastro utilizando os recursos padrões do Protheus. Ele já oferece as operações de inclusão, alteração, exclusão, visualização e pesquisa, exigindo poucas linhas de código.

**Exemplo:** cadastro de Pets (ZA1) para uma rotina simples.

**mBrowse**

Utilizaria o mBrowse quando fosse necessário maior controle da interface e personalização da rotina, permitindo filtros, legendas coloridas, consultas F3 e outras funcionalidades.

**Exemplo:** cadastro de Pets com filtros personalizados e destaque por cores conforme regras definidas.

---

## b) Cite três coisas que o mBrowse faz e o AxCadastro não faz.

- Permite utilizar legendas coloridas (aColors).
- Permite criar filtros personalizados.
- Permite maior personalização da interface, como consultas F3 e outras configurações da rotina.

---

## c) Na configuração de legendas (aColors), por que a regra ".T." deve ficar por último?

A regra ".T." deve ficar por último porque ela sempre retorna verdadeiro. Como as condições são avaliadas de cima para baixo, se ela estiver antes das demais, todas as linhas receberão a cor padrão e as outras regras nunca serão executadas.

---

## d) Explique a diferença entre um campo Virtual (X3_RELACAO) e um gatilho (SX7).

O campo Virtual (X3_RELACAO) não grava informações no banco de dados. Ele apenas calcula ou busca um valor durante a exibição.

O gatilho (SX7) executa uma ação automaticamente quando um determinado evento ocorre, podendo preencher outros campos ou chamar uma função do sistema.