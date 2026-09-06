# ADR-1 — Especificação técnica

| Campo | Valor |
|---|---|
| ADR | 1 — Fundação segura do app |
| PRD de origem | [`PRD.md`](PRD.md) |
| Guarda-chuva | [`../PRD-MVP.md`](../PRD-MVP.md), seções 5 e 6 |
| Versão | 1.0 |
| Data | 2026-09-05 |
| Status | Aprovado |

---

## 1. Resumo técnico

Cria o projeto Flutter `com.jotta.financial`, sobe o banco Drift **sobre SQLCipher** com
chave de 32 bytes vinda do Android Keystore, aplica o schema v1 completo com o seed dos
7 nichos, monta a casca de navegação (Riverpod + go_router + Material 3) e instala uma
CI que reprova o build se qualquer garantia de segurança for afrouxada.

O eixo técnico da fatia é um detalhe fácil de errar: **`PRAGMA key` em uma SQLite que
não é SQLCipher é aceito e ignorado.** O banco fica em claro e nada avisa. Toda a
estratégia de teste deste ADR gira em torno de provar que isso não aconteceu.

## 2. Decisões técnicas desta fatia

| Decisão | Alternativa descartada | Por quê |
|---|---|---|
| `applicationId` = `com.jotta.financial` | `br.com.joaosantos.jotta`; `com.jottafinancial.app` | Decisão do usuário. Trava agora porque mudar depois da 1ª instalação com dado real apaga um banco irrecuperável |
| Chave passada como **raw key hex**: `PRAGMA key = "x'<64 hex>'"` | Passar a chave como texto e deixar o SQLCipher rodar PBKDF2 por cima | A chave já tem 256 bits de entropia de CSPRNG. Derivar de novo custa tempo de abertura e não acrescenta segurança |
| SQLCipher via **hooks nativos do `sqlite3` 3.x** (`hooks.user_defines.sqlite3.source: sqlcipher` no pubspec) | `package:sqlcipher_flutter_libs` | **Emenda de 2026-09-05, na implementação:** `sqlcipher_flutter_libs` está EOL no pub.dev ("Not used anymore, update to version 3.x of package:sqlite3 instead"). O hook baixa, para **qualquer plataforma que rodar o app ou o teste**, o mesmo build de SQLCipher community edition dos releases assinados do pacote — verificado por sha256 embutido no código Dart e, na versão travada (3.5.2), por atestação SLSA3. Testado neste ambiente: `PRAGMA cipher_version` devolveu `4.18.0 community` |
| Prova do SEG-1 roda no **desktop**, com o SQLCipher baixado pelo hook — **o mesmo binário que o Android usaria**, não mais uma lib do sistema operacional | Emulador Android no pipeline; `libsqlcipher-dev` do apt do runner Linux | Decisão original do usuário (desktop em vez de emulador) preservada; o **mecanismo** mudou. Antes disso, CI e Android usariam dois binários de SQLCipher diferentes (risco A2, mitigado por checklist manual). O hook os torna o **mesmo arquivo**: o risco deixa de existir, em vez de ser mitigado |
| Schema **v1 completo** na migração 1, com as 10 tabelas | Criar cada tabela no ADR que a consome | Migração é global e barata de fazer de uma vez; fatiar cria 6 migrações para chegar no mesmo lugar, cada uma com risco de perda de dados |
| Seed dos nichos no `onCreate` da migração, não em código de app | Semear na primeira abertura da Home | O seed é parte do schema: um banco sem os 7 nichos é um banco inválido, não um banco vazio |
| `DatabaseKey` é um tipo próprio com `toString()` redigido | Passar a chave como `String` | `String` cru aparece em log, em mensagem de exceção e em `toString()` de objeto que a contenha. RNF-16 vira estrutural em vez de disciplina |
| Trava de manifest lê o **APK construído** via `aapt2 dump`, não o XML-fonte | `grep` no `AndroidManifest.xml` do repositório | O fonte não vê o que o merge de dependências acrescentou. É exatamente o cenário do risco A4 |
| `niches.icon` guarda **nome** de ícone Material Symbols (`home`, `directions_car`, …) | Emoji literal na coluna | Ícone nativo herda a cor do tema, escala com a fonte do sistema e o TalkBack lê o rótulo do nicho — o emoji faz o leitor dizer "veículo utilitário esportivo" |
| Mapeamento nome → `IconData` por `const Map` na camada de apresentação | `IconData(codePoint)` construído a partir da string | `IconData` dinâmico **desliga o tree-shaking de ícones** do Flutter e obriga `--no-tree-shake-icons`, engordando o APK contra o RNF-5 |
| `niches.color` são 7 valores ARGB fixos no seed | Derivar da paleta tonal do Material You | Paleta tonal é harmônica, não contrastante: os 7 nichos ficariam parecidos e a distribuição da Home perderia legibilidade. E a cor mudaria com o papel de parede |
| Schema v1 ganha `description_norm`, `app_usage_days` e `error_log` | Deixar para uma v2 | O `onUpgrade` lança em vez de migrar; o que ficar fora hoje exige um mecanismo que ainda não existe. Decisão do usuário |
| Medições da métrica M3 **não** são persistidas | Tabela própria para os tempos de lançamento | Fora por não-seleção do usuário. Se mudar de ideia, cabe em `app_settings` como JSON — que já existe no v1 e **não exige migração nenhuma** |
| Banco em `getApplicationDocumentsDirectory()` (`path_provider`), diretório privado do app | Armazenamento externo/compartilhado | Arquivo cifrado em diretório compartilhado continua sendo um arquivo que outro app copia. A cifra protege o conteúdo; o diretório privado evita a cópia |
| Regra de camadas verificada por teste que varre imports | Convenção documentada e revisão de PR | Convenção não roda na CI |

