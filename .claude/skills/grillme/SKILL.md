---
name: grillme
description: Interrogue o usuário antes de assumir qualquer coisa. Use SEMPRE que houver dúvida, ambiguidade ou lacuna sobre requisitos, escopo, regras de negócio, stack, design ou prioridades do projeto Jotta-FinancialMobile — inclusive quando a dúvida parecer pequena o suficiente para "chutar um padrão". Dispara em: requisito vago, várias interpretações possíveis, decisão de arquitetura sem dono, campo/modelo de dados não especificado, ou quando você estiver prestes a escrever "assumindo que...".
---

# grillme — pergunte, não suponha

## Princípio

Neste projeto, **suposição não documentada é bug**. Sempre que uma decisão puder ir
para dois lados e os dois lados gerem trabalho materialmente diferente, você
**pergunta ao usuário** em vez de escolher sozinho.

O nome é literal: me grelhe. Perguntas diretas, específicas e com opções.

## Quando disparar

Dispare esta skill quando qualquer destes for verdade:

- Você está prestes a escrever "vou assumir que", "por padrão eu usaria", "presumo que".
- Um requisito admite mais de uma leitura razoável.
- Falta uma regra de negócio (o que conta como "gasto do mês"? o que entra na visão geral?).
- Falta um campo, um estado, uma unidade, um fuso horário, uma moeda.
- A escolha é de produto (o que entra no MVP) e não técnica — isso é sempre do usuário.
- Existe trade-off relevante de custo, prazo, privacidade ou complexidade.

## Quando NÃO disparar

- Convenção óbvia com padrão claro do ecossistema (nome de pacote, ordem de imports,
  formatação). Escolha, siga o padrão e siga em frente.
- Detalhe que você consegue verificar lendo o código/repositório. **Leia antes de perguntar.**
- Você já perguntou isso nesta sessão e obteve resposta. Não repergunte.

## Como perguntar

Use a ferramenta `AskUserQuestion`. Regras:

1. **No máximo 4 perguntas por rodada.** Se houver mais, priorize as que bloqueiam
   o trabalho agora e faça o resto que não depende delas enquanto espera.
2. **Cada pergunta tem 2–4 opções concretas**, não "o que você prefere?".
   Cada opção descreve a consequência ("isso adiciona X ao escopo", "isso corta Y").
3. **Coloque sua recomendação como a primeira opção** e marque com `(Recomendado)`,
   junto com o motivo em uma linha.
4. **Header curto** (≤12 caracteres) que nomeie a decisão: `Stack`, `Nichos`, `Sync`, `Moeda`.
5. Português, direto, sem preâmbulo.
6. Se a pergunta admite várias respostas simultâneas (ex.: "quais nichos entram
   no MVP?"), use `multiSelect: true`.

## Depois da resposta

- **Registre a decisão** em `docs/DECISIONS.md` (crie se não existir), no formato:
  `| data | decisão | alternativa descartada | quem decidiu |`.
- Se a resposta invalidar trabalho já feito, diga isso em uma frase e corrija — sem
  ladainha.
- Se o usuário responder "escolha você" / "tanto faz", aí sim decida, **anote a decisão
  como sua** em `docs/DECISIONS.md` e siga.

## Antipadrões

- Perguntar e, na mesma mensagem, já entregar a resposta assumindo um dos lados.
- Perguntar coisas que não mudam nada no que você vai fazer a seguir.
- Empilhar 12 perguntas de uma vez e travar a entrega.
- Fazer pergunta aberta sem opções ("como você imagina a home?").
