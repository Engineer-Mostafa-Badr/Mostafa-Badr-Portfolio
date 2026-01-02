enum DeviceType { mobile, tablet, desktop }

DeviceType deviceTypeFromWidth(double width) {
  if (width >= 1100) return DeviceType.desktop;
  if (width >= 700) return DeviceType.tablet;
  return DeviceType.mobile;
}
