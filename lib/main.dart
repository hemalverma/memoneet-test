import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotexh_test/src/app.dart';
import 'package:infotexh_test/src/logic/services/isar_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDatabase.initialize();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
