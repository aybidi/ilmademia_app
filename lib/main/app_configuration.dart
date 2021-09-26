import 'package:app_config_repository/app_config_repository.dart';
import 'package:ilmademia/src/version.dart';
import 'package:platform/platform.dart' as platform;

Platform currentPlatform([
  platform.Platform localPlatform = const platform.LocalPlatform(),
]) {
  if (localPlatform.isAndroid) {
    return Platform.android;
  }
  if (localPlatform.isIOS) {
    return Platform.iOS;
  }
  throw UnsupportedError('unsupported platform exception');
}

int buildNumber([String version = packageVersion]) {
  final versionSegments = version.split('+');
  if (versionSegments.isEmpty) return 0;
  return int.tryParse(versionSegments.last) ?? 0;
}
