---
name: to-spec
description: Escreve a especificação técnica de uma fatia de entrega (ADR) em docs/adr-N/SPEC.md — frameworks, camadas, arquivos, contratos de função, migrations, providers e estratégia de testes. Use depois que docs/adr-N/PRD.md existir e antes de qualquer código ou task do Jotta-FinancialMobile. Segundo elo da cadeia PRD → SPEC → TASK. Dispara em "especifica tecnicamente", "como isso vai ser feito", "monte a spec do adr-N".
---

# to-spec — o como, executável

## Trava de entrada

**Sem `docs/adr-N/PRD.md`, não existe SPEC.** Verifique o arquivo antes de escrever
qualquer coisa. Se não existir, ou existir com aberturas pendentes na seção 8:

> pare, diga qual arquivo falta e chame `to-prd`.

Não escreva "spec provisória enquanto o PRD não sai". Spec provisória é a forma mais
cara de descobrir que o requisito era outro.

## Princípio

A SPEC é o documento que um dev que não participou da conversa consegue implementar
sem adivinhar. O teste é literal: **se uma frase da spec admite duas implementações
diferentes, ela não é spec — é desejo.**

"Usar boas práticas", "tratar erros adequadamente", "garantir performance" não são
especificação. `Result<Transaction, InsertError>` com os três casos de erro nomeados é.

## Antes de escrever

1. Leia `docs/adr-N/PRD.md` inteiro — é o único escopo que você pode especificar.
2. Leia a seção 5 (Arquitetura) e a 6 (Segurança) de `docs/PRD-MVP.md`: stack, camadas,
   modelo de dados e controles já estão decididos lá e **não se redecidem aqui**.
3. Leia `docs/DECISIONS.md`.
4. Leia o código que já existe. Spec que contradiz o que está no repositório é achado,
   não novidade.

## Estrutura obrigatória de `docs/adr-N/SPEC.md`

Cabeçalho: ADR, PRD de origem (link relativo), versão, data, status.

1. **Resumo técnico** — o que se constrói, em um parágrafo.
2. **Decisões técnicas desta fatia** — tabela `| decisão | alternativa descartada |
   por quê |`. Toda linha aqui vira também uma linha em `docs/DECISIONS.md`.
   Decisão que é de produto, não técnica, **não é sua**: dispare `grillme`.
3. **Estrutura de arquivos** — árvore real de `lib/` e `test/` com os arquivos que esta
   fatia cria ou altera, marcando `[novo]` e `[altera]`. Nada de "etc.".
4. **Modelo de dados** — SQL das tabelas tocadas, migrations numeradas, e o *diff*
   contra a seção 5.3 do guarda-chuva. Se não toca o banco, escreva "não toca".
5. **Contratos** — para cada classe/função pública: assinatura completa, o que recebe,
   o que devolve, o que lança, e a invariante que ela mantém. É a seção mais longa e é
   a razão de a SPEC existir.
6. **Estado e fluxo** — providers Riverpod, quem observa quem, quando invalida, o que
   acontece na falha. Diagrama ASCII quando o texto ficar ambíguo.
7. **Segurança da fatia** — quais SEG-1..SEG-8 esta fatia implementa ou toca, e como.
   Fatia que não toca nenhum controle escreve isso explicitamente.
8. **Estratégia de testes** — tabela `| o que prova | tipo | arquivo de teste |`,
   cobrindo unitário, widget, integração e e2e conforme o caso. Todo critério de aceite
   do PRD precisa aparecer em pelo menos uma linha desta tabela. É daqui que a TASK nasce.
9. **Fora do escopo técnico** — o que alguém razoável esperaria encontrar aqui e não vai.
10. **Rastreabilidade** — tabela `| requisito do PRD | onde é implementado | teste que prova |`.

## Regras

- **Cobertura é obrigatória.** Todo requisito da seção 4 do PRD do ADR aparece na
  rastreabilidade. Se algum não aparece: ou saiu do escopo (e o PRD precisa dizer isso),
  ou a spec está incompleta. Não deixe passar em silêncio.
- Versão de pacote sempre fixada. `drift: ^2.x` numa spec vira build quebrado em três meses.
- Nada de código de implementação completo aqui. Assinatura e invariante, sim; corpo de
  função, não — isso é o trabalho da TASK.
- Se a spec ficou impossível de escrever sem inventar uma regra de negócio, a regra
  faltava no PRD. Volte ao PRD; não a invente aqui.

## Ao terminar

Rode a checagem de cobertura você mesmo e diga o resultado: quantos requisitos do PRD,
quantos rastreados, quantos com teste nomeado. Se não fechar, diga qual não fechou.
Só então declare a TASK liberada.
