import 'package:flutter_test/flutter_test.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';

void main() {
  test('deviceTypeFromWidth maps breakpoints', () {
    expect(deviceTypeFromWidth(400), DeviceType.mobile);
    expect(deviceTypeFromWidth(800), DeviceType.tablet);
    expect(deviceTypeFromWidth(1400), DeviceType.desktop);
  });
}
