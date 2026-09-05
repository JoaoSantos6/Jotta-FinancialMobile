---
description: Audita a viabilidade e a coerência de um ou mais documentos, em contexto isolado
argument-hint: <caminho-do-doc> [outro-doc ...]
allowed-tools: Agent, Bash(ls:*), Bash(test:*)
---

Acione o subagent `judge` para auditar os documentos indicados em: $ARGUMENTS

## Antes de acionar

1. Sem argumento, pergunte quais documentos julgar e **pare**. Não escolha por conta própria.
2. Confirme que cada caminho existe (`ls`). Caminho inexistente: avise e não acione o agente.
3. Para auditar coerência **entre** documentos, todos precisam vir na mesma chamada — o
   agente não enxerga nada além do que você passar.

## Ao acionar

Chame `Agent` com `subagent_type: "judge"` e um prompt contendo **apenas**:

- os caminhos dos documentos a julgar;
- o roteiro de análise abaixo, copiado tal e qual.

**Não** inclua no prompt: resumo do projeto, decisões desta conversa, histórico, o que
você acha do documento, nem qualquer arquivo além dos caminhos. O valor do `judge` é
julgar o documento pelo que ele diz — não pelo que você sabe que ele queria dizer. Se
você contextualizar, você contaminou o laudo.

Rode em background e relate o laudo ao usuário quando chegar.

## Roteiro de análise (copie para o prompt do agente)

Audite os documentos nos caminhos acima, nesta ordem:

1. **Coerência interna** — um requisito que contradiz outro; regra de cálculo que muda
   entre seções; número que não fecha (totais, prazos, somas); referência cruzada
   quebrada (seção, requisito ou tabela citada que não existe ou mudou de número).
2. **Coerência entre documentos** — a mesma decisão contada de formas diferentes em
   arquivos diferentes; decisão registrada num doc e contrariada na spec; termo usado
   com dois sentidos.
3. **Completude da spec** — requisito sem critério de aceite verificável; comportamento
   citado mas nunca especificado; caso de borda que a própria regra levanta e ninguém
   resolveu; dado exigido por uma tela que o modelo de dados não guarda.
4. **Viabilidade** — o escopo cabe no prazo e no time declarados? Alguma meta é
   inverificável ou impossível como escrita? Alguma dependência técnica é assumida sem
   estar decidida? Alguma promessa ao usuário é contrariada por um requisito?
5. **Autoconsciência** — o documento reconhece os próprios limites, ou vende como
   resolvido algo que deixou em aberto?

Para cada achado: **severidade** (bloqueia / corrige antes de codar / anota), o trecho
citado, por que é um problema e o que precisaria ser decidido. Não proponha o texto da
correção — dizer o que está quebrado é seu trabalho; consertar não é.

Se não houver achado numa categoria, diga "nada encontrado" e siga. Não invente achado
para parecer útil, e não amacie um achado real para parecer construtivo.
