# PRD — Jotta FinancialMobile (MVP)

| Campo | Valor |
|---|---|
| Produto | Jotta FinancialMobile — gestão financeira pessoal por nichos de vida |
| Versão do documento | 1.0 |
| Data | 2026-09-05 |
| Status | Aprovado para desenvolvimento |
| Plataforma | Android (Flutter) |
| Autor | João Santos + Claude |
| Decisões de origem | `docs/DECISIONS.md` |

---

## 1. Visão de Produto

### 1.1 Problema

Aplicativos de finanças pessoais organizam dinheiro do jeito que o **banco** enxerga:
contas, extratos, categorias genéricas. Isso não corresponde a como uma pessoa
realmente vive e decide. Ninguém pensa "gastei R$ 340 em categoria 4"; pensa
"a casa está cara esse mês" ou "estou gastando demais saindo".

O resultado prático é que a maioria dos apps vira um diário de lançamentos que se
abandona em três semanas: muito atrito para registrar, pouca resposta útil de volta.

### 1.2 Proposta

Um app Android **offline-first** em que **cada tela é um nicho da vida** — Casa,
Transporte, Alimentação, Saúde, Lazer, Investimentos, Dívidas — mais uma tela de
Renda. A **Home é a visão geral consolidada**, filtrável por **semana, mês ou ano**.

O usuário navega pelo app do jeito que ele pensa na própria vida, não do jeito que
o extrato bancário está ordenado.

### 1.3 Princípios de design

1. **Registrar tem que ser mais rápido que desistir.** Meta dura: lançar um gasto em
   ≤ 3 toques e ≤ 10 segundos, a partir da Home.
2. **Offline-first e privado por construção.** Zero rede, zero conta, zero telemetria.
   Os dados nunca saem do aparelho a não ser por exportação explícita do usuário.
3. **A Home responde uma pergunta, não mostra dez.** "Como está meu período?" — o
   resto está a um toque de distância.
4. **Nada de moralismo financeiro.** O app mostra números; não julga, não gamifica,
   não manda notificação de culpa.
5. **Não inventa dado.** Nenhuma estimativa, projeção ou categorização automática no
   MVP. O que aparece na tela foi o usuário que digitou.

### 1.4 Usuário-alvo

Usuário único (single-user, single-device): o próprio dono do aparelho. Não há
multiusuário, compartilhamento, perfis nem contas conjuntas no MVP.

**Perfil:** adulto com renda variável ou mista (CLT + freela), que já tentou usar
planilha ou app de finanças e abandonou por atrito. Conforto com tecnologia alto.
Quer entender para onde o dinheiro vai antes de querer que alguém diga o que fazer
com ele.

### 1.5 Não-objetivos do MVP

Explicitamente **fora** do escopo, para não haver dúvida:

- Sincronização bancária (Open Finance, Pluggy, Belvo, screen scraping).
- Import de CSV/OFX ou leitura de notificações do banco.
- Backend, login, conta de usuário, sync multi-dispositivo, versão web.
- Orçamento/teto por nicho e alertas de estouro (**v2 — decisão explícita do usuário**).
- Categorização automática, IA, sugestões, projeções, score financeiro.
- Multimoeda, câmbio, cripto com cotação.
- Multiusuário, compartilhamento, exportação para contador.
- iOS. (Flutter foi escolhido para deixar a porta aberta, mas iOS não é entregável do MVP.)
- Widgets de home screen e atalhos rápidos do Android (candidatos a v1.1).

---

## 2. Métricas de Sucesso

Como é um produto de usuário único, as métricas são de **uso próprio**, medidas
localmente pelo app (tela de Ajustes → "Meu uso"), sem envio a lugar nenhum.

| # | Métrica | Meta MVP | Como medir |
|---|---|---|---|
| M1 | Retenção pessoal D30 | App aberto em ≥ 20 dos 30 primeiros dias | Contador local de dias com sessão |
| M2 | Cobertura de registro | ≥ 80% dos dias do mês com ao menos 1 lançamento | `COUNT(DISTINCT occurred_on)` no mês |
| M3 | Atrito de lançamento | Tempo mediano do toque no FAB até salvar < 10s | Timer local em memória, mediana das últimas 50 |
| M4 | Completude | < 5% dos gastos do período sem descrição | Query sobre `transactions` |
| M5 | Estabilidade | 0 crashes em 30 dias de uso | Log local de exceções não tratadas |
| M6 | Confiança nos dados | Backup exportado e reimportado com sucesso ao menos 1x | Flag em `app_settings` |

**Critério de "MVP bem-sucedido":** M1, M2 e M3 batidos após 30 dias de uso real.
Se M3 falhar, o problema é o formulário de lançamento — e ele é a coisa mais
importante do app. Nenhuma feature nova entra antes de M3 estar verde.

