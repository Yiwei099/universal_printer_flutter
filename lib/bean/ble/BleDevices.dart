
import 'package:json_annotation/json_annotation.dart';

part 'BleDevices.g.dart';

@JsonSerializable()
class BleDevices {
  final String deviceName;
  final String address;

  BleDevices({
    required this.deviceName,
    required this.address,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BleDevices && other.address == address;
  }

  @override
  int get hashCode => address.hashCode;

  factory BleDevices.fromJson(Map<String, dynamic> json) => _$BleDevicesFromJson(json);
  Map<String, dynamic> toJson() => _$BleDevicesToJson(this);
}