import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '../universal_platform.dart';

UniversalPlatformType? _platformType;

// Define the enum for Universal Platform Types
Future<void> initializePlatform() async {
  if (_platformType != null) return;
  if (Platform.isWindows) _platformType = UniversalPlatformType.Windows;
  if (Platform.isFuchsia) _platformType = UniversalPlatformType.Fuchsia;
  if (Platform.isMacOS) _platformType = UniversalPlatformType.MacOS;
  if (Platform.isLinux) _platformType = UniversalPlatformType.Linux;
  if (Platform.isIOS) _platformType = UniversalPlatformType.IOS;
  if (Platform.isAndroid) {
    // Check if it's an Android TV
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.systemFeatures.contains('android.software.leanback')) {
      _platformType = UniversalPlatformType.AndroidTv;
    }
    _platformType = UniversalPlatformType.Android;
  }
}

//Override default method, to provide .io access
UniversalPlatformType get currentUniversalPlatform =>
    _platformType ?? UniversalPlatformType.Unknown;
