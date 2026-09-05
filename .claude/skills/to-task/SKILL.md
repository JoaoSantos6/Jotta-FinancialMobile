---
name: to-task
description: Fatia a especificação técnica em tasks numeradas e validáveis em docs/adr-N/TASK.md, cada uma do tamanho de um commit e com um teste automatizado que a prova. Use depois que docs/adr-N/SPEC.md existir e antes de escrever a primeira linha de código do Jotta-FinancialMobile. Último elo da cadeia PRD → SPEC → TASK. Dispara em "quebra em tasks", "monte o plano de execução", "por onde eu começo o adr-N".
---

# to-task — nenhuma task sem prova

## Trava de entrada

**Sem `docs/adr-N/SPEC.md`, não existe TASK.** Verifique antes de escrever qualquer
coisa. Se faltar:

> pare, diga qual arquivo falta e chame `to-spec` (que por sua vez exige o `PRD.md`).

Lista de tasks derivada de conversa em vez de spec é lista de intenções. Não faça.

## Princípio

**Task sem validação automatizada não é task.** A validação não é "eu conferi", não é
"abri o app e vi funcionando": é um comando que roda, falha antes e passa depois.

Cada task tem o tamanho de **um commit**: uma unidade que se implementa, se testa e se
comita sem deixar a branch quebrada no meio. Se precisar de dois testes de tipos
diferentes para provar, provavelmente são duas tasks.

## Formato de cada task

```markdown
### T-07 — Implementar Period.week() com semana iniciando na segunda

- **Spec:** §5.2, §8 (linha 3 da tabela de testes)
- **Faz:** calcula início e fim da semana para uma data, em horário local.
- **Arquivos:** `lib/core/period/period.dart` [novo], `test/core/period_week_test.dart` [novo]
- **Validação:** `flutter test test/core/period_week_test.dart` — unitário — prova que
  a virada de ano (2026-12-31 → semana que começa em 2026-12-28) e a semana 53 caem
  nos limites corretos.
- **Pronto quando:** o teste passa, `dart analyze` limpo, nenhum outro teste quebra.
- **Depende de:** T-03
```

Campo faltando é task incompleta. Em especial: **Validação** e **Pronto quando** não
são opcionais nunca.

## Estrutura de `docs/adr-N/TASK.md`

1. Cabeçalho: ADR, SPEC de origem (link relativo), total de tasks, data.
2. **Tabela de progresso** no topo: `| # | Task | Tipo de teste | Status |`, com
   caixa de marcação. É o que se atualiza durante a execução.
3. **Ordem de execução** — as tasks, em ordem topológica. Nenhuma task depende de uma
   de número maior. Se depender, a numeração está errada; renumere.
4. **Definição de pronto do ADR** — a suíte inteira verde, os critérios de aceite do
   PRD verificados um a um, e o critério de saída do marco atendido.

## Tasks que parecem não-testáveis

Elas existem, e a saída **nunca** é dispensar a validação — é achar a asserção
automatizável. Três casos que vão aparecer neste projeto:

| Task | Validação errada | Validação certa |
|---|---|---|
| `allowBackup="false"` no manifest | "conferi o XML" | teste que faz parse do `AndroidManifest.xml` do build e falha se `allowBackup` não for `false` |
| Ligar SQLCipher | "o app abriu" | teste de integração que abre o arquivo `.db` com senha errada e exige que falhe |
| Configurar o CI | "o workflow rodou" | job que roda a suíte e o grep de segurança da RNF-14, com falha proposital verificada uma vez |

Se depois disso a task ainda não tem asserção possível, ela não é uma task: é parte de
outra, ou é decisão pendente. Não invente um `expect(true, isTrue)` para cumprir tabela.

## Regras

- **Cobertura:** toda seção da SPEC aparece em pelo menos uma task, e toda linha da
  tabela de testes da SPEC (§8) vira a validação de alguma task. Confira e reporte.
- **"Escrever os testes" não é uma task.** O teste é a validação da própria task; separá-lo
  é o mesmo que planejar entregar código não testado e consertar depois.
- **"Refatorar depois" não é uma task.** Ou está na spec, ou não entra.
- Nada de estimativa em hora. Se quiser tamanho, use `P`/`M`/`G` e olhe a contagem.
- Task que só passa em manual vira abertura no PRD, não item na lista.

## Ao terminar

Reporte três números: total de tasks, quantas por tipo de teste, e quantas linhas da
tabela de testes da SPEC ficaram sem task correspondente. O terceiro número tem que ser
zero. Se não for, diga qual ficou de fora e por quê — não feche o documento fingindo
que fechou.
