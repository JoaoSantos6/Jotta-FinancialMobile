import 'package:financial/core/database/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Observa [appDatabaseProvider] e decide o que a raiz do app mostra:
/// splash enquanto carrega, [BootstrapFailureScreen] em erro, ou [child]
/// quando o banco abriu.
class BootstrapGate extends ConsumerWidget {
  const BootstrapGate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final databaseAsync = ref.watch(appDatabaseProvider);

    return databaseAsync.when(
      data: (_) => child,
      loading: () => const _BootstrapSplash(),
      error: (error, stackTrace) => BootstrapFailureScreen(error: error),
    );
  }
}

/// Sem texto: não pisca "carregando" em 200ms (docs/adr-1/SPEC.md §6).
class _BootstrapSplash extends StatelessWidget {
  const _BootstrapSplash();

  @override
  Widget build(BuildContext context) => const Scaffold(body: SizedBox.expand());
}

/// As falhas aqui são reais e não recuperáveis em tela: Keystore
/// indisponível, chave corrompida, SQLCipher indisponível. Mostra só o
/// tipo do erro e nada mais — **nunca** a chave, **nunca** o caminho do
/// banco (RNF-16). Sem essa tela, o modo de falha seria tela branca.
///
/// Deliberadamente sem "tentar de novo": as duas ações possíveis são
/// destrutivas (apagar e recomeçar, RF-29, é do M5) ou inúteis (repetir a
/// mesma leitura que já falhou).
class BootstrapFailureScreen extends StatelessWidget {
  const BootstrapFailureScreen({required this.error, super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Não foi possível abrir o banco de dados.\n'
            'Tipo do erro: ${error.runtimeType}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