Todas as linhas acima vão para `docs/DECISIONS.md`.

## 3. Estrutura de arquivos

```
pubspec.yaml                                   [novo]
analysis_options.yaml                          [novo]
.github/workflows/ci.yml                       [novo]
tool/ci/check_manifest.sh                      [novo]   travas RNF-14 #1 e #2
tool/ci/check_logs.sh                          [novo]   travas RNF-14 #4 e RNF-16
tool/ci/permissions.baseline                   [novo]   baseline versionado (vazio)

android/app/build.gradle.kts                   [novo]   applicationId, minSdk 26
android/app/src/main/AndroidManifest.xml       [novo]   zero permissões, allowBackup=false
android/app/src/main/res/xml/
  data_extraction_rules.xml                    [novo]   nega cloud-backup e device-transfer
  backup_rules.xml                             [novo]   fullBackupContent vazio (API < 31)

lib/
├── main.dart                                  [novo]   bootstrap
├── app/
│   ├── app.dart                               [novo]   JottaApp (MaterialApp.router)
│   ├── router.dart                             [novo]   go_router + shell
│   ├── bootstrap_gate.dart                    [novo]   splash / erro de abertura do banco
│   ├── logging.dart                           [novo]   debugPrint no-op em release
│   └── theme/app_theme.dart                   [novo]   M3 + cor dinâmica
├── core/
│   ├── result/result.dart                     [novo]   Result<T, Failure>
│   ├── security/
│   │   ├── database_key.dart                  [novo]   DatabaseKey (toString redigido)
│   │   ├── database_key_store.dart            [novo]   interface
│   │   └── keystore_database_key_store.dart   [novo]   flutter_secure_storage
│   └── database/
│       ├── app_database.dart                  [novo]   @DriftDatabase, schemaVersion 1
│       ├── open_encrypted_database.dart       [novo]   PRAGMA key + verificação
│       ├── database_location.dart            [novo]   caminho de jotta.db
│       ├── providers.dart                    [novo]   databaseKeyStore, appDatabase
│       ├── normalize.dart                     [novo]   minúscula + sem acento (RF-14)
│       ├── tables/*.dart                      [novo]   10 tabelas
│       └── seed/niche_seed.dart               [novo]   as 7 linhas
└── features/
    ├── overview/presentation/overview_page.dart   [novo]   vazia
    ├── niches/presentation/niches_page.dart       [novo]   vazia
    ├── income/presentation/income_page.dart       [novo]   vazia
    └── settings/presentation/settings_page.dart   [novo]   vazia

test/
├── config/
│   ├── android_config_test.dart               [novo]
│   ├── manifest_source_test.dart              [novo]
│   └── pubspec_pinning_test.dart              [novo]
├── architecture/layering_test.dart            [novo]
├── core/result/result_test.dart               [novo]
├── core/security/
│   ├── database_key_test.dart                 [novo]
│   └── keystore_database_key_store_test.dart  [novo]
├── core/database/
│   ├── database_location_test.dart            [novo]
│   ├── normalize_test.dart                    [novo]
│   ├── sqlcipher_active_test.dart             [novo]   CA-2
│   ├── encryption_at_rest_test.dart           [novo]   CA-3
│   ├── schema_v1_test.dart                    [novo]   CA-5
│   ├── schema_snapshot_test.dart              [novo]   golden do sqlite_master
│   └── niche_seed_test.dart                   [novo]   CA-5
└── app/
    ├── providers_test.dart                    [novo]
    ├── logging_test.dart                      [novo]
    ├── bootstrap_gate_test.dart               [novo]
    ├── router_test.dart                       [novo]
    └── theme_test.dart                        [novo]

test/fixtures/schema_v1.sql                    [novo]   golden do schema
```

Nenhum diretório `data/` ou `domain/` de feature recebe **arquivo** neste ADR: não há
regra de negócio nem repositório ainda. As pastas são criadas vazias na T-06 e passam a
ter conteúdo no ADR-2.

