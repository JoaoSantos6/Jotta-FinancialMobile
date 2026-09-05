# Jotta FinancialMobile

App Android de gestão financeira pessoal em que **cada tela é um nicho da vida** —
Casa, Transporte, Alimentação, Saúde, Lazer, Investimentos e Dívidas — mais uma tela
de Renda. A **Home é a visão geral**, filtrável por **semana, mês ou ano**.

Offline-first: os dados ficam só no aparelho. Sem conta, sem backend, sem rede.

## Documentação

| Documento | O que é |
|---|---|
| [`docs/PRD-MVP.md`](docs/PRD-MVP.md) | PRD completo do MVP — visão de produto, requisitos funcionais com critérios de aceite, arquitetura, modelo de dados, roadmap e riscos |
| [`docs/DECISIONS.md`](docs/DECISIONS.md) | Registro de decisões: o que foi decidido, o que foi descartado e quem decidiu |

## Stack

Flutter · Drift (SQLite) · Riverpod 2 · go_router · Material 3.
`minSdk` 26. **Nenhuma permissão declarada** — nem `INTERNET`.

## Estado

📋 Fase de especificação. Nenhum código ainda. Próximo passo é o marco **M0** do
roadmap (seção 7 do PRD): setup do projeto e CI.

## Regra de trabalho: `grillme`

Este repositório tem uma skill em [`.claude/skills/grillme`](.claude/skills/grillme/SKILL.md).

A regra é simples: **suposição não documentada é bug**. Diante de um requisito
ambíguo, uma regra de negócio faltando ou uma decisão de produto sem dono, o agente
**pergunta** — com opções concretas e uma recomendação — em vez de escolher sozinho.
Toda resposta vira uma linha em `docs/DECISIONS.md`.

Perguntas ainda em aberto estão na seção 11 do PRD.
