// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UsbDevices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsbDevices _$UsbDevicesFromJson(Map<String, dynamic> json) => UsbDevices(
      deviceName: json['deviceName'] as String,
      vendorId: (json['vendorId'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
    );

Map<String, dynamic> _$UsbDevicesToJson(UsbDevices instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'vendorId': instance.vendorId,
      'productId': instance.productId,
    };