Consequência assumida: o teste de camadas (V-05) varre um conjunto vazio enquanto o
ADR-1 durar, e **por isso a T-06 exige demonstrá-lo com uma violação injetada** — sem
essa demonstração, um teste que sempre passa por não ter o que reprovar seria
indistinguível de um teste quebrado. A trava existe antes do código que ela vigia,
o que é o ponto.

## 4. Modelo de dados

Implementa **integralmente** a seção 5.3 do guarda-chuva. **Diff: nenhum.** As 10
tabelas e os 4 índices parciais são criados na migração 1; nenhuma coluna é adicionada,
removida ou renomeada.

> A seção 5.3 do guarda-chuva foi **emendada em 2026-09-05** para incluir
> `description_norm`, `app_usage_days` e `error_log` — três coisas que requisitos já
> aprovados (RF-14, RF-30, métricas M1 e M5) exigiam e que o schema não guardava. A
> emenda aconteceu lá, não aqui: o ADR continua sem diff próprio contra o guarda-chuva,
> que segue sendo a fonte única do modelo de dados.

Mapeamento Drift (`lib/core/database/tables/`):

| Tabela SQL | Classe Drift | Observação |
|---|---|---|
| `niches` | `Niches` | `id` textual semântico (`'casa'`), não UUID |
| `transactions` | `Transactions` | `CHECK (amount_cents > 0)` via `customConstraints`; `description_norm` para o RF-14 |
| `income_sources` | `IncomeSources` | |
| `investments` | `Investments` | |
| `investment_balances` | `InvestmentBalances` | |
| `debts` | `Debts` | |
| `debt_installments` | `DebtInstallments` | `UNIQUE (debt_id, number)` |
| `app_settings` | `AppSettings` | chave-valor textual |
| `app_usage_days` | `AppUsageDays` | métrica M1; `day` é a PK, o que torna a contagem idempotente |
| `error_log` | `ErrorLog` | métrica M5; sem coluna para valor, descrição ou credor, por construção |

Convenções, fixadas aqui e válidas para todos os ADRs seguintes:

- Dinheiro é `IntColumn` em centavos. **Nunca** `RealColumn`.
- Data é `TextColumn` no formato `YYYY-MM-DD`, hora local. **Nunca** `DateTimeColumn` —
  Drift persistiria como timestamp e reintroduziria fuso onde não existe fuso.
- `id` é `TextColumn` com UUID v4, exceto `niches`.
- `deleted_at` nulo significa vivo. Todo índice é parcial com `WHERE deleted_at IS NULL`.

```dart
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get kind => text()();
  IntColumn  get amountCents => integer().named('amount_cents')();
  TextColumn get occurredOn => text().named('occurred_on')();
  TextColumn get description => text().nullable()();
  // ... demais colunas conforme 5.3
  TextColumn get deletedAt => text().named('deleted_at').nullable()();

  @override Set<Column> get primaryKey => {id};
  @override List<String> get customConstraints => ['CHECK (amount_cents > 0)'];
}
```

Os índices parciais não têm equivalente declarativo em Drift e são criados por SQL
literal no `onCreate`, exatamente como escritos na seção 5.3.

**Estratégia de migração** (`MigrationStrategy`):

- `onCreate`: cria tudo e roda o seed dos nichos, **na mesma transação**. Um banco meio
  criado não pode sobreviver a um erro no meio.
- `onUpgrade`: lança `UnsupportedError` — não existe v2 ainda, e um `onUpgrade` vazio
  que aceita qualquer versão é uma armadilha esperando o ADR-2.
- `beforeOpen`: liga `PRAGMA foreign_keys = ON` (SQLite deixa desligado por padrão, e
  todas as invariantes da 5.3 dependem disso).

## 5. Contratos

### 5.1 `DatabaseKey` — `core/security/database_key.dart`

```dart
/// Chave de 256 bits do SQLCipher. Existe para que a chave nunca vire String solta.
final class DatabaseKey {
  /// Lança [ArgumentError] se [bytes] não tiver exatamente 32 posições.
  factory DatabaseKey.fromBytes(Uint8List bytes);

  /// Lança [FormatException] se não for hex de 64 caracteres.
  factory DatabaseKey.fromHex(String hex);

  /// Gera 32 bytes com [Random.secure] (CSPRNG do sistema).
  factory DatabaseKey.generate();

  /// Forma aceita pelo SQLCipher como raw key: `x'a1b2...'` (64 hex).
  String get pragmaLiteral;

  String toHex();

  /// SEMPRE 'DatabaseKey(<redigida>)'. Nunca o material.
  @override String toString();
}
```

