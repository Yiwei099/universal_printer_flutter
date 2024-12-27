// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_devices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BleDevices _$BleDevicesFromJson(Map<String, dynamic> json) => BleDevices(
      deviceName: json['deviceName'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$BleDevicesToJson(BleDevices instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'address': instance.address,
    };