---

## 3. Estrutura do App

### 3.1 Navegação

```
┌─────────────────────────────────────────────────────────┐
│                        HOME                             │
│           (visão geral · semana/mês/ano)                │
└──────────────┬──────────────────────────────────────────┘
               │
   ┌───────────┴────────────┬──────────────┬─────────────┐
   │                        │              │             │
┌──▼───────┐   ┌────────────▼──┐   ┌───────▼──────┐  ┌───▼─────┐
│  NICHOS  │   │     RENDA     │   │  AJUSTES     │  │  FAB +  │
│ (7 telas)│   │  (fontes +    │   │ (backup,     │  │  novo   │
│          │   │  recebimentos)│   │  dados, uso) │  │lançamento│
└──────────┘   └───────────────┘   └──────────────┘  └─────────┘
```

**Barra de navegação inferior (4 itens):** Home · Nichos · Renda · Ajustes.
**FAB central persistente:** novo lançamento, disponível em Home e em qualquer nicho
(quando aberto de dentro de um nicho, já vem com o nicho pré-selecionado).

### 3.2 Os nichos

| Nicho | Ícone | Natureza | Comportamento especial |
|---|---|---|---|
| Casa | 🏠 | Gasto | Padrão. Aluguel, contas, mercado de casa, manutenção |
| Transporte | 🚗 | Gasto | Padrão. Combustível, app de corrida, transporte público, manutenção |
| Alimentação | 🍽️ | Gasto | Padrão. Mercado, delivery, restaurante |
| Saúde | ⚕️ | Gasto | Padrão. Plano, consulta, farmácia, academia |
| Lazer | 🎬 | Gasto | Padrão. Streaming, bar, viagem, hobby |
| Investimentos | 📈 | **Patrimônio** | Saldo manual por ativo + aportes e resgates |
| Dívidas | 💳 | **Passivo** | Saldo devedor + parcelas geradas automaticamente |

Os 5 primeiros compartilham exatamente a mesma tela genérica de nicho. Investimentos
e Dívidas têm telas próprias porque carregam **estado** (saldo, saldo devedor), não
apenas fluxo.

Os nichos são **fixos no MVP** — não podem ser criados, renomeados nem apagados.
Criação de nichos custom é v2 (`DECISIONS.md`).

---

## 4. Especificação Funcional

Formato: `RF-x` = requisito funcional. Critérios de aceite em Dado/Quando/Então.

### 4.1 Home — Visão Geral

**RF-1 · Seletor de período**
A Home tem um seletor de três estados no topo: **Semana · Mês · Ano**, com setas
`‹ ›` para navegar entre períodos e um toque no rótulo central para voltar ao período
atual.

- Semana: segunda a domingo, rótulo `02–08 set`.
- Mês: dia 1 ao último dia, rótulo `Setembro 2026`.
- Ano: 1º de janeiro a 31 de dezembro, rótulo `2026`.
- O período selecionado **persiste** entre sessões; ao reabrir o app depois de 24h,
  volta para o período atual (semana/mês/ano correntes) mantendo a granularidade.

> Aceite: Dado que estou em "Mês / Agosto 2026", quando fecho e reabro o app no dia
> seguinte, então vejo "Mês / Setembro 2026" se a data já virou o mês, e "Agosto"
> caso contrário.

**RF-2 · Cartão de resumo**
Bloco superior com três números do período selecionado:

```
┌──────────────────────────────────────┐
│  Setembro 2026            ‹    ›     │
│                                      │
│  Entradas          R$  8.400,00      │
│  Gastos            R$  5.132,47      │
│  ─────────────────────────────       │
│  Sobra             R$  3.267,53      │
│                                      │
│  Aportes R$ 1.200  ·  Dívidas R$ 890 │
└──────────────────────────────────────┘
```

Regra de cálculo (crítica — define o que é "sobra"):

- `Entradas` = soma de `kind = income` no período.
- `Gastos` = soma de `kind = expense` no período (os 5 nichos de gasto).
- `Sobra` = `Entradas − Gastos − aportes líquidos − pagamentos de dívida`.
- Aportes e pagamentos de dívida aparecem como linha secundária, **não somados em
  "Gastos"**: aporte não é gasto, é dinheiro que mudou de lugar; parcela de dívida é
  quitação de passivo. Ambos saem do caixa e por isso entram no cálculo da sobra.
- Resgate de investimento **não** conta como entrada em "Entradas"; abate os aportes
  líquidos do período.

> Aceite: Dado renda de R$ 8.400, gastos de R$ 5.132,47, aporte de R$ 1.200 e parcela
> de R$ 890, então "Sobra" mostra R$ 1.177,53 e "Gastos" mostra R$ 5.132,47.

