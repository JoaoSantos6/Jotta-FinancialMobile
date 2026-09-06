# Registro de Decisões — Jotta FinancialMobile

Decisões tomadas via skill `grillme`. Nada aqui é suposição: cada linha foi
perguntada e respondida. Alterar uma linha significa reabrir o PRD.

| Data | Decisão | Alternativa descartada | Quem decidiu |
|---|---|---|---|
| 2026-09-05 | 7 nichos de gasto: Casa, Transporte, Alimentação, Saúde, Lazer, Investimentos, Dívidas | Nichos 100% customizáveis pelo usuário (adiado p/ v2) | Usuário |
| 2026-09-05 | Renda é uma **tela separada**, fora dos nichos, com fontes recorrentes e avulsas | Renda como aba da Home; renda dentro de cada nicho | Usuário |
| 2026-09-05 | Entrada de lançamentos **100% manual** no MVP | Import CSV/OFX; leitura de notificação bancária; Open Finance (Pluggy/Belvo) | Usuário |
| 2026-09-05 | Stack **Flutter** (Dart) | Kotlin + Compose (nativo); React Native | Usuário |
| 2026-09-05 | Dados **only-device, offline-first** (SQLite). Sem backend, sem login, sem conta | Backup automático no Drive; backend próprio com sync | Usuário |
| 2026-09-05 | Persistência: **Drift** sobre SQLite (Room não existe em Flutter — equivalente idiomático) | sqflite puro; Isar; Hive | Claude (consequência técnica direta da escolha de Flutter) |
| 2026-09-05 | Períodos: **mês do calendário** (dia 1) e **semana seg→dom** | Ciclo do salário configurável; ciclo da fatura do cartão | Usuário |
| 2026-09-05 | **Sem orçamento/teto por nicho no MVP.** Só registro e visualização | Teto mensal com barra de progresso; teto + notificação 80%/100% | Usuário |
| 2026-09-05 | Investimentos: saldo manual + aportes/resgates. Dívidas: parcelas geradas automaticamente | Tratar como gasto comum; cotação automática via API de mercado | Usuário |
| 2026-09-05 | Moeda única **BRL**, sem multimoeda e sem câmbio | Multimoeda | Claude (consequência do escopo pessoal + offline) |
| 2026-09-05 | Sem telemetria/analytics remota. Zero rede no MVP | Firebase Analytics / Crashlytics | Claude (consequência direta de "só no celular") |
| 2026-09-05 | **Banco cifrado em repouso com SQLCipher**, chave de 32B gerada por CSPRNG e guardada no Android Keystore com respaldo em hardware | SQLite em texto plano confiando só no sandbox; chave derivada de senha digitada a cada abertura | Usuário |
| 2026-09-05 | **Bloqueio do app com biometria/PIN do aparelho, ligado por padrão** e desligável em Ajustes; re-bloqueio após 60s em segundo plano | Desligado por padrão; sem bloqueio nenhum | Usuário |
| 2026-09-05 | **Backup exportado sempre criptografado**, com senha obrigatória (AES-256-GCM + Argon2id) | Senha opcional com aviso; arquivo em texto plano | Usuário |
| 2026-09-05 | **Auto Backup do Android desativado** (`allowBackup=false` + regras de extração negando cloud e device-transfer) | Manter ligado com banco cifrado; manter o padrão do Android | Usuário |
| 2026-09-05 | Chave do banco **não** amarrada à biometria (`setUserAuthenticationRequired(false)`); a biometria é portão de UI, não de dado | Amarrar a chave à autenticação do usuário | Claude (amarrar quebraria abertura sem digital cadastrada e geração de recorrências) |
| 2026-09-05 | `FLAG_SECURE` (bloquear screenshot / ocultar em recentes) **fora do MVP** — foi oferecido junto com o bloqueio e não foi selecionado | Incluir no MVP | Usuário (por não-seleção — **reconfirmar antes de M5**) |
| 2026-09-05 | Subagent `judge` isolado (só `Read`/`Grep`, apenas os caminhos passados) entregando laudo no chat; definição do agente cabe em 20 linhas | Agente com acesso ao projeto inteiro; laudo gravado em `docs/reviews/`; flag `--save` | Usuário |
| 2026-09-05 | Toda solução ganha `docs/adr-N/` com **PRD.md, SPEC.md e TASK.md**, nessa ordem obrigatória de dependência | Documento único por solução; spec direto no código; tasks derivadas de conversa | Usuário |
| 2026-09-05 | **Um ADR = um marco do roadmap** (adr-1=M0 … adr-7=M6) | Um ADR por tela/feature; um ADR por decisão de arquitetura clássica | Usuário |
| 2026-09-05 | `docs/PRD-MVP.md` permanece como **guarda-chuva** fora dos ADRs; cada `adr-N/PRD.md` recorta e referencia, não repete | Virar `adr-0/PRD.md`; ser fatiado e deixar de existir | Usuário |
| 2026-09-05 | Task = **um commit, um teste**. Nenhuma task fecha sem validação automatizada que falhe antes e passe depois | Task de meio dia a um dia; fatia vertical fim-a-fim validada por e2e | Usuário |
| 2026-09-05 | Skills `to-prd`, `to-spec` e `to-task` **travam a cadeia**: `to-spec` para se faltar o PRD, `to-task` para se faltar a SPEC | Skill única gerando os três; travas por convenção, sem verificação | Usuário |
| 2026-09-05 | Pasta nomeada `adr-N` sem slug (`docs/adr-1/`), numeração sequencial nunca reciclada | `adr-001-setup-seguro` com slug descritivo | Claude (segue literalmente o formato pedido; slug duplicaria o título do PRD) |
| 2026-09-05 | `applicationId` = **`com.jotta.financial`**, nome de exibição "Jotta" | `br.com.joaosantos.jotta`; `com.jottafinancial.app` | Usuário |
| 2026-09-05 | Prova do SEG-1 roda **no desktop, na CI** (teste que checa `cipher_version` e tenta abrir sem a chave); verificação em aparelho vira checklist manual de fim de marco | Emulador Android na CI desde o M0; emulador só no merge/nightly | Usuário |
| 2026-09-05 | M0 entrega **casca navegável** com bottom nav, FAB central, tema M3 e 4 telas em estado vazio | Só infraestrutura com uma tela provisória; casca + onboarding de segurança antecipado do M5 | Usuário |
| 2026-09-05 | Chave do SQLCipher passada como **raw key hex** (`PRAGMA key = x'…'`), sem KDF por cima | Passar a chave como texto e deixar o SQLCipher rodar PBKDF2 | Claude (a chave já tem 256 bits de CSPRNG; derivar de novo só custa tempo de abertura) |
| 2026-09-05 | Schema **v1 completo** (10 tabelas após a auditoria) na migração 1, no ADR-1; DAOs ficam nos ADRs que os consomem | Criar cada tabela no ADR que a usa | Claude (fatiar geraria 6 migrações para chegar ao mesmo lugar, cada uma com risco de perda de dados) |
| 2026-09-05 | Travas de manifest na CI leem o **APK construído** (`aapt2 dump`), não o XML-fonte | `grep` no `AndroidManifest.xml` do repositório | Claude (o fonte não enxerga o que o merge de dependências acrescentou) |
| 2026-09-05 | Banco em `getApplicationDocumentsDirectory()` (diretório privado do app), via `path_provider` | Armazenamento externo/compartilhado | Claude (a cifra protege o conteúdo, não impede a cópia; arquivo cifrado copiado vira ataque offline com tempo ilimitado) |
| 2026-09-05 | Na CI, `libsqlcipher` é instalado **antes** do job da suíte completa, e o build do APK vem **antes** das travas de manifest | Ordem original da seção 5.9 (travas antes do build) | Claude (correção de achado do `/judge`: manifest merged só existe depois do APK; e a suíte sem a lib reprovaria) |
| 2026-09-05 | `debugPrint` no-op recebe `installLogging({required bool isRelease})` em vez de ler `kReleaseMode` direto | Ler `kReleaseMode` na função | Claude (`kReleaseMode` é `const` e não alterna na suíte; sem a costura, metade do SEG-6 ficaria sem prova automatizada) |
| 2026-09-05 | `niches.icon` guarda **nome de ícone Material Symbols**, não emoji | Emoji literal na coluna; as duas coisas em colunas separadas | Usuário |
| 2026-09-05 | `niches.color` são **7 cores ARGB fixas** no seed (âmbar, azul, verde, vermelho, roxo, teal, ardósia) | Derivar da paleta tonal do Material You; usuário escolher os valores | Usuário |
| 2026-09-05 | O `onUpgrade` **continua lançando** em vez de migrar, e o schema v1 nasce completo | Escrever migração de verdade já no ADR-1; manter a recusa mas sem congelar o golden | Usuário |
| 2026-09-05 | Entram no schema v1: `description_norm` (RF-14), `app_usage_days` (métrica M1) e `error_log` (métrica M5) | Deixar para uma v2 | Usuário |
| 2026-09-05 | Medições da **métrica M3 não são persistidas** — mediana vale só para a sessão atual | Tabela própria para os tempos de lançamento | Usuário (por não-seleção — cabe em `app_settings` sem migração se mudar de ideia; **reconfirmar antes do M5**) |
| 2026-09-05 | Nome do ícone é mapeado para `IconData` por `const Map` na apresentação | Construir `IconData(codePoint)` a partir da string | Claude (`IconData` dinâmico desliga o tree-shaking de ícones do Flutter e infla o APK contra o RNF-5) |
| 2026-09-05 | SQLCipher via **hooks nativos do `sqlite3` 3.x** (`source: sqlcipher` no pubspec), não mais `sqlcipher_flutter_libs` | Manter a dependência antiga | Claude (`sqlcipher_flutter_libs` está **EOL** no pub.dev — "Not used anymore, update to version 3.x of package:sqlite3 instead". O hook baixa o **mesmo** binário SQLCipher community edition para Linux e Android, verificado por sha256 e, na versão travada 3.5.2, por atestação SLSA3 — elimina o risco A2 do ADR-1 por construção, em vez de mitigá-lo. Testado neste ambiente: `PRAGMA cipher_version` devolveu `4.18.0 community`) |
| 2026-09-06 | `appDatabaseProvider` declara `retry: _neverRetry` | Deixar o retry padrão do Riverpod 3 | Claude (Riverpod 3 tenta de novo com backoff por padrão quando um provider falha — descoberto ao testar o BootstrapGate: sem desligar, um erro de Keystore/chave ficava preso em `AsyncLoading(...retrying)` para sempre, em vez de virar `AsyncError` e mostrar a tela de falha. As falhas do bootstrap não são transitórias) |
| 2026-09-05 | `flutter_secure_storage` 11.0.0: `AndroidOptions(enforceBiometrics: false)` no lugar de `encryptedSharedPreferences: true` | Manter o parâmetro antigo (não existe mais na versão travada) | Claude (a v11 redesenhou a API: o construtor padrão já usa AES-GCM com chave no Keystore sem opt-in, e `enforceBiometrics` é a flag documentada que mapeia direto para `setUserAuthenticationRequired`. `AndroidOptions.toMap()` é pública desde essa versão — o que a SPEC original chamava de "sem teste possível" agora tem teste: V-12) |

## Em aberto (perguntar antes de implementar)

**Nada bloqueia o ADR-1.** AB-1 e AB-2, abertas pela auditoria do `/judge`, foram
fechadas no mesmo dia (linhas acima).

- Comportamento do app na virada de mês para lançamentos recorrentes: gerar automático ou sugerir?
- Ícone/identidade visual e nome público do app na Play Store.
- `FLAG_SECURE` deve subir para o MVP? (hoje fora, por não-seleção — reconfirmar antes de M5)
- Persistir as medições da métrica M3? (hoje fora, por não-seleção — a mediana só vale
  para a sessão atual, e M3 é critério de gate do MVP. Cabe em `app_settings` sem migração)
- A exportação em CSV em texto plano deve continuar existindo, ou o MVP fica com um único
  caminho de saída, sempre criptografado?

**Resolvido em 2026-09-05:** ~~Se o backup exportado deve ser criptografado com senha~~ →
sim, obrigatoriamente.
