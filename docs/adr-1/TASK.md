# ADR-1 — Plano de execução

| Campo | Valor |
|---|---|
| ADR | 1 — Fundação segura do app |
| SPEC de origem | [`SPEC.md`](SPEC.md) |
| PRD de origem | [`PRD.md`](PRD.md) |
| Total de tasks | 51 |
| Data | 2026-09-05 |

Cada task é **um commit** e fecha com **uma validação automatizada** que falha antes e
passa depois. A coluna `V-xx` liga a task à tabela de testes da seção 8 da SPEC.

---

## Progresso

| # | Task | Tipo de teste | V | Status |
|---|---|---|---|---|
| T-01 | Projeto Flutter, `applicationId`, `minSdk` | config | V-01 | [ ] |
| T-02 | Manifest sem permissões e sem Auto Backup | config | V-02 | [ ] |
| T-03 | Regras de extração de dados | config | V-03 | [ ] |
| T-04 | `pubspec.yaml` com versões exatas | config | V-04 | [ ] |
| T-05 | Lint e formatação | comando | V-41 | [ ] |
| T-06 | Estrutura de pastas e trava de camadas | arquitetura | V-05 | [ ] |
| T-07 | `Result<T, F>` | unidade | V-40 | [ ] |
| T-08 | `DatabaseKey`: geração e validação | unidade | V-06, V-08 | [ ] |
| T-09 | `DatabaseKey.toString()` redigido | unidade | V-07 | [ ] |
| T-10 | `DatabaseKeyStore.getOrCreate()` | unidade | V-09 | [ ] |
| T-11 | Chave corrompida vira `KeyCorrupted` | unidade | V-10 | [ ] |
| T-12 | `DatabaseKeyStore.destroy()` | unidade | V-11 | [ ] |
| T-13 | `EncryptedSharedPreferences` ligado | unidade | V-12 | [ ] |
| T-14 | SQLCipher carregado e ativo | integração | V-13 | [ ] |
| T-15 | `openEncryptedDatabase` e `SqlCipherUnavailable` | integração | V-14 | [ ] |
| T-16 | Round-trip com a chave certa | integração | V-15 | [ ] |
| T-17 | Abertura sem chave falha | integração | V-16 | [ ] |
| T-18 | Abertura com chave errada falha | integração | V-17 | [ ] |
| T-19 | Dado não aparece nos bytes do arquivo | integração | V-18 | [ ] |
| T-20 | `AppDatabase` e tabela `niches` | integração | V-19 | [ ] |
| T-21 | Tabela `transactions` com `CHECK` | integração | V-20 | [ ] |
| T-22 | Coluna `description_norm` e índice de busca | integração | V-45, V-46 | [ ] |
| T-23 | Tabela `app_usage_days` | integração | V-47 | [ ] |
| T-24 | Tabela `error_log` sem coluna sensível | integração | V-48 | [ ] |
| T-25 | Tabelas de renda e investimento | integração | V-19 | [ ] |
| T-26 | Tabelas de dívida com `UNIQUE` | integração | V-21 | [ ] |
| T-27 | `app_settings` e fechamento do schema | integração | V-19 | [ ] |
| T-28 | Índices parciais | integração | V-22 | [ ] |
| T-29 | `foreign_keys = ON` | integração | V-23 | [ ] |
| T-30 | `onUpgrade` que se recusa a adivinhar | integração | V-24 | [ ] |
| T-31 | Golden do schema v1 | golden | V-25 | [ ] |
| T-32 | Seed dos 7 nichos | integração | V-26 | [ ] |
| T-33 | Distribuição de `kind` dos nichos | integração | V-27 | [ ] |
| T-34 | Seed idempotente | integração | V-28 | [ ] |
| T-35 | Localização do arquivo do banco | unidade | V-43 | [ ] |
| T-36 | Providers do banco | unidade | V-42 | [ ] |
| T-37 | `BootstrapGate` e `main.dart` | widget | V-29 | [ ] |
| T-38 | `debugPrint` no-op em release | unidade | V-44 | [ ] |
| T-39 | Tela de falha que não vaza | widget | V-30 | [ ] |
| T-40 | Tema Material 3 com cor dinâmica | widget | V-31 | [ ] |
| T-41 | Rotas e telas vazias | widget | V-32 | [ ] |
| T-42 | Bottom nav e FAB persistente | widget | V-33 | [ ] |
| T-43 | Alvos de toque ≥ 48dp | widget | V-34 | [ ] |
| T-44 | `libsqlcipher` no runner | script CI | V-13–V-18 | [ ] |
| T-45 | Workflow de CI base | script CI | V-41 | [ ] |
| T-46 | Build do APK debug na CI | script CI | — | [ ] |
| T-47 | Trava: sem `INTERNET` no APK | script CI | V-35 | [ ] |
| T-48 | Trava: `allowBackup="false"` no APK | script CI | V-36 | [ ] |
| T-49 | Trava: baseline de permissões | script CI | V-37 | [ ] |
| T-50 | Trava: log de valor monetário | script CI | V-38 | [ ] |
| T-51 | Trava: material da chave no código | script CI | V-39 | [ ] |