**Invariante:** nenhum caminho de código expõe o material da chave a não ser
`pragmaLiteral` e `toHex()`, e `toHex()` só é chamado pelo `DatabaseKeyStore` ao
persistir. O `grep` de CI (RNF-16) reprova qualquer `toHex()` fora desses dois lugares.

### 5.2 `DatabaseKeyStore` — `core/security/database_key_store.dart`

```dart
abstract interface class DatabaseKeyStore {
  /// Devolve a chave existente ou gera e persiste uma na primeira chamada.
  /// Chamadas seguintes devolvem sempre a mesma chave.
  Future<Result<DatabaseKey, KeyStoreFailure>> getOrCreate();

  /// Apaga o material do Keystore. Primitiva para o RF-29 (M5).
  /// Depois disso, [getOrCreate] gera uma chave nova — e o banco antigo fica ilegível.
  Future<Result<void, KeyStoreFailure>> destroy();
}

sealed class KeyStoreFailure {}
final class KeystoreUnavailable extends KeyStoreFailure {}   // hardware/SO recusou
final class KeyCorrupted extends KeyStoreFailure {}          // valor lido não é hex de 64
```

`KeystoreDatabaseKeyStore` implementa com `flutter_secure_storage`, chave
`jotta.db.key`, `AndroidOptions(encryptedSharedPreferences: true)`.

**`getOrCreate` não é atômico entre processos** e não precisa ser: o app tem um único
processo e a chamada acontece uma vez, no bootstrap, antes de qualquer UI.

### 5.3 `openEncryptedDatabase` — `core/database/open_encrypted_database.dart`

```dart
typedef DatabaseOpener = Database Function(String path);

/// Abre [file] cifrado com [key] e prova que o SQLCipher está de fato ativo.
///
/// Ordem obrigatória: PRAGMA key ANTES de qualquer outra instrução. Um SELECT
/// antes do key faz o SQLCipher marcar o banco como não-cifrado nesta conexão.
///
/// [open] é um ponto de injeção para teste — por padrão é `sqlite3.open`, que usa
/// o binário resolvido pelo hook (§5.4). Um teste pode passar um `Database`
/// falso para provar o [SqlCipherUnavailable] sem depender de um binário diferente
/// existir em tempo de execução.
///
/// Lança [SqlCipherUnavailable] se `PRAGMA cipher_version` vier vazio — o caso em
/// que a lib carregada é SQLite puro, o PRAGMA key foi ignorado e o banco estaria
/// em claro sem nenhum erro visível.
/// Lança [DatabaseLocked] se a chave não abrir o arquivo.
Database openEncryptedDatabase({
  required File file,
  required DatabaseKey key,
  DatabaseOpener? open, // null usa sqlite3.open — tear-off não é const em Dart
});
```

Sequência no `setup` do `NativeDatabase`:

1. `PRAGMA key = x'...';`
2. `PRAGMA cipher_version;` → vazio ⇒ `SqlCipherUnavailable`
3. `SELECT count(*) FROM sqlite_master;` → falha ⇒ `DatabaseLocked`

O passo 3 é o que transforma "chave errada" em erro imediato no bootstrap, em vez de
uma exceção obscura na primeira query da Home.

### 5.4 Resolução do binário SQLCipher — `pubspec.yaml`, sem código

**Não existe `sqlcipherLoader`.** A versão original desta seção descrevia um
`open.overrideFor` manual, escolhendo `sqlcipher_flutter_libs` no Android e
`libsqlcipher.so` do sistema no Linux — dois binários diferentes, o que era
precisamente o risco A2 do PRD. `sqlcipher_flutter_libs` está **EOL**
(`docs/DECISIONS.md`), e o `sqlite3` 3.x resolve o binário nativo sozinho, em
qualquer plataforma, via *native asset hooks* — declarativo, sem `DynamicLibrary`:

```yaml
hooks:
  user_defines:
    sqlite3:
      source: sqlcipher
```

Com isso, `sqlite3.open(path)` já abre contra SQLCipher em Android, em Linux (testes
e CI) e em qualquer outra plataforma que rodar o hook — **o mesmo arquivo binário**,
baixado dos releases assinados do pacote `sqlite3.dart` e verificado por sha256 (e,
na versão travada, por atestação SLSA3). Não há mais dois lugares para divergir.

Consequência para o teste do CA-2/CA-3: `PRAGMA cipher_version` continua sendo a
prova de que a cifra está ativa, mas agora não distingue mais "plataforma de teste"
de "plataforma de produção" — é a mesma pergunta, no mesmo binário, nos dois casos.

### 5.5 `AppDatabase` — `core/database/app_database.dart`

```dart
@DriftDatabase(tables: [Niches, Transactions, IncomeSources, Investments,
                        InvestmentBalances, Debts, DebtInstallments, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override int get schemaVersion => 1;
  @override MigrationStrategy get migration; // conforme seção 4
}
```

Nenhum DAO é declarado neste ADR.