**RF-3 · Distribuição por nicho**
Lista dos 5 nichos de gasto ordenada por valor decrescente no período, cada linha com
nome, valor absoluto, percentual do total de gastos e uma barra horizontal
proporcional. Toque na linha abre a tela do nicho **já filtrada pelo mesmo período**.

Nichos com zero no período aparecem no fim da lista, apagados, sem barra.

**RF-4 · Evolução**
Um gráfico de barras da evolução dos gastos dentro do período:

- Semana → 7 barras (uma por dia).
- Mês → barras por semana do mês (4–6 barras) ou por dia; padrão: por dia.
- Ano → 12 barras (uma por mês).

Sem tooltip complexo: tocar numa barra mostra o valor daquela fatia acima do gráfico.

**RF-5 · Patrimônio resumido**
Duas linhas fixas no rodapé da Home, independentes do período (são saldos "hoje"):

- `Investido: R$ X` — soma dos saldos atuais de todos os ativos.
- `Devendo: R$ Y` — soma dos saldos devedores em aberto.
- `Patrimônio líquido: R$ X − Y`.

**RF-6 · Estado vazio**
Sem nenhum lançamento no período, a Home mostra um estado vazio com uma frase curta e
um botão que abre direto o formulário de lançamento. Nunca mostra gráfico vazio ou
"R$ 0,00" em todos os campos sem contexto.

### 4.2 Lançamento

**RF-7 · Novo gasto (fluxo principal)**
FAB → bottom sheet. Campos, nesta ordem:

1. **Valor** — teclado numérico já aberto, foco automático, máscara `R$ 0,00`
   preenchendo da direita para a esquerda.
2. **Nicho** — 5 chips horizontais (ou pré-selecionado se veio de dentro do nicho).
3. **Data** — chips `Hoje` / `Ontem` / `Outra…`. Padrão: hoje.
4. **Descrição** — texto livre, opcional, com autocompletar das últimas 20 descrições
   usadas naquele nicho.
5. **Forma de pagamento** — chips: Débito · Crédito · Pix · Dinheiro. Opcional,
   lembra a última usada.

Botão **Salvar** habilitado assim que valor > 0 e nicho selecionado. Ou seja: valor →
chip do nicho → salvar = 3 toques.

> Aceite: Dado que abro o formulário pelo FAB da Home, quando digito `4500`, toco em
> "Alimentação" e toco em "Salvar", então um gasto de R$ 45,00 em Alimentação com data
> de hoje é criado e o sheet fecha com um snackbar "Salvo · Desfazer".

**RF-8 · Desfazer**
Todo salvamento e toda exclusão mostram snackbar com ação **Desfazer** por 5 segundos.
Exclusão é *soft delete* (`deleted_at`), então desfazer é sempre possível dentro da
janela.

**RF-9 · Editar e excluir**
Toque num lançamento em qualquer lista abre o mesmo formulário em modo edição.
Deslizar para a esquerda exclui (com desfazer). Não existe exclusão sem confirmação
ou sem desfazer.

**RF-10 · Recorrência**
No formulário, um toggle "Repete todo mês". Marcado, o lançamento é criado com
`recurrence = monthly` e o app **gera automaticamente** a ocorrência do mês seguinte
na primeira abertura do app após a virada do mês, com a mesma data (ajustada para o
último dia do mês quando o dia não existir — dia 31 em fevereiro vira 28/29).

Ocorrências geradas são lançamentos normais: podem ser editadas ou excluídas
individualmente sem afetar a série. Editar a série inteira é v2.

### 4.3 Tela de nicho (Casa, Transporte, Alimentação, Saúde, Lazer)

**RF-11 · Cabeçalho**
Nome e ícone do nicho, total do período, comparação com o período anterior
(`↑ 12% vs. agosto`), e o mesmo seletor semana/mês/ano da Home, sincronizado com ela.

**RF-12 · Lista de lançamentos**
Agrupada por dia, mais recente primeiro, com subtotal por dia. Cada item: descrição
(ou "Sem descrição"), forma de pagamento, valor. Rolagem infinita paginada de 50 em 50.

**RF-13 · Mini-gráfico**
Barras dos últimos 6 períodos da mesma granularidade (6 semanas, 6 meses ou 6 anos),
para ver tendência do nicho sem sair da tela.

**RF-14 · Busca**
Campo de busca por descrição dentro do nicho, ignorando acentos e caixa.

### 4.4 Tela de Renda

**RF-15 · Fontes de renda**
Cadastro de fontes: nome, tipo (`Salário` / `Freelance` / `Aluguel` / `Outro`),
valor esperado e se é recorrente (dia do mês esperado).