---

## Bloco A — Projeto e travas de configuração

### T-01 — Criar o projeto Flutter com identidade definitiva

- **Spec:** §2, §3
- **Faz:** `flutter create` com `--org com.jotta --project-name financial`, ajusta
  `minSdk` para 26 e remove o boilerplate do contador.
- **Arquivos:** raiz do projeto, `android/app/build.gradle.kts` [novo],
  `test/config/android_config_test.dart` [novo]
- **Validação:** `flutter test test/config/android_config_test.dart` — config — **V-01** —
  faz parse do Gradle e exige `applicationId == "com.jotta.financial"`,
  `minSdk == 26` e `namespace` coerente. Falha se alguém trocar qualquer um dos três.
- **Pronto quando:** o teste passa e `flutter run` sobe o app com a tela padrão.
- **Depende de:** —

> Por que isso é uma task com teste e não uma linha de configuração: mudar o
> `applicationId` depois da primeira instalação com dado real obriga a desinstalar, e
> desinstalar apaga um banco que não tem cópia (risco A3).

### T-02 — Manifest sem permissões e sem Auto Backup

- **Spec:** §7 (SEG-4, SEG-5)
- **Faz:** limpa o manifest de qualquer `<uses-permission>` e define
  `android:allowBackup="false"`, `android:dataExtractionRules` e
  `android:fullBackupContent`.
- **Arquivos:** `android/app/src/main/AndroidManifest.xml`,
  `test/config/manifest_source_test.dart` [novo]
- **Validação:** `flutter test test/config/manifest_source_test.dart` — config — **V-02** —
  faz parse do XML e exige zero elementos `uses-permission`, `allowBackup="false"` e a
  presença dos dois atributos de regras.
- **Pronto quando:** o teste passa. A verificação equivalente sobre o manifest *merged*
  é a T-47/T-48 — esta cobre só o fonte.
- **Depende de:** T-01

### T-03 — Regras de extração de dados

- **Spec:** §7 (SEG-4)
- **Faz:** cria `data_extraction_rules.xml` negando `cloud-backup` e `device-transfer`
  (API 31+) e `backup_rules.xml` vazio (API < 31).
- **Arquivos:** `android/app/src/main/res/xml/data_extraction_rules.xml` [novo],
  `.../backup_rules.xml` [novo], `test/config/manifest_source_test.dart` [altera]
- **Validação:** `flutter test test/config/manifest_source_test.dart` — config — **V-03** —
  exige que ambos os XML existam e que o primeiro negue explicitamente os dois canais.
- **Pronto quando:** o teste passa.
- **Depende de:** T-02

### T-04 — `pubspec.yaml` com versões exatas

- **Spec:** §2, guarda-chuva §6.6
- **Faz:** declara as dependências deste ADR — `drift`, `sqlite3`,
  `sqlcipher_flutter_libs`, `flutter_secure_storage`, `riverpod`, `go_router`,
  `dynamic_color` — todas com versão exata, e comita o `pubspec.lock`.
- **Arquivos:** `pubspec.yaml`, `pubspec.lock`, `test/config/pubspec_pinning_test.dart` [novo]
- **Validação:** `flutter test test/config/pubspec_pinning_test.dart` — config — **V-04** —
  falha se qualquer dependência da lista sensível (cripto, banco, segredos) usar `^`,
  `any` ou intervalo aberto.
- **Pronto quando:** o teste passa e `pubspec.lock` está versionado.
- **Depende de:** T-01

> `local_auth` e `cryptography` **não** entram aqui. São do M5, e dependência não usada
> é superfície de ataque de graça.

### T-05 — Lint e formatação

- **Spec:** §3
- **Faz:** `analysis_options.yaml` com `flutter_lints` mais as regras do projeto
  (`prefer_final_locals`, `avoid_print`, `require_trailing_commas`).
- **Arquivos:** `analysis_options.yaml` [novo]
- **Validação:** `flutter analyze && dart format --set-exit-if-changed .` — comando —
  **V-41** — demonstrado uma vez com uma violação proposital (um `print` e um arquivo
  mal formatado) reprovando, antes de remover a violação.
- **Pronto quando:** ambos os comandos saem limpos e a demonstração da falha está no
  corpo do commit.
- **Depende de:** T-01

### T-06 — Estrutura de pastas e trava de camadas

- **Spec:** §3, guarda-chuva §5.2
- **Faz:** cria a árvore de `lib/` e escreve o teste que impede o domínio de importar
  Flutter ou Drift.
- **Arquivos:** `lib/**` (pastas), `test/architecture/layering_test.dart` [novo]
- **Validação:** `flutter test test/architecture/layering_test.dart` — arquitetura —
  **V-05** — varre todo `lib/features/*/domain/**.dart` e falha se encontrar
  `package:flutter` ou `package:drift` em um import. Demonstrado com um arquivo de
  domínio temporário que viola a regra.
- **Pronto quando:** o teste passa com a árvore real e falha com a violação injetada.
- **Depende de:** T-01