### 5.6 Seed — `core/database/seed/niche_seed.dart`

```dart
/// As 7 linhas de `niches`. Fixas no MVP: o usuário não cria nem remove nichos.
const List<NichesCompanion> kNicheSeed = [...];
```

| id | nome | icon | color | kind | sort_order |
|---|---|---|---|---|---|
| `casa` | Casa | `home` | `0xFFE07A1F` âmbar | `expense` | 1 |
| `transporte` | Transporte | `directions_car` | `0xFF1E6FD9` azul | `expense` | 2 |
| `alimentacao` | Alimentação | `restaurant` | `0xFF2E8B4A` verde | `expense` | 3 |
| `saude` | Saúde | `medical_services` | `0xFFD32F4B` vermelho | `expense` | 4 |
| `lazer` | Lazer | `movie` | `0xFF7B4DBF` roxo | `expense` | 5 |
| `investimentos` | Investimentos | `trending_up` | `0xFF0F8C8C` teal | `investment` | 6 |
| `dividas` | Dívidas | `credit_card` | `0xFF5A6472` ardósia | `debt` | 7 |

As sete cores foram escolhidas para serem distinguíveis entre si na distribuição da Home
e manterem contraste AA sobre as superfícies clara e escura do Material 3. Elas são
**dados**, não código: trocar uma é editar o seed, e no banco já existente é um `UPDATE`.

O `icon` é resolvido por um `const Map<String, IconData>` na camada de apresentação — o
mapa é obrigatório, não conveniência: construir `IconData` a partir da string em tempo de
execução desliga o tree-shaking de ícones do Flutter e infla o APK contra o RNF-5.

O seed é idempotente (`InsertMode.insertOrIgnore`), para que uma futura migração possa
reexecutá-lo sem duplicar.

### 5.7 `Result` — `core/result/result.dart`

```dart
sealed class Result<T, F> {
  R fold<R>({required R Function(T) ok, required R Function(F) err});
}
final class Ok<T, F> extends Result<T, F> { const Ok(this.value); final T value; }
final class Err<T, F> extends Result<T, F> { const Err(this.failure); final F failure; }
```

Deliberadamente mínimo. Falha esperada (Keystore indisponível, chave corrompida) é
`Result`; bug de programação continua sendo exceção.

### 5.8 Localização do banco — `core/database/database_location.dart`

```dart
/// Caminho de `jotta.db`, sempre no diretório privado do app.
///
/// Usa `getApplicationDocumentsDirectory()` do `path_provider` — em Android isso é
/// o sandbox do app, que só o próprio app e o root leem. Nunca
/// `getExternalStorageDirectory()`: a cifra protege o conteúdo do arquivo, mas não
/// impede que ele seja copiado, e cópia de arquivo cifrado é material para ataque
/// offline com tempo ilimitado.
Future<File> resolveDatabaseFile();
```

A dependência `path_provider` entra no `pubspec.yaml` com versão exata e faz parte da
lista sensível verificada por V-04 — ela decide **onde** o dado cifrado repousa.

### 5.9 Logging — `app/logging.dart`

```dart
/// Instala o comportamento de log do processo. Chamada uma vez, no início de main().
///
/// Em release, substitui `debugPrint` por uma função vazia: nenhum log do app chega
/// ao logcat, nem por engano, nem por dependência que use debugPrint (SEG-6).
void installLogging({required bool isRelease});
```

O parâmetro `isRelease` existe por testabilidade: `kReleaseMode` é `const` e não pode
ser alternado dentro da suíte. `main()` passa `kReleaseMode`; o teste passa os dois
valores (V-44).

## 6. Estado e fluxo

Providers (Riverpod 2 com `@riverpod`), em `core/database/providers.dart`:

```dart
@Riverpod(keepAlive: true) DatabaseKeyStore databaseKeyStore(Ref ref);
@Riverpod(keepAlive: true) Future<AppDatabase> appDatabase(Ref ref);
```

Bootstrap:

```
main()
  └─ ProviderScope
       └─ JottaApp
            └─ BootstrapGate  ── observa appDatabaseProvider
                 ├─ loading → splash (sem texto: não pisca "carregando" em 200 ms)
                 ├─ error   → BootstrapFailureScreen
                 └─ data    → MaterialApp.router (casca navegável)
```

`appDatabase` orquestra: `getOrCreate()` → `openEncryptedDatabase` → `AppDatabase`. É
`keepAlive` porque o banco vive enquanto o app viver; nenhum `autoDispose` fecha conexão
por trás da UI.

**`BootstrapFailureScreen`** existe porque as falhas aqui são reais e não recuperáveis
em tela: Keystore indisponível, chave corrompida, `SqlCipherUnavailable`. Ela mostra o
tipo do erro e nada mais — **nunca a chave, nunca o caminho completo do banco**. Sem
essa tela, o modo de falha é tela branca.

