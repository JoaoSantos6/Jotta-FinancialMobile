# ADR-1 — Fundação segura do app

| Campo | Valor |
|---|---|
| ADR | 1 |
| Marco | **M0** do roadmap (seção 8 do [PRD guarda-chuva](../PRD-MVP.md)) |
| Versão | 1.0 |
| Data | 2026-09-05 |
| Status | **Em execução** — v1.1, aprovado após a auditoria de 2026-09-05; as 51 tasks de `TASK.md` foram implementadas em 2026-09-06, pendente apenas confirmação em CI real (Android SDK indisponível no ambiente de implementação) e o checklist manual em aparelho |
| Estimativa | 1,5 semana (um desenvolvedor) |
| Depende de | nada |

---

## 1. Contexto

**O que existe hoje no repositório:** três documentos (`PRD-MVP.md`, `DECISIONS.md`,
este) e as ferramentas de agente em `.claude/`. **Nenhuma linha de código.** Não há
projeto Flutter, não há `pubspec.yaml`, não há CI.

**O que existe quando este ADR terminar:** um app Android que instala, abre, mostra a
casca de navegação com as quatro abas e não faz absolutamente nada de financeiro — mas
com o banco já cifrado, a chave já no Keystore, o manifest já sem permissões e a CI já
reprovando quem tentar afrouxar qualquer um dos três.

É um marco de fundação. Ele não entrega valor ao usuário final e isso é deliberado.

## 2. Problema e valor

O PRD guarda-chuva decidiu que o banco é cifrado em repouso (SEG-1) e que o app não
tem superfície de rede (SEG-4, SEG-5). Essas decisões têm uma propriedade incômoda:
**custam pouco antes do primeiro `INSERT` e custam muito depois dele.**

- Ligar SQLCipher num banco que já tem dado real significa escrever uma migração que lê
  a base em claro e reescreve cifrada, com todo o risco de perda que isso carrega — em
  um app cujo dado é, por construção, irrecuperável (seção 6.4 do guarda-chuva).
- `allowBackup="false"` aplicado tarde não desfaz o que o Google Auto Backup já subiu
  para o Drive.
- Uma trava de CI criada no M5 não impede nada do que entrou entre o M1 e o M4.

O valor do ADR-1 é, portanto, **fechar as portas enquanto a casa está vazia**. O
segundo valor, menor mas real, é que o M1 começa com o esqueleto pronto: schema
migrado, injeção de dependência de pé, rotas e tema decididos.

## 3. Escopo

### Está dentro

- Projeto Flutter criado, `applicationId` definitivo, `minSdk` 26.
- Banco Drift **sobre SQLCipher**, com prova automatizada de que a cifra está ativa.
- Chave de 32 bytes gerada por CSPRNG e guardada no Android Keystore.
- **Schema v1 completo** — todas as tabelas da seção 5.3 do guarda-chuva, criadas na
  migração 1, incluindo o que a auditoria mostrou faltar: `description_norm` para a
  busca sem acento (RF-14), `app_usage_days` e `error_log` para as métricas M1 e M5.
  Os DAOs e as queries ficam para os ADRs que os consomem.
- Seed fixo dos 7 nichos.
- `AndroidManifest.xml` sem nenhuma permissão, com `allowBackup="false"` e regras de
  extração negando cloud e device-transfer.
- Riverpod 2 com code-gen, go_router, tema Material 3 com cor dinâmica.
- Casca navegável: bottom nav (Home · Nichos · Renda · Ajustes), FAB central
  persistente e quatro telas com estado vazio honesto.
- CI no GitHub Actions com as travas de segurança da RNF-14 que são verificáveis
  estaticamente, e a suíte de testes.

### Está fora

Esta é a lista mais importante da seção. Nada abaixo entra no ADR-1, mesmo parecendo
barato:

- **Qualquer lançamento financeiro.** Nenhum RF de produto é entregue aqui.
- Formulário, FAB funcional, listas, gráficos, cálculo de sobra. O FAB existe e não
  abre nada.
- `Money`, `Period` e demais tipos do `core` que só o M1/M2 consomem.
- Bloqueio biométrico (SEG-2, marco M5). A chave nasce com
  `setUserAuthenticationRequired(false)` desde já, então nada aqui precisa mudar depois.
- Backup, export, import, Argon2id (SEG-3, marco M5).
- Onboarding de primeira execução (seção 6.4 do guarda-chuva, marco M5).
- **Trava de CI de ofuscação/R8** (seção 5.9 do guarda-chuva, item 3). Não existe build de release nem
  configuração de assinatura antes do M6; a trava sobe junto com eles.
- Emulador Android no CI — ver seção 5, critério CA-3.

## 4. Requisitos cobertos

Referências ao [PRD guarda-chuva](../PRD-MVP.md). Nenhum requisito novo é criado aqui.