---

## Bloco B — Chave no Keystore

### T-07 — `Result<T, F>`

- **Spec:** §5.7
- **Faz:** `sealed class Result` com `Ok`, `Err` e `fold`.
- **Arquivos:** `lib/core/result/result.dart` [novo], `test/core/result/result_test.dart` [novo]
- **Validação:** `flutter test test/core/result/result_test.dart` — unidade — **V-40** —
  prova que `fold` chama o ramo `ok` em `Ok` e o ramo `err` em `Err`, e nunca os dois.
- **Pronto quando:** o teste passa.
- **Depende de:** T-06

### T-08 — `DatabaseKey`: geração e validação

- **Spec:** §5.1
- **Faz:** `DatabaseKey` com `generate()` (via `Random.secure`), `fromBytes`,
  `fromHex`, `toHex()` e `pragmaLiteral`.
- **Arquivos:** `lib/core/security/database_key.dart` [novo],
  `test/core/security/database_key_test.dart` [novo]
- **Validação:** `flutter test test/core/security/database_key_test.dart` — unidade —
  **V-06, V-08** — prova que `generate()` devolve 32 bytes, que duas gerações
  consecutivas diferem, que `pragmaLiteral` tem a forma `x'<64 hex>'`, e que
  `fromBytes` com 31 ou 33 bytes e `fromHex` com caractere inválido lançam.
- **Pronto quando:** o teste passa.
- **Depende de:** T-06

### T-09 — `DatabaseKey.toString()` redigido

- **Spec:** §5.1, §7 (RNF-16)
- **Faz:** sobrescreve `toString()` para `DatabaseKey(<redigida>)`.
- **Arquivos:** `lib/core/security/database_key.dart` [altera],
  `test/core/security/database_key_test.dart` [altera]
- **Validação:** `flutter test test/core/security/database_key_test.dart` — unidade —
  **V-07** — gera uma chave, interpola em uma string e exige que o hex **não** apareça
  no resultado.
- **Pronto quando:** o teste passa.
- **Depende de:** T-08

> Separada da T-08 de propósito: é o controle da RNF-16 e merece um commit que se possa
> apontar. Um `toString()` padrão que vaza a chave em uma mensagem de exceção é
> exatamente o tipo de falha que ninguém revisa.

### T-10 — `DatabaseKeyStore.getOrCreate()`

- **Spec:** §5.2
- **Faz:** interface `DatabaseKeyStore`, hierarquia `KeyStoreFailure` e a implementação
  sobre `flutter_secure_storage`.
- **Arquivos:** `lib/core/security/database_key_store.dart` [novo],
  `lib/core/security/keystore_database_key_store.dart` [novo],
  `test/core/security/keystore_database_key_store_test.dart` [novo]
- **Validação:** `flutter test test/core/security/keystore_database_key_store_test.dart`
  — unidade — **V-09** — com storage falso em memória: a 1ª chamada grava uma chave, a
  2ª devolve exatamente a mesma, e o storage foi escrito uma única vez.
- **Pronto quando:** o teste passa.
- **Depende de:** T-07, T-09

### T-11 — Chave corrompida vira `KeyCorrupted`

- **Spec:** §5.2
- **Faz:** valida o valor lido do storage antes de usá-lo.
- **Arquivos:** `lib/core/security/keystore_database_key_store.dart` [altera],
  `test/core/security/keystore_database_key_store_test.dart` [altera]
- **Validação:** mesmo comando — unidade — **V-10** — com `'nao-e-hex'` no storage,
  `getOrCreate()` devolve `Err(KeyCorrupted)` em vez de lançar, e **não** sobrescreve o
  valor existente.
- **Pronto quando:** o teste passa.
- **Depende de:** T-10

> Não sobrescrever é a parte que importa: gerar uma chave nova por cima de um valor
> ilegível transformaria um erro de leitura na destruição permanente do banco.

### T-12 — `DatabaseKeyStore.destroy()`

- **Spec:** §5.2, §7 (SEG-8)
- **Faz:** apaga o material do storage.
- **Arquivos:** `lib/core/security/keystore_database_key_store.dart` [altera],
  `test/core/security/keystore_database_key_store_test.dart` [altera]
- **Validação:** mesmo comando — unidade — **V-11** — depois de `destroy()`, o storage
  está vazio e o `getOrCreate()` seguinte devolve uma chave **diferente** da anterior.
- **Pronto quando:** o teste passa.
- **Depende de:** T-10

### T-13 — `EncryptedSharedPreferences` ligado

- **Spec:** §5.2, §7
- **Faz:** configura `AndroidOptions(encryptedSharedPreferences: true)` e expõe a opção
  para inspeção em teste.
- **Arquivos:** `lib/core/security/keystore_database_key_store.dart` [altera],
  `test/core/security/keystore_database_key_store_test.dart` [altera]
- **Validação:** mesmo comando — unidade — **V-12** — exige a flag ligada. Fixa a
  expectativa para que uma atualização da dependência não mude o padrão em silêncio.
- **Pronto quando:** o teste passa.
- **Depende de:** T-10

