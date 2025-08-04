import 'package:desafio_fteam/core/resources/settings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DevelopmentSettings implements Settings {
  DevelopmentSettings();

  final String _ramApiUrl = dotenv.get('RAM_URL');



  @override
  String get ramApiUrl => _ramApiUrl;


}
