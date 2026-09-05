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

📋 Fase de especificação. Nenhum código ainda. Próximo passo é o marco **M0** do
roadmap (seção 8 do PRD): setup do projeto, banco cifrado e CI com as travas de
segurança.

## Ferramentas do repositório

### `grillme` — skill

[`.claude/skills/grillme`](.claude/skills/grillme/SKILL.md)

A regra é simples: **suposição não documentada é bug**. Diante de um requisito
ambíguo, uma regra de negócio faltando ou uma decisão de produto sem dono, o agente
**pergunta** — com opções concretas e uma recomendação — em vez de escolher sozinho.
Toda resposta vira uma linha em `docs/DECISIONS.md`.

Perguntas ainda em aberto estão na seção 12 do PRD.

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
