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
| 2026-09-05 | Schema **v1 completo** (as 8 tabelas) na migração 1, no ADR-1; DAOs ficam nos ADRs que os consomem | Criar cada tabela no ADR que a usa | Claude (fatiar geraria 6 migrações para chegar ao mesmo lugar, cada uma com risco de perda de dados) |
| 2026-09-05 | Travas de manifest na CI leem o **APK construído** (`aapt2 dump`), não o XML-fonte | `grep` no `AndroidManifest.xml` do repositório | Claude (o fonte não enxerga o que o merge de dependências acrescentou) |

## Em aberto (perguntar antes de implementar)

- Comportamento do app na virada de mês para lançamentos recorrentes: gerar automático ou sugerir?
- Ícone/identidade visual e nome público do app na Play Store.
- `FLAG_SECURE` deve subir para o MVP? (hoje fora, por não-seleção — reconfirmar antes de M5)
- A exportação em CSV em texto plano deve continuar existindo, ou o MVP fica com um único
  caminho de saída, sempre criptografado?

**Resolvido em 2026-09-05:** ~~Se o backup exportado deve ser criptografado com senha~~ →
sim, obrigatoriamente.