`BootstrapFailureScreen` não oferece "tentar de novo" nem "apagar e recomeçar": as duas
ações são destrutivas ou inúteis, e a segunda é o RF-29, do M5.

Navegação (`app/router.dart`): `StatefulShellRoute.indexedStack` com `/`, `/nichos`,
`/renda`, `/ajustes`. Cada aba mantém sua própria pilha. O FAB vive no shell, não nas
telas — ele é persistente por requisito (seção 3.1 do guarda-chuva) e neste ADR não
abre nada.

Tema (`app/theme/app_theme.dart`): `ColorScheme.fromSeed` com semente fixa, substituída
pelo `dynamicColorScheme` quando o aparelho oferece (`dynamic_color`), claro e escuro,
`useMaterial3: true`.

## 7. Segurança da fatia

| Controle | O que esta fatia faz | Onde |
|---|---|---|
| **SEG-1** | Banco cifrado AES-256; chave de 32B CSPRNG no Keystore com `EncryptedSharedPreferences`; raw key hex, sem KDF redundante | 5.1–5.4 |
| **SEG-4** | `allowBackup="false"`, `dataExtractionRules` negando `cloud-backup` e `device-transfer`, `fullBackupContent` vazio para API < 31 | manifest + `res/xml/` |
| **SEG-5** | Zero `<uses-permission>`. Nenhuma dependência com I/O de rede | manifest + `pubspec.yaml` |
| **SEG-6** (parcial) | `debugPrint` no-op em release; `grep` de CI contra log de valor monetário. R8 e `debuggable` ficam no M6 | `main.dart`, `tool/ci/check_logs.sh` |
| **SEG-8** (parcial) | Chave nasce aqui; `destroy()` existe como primitiva. O RF-29 que a usa é do M5 | 5.2 |
| **RNF-16** | `DatabaseKey.toString()` redigido + `grep` de CI por `toHex()` fora dos dois pontos autorizados | 5.1 |

**Emenda de 2026-09-05, na implementação:** o texto original desta seção dizia que
não havia como testar `setUserAuthenticationRequired(false)`, porque a `AndroidOptions`
da dependência não expunha a flag. Isso valia para a API assumida ao escrever a SPEC;
a versão travada de fato (`flutter_secure_storage` 11.0.0) **redesenhou** essa API:

- O parâmetro `encryptedSharedPreferences` não existe mais — o construtor padrão de
  `AndroidOptions` já faz o equivalente (AES-GCM com chave embrulhada no Keystore) sem
  opt-in nenhum. V-12 mudou de alvo por isso.
- No lugar, `enforceBiometrics` (default `false`) é **documentado pela própria
  dependência** como controlando exatamente isso: `false` gera a chave com
  `setUserAuthenticationRequired(false)`; `true` gera com `true`. E `AndroidOptions`
  ganhou um `toMap()` **público**, que expõe o valor como string.

Resultado: o que a versão anterior chamava de "limitação conhecida, sem teste possível"
passou a ser diretamente verificável. `FlutterSecureKeyValueStore.androidOptions` é uma
constante pública com `enforceBiometrics: false` explícito (não só herdado do default),
e V-12 lê `toMap()['enforceBiometrics']` e exige `'false'`. Se uma versão futura da
dependência mudar esse default, ou se alguém mudar nosso valor por engano, o teste pega.

## 8. Estratégia de testes

Toda linha desta tabela vira a validação de pelo menos uma task no `TASK.md`.

