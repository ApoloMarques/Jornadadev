# Exercício 4 — Refinamento Sucessivo

## Problema

Um sistema de caixa de supermercado deve registrar os itens de uma compra, calcular o subtotal, aplicar desconto se o cliente tiver cartão fidelidade (5%) e mostrar o total a pagar.

---

# Nível 1 — Visão Geral

1. Registrar os itens da compra.
2. Calcular o subtotal.
3. Verificar se o cliente possui cartão fidelidade e aplicar desconto, se necessário.
4. Mostrar o valor total a pagar.

---

# Nível 2 — Detalhamento

## 1. Registrar os itens da compra

- Ler cada item da compra.
- Ler o preço de cada item.
- Armazenar os valores para o cálculo.

---

## 2. Calcular o subtotal

- Somar o valor de todos os itens registrados.
- Armazenar o resultado na variável **subtotal**.

---

## 3. Verificar cartão fidelidade

- Perguntar se o cliente possui cartão fidelidade.
- Se a resposta for **Sim**, calcular 5% de desconto sobre o subtotal.
- Subtrair o desconto do subtotal para obter o valor final.
- Se a resposta for **Não**, manter o subtotal como valor final.

---

## 4. Mostrar o total a pagar

- Exibir o valor final da compra.
- Encerrar o processo.