**RF-16 · Recebimentos**
Lista de recebimentos do período, cada um vinculado (opcionalmente) a uma fonte.
Total recebido no período no topo, comparado com o total esperado das fontes
recorrentes: `Recebido R$ 8.400 de R$ 8.400 esperados`.

**RF-17 · Recebimento previsto e não confirmado**
Fonte recorrente cujo dia esperado já passou sem recebimento registrado aparece
destacada como `Previsto · não confirmado` com um botão "Confirmar recebimento" que
pré-preenche o formulário. Não é notificação; é só um estado na tela.

**RF-18 · Renda variável**
Recebimento avulso sem fonte vinculada é permitido e entra normalmente no total.

### 4.5 Tela de Investimentos

**RF-19 · Ativos**
Cadastro de ativo: nome (ex.: "Tesouro Selic 2029", "CDB Banco X"), tipo
(`Renda fixa` / `Renda variável` / `Fundo` / `Cripto` / `Outro`) e saldo atual em reais.

**RF-20 · Saldo manual**
O saldo é **digitado pelo usuário**, com data da última atualização visível
(`Atualizado há 12 dias`). Não há cotação automática — decisão explícita
(`DECISIONS.md`). Toque no saldo abre um campo para atualizá-lo; cada atualização é
gravada como um snapshot histórico.

**RF-21 · Aportes e resgates**
Movimentações de entrada (aporte) e saída (resgate) por ativo. Aporte sai do caixa e
entra no ativo; resgate faz o inverso. Ambos aparecem na Home como "movimentação
patrimonial", nunca como gasto ou renda (RF-2).

Ao registrar um aporte, o app oferece somar o valor ao saldo do ativo — sugestão com
um toque, nunca automático, porque o saldo real depende de rendimento que o app não
conhece.

**RF-22 · Rentabilidade aproximada**
Por ativo e no total: `saldo atual − (aportes − resgates acumulados)` = ganho/perda
nominal desde o início do registro. Exibido com o rótulo honesto **"aproximado"**,
porque depende do usuário manter o saldo atualizado.

### 4.6 Tela de Dívidas

**RF-23 · Cadastro de dívida**
Campos: nome (ex.: "Financiamento carro"), credor, valor total, número de parcelas,
valor da parcela, dia de vencimento, data da primeira parcela.

**RF-24 · Geração de parcelas**
Ao salvar, o app gera todas as parcelas com vencimento mensal a partir da primeira.
Cada parcela tem estado `em aberto` / `paga` / `vencida` (vencida = em aberto com
vencimento no passado).

**RF-25 · Pagar parcela**
Botão "Pagar" na parcela registra uma transação `debt_payment` na data de hoje (ou
data escolhida) e marca a parcela como paga. O saldo devedor da dívida cai pelo valor
da parcela.

> Nota de escopo: o MVP **não decompõe juros e principal**. A parcela inteira abate o
> saldo devedor. Amortização com juros é v2 — está registrado como limitação conhecida
> na seção 9.

**RF-26 · Visão da dívida**
Por dívida: saldo devedor, parcelas pagas/total (`14/48`), barra de progresso, próximo
vencimento e valor. No topo da tela: soma de todos os saldos devedores e total a pagar
nos próximos 30 dias.

### 4.7 Ajustes

**RF-27 · Exportar backup**
Gera um arquivo `jotta-backup-AAAA-MM-DD.json` com **todos** os dados e abre o seletor
de arquivos do Android (SAF) para o usuário escolher onde salvar, ou compartilhar.
Também oferece exportação em `.csv` (uma linha por transação) para uso em planilha.

**RF-28 · Importar backup**
Seleciona um `.json` de backup. Duas opções explícitas, com confirmação por texto:
**Substituir tudo** (apaga o banco local e restaura) ou **Mesclar** (insere o que não
existe, comparando por `id`). A escolha é irreversível e o app avisa isso antes.

**RF-29 · Apagar todos os dados**
Com confirmação dupla (digitar `APAGAR`). Necessário para atender o direito de exclusão
mesmo sem backend.

**RF-30 · Meu uso**
Tela com as métricas M1–M6 da seção 2, calculadas localmente. Nada é enviado.

**RF-31 · Aparência**
Tema Claro / Escuro / Sistema. Padrão: Sistema. Material 3 com cor dinâmica do
aparelho (Material You) quando disponível.

---

## 5. Arquitetura Técnica

### 5.1 Stack

