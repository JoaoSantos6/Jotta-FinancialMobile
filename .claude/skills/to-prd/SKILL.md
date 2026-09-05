---
name: to-prd
description: Escreve o PRD de uma fatia de entrega (ADR) em docs/adr-N/PRD.md. Use ao iniciar qualquer marco do roadmap, feature ou solução nova do Jotta-FinancialMobile, ANTES de qualquer spec técnica ou código. É o primeiro elo da cadeia PRD → SPEC → TASK: sem este arquivo, to-spec e to-task se recusam a rodar. Dispara em "vamos começar o M0", "quero fazer a tela X", "monte a documentação dessa solução".
---

# to-prd — o porquê antes do como

## Princípio

O PRD do ADR responde **por que isso existe** e **o que precisa ser verdade quando
acabar**. Não responde *como*. Se você escreveu nome de classe, pacote, assinatura de
função ou tabela, está no arquivo errado — isso é SPEC.

Cada ADR é **um marco do roadmap** (seção 8 do PRD guarda-chuva):

| Pasta | Marco | Entrega |
|---|---|---|
| `docs/adr-1/` | M0 | Setup, Drift sobre SQLCipher, chave no Keystore, CI com travas |
| `docs/adr-2/` | M1 | Núcleo: modelo de dados, lançamento, tela de nicho, CRUD com desfazer |
| `docs/adr-3/` | M2 | Home: período, resumo, distribuição, evolução |
| `docs/adr-4/` | M3 | Renda |
| `docs/adr-5/` | M4 | Investimentos e Dívidas |
| `docs/adr-6/` | M5 | Backup criptografado, bloqueio biométrico, Ajustes, recorrência |
| `docs/adr-7/` | M6 | Uso real, revisão de segurança fim-a-fim, build assinado |

Solução que não é marco (um bug estrutural, uma mudança de arquitetura no meio do
caminho) entra como o próximo número livre. Numeração é sequencial e nunca é reciclada.

## Antes de escrever

1. **Leia `docs/PRD-MVP.md`.** Ele é o guarda-chuva: visão de produto, RF-1..RF-32,
   SEG-1..SEG-8, RNF, modelo de dados global. O PRD do ADR **recorta** dele, não repete.
2. **Leia `docs/DECISIONS.md`.** Decisão já tomada não se re-discute no PRD do ADR.
3. Se a fatia exige um requisito que **não existe** no guarda-chuva, você tem duas
   opções e nenhuma é inventar aqui: (a) o requisito sobe para `docs/PRD-MVP.md` como
   RF novo, ou (b) é uma pergunta — dispare `grillme`.
4. Se `docs/adr-N/PRD.md` já existe, **não sobrescreva**. Leia, e edite o que mudou.

## Estrutura obrigatória de `docs/adr-N/PRD.md`

Cabeçalho com tabela: ADR, marco correspondente, versão, data, status
(`Rascunho` / `Aprovado` / `Em execução` / `Entregue`), estimativa em semanas.

1. **Contexto** — o que já existe no repositório quando esta fatia começa e o que
   ainda não existe. Sem isso, quem lê não sabe de onde parte.
2. **Problema e valor** — o que quebra ou não acontece sem esta fatia. Uma fatia que
   você não consegue justificar em três frases provavelmente não deveria ser um ADR.
3. **Escopo** — duas listas explícitas: **está dentro** e **está fora**. A lista do que
   está fora é a mais importante das duas; é ela que impede o ADR de crescer sozinho.
4. **Requisitos cobertos** — tabela referenciando o guarda-chuva:
   `| RF/SEG/RNF | O que é | Coberto nesta fatia (total/parcial) |`.
   Cobertura parcial diz explicitamente qual pedaço fica para qual ADR.
5. **Critérios de aceite** — em `Dado / Quando / Então`, observáveis por quem não
   escreveu o código. Herda e detalha o *critério de saída* do marco.
6. **Dependências** — quais ADRs precisam estar entregues antes. Se depende de nenhum,
   diga isso.
7. **Riscos desta fatia** — só os que são desta fatia. Risco global mora na seção 9 do
   guarda-chuva.
8. **Aberturas** — o que ainda precisa de decisão do usuário. Toda abertura vira uma
   rodada de `grillme` antes da SPEC, não depois.

## Regras

- **Português, direto.** Sem "o sistema deverá prover funcionalidades de".
- Todo critério de aceite é verificável. "Deve ser rápido" não é critério; "mediana
  abaixo de 10 s em 20 medições" é.
- Nada de estimativa por task aqui. Estimativa fina é da TASK.
- Se você precisou supor alguma coisa para terminar o documento, **você não terminou** —
  dispare `grillme` e volte.

## Ao terminar

Diga ao usuário, em uma linha, o que ficou fora do escopo e quantas aberturas restam.
Só declare a SPEC liberada quando não houver abertura pendente. PRD com pergunta em
aberto gera SPEC que vira retrabalho.