| Requisito | O que é | Cobertura |
|---|---|---|
| SEG-1 | Banco cifrado em repouso; chave no Keystore | **Total** |
| SEG-4 | Sem exfiltração pelo SO (`allowBackup`, regras de extração) | **Total** |
| SEG-5 | Sem superfície de rede (nenhuma permissão) | **Total** |
| SEG-6 | Higiene de log e build | **Parcial** — `debugPrint` no-op em release e o `grep` de CI entram agora; R8, `shrinkResources` e a checagem de `debuggable` vão para o M6 com o build de release |
| SEG-8 | Ciclo de vida da chave | **Parcial** — nascimento da chave e a primitiva de destruição entram agora; o "apagar todos os dados" (RF-29) é do M5 |
| RNF-1 | `minSdkVersion` 26 | **Total** |
| RNF-6 | Nenhuma permissão declarada | **Total** |
| RNF-14 | CI reprova manifest com `INTERNET` ou `allowBackup ≠ false` | **Parcial** — a lista numerada de travas está na seção **5.9** do guarda-chuva, não no texto do RNF-14 (seção 6.5), que tem três condições. Entram os itens 1, 2 e 4 da 5.9; o item 3 (ofuscação) é do M6 |
| RNF-16 | Chave nunca em log, backup ou preferências em claro | **Total** — inclui o `grep` de CI |
| RF-14 | Busca por descrição ignorando acento e caixa | **Parcial** — a coluna `description_norm`, a normalização e o índice entram agora; a tela de busca é do ADR-2 |
| RF-30 | Tela "Meu uso" com as métricas M1–M6 | **Parcial** — `app_usage_days` e `error_log` existem e ficam vazias; quem as preenche e a tela são do M5 |
| RNF-9 | Zero perda em atualização de versão | **Quase nada** — o que existe é um `onUpgrade` que se **recusa** a migrar (V-24). O backup interno automático antes de cada migração, que o SEG-7 exige e é o mecanismo que o RNF-9 nomeia, está inteiramente por fazer |
| RNF-11 | Overhead do SQLCipher < 15% | **Fora** — precisa da query agregada da Home (M2) e de 10.000 transações para medir. Fica no ADR-3 |

Nenhum **RF** (requisito funcional) é coberto por este ADR. Se isso incomoda, é o
sintoma certo: um marco de fundação que entregasse feature estaria fazendo duas coisas.

## 5. Critérios de aceite

**CA-1 — O app instala e navega.**
Dado um aparelho com Android 8.0 ou superior, quando eu instalo o APK e abro o app,
então vejo a casca com quatro abas, consigo trocar de aba e cada tela exibe seu estado
vazio, sem travar e sem erro em tela.

**CA-2 — O banco nasce cifrado.**
Dado um banco recém-criado pelo app, quando um teste consulta `PRAGMA cipher_version`,
então a resposta não é vazia — provando que é SQLCipher de verdade, e não SQLite puro
com um `PRAGMA key` silenciosamente ignorado.

**CA-3 — O arquivo do banco é ilegível sem a chave.**
Dado o arquivo `.db` gerado, quando se tenta abri-lo sem chave ou com chave errada,
então a abertura falha; e quando se varre o arquivo em busca de uma descrição gravada
propositalmente, então essa string não aparece nos bytes.

> Este critério **substituiu** o critério de saída original do marco M0, que exigia
> extrair o banco de um emulador. A prova passou a rodar no *desktop*, na CI, a cada
> push, em vez de exigir um emulador Android no pipeline; a verificação em aparelho de
> verdade virou item do checklist manual do marco. A seção 8 do guarda-chuva já foi
> reescrita e aponta de volta para cá; a decisão está em `DECISIONS.md`.

**CA-4 — A chave vive no Keystore e não vaza.**
Dado o primeiro início do app, quando a chave é gerada, então ela tem 32 bytes de
origem CSPRNG, é guardada via `flutter_secure_storage` com `EncryptedSharedPreferences`,
e a segunda abertura recupera exatamente a mesma chave.

Sobre vazamento, o critério é o que os testes conseguem provar, e só: `toString()` da
chave não contém o material (V-07), e `toHex()` não é chamado fora dos dois arquivos
autorizados (V-39). **Não** se afirma "nenhum log, em nenhum nível" — isso seria uma
universal que nenhum teste desta fatia verifica, e um aceite que ninguém consegue marcar
honestamente não é aceite.

**CA-5 — O schema v1 está completo e semeado.**
Dado um banco novo, quando ele termina de subir, então existem as 10 tabelas da seção
5.3, os 4 índices parciais, e exatamente 7 nichos semeados — 5 de gasto, 1 de
investimento e 1 de dívida, todos com ícone e cor — e rodar o seed uma segunda vez não
duplica nada.

**CA-6 — O manifest não pede nada.**
Dado o APK construído, quando se inspeciona o manifest **merged** dentro dele, então
não há nenhuma `<uses-permission>` — em particular nenhuma `INTERNET` — e
`android:allowBackup` é `false`, com as regras de extração negando `cloud-backup` e
`device-transfer`.

