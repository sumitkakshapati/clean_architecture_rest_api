import 'package:flutter_clean_architecture_template/core/enum/environment.dart';

class Env {
  final String baseUrl;
  final Environment type;

  Env({
    required this.baseUrl,
    required this.type,
  });

  factory Env.production() {
    return Env(
      baseUrl: "http://www.example.com",
      type: Environment.production,
    );
  }

  factory Env.development() {
    return Env(
      baseUrl: "http://www.example.com",
      type: Environment.development,
    );
  }
}
