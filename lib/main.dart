import 'package:desafio_fteam/app_widget.dart';
import 'package:desafio_fteam/core/services/injection/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  setupDependencies();
  runApp(const AppWidget());
}