| Camada | Escolha | Motivo |
|---|---|---|
| Framework | Flutter 3.x (Dart 3.x) | Decisão do usuário; abre caminho para iOS na v2 |
| UI | Material 3, cor dinâmica | Nativo do Android moderno, sem design system próprio a manter |
| Estado | Riverpod 2 (code-gen) | Injeção + estado num só lugar, testável sem widget tree |
| Navegação | go_router | Rotas declarativas, deep link pronto para atalhos futuros |
| Persistência | **Drift** sobre SQLite | Equivalente idiomático ao Room em Flutter: SQL tipado, migrações versionadas, queries reativas (`Stream`) |
| Modelos | freezed + json_serializable | Imutabilidade, `copyWith`, serialização do backup |
| Datas/moeda | `intl` com locale `pt_BR` | Formatação `R$ 1.234,56` e datas em português |
| Testes | `flutter_test`, `mocktail`, `drift/native` | Unidade, widget e banco em memória |
| Lint | `flutter_lints` + regras extras do projeto | |

**Sem** Firebase, sem HTTP client, sem SDK de terceiros com rede. O app declara
**nenhuma permissão de internet** no `AndroidManifest.xml` — isso é uma garantia
verificável de privacidade, não uma promessa.

### 5.2 Camadas

Organização **feature-first**, três camadas por feature:

```
lib/
├── main.dart
├── app/                       # bootstrap, tema, rotas, DI raiz
│   ├── app.dart
│   ├── router.dart
│   └── theme/
├── core/
│   ├── database/              # Drift: tabelas, DAOs, migrações
│   ├── money/                 # Money (centavos), formatação, parsing
│   ├── period/                # Period, PeriodType, cálculo de fronteiras
│   ├── result/                # Result<T, Failure>
│   └── widgets/               # componentes compartilhados
├── features/
│   ├── overview/              # Home
│   │   ├── data/              # repositório + queries agregadas
│   │   ├── domain/            # entidades, casos de uso
│   │   └── presentation/      # telas, controllers Riverpod, widgets
│   ├── transactions/          # formulário de lançamento (compartilhado)
│   ├── niches/                # tela genérica de nicho
│   ├── income/                # Renda
│   ├── investments/           # Investimentos
│   ├── debts/                 # Dívidas
│   ├── backup/                # export/import
│   └── settings/
└── l10n/                      # strings pt-BR (pronto para i18n, sem traduzir agora)
```

Regra de dependência: `presentation → domain ← data`. `domain` não importa Flutter nem
Drift. Isso mantém a regra de negócio (cálculo de sobra, fronteiras de período,
geração de parcelas) testável sem emulador.

### 5.3 Modelo de dados

Todos os valores monetários são **inteiros em centavos** (`INTEGER`). Nunca `double` —
ponto flutuante em dinheiro é bug garantido. Datas são `TEXT` no formato `YYYY-MM-DD`
em **hora local do aparelho** (o app é single-device; não há fuso a reconciliar).
IDs são UUID v4 em `TEXT`, para que o merge de backup funcione sem colisão.

```sql
-- Nichos: seed fixo de 7 linhas, não editável pelo usuário no MVP
CREATE TABLE niches (
  id            TEXT PRIMARY KEY,          -- 'casa', 'transporte', ...
  name          TEXT NOT NULL,
  icon          TEXT NOT NULL,
  color         INTEGER NOT NULL,
  kind          TEXT NOT NULL,             -- 'expense' | 'investment' | 'debt'
  sort_order    INTEGER NOT NULL
);

-- Toda movimentação de caixa vive aqui. Fonte única de verdade da Home.
CREATE TABLE transactions (
  id                  TEXT PRIMARY KEY,
  kind                TEXT NOT NULL,       -- 'expense' | 'income' | 'investment_in'
                                           -- | 'investment_out' | 'debt_payment'
  amount_cents        INTEGER NOT NULL CHECK (amount_cents > 0),
  occurred_on         TEXT NOT NULL,       -- 'YYYY-MM-DD'
  description         TEXT,
  payment_method      TEXT,                -- 'debit'|'credit'|'pix'|'cash'|NULL
  niche_id            TEXT REFERENCES niches(id),
  income_source_id    TEXT REFERENCES income_sources(id),
  investment_id       TEXT REFERENCES investments(id),
  debt_installment_id TEXT REFERENCES debt_installments(id),
  recurrence          TEXT,                -- NULL | 'monthly'
  recurrence_group_id TEXT,                -- agrupa ocorrências da mesma série
  created_at          TEXT NOT NULL,
  updated_at          TEXT NOT NULL,
  deleted_at          TEXT                 -- soft delete
);

CREATE INDEX idx_tx_period  ON transactions(occurred_on) WHERE deleted_at IS NULL;
CREATE INDEX idx_tx_niche   ON transactions(niche_id, occurred_on) WHERE deleted_at IS NULL;
CREATE INDEX idx_tx_kind    ON transactions(kind, occurred_on) WHERE deleted_at IS NULL;

CREATE TABLE income_sources (
  id             TEXT PRIMARY KEY,
  name           TEXT NOT NULL,
  type           TEXT NOT NULL,            -- 'salary'|'freelance'|'rent'|'other'
  expected_cents INTEGER,
  is_recurring   INTEGER NOT NULL DEFAULT 0,
  expected_day   INTEGER,                  -- 1..31, quando recorrente
  archived_at    TEXT,
  created_at     TEXT NOT NULL
);

CREATE TABLE investments (
  id                 TEXT PRIMARY KEY,
  name               TEXT NOT NULL,
  type               TEXT NOT NULL,        -- 'fixed'|'variable'|'fund'|'crypto'|'other'
  balance_cents      INTEGER NOT NULL DEFAULT 0,
  balance_updated_at TEXT,
  archived_at        TEXT,
  created_at         TEXT NOT NULL
);

-- Histórico de saldo, para o gráfico de evolução patrimonial
CREATE TABLE investment_balances (
  id            TEXT PRIMARY KEY,
  investment_id TEXT NOT NULL REFERENCES investments(id),
  balance_cents INTEGER NOT NULL,
  recorded_on   TEXT NOT NULL
);

CREATE TABLE debts (
  id                  TEXT PRIMARY KEY,
  name                TEXT NOT NULL,
  creditor            TEXT,
  total_cents         INTEGER NOT NULL,
  installment_count   INTEGER NOT NULL,
  installment_cents   INTEGER NOT NULL,
  first_due_on        TEXT NOT NULL,
  settled_at          TEXT,
  created_at          TEXT NOT NULL
);

CREATE TABLE debt_installments (
  id          TEXT PRIMARY KEY,
  debt_id     TEXT NOT NULL REFERENCES debts(id),
  number      INTEGER NOT NULL,            -- 1..N
  due_on      TEXT NOT NULL,
  amount_cents INTEGER NOT NULL,
  paid_on     TEXT,                        -- NULL = em aberto
  UNIQUE (debt_id, number)
);

CREATE TABLE app_settings (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
```