---

## Bloco C — Banco cifrado

### T-14 — SQLCipher carregado e ativo

- **Spec:** §5.4
- **Faz:** adiciona `sqlcipher_flutter_libs` e escreve o `sqlcipher_loader`, com
  `open.overrideFor` apontando para `libsqlcipher.so` no Linux.
- **Arquivos:** `lib/core/database/sqlcipher_loader.dart` [novo],
  `test/core/database/sqlcipher_active_test.dart` [novo]
- **Validação:** `flutter test test/core/database/sqlcipher_active_test.dart` —
  integração — **V-13** — abre um banco temporário e exige que
  `PRAGMA cipher_version` devolva string **não vazia**.
- **Pronto quando:** o teste passa localmente com `libsqlcipher-dev` instalado.
- **Depende de:** T-04, T-06

> **A task mais importante deste ADR.** Sem ela, `PRAGMA key` é aceito e ignorado pela
> SQLite do sistema, o banco fica em claro e absolutamente nada avisa (risco A1).

### T-15 — `openEncryptedDatabase` e `SqlCipherUnavailable`

- **Spec:** §5.3
- **Faz:** implementa a sequência `PRAGMA key` → `cipher_version` → `SELECT` de
  verificação, com as duas exceções tipadas.
- **Arquivos:** `lib/core/database/open_encrypted_database.dart` [novo],
  `test/core/database/sqlcipher_active_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-14** — forçando o loader a usar a
  SQLite **sem** SQLCipher, a abertura lança `SqlCipherUnavailable` em vez de devolver
  um banco em claro.
- **Pronto quando:** o teste passa nos dois cenários (com e sem SQLCipher).
- **Depende de:** T-08, T-14

### T-16 — Round-trip com a chave certa

- **Spec:** §5.3
- **Faz:** nada de novo em produção; fecha o caminho feliz.
- **Arquivos:** `test/core/database/encryption_at_rest_test.dart` [novo]
- **Validação:** `flutter test test/core/database/encryption_at_rest_test.dart` —
  integração — **V-15** — cria o banco, escreve uma linha, fecha, reabre com a mesma
  chave e lê a linha de volta.
- **Pronto quando:** o teste passa.
- **Depende de:** T-15

### T-17 — Abertura sem chave falha

- **Spec:** §5.3, PRD CA-3
- **Arquivos:** `test/core/database/encryption_at_rest_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-16** — abrir o mesmo arquivo sem
  `PRAGMA key` lança; nenhuma tabela é lida.
- **Pronto quando:** o teste passa.
- **Depende de:** T-16

### T-18 — Abertura com chave errada falha

- **Spec:** §5.3, PRD CA-3
- **Arquivos:** `test/core/database/encryption_at_rest_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-17** — abrir com uma segunda chave
  gerada lança `DatabaseLocked`.
- **Pronto quando:** o teste passa.
- **Depende de:** T-16

### T-19 — Dado não aparece nos bytes do arquivo

- **Spec:** §5.3, PRD CA-3
- **Arquivos:** `test/core/database/encryption_at_rest_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-18** — grava uma descrição-marcador
  única, fecha o banco, lê o arquivo como bytes e exige que a sequência do marcador
  **não** esteja presente. É a versão automatizada do `strings jotta.db`.
- **Pronto quando:** o teste passa.
- **Depende de:** T-16

---

## Bloco D — Schema v1

### T-20 — `AppDatabase` e tabela `niches`

- **Spec:** §4, §5.5
- **Faz:** primeira tabela Drift, `AppDatabase` com `schemaVersion = 1` e `onCreate`,
  e o `build_runner` gerando o código.
- **Arquivos:** `lib/core/database/tables/niches.dart` [novo],
  `lib/core/database/app_database.dart` [novo],
  `test/core/database/schema_v1_test.dart` [novo]
- **Validação:** `flutter test test/core/database/schema_v1_test.dart` — integração —
  **V-19 (parcial)** — banco novo tem a tabela `niches` com as 6 colunas da seção 5.3 e
  `schemaVersion == 1`.
- **Pronto quando:** o teste passa e o código gerado está versionado.
- **Depende de:** T-15

### T-21 — Tabela `transactions` com `CHECK`

