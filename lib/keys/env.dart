import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'openWeatherApiKey', obfuscate: true)
  static String openWeatherkey1 = _Env.openWeatherkey1;
}
