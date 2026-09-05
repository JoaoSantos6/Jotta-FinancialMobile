# ADR-1 — Fundação segura do app

| Campo | Valor |
|---|---|
| ADR | 1 |
| Marco | **M0** do roadmap (seção 8 do [PRD guarda-chuva](../PRD-MVP.md)) |
| Versão | 1.0 |
| Data | 2026-09-05 |
| Status | **Bloqueado** — 2 aberturas na seção 8, abertas pela auditoria de 2026-09-05 |
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
  migração 1. Os DAOs e as queries ficam para os ADRs que os consomem.
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
Dado um banco novo, quando ele termina de subir, então existem as 8 tabelas da seção
5.3, os 3 índices parciais, e exatamente 7 nichos semeados — 5 de gasto, 1 de
investimento e 1 de dívida — e rodar o seed uma segunda vez não duplica nada.

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
| A2 | `libsqlcipher` na CI Linux divergir da biblioteca embarcada no APK Android, fazendo o teste passar no desktop e o app falhar no aparelho | Alto | Versão da lib fixada nos dois lados — **e essa paridade ainda não foi verificada**: depende de o repositório da distro oferecer a mesma versão que o `sqlcipher_flutter_libs` embarca. Confirmar na T-41. A verificação no aparelho, no checklist manual, é a rede de segurança |
| A3 | `applicationId` mudar depois da primeira instalação com dado real — reinstalar apaga um banco que é irrecuperável | Fatal | Decidido e travado agora, com teste de configuração (T-01) |
| A4 | Dependência transitiva reintroduzir `allowBackup="true"` ou uma permissão via merge de manifest | Alto | Trava de CI lê o manifest **merged do APK**, não o arquivo-fonte |
| A5 | Escopo do M0 crescer para "só mais uma telinha" e virar o M1 disfarçado | Médio | Lista do que está fora (seção 3), e nenhum RF na seção 4 |
| A6 | Overhead do SQLCipher só aparecer no M2, quando a query agregada existir, e aí ser caro voltar | Médio | RNF-11 tem dono explícito no ADR-3, com o benchmark como critério de aceite de lá |

## 8. Aberturas

Três foram fechadas em 2026-09-05, antes de a spec ser escrita: `applicationId`,
estratégia de prova do SEG-1 na CI e escopo de tela do M0. Estão em `DECISIONS.md`.

Duas foram **abertas pela auditoria** do mesmo dia, e bloqueiam a implementação:

**AB-1 · Ícones e cores dos 7 nichos.**
`niches.icon` e `niches.color` são `NOT NULL` (seção 5.3 do guarda-chuva). O seed é a
T-29, dentro desta fatia, e a T-28 congela o resultado num golden. Sem 7 ícones e 7
cores decididos, a T-29 não é implementável.

> A versão anterior desta seção afirmava que identidade visual "não bloqueia este ADR".
> Estava errado, e o erro tinha uma causa: eu tratei "identidade visual" como assunto de
> Play Store, sem ligar ao fato de que o schema exige as duas colunas.

**AB-2 · O que entra no schema v1.**
A migração 1 é congelada por golden (T-28) e o `onUpgrade` foi escrito para **lançar**
em vez de migrar. Nessa combinação, tudo que ficar de fora vira uma v2 obrigatória num
mecanismo que se recusa a rodar. Três coisas que o guarda-chuva exige e o schema atual
não guarda:

- **RF-14** — busca por descrição "ignorando acentos e caixa". A coluna é `description
  TEXT` pura, e `LIKE` do SQLite não faz *accent folding*.
- **RF-30 / métricas M1 e M5** — a tela "Meu uso" exibe contagem de dias com sessão e um
  log local de exceções. Não há tabela para nenhum dos dois.
- **Métrica M3** — a mediana das últimas 50 medições de tempo de lançamento é descrita
  como "timer em memória", que não sobrevive à sessão, mas é critério de gate do MVP.

Cada um dos três tem três saídas: entra no v1 agora, entra numa v2 planejada (e aí o
`onUpgrade` precisa saber migrar), ou o requisito correspondente cai. É decisão de
produto, não técnica.

**Seguem em aberto no projeto e realmente não bloqueiam esta fatia** — todas caem no M5
ou depois: `FLAG_SECURE`, export CSV em texto plano, recorrência automática vs. sugerida,
nome público do app.

⛔ **A SPEC e a TASK já existem** e cobrem tudo que não depende de AB-1 e AB-2. A
implementação da T-28, da T-29 e das tabelas afetadas fica bloqueada até as duas serem
respondidas — as outras 45 tasks não dependem delas.