- **Spec:** §4
- **Arquivos:** `lib/core/database/tables/transactions.dart` [novo],
  `lib/core/database/app_database.dart` [altera],
  `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-20** — inserir `amount_cents = 0` e
  `amount_cents = -1` falha; `1` passa.
- **Pronto quando:** o teste passa.
- **Depende de:** T-20

### T-22 — Coluna `description_norm` e índice de busca

- **Spec:** §4, guarda-chuva RF-14
- **Faz:** acrescenta `description_norm` a `transactions`, a função de normalização
  (minúscula + remoção de acento) e o índice parcial `idx_tx_search`.
- **Arquivos:** `lib/core/database/tables/transactions.dart` [altera],
  `lib/core/database/normalize.dart` [novo],
  `lib/core/database/app_database.dart` [altera],
  `test/core/database/schema_v1_test.dart` [altera],
  `test/core/database/normalize_test.dart` [novo]
- **Validação:** `flutter test test/core/database/` — integração — **V-45, V-46** —
  "Açúcar" normaliza para "acucar"; `LIKE '%acucar%'` sobre a coluna encontra o
  lançamento; `description` nula produz `description_norm` nula; e `idx_tx_search`
  existe com `WHERE deleted_at IS NULL`.
- **Pronto quando:** os testes passam.
- **Depende de:** T-21

> A normalização é gravada, não calculada na consulta: o `LIKE` do SQLite não faz
> *accent folding*, e normalizar em tempo de query impediria o uso do índice.

### T-23 — Tabela `app_usage_days`

- **Spec:** §4, guarda-chuva RF-30 / métrica M1
- **Faz:** tabela de um registro por dia com sessão, `day TEXT PRIMARY KEY`.
- **Arquivos:** `lib/core/database/tables/app_usage_days.dart` [novo],
  `lib/core/database/app_database.dart` [altera],
  `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-47** — registrar o mesmo dia duas
  vezes mantém uma linha; dois dias diferentes produzem duas.
- **Pronto quando:** o teste passa.
- **Depende de:** T-20

> A tabela entra agora e fica vazia até o M5 preenchê-la. Dia não registrado é dia
> perdido para sempre — e a métrica M1 é um dos três critérios de MVP bem-sucedido.

### T-24 — Tabela `error_log` sem coluna sensível

- **Spec:** §4, §7 (SEG-6), guarda-chuva RF-30 / métrica M5
- **Faz:** tabela com `id`, `occurred_at`, `type`, `screen`, `stack` — e nada mais.
- **Arquivos:** `lib/core/database/tables/error_log.dart` [novo],
  `lib/core/database/app_database.dart` [altera],
  `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-48** — a tabela tem exatamente essas
  5 colunas, e o teste **falha se alguém acrescentar** coluna de valor, descrição,
  credor ou fonte de renda.
- **Pronto quando:** o teste passa.
- **Depende de:** T-20

> O teste vigia a ausência, não a presença. É a forma de o SEG-6 ("nunca o dado que
> causou o erro") virar impedimento estrutural em vez de recomendação: para logar um
> valor monetário seria preciso alterar o schema e derrubar este teste de propósito.

### T-25 — Tabelas de renda e investimento

- **Spec:** §4
- **Arquivos:** `lib/core/database/tables/income_sources.dart` [novo],
  `.../investments.dart` [novo], `.../investment_balances.dart` [novo],
  `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-19 (parcial)** — as três tabelas
  existem com as colunas e tipos da seção 5.3.
- **Pronto quando:** o teste passa.
- **Depende de:** T-20

### T-26 — Tabelas de dívida com `UNIQUE`

- **Spec:** §4
- **Arquivos:** `lib/core/database/tables/debts.dart` [novo],
  `.../debt_installments.dart` [novo], `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-21** — inserir duas parcelas com o
  mesmo `(debt_id, number)` falha.
- **Pronto quando:** o teste passa.
- **Depende de:** T-20

### T-27 — `app_settings` e fechamento do schema

- **Spec:** §4
- **Arquivos:** `lib/core/database/tables/app_settings.dart` [novo],
  `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-19** — o banco novo tem
  **exatamente 10** tabelas, nem uma a mais nem a menos.
- **Pronto quando:** o teste passa.
- **Depende de:** T-21, T-22, T-23, T-24, T-25, T-26

### T-28 — Índices parciais

- **Spec:** §4
- **Faz:** cria `idx_tx_period`, `idx_tx_niche` e `idx_tx_kind` por SQL literal no
  `onCreate` — o `idx_tx_search` já entrou na T-22.
- **Arquivos:** `lib/core/database/app_database.dart` [altera],
  `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-22** — os **4** índices existem em
  `sqlite_master` e cada definição contém `WHERE deleted_at IS NULL`.
- **Pronto quando:** o teste passa.
- **Depende de:** T-22

> O `WHERE` é testado, não só a existência: um índice completo em vez de parcial passa
> despercebido e degrada exatamente a query que a Home mais usa (RNF-3).

### T-29 — `foreign_keys = ON`

- **Spec:** §4
- **Arquivos:** `lib/core/database/app_database.dart` [altera],
  `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-23** — após abrir,
  `PRAGMA foreign_keys` devolve 1, e inserir uma transação com `niche_id` inexistente
  falha.
- **Pronto quando:** o teste passa.
- **Depende de:** T-27

### T-30 — `onUpgrade` que se recusa a adivinhar

