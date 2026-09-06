import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Resolve o caminho de `jotta.db`, sempre no diretório privado do app.
///
/// Usa `getApplicationDocumentsDirectory()` — no Android é o sandbox do app,
/// que só o próprio app e o root leem. Nunca `getExternalStorageDirectory()`:
/// a cifra (SEG-1) protege o *conteúdo* do arquivo, mas não impede que ele
/// seja copiado, e cópia de arquivo cifrado é material para ataque offline
/// com tempo ilimitado — o diretório privado evita a cópia em primeiro lugar
/// (docs/DECISIONS.md).
Future<File> resolveDatabaseFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/jotta.db');
}