**Invariantes de integridade** (validadas no domínio, não só no banco):

- `kind = 'expense'` ⇒ `niche_id` obrigatório e o nicho é de `kind = 'expense'`.
- `kind = 'income'` ⇒ `niche_id` nulo.
- `kind IN ('investment_in','investment_out')` ⇒ `investment_id` obrigatório.
- `kind = 'debt_payment'` ⇒ `debt_installment_id` obrigatório.
- `SUM(amount_cents)` de parcelas de uma dívida pode divergir de `total_cents` por até
  N centavos (arredondamento); a última parcela absorve a diferença.

### 5.4 Cálculo de períodos

Uma classe `Period` no `core`, com fábricas `Period.week(date)`, `Period.month(date)`,
`Period.year(date)`, cada uma expondo `start`, `endExclusive`, `label` e
`previous()`/`next()`. Toda query agregada recebe um `Period`; nenhuma tela calcula
data por conta própria.

Casos de fronteira que **têm teste obrigatório**:

- Semana que cruza a virada do mês e do ano.
- Ano bissexto (29/02) na geração de recorrências e parcelas.
- Recorrência de dia 31 em meses de 30 dias e em fevereiro.
- Horário de verão: irrelevante por usarmos data pura (`YYYY-MM-DD`), sem `DateTime`
  com hora — e isso é intencional, documentado no código.

### 5.5 Consultas principais

A Home faz **uma** query agregada por período, não uma por card:

```sql
SELECT kind, niche_id, SUM(amount_cents) AS total, COUNT(*) AS n
FROM transactions
WHERE deleted_at IS NULL
  AND occurred_on >= :start AND occurred_on < :end_exclusive
GROUP BY kind, niche_id;
```

O gráfico de evolução usa uma segunda query com `GROUP BY` no bucket (dia, semana ou
mês) derivado de `occurred_on` via `substr()`. Ambas são expostas como `Stream` pelo
Drift, então qualquer inserção reflete na Home sem refresh manual.

### 5.6 Formato do backup

```json
{
  "schema": 1,
  "app": "jotta-financialmobile",
  "exported_at": "2026-09-05T14:22:10-03:00",
  "counts": { "transactions": 1284, "debts": 2 },
  "data": {
    "niches": [], "transactions": [], "income_sources": [],
    "investments": [], "investment_balances": [],
    "debts": [], "debt_installments": [], "app_settings": []
  }
}
```

O campo `schema` versiona o formato; o importador rejeita `schema` maior que o
suportado com mensagem clara, em vez de corromper o banco.

### 5.7 Requisitos não-funcionais

