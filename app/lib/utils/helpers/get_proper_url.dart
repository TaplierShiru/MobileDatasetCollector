import 'package:app/environment/environment.dart';

String? getProperUrl(String? url) {
  if (url != null) {
    return Environment.appendToApiUrl([url]);
  }
  return null;
}
