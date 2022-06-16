import 'environment_local.dart' as env_local;
import 'base_environment.dart';

class Environment extends BaseEnvironment {
  static String apiUrl = env_local.Environment.apiUrl;

  static String appendToApiUrl(List<String> args) {
    var finalString = Environment.apiUrl;
    for (var element in args) {
      if (element.isNotEmpty) {
        finalString += '/$element';
      }
    }
    return finalString;
  }
}
