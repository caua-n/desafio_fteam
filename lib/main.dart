import 'package:desafio_fteam/app_widget.dart';
import 'package:desafio_fteam/core/resources/development_settings.dart';
import 'package:desafio_fteam/core/resources/settings.dart';
import 'package:desafio_fteam/core/services/injection/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'env/.env.production');
  Settings appSettings = DevelopmentSettings();
  
  setupDependencies(appSettings);
  runApp(const AppWidget());
}