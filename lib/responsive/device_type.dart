import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

class DeviceInfo {
  static DeviceType getDeviceType(MediaQueryData mediaQuery) {
    final width = mediaQuery.size.width;

    if (width >= 1024) {
      return DeviceType.desktop;
    } else if (width >= 600) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }
}