| # | O que prova | Tipo | Arquivo |
|---|---|---|---|
| V-01 | `applicationId` é `com.jotta.financial` e `minSdk` é 26 | config | `test/config/android_config_test.dart` |
| V-02 | Manifest-fonte sem `<uses-permission>`, com `allowBackup="false"` e `dataExtractionRules` | config | `test/config/manifest_source_test.dart` |
| V-03 | `data_extraction_rules.xml` nega `cloud-backup` e `device-transfer` | config | `test/config/manifest_source_test.dart` |
| V-04 | Dependências de cripto e banco com versão exata, sem `^` nem `any` | config | `test/config/pubspec_pinning_test.dart` |
| V-05 | Nenhum arquivo em `features/*/domain/` importa Flutter ou Drift | arquitetura | `test/architecture/layering_test.dart` |
| V-06 | `DatabaseKey.generate()` produz 32 bytes, hex válido, e duas gerações diferem | unidade | `test/core/security/database_key_test.dart` |
| V-07 | `toString()` da chave não contém o material | unidade | `test/core/security/database_key_test.dart` |
| V-08 | `fromBytes` rejeita tamanho ≠ 32; `fromHex` rejeita não-hex | unidade | `test/core/security/database_key_test.dart` |
| V-09 | `getOrCreate` gera na 1ª chamada e devolve a mesma na 2ª | unidade | `test/core/security/keystore_database_key_store_test.dart` |
| V-10 | Valor corrompido no storage vira `KeyCorrupted`, não crash | unidade | `test/core/security/keystore_database_key_store_test.dart` |
| V-11 | `destroy()` apaga; o `getOrCreate` seguinte gera chave diferente | unidade | `test/core/security/keystore_database_key_store_test.dart` |
| V-12 | `AndroidOptions.encryptedSharedPreferences` está ligado | unidade | `test/core/security/keystore_database_key_store_test.dart` |
| V-13 | **`PRAGMA cipher_version` não é vazio** — SQLCipher realmente ativo (CA-2) | integração | `test/core/database/sqlcipher_active_test.dart` |
| V-14 | Biblioteca sem SQLCipher produz `SqlCipherUnavailable`, não sucesso silencioso | integração | `test/core/database/sqlcipher_active_test.dart` |
| V-15 | Escreve, fecha, reabre com a chave certa e lê de volta | integração | `test/core/database/encryption_at_rest_test.dart` |
| V-16 | Reabrir **sem** chave falha (CA-3) | integração | `test/core/database/encryption_at_rest_test.dart` |
| V-17 | Reabrir com chave **errada** falha (CA-3) | integração | `test/core/database/encryption_at_rest_test.dart` |
| V-18 | Descrição-marcador gravada **não** aparece nos bytes do arquivo (CA-3) | integração | `test/core/database/encryption_at_rest_test.dart` |
| V-19 | Banco novo tem as 10 tabelas e `schemaVersion == 1` | integração | `test/core/database/schema_v1_test.dart` |
| V-20 | `CHECK (amount_cents > 0)` rejeita 0 e negativo | integração | `test/core/database/schema_v1_test.dart` |
| V-21 | `UNIQUE (debt_id, number)` rejeita parcela duplicada | integração | `test/core/database/schema_v1_test.dart` |
| V-22 | Os 4 índices existem e são parciais (`WHERE deleted_at IS NULL`) | integração | `test/core/database/schema_v1_test.dart` |
| V-23 | `PRAGMA foreign_keys` está ON após `beforeOpen` | integração | `test/core/database/schema_v1_test.dart` |
| V-24 | `onUpgrade` de v1 para v2 lança em vez de aceitar em silêncio | integração | `test/core/database/schema_v1_test.dart` |
| V-25 | `sqlite_master` bate com o golden `test/fixtures/schema_v1.sql` | golden | `test/core/database/schema_snapshot_test.dart` |
| V-26 | 7 nichos semeados, ids e `sort_order` 1..7 corretos | integração | `test/core/database/niche_seed_test.dart` |
| V-27 | 5 nichos `expense`, 1 `investment`, 1 `debt` | integração | `test/core/database/niche_seed_test.dart` |
| V-28 | Seed rodado duas vezes não duplica | integração | `test/core/database/niche_seed_test.dart` |
| V-29 | `appDatabaseProvider` em erro renderiza a tela de falha, não a Home | widget | `test/app/bootstrap_gate_test.dart` |
| V-30 | A tela de falha não exibe a chave nem o caminho do banco | widget | `test/app/bootstrap_gate_test.dart` |
| V-31 | Tema M3 ativo, claro e escuro, com fallback quando não há cor dinâmica | widget | `test/app/theme_test.dart` |
| V-32 | As 4 rotas resolvem e cada aba mostra seu estado vazio | widget | `test/app/router_test.dart` |
| V-33 | O FAB está presente nas 4 abas e a troca de aba preserva a pilha | widget | `test/app/router_test.dart` |
| V-34 | Alvos de toque das abas e do FAB ≥ 48dp | widget | `test/app/router_test.dart` |
| V-35 | CI reprova APK com `INTERNET` (fixture negativa) | script CI | `tool/ci/check_manifest.sh` |
| V-36 | CI reprova APK com `allowBackup="true"` (fixture negativa) | script CI | `tool/ci/check_manifest.sh` |
| V-37 | CI reprova permissão fora do baseline versionado | script CI | `tool/ci/check_manifest.sh` |
| V-38 | CI reprova log de valor monetário fora de bloco de debug | script CI | `tool/ci/check_logs.sh` |
| V-39 | CI reprova `toHex()` da chave fora dos dois pontos autorizados | script CI | `tool/ci/check_logs.sh` |
| V-40 | `Result.fold` chama o ramo certo em `Ok` e em `Err` | unidade | `test/core/result/result_test.dart` |
| V-41 | `flutter analyze` e `dart format --set-exit-if-changed` passam limpos | comando | `.github/workflows/ci.yml` |
| V-42 | `appDatabaseProvider` pede a chave ao store e abre o banco com ela | unidade | `test/app/providers_test.dart` |
| V-43 | O caminho do banco cai no diretório privado do app e termina em `jotta.db` | unidade | `test/core/database/database_location_test.dart` |
| V-44 | `debugPrint` é no-op quando `isRelease` é true, e emite quando é false | unidade | `test/app/logging_test.dart` |
| V-45 | "Açúcar" normaliza para "acucar"; descrição nula produz `description_norm` nula | integração | `test/core/database/normalize_test.dart` |
| V-46 | `idx_tx_search` existe, é parcial, e `LIKE '%acucar%'` encontra "Açúcar" | integração | `test/core/database/schema_v1_test.dart` |
| V-47 | `app_usage_days` não duplica o mesmo dia e aceita dias distintos | integração | `test/core/database/schema_v1_test.dart` |
| V-48 | `error_log` tem exatamente 5 colunas — falha se surgir coluna de valor, descrição ou credor | integração | `test/core/database/schema_v1_test.dart` |

