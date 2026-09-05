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

## Em aberto (perguntar antes de implementar)

- Comportamento do app na virada de mês para lançamentos recorrentes: gerar automático ou sugerir?
- Ícone/identidade visual e nome público do app na Play Store.
- `FLAG_SECURE` deve subir para o MVP? (hoje fora, por não-seleção — reconfirmar antes de M5)
- A exportação em CSV em texto plano deve continuar existindo, ou o MVP fica com um único
  caminho de saída, sempre criptografado?

**Resolvido em 2026-09-05:** ~~Se o backup exportado deve ser criptografado com senha~~ →
sim, obrigatoriamente.
