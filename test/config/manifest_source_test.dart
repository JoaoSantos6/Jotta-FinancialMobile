// T-02/T-03 — manifest sem permissões e sem Auto Backup (SEG-4, SEG-5).
//
// Cobre só o arquivo-fonte. A verificação equivalente sobre o manifest MERGED do
// APK construído (o que uma dependência transitiva poderia alterar) é a trava de
// CI (T-44/T-45), que precisa de um APK real para existir.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

XmlDocument _manifest() => XmlDocument.parse(
  File('android/app/src/main/AndroidManifest.xml').readAsStringSync(),
);

void main() {
  group('AndroidManifest.xml (fonte)', () {
    test('não declara nenhuma <uses-permission> — em particular, nenhuma INTERNET', () {
      final permissions = _manifest()
          .findAllElements('uses-permission')
          .toList();
      expect(
        permissions,
        isEmpty,
        reason:
            'RNF-6/SEG-5: o app não deve pedir nenhuma permissão. Encontradas: '
            '${permissions.map((p) => p.getAttribute('android:name')).toList()}',
      );
    });

    test('allowBackup é "false" (SEG-4)', () {
      final app = _manifest().findAllElements('application').single;
      expect(app.getAttribute('android:allowBackup'), 'false');
    });

    test('declara dataExtractionRules e fullBackupContent (SEG-4)', () {
      final app = _manifest().findAllElements('application').single;
      expect(app.getAttribute('android:dataExtractionRules'), isNotNull);
      expect(app.getAttribute('android:fullBackupContent'), isNotNull);
    });
  });

  group('res/xml/data_extraction_rules.xml (T-03)', () {
    late XmlDocument doc;

    setUpAll(() {
      doc = XmlDocument.parse(
        File(
          'android/app/src/main/res/xml/data_extraction_rules.xml',
        ).readAsStringSync(),
      );
    });

    test('nega cloud-backup', () {
      final cloudBackup = doc.findAllElements('cloud-backup').single;
      final excludeAll = cloudBackup.findElements('exclude').where(
        (e) => e.getAttribute('domain') == 'root' && e.getAttribute('path') == '.',
      );
      expect(
        excludeAll,
        isNotEmpty,
        reason: 'cloud-backup precisa excluir tudo (domain="root" path=".")',
      );
    });

    test('nega device-transfer', () {
      final deviceTransfer = doc.findAllElements('device-transfer').single;
      final excludeAll = deviceTransfer.findElements('exclude').where(
        (e) => e.getAttribute('domain') == 'root' && e.getAttribute('path') == '.',
      );
      expect(
        excludeAll,
        isNotEmpty,
        reason: 'device-transfer precisa excluir tudo (domain="root" path=".")',
      );
    });
  });

  group('res/xml/backup_rules.xml (T-03)', () {
    test('existe e está vazio (fullBackupContent para API < 31)', () {
      final doc = XmlDocument.parse(
        File(
          'android/app/src/main/res/xml/backup_rules.xml',
        ).readAsStringSync(),
      );
      final root = doc.rootElement;
      expect(root.name.local, 'full-backup-content');
      expect(
        root.children.whereType<XmlElement>(),
        isEmpty,
        reason: 'vazio de propósito: nada deve ser incluído no backup legado',
      );
    });
  });
}