Cobertura mínima da seção 5.8 do guarda-chuva (90% domínio / 80% integração) **não se
aplica a este ADR**: não há camada de domínio ainda. A trava de cobertura entra no
ADR-2, junto com o primeiro código de regra de negócio.

## 9. Fora do escopo técnico

O que alguém razoável esperaria encontrar aqui e não vai:

- **Nenhum DAO, nenhum repositório, nenhuma query.** O schema existe; ninguém o lê.
- **`Money` e `Period`.** Nascem no ADR-2 e no ADR-3, com os testes de fronteira que a
  seção 5.4 do guarda-chuva exige.
- **Build de release, assinatura, R8, ofuscação** — e portanto a trava RNF-14 #3.
- **`local_auth`, `cryptography`, Argon2id.** Não entram nem no `pubspec.yaml`: uma
  dependência que ninguém usa é superfície de ataque de graça (seção 6.6).
- **`integration_test` em aparelho.** As 5 jornadas e2e da seção 5.8 são do M6.
- **Benchmark do RNF-11.** Sem query agregada e sem 10.000 transações, não há o que medir.

## 10. Rastreabilidade

| Requisito (PRD do ADR §4) | Onde é implementado | Testes que provam |
|---|---|---|
| SEG-1 | `database_key.dart`, `keystore_database_key_store.dart`, `open_encrypted_database.dart`, `pubspec.yaml` (hook `sqlite3`), `database_location.dart` | V-06 a V-18, V-43 |
| SEG-4 | `AndroidManifest.xml`, `res/xml/data_extraction_rules.xml`, `backup_rules.xml` | V-02, V-03, V-36 |
| SEG-5 | `AndroidManifest.xml`, `pubspec.yaml` | V-02, V-35, V-37 |
| SEG-6 (parcial) | `app/logging.dart`, `tool/ci/check_logs.sh`, schema do `error_log` | V-44, V-38, V-48 |
| SEG-8 (parcial) | `DatabaseKeyStore.destroy()` | V-11 |
| RNF-1 | `android/app/build.gradle.kts` | V-01 |
| RNF-6 | `AndroidManifest.xml` | V-02, V-35, V-37 |
| RNF-14 (parcial) | `tool/ci/check_manifest.sh`, `tool/ci/check_logs.sh` | V-35, V-36, V-37, V-38 |
| RNF-16 | `DatabaseKey.toString()`, `tool/ci/check_logs.sh` | V-07, V-39 |
| RNF-9 (parcial) | `MigrationStrategy` | V-24 |
| RF-14 (parcial) | `description_norm`, `normalize.dart`, `idx_tx_search` — a tela de busca é do ADR-2 | V-45, V-46 |
| RF-30 (parcial) | `app_usage_days`, `error_log` — a tela "Meu uso" é do M5 | V-47, V-48 |
| CA-1 | shell, rotas, telas vazias | V-32, V-33, V-34 — **e o checklist manual** (`TASK.md`, pronto item 5): instalar o APK em aparelho não é coisa que teste de widget prove |
| CA-2 | `open_encrypted_database.dart` | V-13, V-14 |
| CA-3 | `open_encrypted_database.dart` | V-16, V-17, V-18 |
| CA-4 | `keystore_database_key_store.dart` | V-09, V-12, V-07 |
| CA-5 | migração 1 + seed | V-19 a V-28, V-45 a V-48 |
| CA-6 | manifest + `res/xml/` | V-35, V-36 |
| CA-7 | workflow + scripts | V-35 a V-39 |
| CA-8 | `test/architecture/layering_test.dart` | V-05 |

**Cobertura: 12 requisitos rastreados, 12 com teste nomeado. 8 critérios de aceite,
8 rastreados** — sendo que metade do CA-1 é prova humana, não automatizada.

A seção 4 do PRD lista **11** requisitos. O 11º é o RNF-11, marcado ali como **Fora**
(fica no ADR-3) e por isso ausente desta tabela — ausência deliberada, não esquecimento.

➡️ **TASK liberada.**