- **Spec:** §4
- **Arquivos:** `lib/core/database/app_database.dart` [altera],
  `test/core/database/schema_v1_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-24** — chamar a estratégia com
  `from: 1, to: 2` lança `UnsupportedError`.
- **Pronto quando:** o teste passa.
- **Depende de:** T-27

### T-31 — Golden do schema v1

- **Spec:** §4
- **Faz:** grava o dump ordenado de `sqlite_master` como fixture.
- **Arquivos:** `test/fixtures/schema_v1.sql` [novo],
  `test/core/database/schema_snapshot_test.dart` [novo]
- **Validação:** `flutter test test/core/database/schema_snapshot_test.dart` — golden —
  **V-25** — o schema gerado bate byte a byte com a fixture. Qualquer alteração de
  coluna, tipo ou índice quebra o teste e obriga a atualizar o golden conscientemente.
- **Pronto quando:** o teste passa.
- **Depende de:** T-28, T-29

---

## Bloco E — Seed dos nichos

### T-32 — Seed dos 7 nichos

- **Spec:** §5.6
- **Faz:** `kNicheSeed` — os 7 nichos com id, nome, nome do ícone Material Symbols,
  cor e ordem — e a inserção dentro da transação do `onCreate`.
- **Arquivos:** `lib/core/database/seed/niche_seed.dart` [novo],
  `lib/core/database/app_database.dart` [altera],
  `test/core/database/niche_seed_test.dart` [novo]
- **Validação:** `flutter test test/core/database/niche_seed_test.dart` — integração —
  **V-26** — banco novo tem 7 nichos, com os ids da tabela da §5.6, `sort_order` de
  1 a 7 sem buraco nem repetição, e `icon` e `color` preenchidos nos 7.
- **Pronto quando:** o teste passa.
- **Depende de:** T-20

### T-33 — Distribuição de `kind` dos nichos

- **Spec:** §5.6
- **Arquivos:** `test/core/database/niche_seed_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-27** — 5 nichos `expense`, 1
  `investment`, 1 `debt`.
- **Pronto quando:** o teste passa.
- **Depende de:** T-32

### T-34 — Seed idempotente

- **Spec:** §5.6
- **Faz:** troca a inserção para `InsertMode.insertOrIgnore`.
- **Arquivos:** `lib/core/database/seed/niche_seed.dart` [altera],
  `test/core/database/niche_seed_test.dart` [altera]
- **Validação:** mesmo comando — integração — **V-28** — rodar o seed duas vezes no
  mesmo banco mantém 7 linhas.
- **Pronto quando:** o teste passa.
- **Depende de:** T-32

---

## Bloco F — Bootstrap, navegação e tema

### T-35 — Localização do arquivo do banco

- **Spec:** §5.8
- **Faz:** resolve o caminho de `jotta.db` no diretório privado do app via
  `path_provider`. Nunca em armazenamento externo — arquivo cifrado em diretório
  compartilhado continua sendo um arquivo que qualquer app com permissão de leitura
  copia.
- **Arquivos:** `lib/core/database/database_location.dart` [novo],
  `test/core/database/database_location_test.dart` [novo], `pubspec.yaml` [altera]
- **Validação:** `flutter test test/core/database/database_location_test.dart` —
  unidade — **V-43** — com `PathProviderPlatform` substituído, o caminho resolvido cai
  sob o diretório privado do app e termina em `jotta.db`; nenhum caminho externo é
  produzido.
- **Pronto quando:** o teste passa e `path_provider` está com versão exata no `pubspec`.
- **Depende de:** T-04, T-15

### T-36 — Providers do banco

- **Spec:** §6
- **Faz:** `databaseKeyStoreProvider` e `appDatabaseProvider` (`keepAlive`), com o
  code-gen do Riverpod.
- **Arquivos:** `lib/core/database/providers.dart` [novo],
  `test/app/providers_test.dart` [novo]
- **Validação:** `flutter test test/app/providers_test.dart` — unidade — **V-42** — com
  o store sobrescrito por um falso, o provider pede a chave uma vez e abre o banco no
  caminho da T-35 com exatamente aquela chave.
- **Pronto quando:** o teste passa.
- **Depende de:** T-13, T-27, T-35

### T-37 — `BootstrapGate` e `main.dart`

- **Spec:** §6
- **Faz:** `ProviderScope`, `JottaApp` e o gate que observa o provider assíncrono.
- **Arquivos:** `lib/main.dart` [novo], `lib/app/app.dart` [novo],
  `lib/app/bootstrap_gate.dart` [novo], `test/app/bootstrap_gate_test.dart` [novo]
- **Validação:** `flutter test test/app/bootstrap_gate_test.dart` — widget — **V-29** —
  com o provider em erro, a árvore renderiza a tela de falha e **não** a casca de
  navegação; com o provider resolvido, o contrário.
- **Pronto quando:** o teste passa nos dois estados.
- **Depende de:** T-36

### T-38 — `debugPrint` no-op em release

- **Spec:** §5.9, §7 (SEG-6)
- **Faz:** `installLogging({required bool isRelease})`, chamada no `main()`, que
  substitui `debugPrint` por uma função vazia quando em release.
- **Arquivos:** `lib/app/logging.dart` [novo], `lib/main.dart` [altera],
  `test/app/logging_test.dart` [novo]
- **Validação:** `flutter test test/app/logging_test.dart` — unidade — **V-44** — com
  `isRelease: true`, `debugPrint('segredo')` não produz saída; com `isRelease: false`,
  produz.
