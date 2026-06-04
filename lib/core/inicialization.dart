import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../data/database/local/app_database.dart';
import '../providers/user_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';


class Inicialization {

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // ANDROID_ID
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "unknown"; // UUID único por app+device
    } else {
      return "unsupported-platform";
    }
  }


}