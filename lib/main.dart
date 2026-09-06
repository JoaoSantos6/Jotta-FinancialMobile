import 'package:financial/app/app.dart';
import 'package:financial/app/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  installLogging(isRelease: kReleaseMode);
  runApp(const ProviderScope(child: JottaApp()));
}