- **Pronto quando:** o teste passa nos dois modos.
- **Depende de:** T-37

> O parâmetro `isRelease` existe para o teste: `kReleaseMode` é `const` e não dá para
> alternar dentro da suíte. `main()` passa `kReleaseMode`; o teste passa os dois valores.
> Sem essa costura, o controle só seria verificável instalando um APK de release — que é
> exatamente como esta metade do SEG-6 tinha ficado sem prova.

### T-39 — Tela de falha que não vaza

- **Spec:** §6, §7 (RNF-16)
- **Faz:** `BootstrapFailureScreen` mostrando só o tipo do erro.
- **Arquivos:** `lib/app/bootstrap_gate.dart` [altera],
  `test/app/bootstrap_gate_test.dart` [altera]
- **Validação:** `flutter test test/app/bootstrap_gate_test.dart` — widget — **V-30** —
  com uma falha que carrega chave e caminho do banco na mensagem, nenhum dos dois
  aparece na árvore renderizada.
- **Pronto quando:** o teste passa.
- **Depende de:** T-37

### T-40 — Tema Material 3 com cor dinâmica

- **Spec:** §6
- **Arquivos:** `lib/app/theme/app_theme.dart` [novo], `lib/app/app.dart` [altera],
  `test/app/theme_test.dart` [novo]
- **Validação:** `flutter test test/app/theme_test.dart` — widget — **V-31** —
  `useMaterial3` é true no claro e no escuro, e sem cor dinâmica disponível o tema cai
  no `ColorScheme.fromSeed` sem lançar.
- **Pronto quando:** o teste passa.
- **Depende de:** T-37

### T-41 — Rotas e telas vazias

- **Spec:** §6
- **Faz:** `StatefulShellRoute.indexedStack` com as 4 rotas e as 4 telas com estado
  vazio.
- **Arquivos:** `lib/app/router.dart` [novo], `lib/features/*/presentation/*_page.dart`
  [novos], `test/app/router_test.dart` [novo]
- **Validação:** `flutter test test/app/router_test.dart` — widget — **V-32** — cada
  uma das 4 rotas resolve e renderiza o texto de estado vazio da sua tela.
- **Pronto quando:** o teste passa.
- **Depende de:** T-40

### T-42 — Bottom nav e FAB persistente

- **Spec:** §6
- **Arquivos:** `lib/app/router.dart` [altera], `test/app/router_test.dart` [altera]
- **Validação:** mesmo comando — widget — **V-33** — tocar cada aba troca a tela, o FAB
  está presente nas 4, e voltar para uma aba preserva a pilha dela.
- **Pronto quando:** o teste passa.
- **Depende de:** T-41

### T-43 — Alvos de toque ≥ 48dp

- **Spec:** §6, guarda-chuva RNF-7
- **Arquivos:** `lib/app/router.dart` [altera], `test/app/router_test.dart` [altera]
- **Validação:** mesmo comando — widget — **V-34** — o retângulo de cada item da bottom
  nav e do FAB tem altura e largura ≥ 48dp.
- **Pronto quando:** o teste passa.
- **Depende de:** T-42

---

## Bloco G — CI e travas de segurança

> **A ordem deste bloco não é arbitrária.** A biblioteca do SQLCipher entra **antes** do
> job que roda a suíte: quando o workflow completo sobe, as tasks T-14 a T-19 já estão
> comitadas, e sem `libsqlcipher` no runner elas reprovam. E o build do APK vem **antes**
> das travas de manifest, porque elas leem o manifest *merged*, que só existe dentro do
> APK.

### T-44 — `libsqlcipher` no runner

- **Spec:** §5.4
- **Faz:** cria o workflow com a versão do Flutter fixada e a etapa
  `apt-get install libsqlcipher-dev`, e roda **apenas** os testes de banco
  (`flutter test test/core/database/`).
- **Arquivos:** `.github/workflows/ci.yml` [novo]
- **Validação:** o job na CI — script CI — **V-13 a V-18** — os seis testes do bloco C
  passam no runner. Removendo a etapa do `apt-get`, os seis falham: é a demonstração.
- **Pronto quando:** o job passa com a etapa e reprova sem ela.
- **Depende de:** T-19

### T-45 — Workflow de CI base

- **Spec:** §3, guarda-chuva §5.9
- **Faz:** acrescenta ao workflow `flutter analyze`,
  `dart format --set-exit-if-changed .` e `flutter test --coverage` sobre a suíte
  **inteira**.
- **Arquivos:** `.github/workflows/ci.yml` [altera]
- **Validação:** o job na CI — script CI — **V-41** — verde no push. Falha proposital
  (um `print` deixado no código) verificada uma vez antes do merge.
- **Pronto quando:** o job passa e a demonstração da falha está registrada no commit.
- **Depende de:** T-05, T-44

### T-46 — Build do APK debug na CI

- **Spec:** §3
- **Faz:** etapa `flutter build apk --debug`, cujo artefato as travas seguintes leem.
- **Arquivos:** `.github/workflows/ci.yml` [altera]
- **Validação:** o job na CI — script CI — a etapa falha se
  `build/app/outputs/flutter-apk/app-debug.apk` não existir ao final.
