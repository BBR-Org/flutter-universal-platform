import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '../universal_platform.dart';

//Override default method, to provide .io access
Future<UniversalPlatformType> get currentUniversalPlatform async {
  if (Platform.isWindows) return UniversalPlatformType.Windows;
  if (Platform.isFuchsia) return UniversalPlatformType.Fuchsia;
  if (Platform.isMacOS) return UniversalPlatformType.MacOS;
  if (Platform.isLinux) return UniversalPlatformType.Linux;
  if (Platform.isIOS) return UniversalPlatformType.IOS;
  if (Platform.isAndroid) {
    // Check if it's an Android TV
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.systemFeatures.contains('android.software.leanback')) {
      return UniversalPlatformType.AndroidTv;
    }
    return UniversalPlatformType.Android;
  }
  return UniversalPlatformType.Unknown;
}
