# Exercício 3 — Fluxograma

```mermaid
flowchart TD

A([Início]) --> B[Leia valorCompra]

B --> C{Valor > 100?}

C -- Sim --> D[desconto ← valorCompra × 0.10]
D --> E[valorFinal ← valorCompra - desconto]

C -- Não --> F[valorFinal ← valorCompra]

E --> G[Escreva valorFinal]
F --> G

G --> H([Fim])
```