- **Pronto quando:** o APK é produzido em cada execução.
- **Depende de:** T-43, T-45

### T-47 — Trava: sem `INTERNET` no APK

- **Spec:** §2, §7 (SEG-5, guarda-chuva §5.9 item 1)
- **Faz:** `check_manifest.sh` lendo o manifest **merged** do APK com `aapt2 dump
  permissions`.
- **Arquivos:** `tool/ci/check_manifest.sh` [novo], `.github/workflows/ci.yml` [altera]
- **Validação:** o script na CI — script CI — **V-35** — reprova o build quando
  `android.permission.INTERNET` aparece. Demonstrado adicionando a permissão ao
  manifest, vendo o job falhar, e removendo.
- **Pronto quando:** o script passa no APK real e falha na fixture negativa.
- **Depende de:** T-46

> Lê o APK, não o XML-fonte: o merge de dependências é justamente o caminho pelo qual
> uma permissão entra sem ninguém escrever uma linha (risco A4).

### T-48 — Trava: `allowBackup="false"` no APK

- **Spec:** §7 (SEG-4, guarda-chuva §5.9 item 2)
- **Arquivos:** `tool/ci/check_manifest.sh` [altera]
- **Validação:** o script na CI — script CI — **V-36** — reprova se `allowBackup` for
  diferente de `false` no manifest merged, ou se as regras de extração sumirem.
  Demonstrado com `allowBackup="true"`.
- **Pronto quando:** o script passa no APK real e falha na fixture negativa.
- **Depende de:** T-47

### T-49 — Trava: baseline de permissões

- **Spec:** §2, guarda-chuva §6.6
- **Faz:** compara a lista de permissões do APK com um baseline versionado (vazio).
- **Arquivos:** `tool/ci/permissions.baseline` [novo], `tool/ci/check_manifest.sh` [altera]
- **Validação:** o script na CI — script CI — **V-37** — qualquer permissão fora do
  baseline reprova o build, com o diff impresso. Demonstrado com `VIBRATE`, que é
  inofensiva e ainda assim precisa de decisão explícita.
- **Pronto quando:** o script passa e falha na fixture negativa.
- **Depende de:** T-48

### T-50 — Trava: log de valor monetário

- **Spec:** §7 (SEG-6, guarda-chuva §5.9 item 4)
- **Faz:** `check_logs.sh` com o `grep` de padrões de log de valor fora de bloco de
  debug.
- **Arquivos:** `tool/ci/check_logs.sh` [novo], `.github/workflows/ci.yml` [altera]
- **Validação:** o script na CI — script CI — **V-38** — reprova um
  `print('valor: $amountCents')` fora de `kDebugMode`. Demonstrado com a linha
  injetada.
- **Pronto quando:** o script passa e falha na fixture negativa.
- **Depende de:** T-45

### T-51 — Trava: material da chave no código

- **Spec:** §5.1, §7 (RNF-16)
- **Faz:** estende `check_logs.sh` para reprovar `toHex()` de `DatabaseKey` fora de
  `database_key.dart` e `keystore_database_key_store.dart`.
- **Arquivos:** `tool/ci/check_logs.sh` [altera]
- **Validação:** o script na CI — script CI — **V-39** — uma chamada a `key.toHex()`
  em qualquer outro arquivo reprova o build.
- **Pronto quando:** o script passa e falha na fixture negativa.
- **Depende de:** T-50

---

## Definição de pronto do ADR-1

O ADR-1 está fechado quando, e só quando:

1. As **51 tasks** estão marcadas, cada uma com seu commit e sua validação verde.
2. `flutter test` roda a suíte inteira sem falha e sem teste pulado.
3. A CI está verde, e as **5 travas de segurança** (T-47 a T-51) foram cada uma
   demonstradas reprovando uma violação proposital — não basta estarem verdes, elas
   precisam ter provado que sabem falhar.
4. Os **8 critérios de aceite** do [`PRD.md`](PRD.md) foram verificados um a um.
5. O checklist manual do marco foi feito **em aparelho real**, e não só no desktop:
   - APK instalado em um Android 8.0 ou superior — **é esta a metade do CA-1 que
     nenhum teste de widget cobre**;
   - o app abre, navega pelas 4 abas e não trava;
   - o arquivo `jotta.db` extraído do sandbox via `adb` não abre com `sqlite3`, e
     `strings` nele não revela nome de tabela nem conteúdo;
   - `logcat` limpo durante uma sessão completa de uso, em build de release.

O item 5 é a contrapartida da decisão de não colocar emulador na CI. Ele é obrigatório
para fechar o marco, e é o único ponto do ADR-1 em que a prova é humana.

## Cobertura

**48 linhas** na tabela de testes da SPEC (V-01 a V-48). **48 têm task correspondente.**
Nenhuma ficou de fora.

Uma task não tem `V-xx`: a **T-46** (build do APK), cuja validação é a existência do
artefato — ela não prova requisito nenhum, existe para alimentar as travas T-47 a T-49.