**CA-7 — A CI reprova quem afrouxar.**
Dado um commit que introduza a permissão `INTERNET`, que mude `allowBackup` para `true`,
que declare qualquer permissão fora do baseline, que logue um valor monetário fora de
bloco de debug ou que chame `toHex()` da chave fora dos dois arquivos autorizados, quando
a CI roda, então o build **falha**. São **cinco** travas (T-44 a T-48), e cada uma é
demonstrada uma vez reprovando uma violação proposital antes de ser dada como pronta.

**CA-8 — A regra de camadas é executável.**
Dado o código em `lib/features/*/domain/`, quando a suíte roda, então nenhum arquivo de
domínio importa `package:flutter` ou `package:drift`, e a violação quebra o build.

## 6. Dependências

Nenhuma. Este é o primeiro ADR; tudo o que ele precisa está decidido em `PRD-MVP.md` e
`DECISIONS.md`.

Ele é, em compensação, **pré-requisito de todos os outros**: nenhum ADR posterior pode
começar antes do `adr-1/TASK.md` estar fechado.

## 7. Riscos desta fatia

| # | Risco | Impacto | Mitigação |
|---|---|---|---|
| A1 | SQLCipher cair silenciosamente para SQLite puro — o `PRAGMA key` é aceito e ignorado quando a biblioteca carregada é a do sistema. É a falha mais perigosa deste ADR porque **não aparece**: tudo funciona, e o banco está em claro | Fatal | CA-2 e CA-3 são testes, não inspeção. `cipher_version` vazio reprova o build |
| ~~A2~~ | ~~`libsqlcipher` na CI Linux divergir da biblioteca embarcada no APK Android~~ | ~~Alto~~ | **Fechado na implementação.** `sqlcipher_flutter_libs` estava EOL; a migração para o hook nativo do `sqlite3` 3.x faz Linux e Android baixarem **o mesmo binário** assinado, verificado por sha256 e atestação SLSA3. Não há mais dois lugares para divergir — `docs/DECISIONS.md` |
| A3 | `applicationId` mudar depois da primeira instalação com dado real — reinstalar apaga um banco que é irrecuperável | Fatal | Decidido e travado agora, com teste de configuração (T-01) |
| A4 | Dependência transitiva reintroduzir `allowBackup="true"` ou uma permissão via merge de manifest | Alto | Trava de CI lê o manifest **merged do APK**, não o arquivo-fonte |
| A5 | Escopo do M0 crescer para "só mais uma telinha" e virar o M1 disfarçado | Médio | Lista do que está fora (seção 3), e nenhum RF na seção 4 |
| A6 | Overhead do SQLCipher só aparecer no M2, quando a query agregada existir, e aí ser caro voltar | Médio | RNF-11 tem dono explícito no ADR-3, com o benchmark como critério de aceite de lá |

## 8. Aberturas

Três foram fechadas em 2026-09-05, antes de a spec ser escrita: `applicationId`,
estratégia de prova do SEG-1 na CI e escopo de tela do M0.

Duas foram abertas pela auditoria do `/judge` no mesmo dia e **fechadas na sequência**:

- **AB-1 · Ícones e cores dos 7 nichos** — resolvida. `icon` guarda nome de ícone
  Material Symbols; `color` são 7 valores ARGB fixos, escolhidos para se distinguirem
  entre si e manterem contraste AA nos dois temas. Tabela completa na SPEC, §5.6.
- **AB-2 · O que entra no schema v1** — resolvida. O `onUpgrade` continua se recusando a
  migrar, e por isso o v1 nasce com tudo que os requisitos aprovados exigem: coluna
  `description_norm` (RF-14), `app_usage_days` (métrica M1) e `error_log` (métrica M5).

**Fora por não-seleção:** persistir as medições da **métrica M3** (tempo do FAB até
salvar). Ela era a quarta opção da mesma pergunta e não foi marcada.

> A consequência, dita sem rodeio: a mediana passa a refletir só a sessão atual, e a M3
> é um dos três critérios de "MVP bem-sucedido" — o único que o PRD trata como portão
> (*"Nenhuma feature nova entra antes de M3 estar verde"*, seção 2 do guarda-chuva).
> Medi-la sobre uma sessão não é medi-la.
>
> O que torna essa não-seleção barata, e por isso aceitável: `app_settings` é
> chave-valor e **já existe no v1**. Guardar ali as últimas 50 medições como JSON não
> precisa de migração nenhuma — é a única das quatro que escapa da armadilha do
> `onUpgrade`. Se mudar de ideia até o M5, o custo é uma task, não uma v2.

**Seguem em aberto no projeto e não bloqueiam esta fatia** — todas caem no M5 ou depois:
`FLAG_SECURE`, export CSV em texto plano, recorrência automática vs. sugerida, nome
público do app.

➡️ **SPEC e TASK liberadas.** Nenhuma abertura bloqueia a implementação.
