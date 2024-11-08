
import 'package:json_annotation/json_annotation.dart';

part 'UsbDevices.g.dart';

@JsonSerializable()
class UsbDevices {
  final String deviceName;
  final int vendorId;
  final int productId;

  UsbDevices({
    required this.deviceName,
    required this.vendorId,
    required this.productId,
  });
  factory UsbDevices.fromJson(Map<String, dynamic> json) => _$UsbDevicesFromJson(json);
  Map<String, dynamic> toJson() => _$UsbDevicesToJson(this);
}