| # | Requisito | Meta | Verificação |
|---|---|---|---|
| RNF-1 | `minSdkVersion` | 26 (Android 8.0) | Build |
| RNF-2 | Cold start até Home interativa | < 1,5 s em aparelho mediano | Trace manual |
| RNF-3 | Home renderizada com 10.000 transações | < 300 ms para a query agregada | Teste de performance com seed |
| RNF-4 | Rolagem das listas | 60 fps, sem jank visível | `flutter run --profile` |
| RNF-5 | Tamanho do APK | < 25 MB | `flutter build apk --split-per-abi` |
| RNF-6 | Permissões declaradas | Nenhuma. Sem `INTERNET` | Inspeção do manifest em CI |
| RNF-7 | Acessibilidade | TalkBack lê todos os valores e ações; alvos de toque ≥ 48dp; contraste AA | Checklist manual + `flutter test --accessibility` |
| RNF-8 | Rotação e tamanhos | Retrato e paisagem; telas de 4.7" a tablets 10" | Teste em 3 densidades |
| RNF-9 | Perda de dados | Zero em kill do app, rotação e atualização de versão | Teste de migração com banco populado |
| RNF-10 | Fonte grande | Layout íntegro com fonte do sistema em 200% | Teste manual |

### 5.8 Estratégia de testes

| Tipo | Cobertura mínima | O que cobre |
|---|---|---|
| Unidade (domínio) | 90% | `Period`, `Money`, cálculo de sobra, geração de parcelas, recorrência, rentabilidade |
| Integração (Drift, banco em memória) | 80% | DAOs, queries agregadas, migrações, soft delete |
| Widget | Fluxos críticos | Formulário de lançamento, Home, tela de nicho |
| End-to-end (`integration_test`) | 4 jornadas | (1) lançar gasto, (2) filtrar período na Home, (3) pagar parcela, (4) exportar e reimportar backup |

Regra do projeto: **um bug corrigido = um teste que falhava antes**. Nenhuma correção
entra sem regressão coberta.

### 5.9 CI

GitHub Actions em cada push da branch:
`flutter analyze` → `dart format --set-exit-if-changed` → `flutter test --coverage`
→ verificação de que o manifest não declara `INTERNET` → `flutter build apk --debug`.

---

## 6. Fluxos Principais

### 6.1 Registrar um gasto (jornada mais frequente — 20+ vezes por semana)

```
Home ──[FAB]──▶ Sheet de lançamento
                  │  valor: teclado já aberto
                  │  nicho: chip
                  ├──[Salvar]──▶ Home atualizada + snackbar "Salvo · Desfazer"
                  └──[Mais opções]──▶ data, descrição, pagamento, recorrência
```

Meta: 3 toques, 10 segundos (M3). Tudo além de valor + nicho é opcional e fica
abaixo da dobra do sheet.

### 6.2 Entender o mês

```
Home ──[Mês]──▶ resumo + distribuição por nicho
        │
        └──[toque em "Alimentação"]──▶ tela do nicho, mesmo mês,
                                       lista por dia + tendência de 6 meses
```

### 6.3 Fechar o mês (uma vez por mês)

```
Renda ──▶ confirmar recebimentos previstos
Dívidas ──▶ pagar parcelas do mês
Investimentos ──▶ atualizar saldos dos ativos
Home ──▶ ver sobra e patrimônio líquido do mês fechado
Ajustes ──▶ exportar backup
```

---

## 7. Roadmap de Entrega

Estimativas para **um desenvolvedor**, em semanas de trabalho.

| Marco | Entrega | Semanas | Critério de saída |
|---|---|---|---|
| **M0** | Setup: projeto Flutter, Drift, Riverpod, go_router, tema M3, CI, seed dos nichos | 1 | CI verde, app roda mostrando Home vazia |
| **M1** | Núcleo: modelo de dados, formulário de lançamento, tela genérica de nicho, CRUD com desfazer | 2 | Consigo registrar e ver gastos nos 5 nichos |
| **M2** | Home: seletor de período, cartão de resumo, distribuição, gráfico de evolução, estados vazios | 2 | RF-1 a RF-6 aceitos; M3 (10s) medido |
| **M3** | Renda: fontes, recebimentos, previsto/não confirmado | 1 | RF-15 a RF-18 aceitos |
| **M4** | Investimentos e Dívidas: saldos, aportes, parcelas, pagamento | 2 | RF-19 a RF-26 aceitos; patrimônio na Home correto |
| **M5** | Backup/restauração, Ajustes, recorrência, acessibilidade, polimento | 1,5 | RF-27 a RF-31; RNF-7 e RNF-9 verificados |
| **M6** | Uso real por 2 semanas, correção do que aparecer, build assinado | 1,5 | M1–M6 da seção 2 medidos; APK instalado no aparelho |

**Total: ~11 semanas.** Caminho crítico: M1 → M2 (o valor do app inteiro depende do
formulário rápido e da Home confiável). M3 e M4 são paralelizáveis se houver mais gente.

