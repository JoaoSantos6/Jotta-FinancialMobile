# Jotta FinancialMobile

App Android de gestão financeira pessoal em que **cada tela é um nicho da vida** —
Casa, Transporte, Alimentação, Saúde, Lazer, Investimentos e Dívidas — mais uma tela
de Renda. A **Home é a visão geral**, filtrável por **semana, mês ou ano**.

Offline-first: os dados ficam só no aparelho, **cifrados em repouso**. Sem conta, sem
backend, sem rede — o app não declara nem a permissão `INTERNET`.

## Documentação

| Documento | O que é |
|---|---|
| [`docs/PRD-MVP.md`](docs/PRD-MVP.md) | PRD completo do MVP — visão de produto, requisitos funcionais com critérios de aceite, arquitetura, modelo de dados, roadmap e riscos |
| [`docs/DECISIONS.md`](docs/DECISIONS.md) | Registro de decisões: o que foi decidido, o que foi descartado e quem decidiu |
| [`docs/adr-1/`](docs/adr-1/) | **ADR-1 — Fundação segura** (marco M0): [PRD](docs/adr-1/PRD.md) · [SPEC](docs/adr-1/SPEC.md) · [TASK](docs/adr-1/TASK.md) — 51 tasks, cada uma com seu teste. Auditado pelo `/judge` e corrigido |
| `docs/adr-N/` | Demais fatias de entrega, mesmo formato — ver abaixo |

## Stack

Flutter · Drift sobre **SQLCipher** · Riverpod 2 · go_router · Material 3.
`minSdk` 26. **Nenhuma permissão declarada** — nem `INTERNET`.

## Segurança em uma tela

| Controle | O que faz |
|---|---|
| **SEG-1** | Banco cifrado com AES-256 (SQLCipher); chave no Android Keystore, com respaldo em hardware |
| **SEG-2** | Bloqueio biométrico/PIN ao abrir, ligado por padrão |
| **SEG-3** | Backup exportado sempre criptografado (AES-256-GCM + Argon2id), senha obrigatória |
| **SEG-4** | Auto Backup do Android desativado — os dados realmente não vão para o Drive |
| **SEG-5** | Sem permissão de rede: exfiltração barrada pelo SO, não por promessa do código |
| **SEG-6 a SEG-8** | Higiene de log e build, validação de import, ciclo de vida da chave |

> **A troca, dita sem rodeio:** não existe recuperação remota. Desinstalar o app,
> resetar ou perder o aparelho apaga tudo definitivamente, e senha de backup esquecida
> não tem como ser recuperada. É consequência aceita da postura, não um defeito — ver
> seção 6.4 do PRD.

Detalhes, modelo de ameaças e testes: **seção 6 do PRD**.

## Estado

📋 Fase de especificação. Nenhum código ainda. O **[`adr-1`](docs/adr-1/)** (marco M0)
está documentado de ponta a ponta — PRD, spec técnica e 51 tasks numeradas: projeto
Flutter, banco cifrado, chave no Keystore, casca navegável e CI com as travas de
segurança.

Ele passou pelo `/judge`, voltou **VIÁVEL COM RESSALVAS**, e as ressalvas foram
tratadas: correções factuais aplicadas e as duas aberturas de produto fechadas. O
schema v1 cresceu de 8 para 10 tabelas no processo — a auditoria mostrou que requisitos
já aprovados exigiam dados que o modelo não guardava.

## Como uma solução vira código

Nada é implementado direto. Toda fatia de entrega — aqui chamada de **ADR** — passa por
três documentos, em `docs/adr-N/`, nesta ordem e sem pular etapa:

```
docs/adr-N/PRD.md   → por que existe, o que precisa ser verdade no fim
      ↓
docs/adr-N/SPEC.md  → como se constrói: camadas, arquivos, contratos, migrations, testes
      ↓
docs/adr-N/TASK.md  → tasks numeradas, uma por commit, cada uma com um teste que a prova
```

**A dependência é travada, não é convenção:** a skill `to-spec` para se não achar o
`PRD.md`, e a `to-task` para se não achar o `SPEC.md`. Documento sem o anterior não é
documento adiantado — é documento escrito no escuro.

Um ADR corresponde a **um marco do roadmap** (seção 8 do PRD): `adr-1` = M0, `adr-2` = M1,
até `adr-7` = M6. O `docs/PRD-MVP.md` continua sendo o guarda-chuva do produto inteiro;
cada `adr-N/PRD.md` recorta dele e referencia, em vez de repetir.

> **Nota sobre o nome:** "ADR" aqui é a unidade de entrega, não o *Architecture Decision
> Record* clássico. Decisões de arquitetura continuam morando em
> [`docs/DECISIONS.md`](docs/DECISIONS.md), uma linha por decisão.

## Ferramentas do repositório

### `grillme` — skill

[`.claude/skills/grillme`](.claude/skills/grillme/SKILL.md)

A regra é simples: **suposição não documentada é bug**. Diante de um requisito
ambíguo, uma regra de negócio faltando ou uma decisão de produto sem dono, o agente
**pergunta** — com opções concretas e uma recomendação — em vez de escolher sozinho.
Toda resposta vira uma linha em `docs/DECISIONS.md`.

Perguntas ainda em aberto estão na seção 12 do PRD.

### `to-prd`, `to-spec`, `to-task` — skills da cadeia de documentação

[`.claude/skills/to-prd`](.claude/skills/to-prd/SKILL.md) ·
[`.claude/skills/to-spec`](.claude/skills/to-spec/SKILL.md) ·
[`.claude/skills/to-task`](.claude/skills/to-task/SKILL.md)

Uma skill por elo da cadeia acima. Cada uma sabe o que o documento precisa conter, e
recusa rodar sem o anterior.

A regra que dá sentido à `to-task`: **task sem validação automatizada não é task.** Não
vale "eu conferi" nem "abri o app e vi funcionando" — vale um comando que falha antes e
passa depois. Inclusive para o que parece não-testável: `allowBackup="false"` se prova
com um teste que faz parse do manifest, e SQLCipher se prova com um teste que tenta abrir
o banco com a senha errada e exige a falha.

### `/judge` — subagent auditor

[`.claude/agents/judge.md`](.claude/agents/judge.md) · [`.claude/commands/judge.md`](.claude/commands/judge.md)

```
/judge docs/PRD-MVP.md docs/DECISIONS.md
```

Audita se a solução proposta se sustenta: coerência interna, coerência entre
documentos, completude das specs, viabilidade de prazo e escopo. Devolve achados com
severidade e um veredito — VIÁVEL / VIÁVEL COM RESSALVAS / INVIÁVEL / INSUFICIENTE.

O `judge` roda **isolado de propósito**: só lê os caminhos que você passar, é
read-only, e não recebe nem o histórico da conversa nem o resto do projeto. Ele julga o
documento pelo que está escrito, não pelo que quem escreveu queria dizer — que é
exatamente o ponto cego de quem acabou de redigir o texto.

Para auditar coerência **entre** documentos, passe todos na mesma chamada: o que não
for passado, ele não enxerga.