**Corte de emergência:** se o prazo apertar, o que sai, nesta ordem: (1) gráfico de
evolução do nicho RF-13, (2) rentabilidade aproximada RF-22, (3) recorrência RF-10,
(4) tela de Renda inteira. O que **nunca** sai: lançamento rápido, os 5 nichos de
gasto, Home com filtro de período, backup.

---

## 8. Riscos

| # | Risco | Prob. | Impacto | Mitigação |
|---|---|---|---|---|
| R1 | Abandono por atrito do registro manual | **Alta** | Fatal — sem dado, o app não serve | M3 é métrica de gate; formulário é a primeira coisa a otimizar. v1.1: widget de home screen e atalho de 1 toque |
| R2 | Perda total dos dados com perda/formatação do aparelho | Média | Alto | Backup manual (RF-27) + lembrete mensal na Ajustes. v2: backup automático no Drive (já avaliado e adiado) |
| R3 | Escopo de 8 telas grande demais para um MVP | Média | Médio | Ordem de corte definida na seção 7; Investimentos e Dívidas reusam o máximo da tela genérica |
| R4 | Saldos de investimento desatualizados tornam o patrimônio mentiroso | **Alta** | Médio | Exibir sempre "Atualizado há N dias"; rotular rentabilidade como "aproximada"; nunca projetar |
| R5 | Dívida sem decomposição de juros dá saldo devedor irreal | Média | Médio | Documentado como limitação conhecida (seção 9); amortização real é o primeiro item da v2 |
| R6 | Migração de schema corromper dados em uso real | Baixa | Alto | Migrações versionadas do Drift + teste de migração com banco populado (RNF-9); backup automático antes de migrar |
| R7 | Flutter dificultar recursos nativos (widget, atalhos) na v1.1 | Média | Baixo | Fora do MVP; se virar bloqueio, plugin de plataforma resolve |

---

## 9. Limitações Conhecidas do MVP

Escritas aqui para que ninguém as descubra como "bug" depois:

1. Pagamento de parcela abate o saldo devedor pelo valor cheio — **não separa juros
   de principal**. O saldo devedor mostrado é "quanto falta pagar", não o valor
   presente da dívida.
2. Rentabilidade de investimento é `saldo − aportes líquidos`, e portanto **só é
   verdade se o usuário mantiver o saldo atualizado**.
3. Não há conciliação com o banco. Se o usuário esquecer de lançar, o app não sabe.
4. Compra parcelada no cartão não tem tratamento próprio: ou vira um gasto único, ou
   o usuário lança mês a mês. Parcelamento de compra é v2.
5. Editar uma série recorrente inteira não existe — só ocorrência por ocorrência.
6. Dados existem em **um** aparelho. Sem sync, sem web, sem multi-device.
7. Nichos são fixos. Quem gasta muito em algo fora dos 7 vai forçar a categoria.

---

## 10. Depois do MVP (backlog priorizado)

**v1.1 — reduzir atrito** (o problema nº 1)
- Widget de home screen com lançamento em 1 toque.
- Atalhos rápidos do app (long-press no ícone) por nicho.
- Lançamento por voz.

**v2 — o que foi conscientemente cortado**
1. Orçamento/teto mensal por nicho com barra de progresso e alerta em 80%/100%.
2. Nichos customizáveis (criar, renomear, arquivar, escolher ícone e cor).
3. Amortização real de dívidas com taxa de juros.
4. Compra parcelada no cartão gerando lançamentos futuros.
5. Backup automático criptografado no Google Drive do usuário.
6. Import de CSV/OFX com conciliação.

**v3 — expansão**
- iOS (o Flutter já foi escolhido pensando nisso).
- Open Finance via agregador, com consentimento e custo avaliados.
- Relatórios comparativos anuais e exportação para contador.

---

## 11. Aberturas Pendentes

Itens que **exigem a skill `grillme`** antes de virar código:

- Na virada do mês, recorrências devem ser criadas automaticamente (RF-10) ou apenas
  sugeridas para confirmação? O PRD assume automático — confirmar antes de M5.
- Nome público e identidade visual do app na Play Store.
- O backup exportado deve ser criptografado com senha?

---

## 12. Glossário

| Termo | Definição neste projeto |
|---|---|
| **Nicho** | Área da vida que ganha tela própria. Não é "categoria": é uma unidade de navegação |
| **Período** | Semana (seg→dom), mês (calendário) ou ano (calendário) |
| **Sobra** | Entradas − Gastos − aportes líquidos − pagamentos de dívida, no período |
| **Movimentação patrimonial** | Aporte, resgate ou pagamento de dívida. Sai do caixa mas não é gasto de consumo |
| **Saldo devedor** | Soma das parcelas em aberto de uma dívida (sem valor presente) |
| **Patrimônio líquido** | Total investido − total devendo, na data de hoje |
