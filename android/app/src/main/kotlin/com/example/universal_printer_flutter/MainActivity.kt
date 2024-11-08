package com.example.universal_printer_flutter

import android.content.Intent
import android.hardware.usb.UsbDevice
import android.os.Bundle
import android.util.Log
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler


class MainActivity: FlutterActivity() {
    companion object {
        const val CHANNEL = "usb_channel"
        const val GET_USB_DEVICES = "getUsbDevices"
        const val REGISTER_USB = "registerUsbService"
        const val UN_REGISTER_USB = "unRegisterUsbService"
        const val REGISTER_BLE = "registerBleService"
        const val UN_REGISTER_BLE = "unRegisterBleService"
        const val DISCOVERY_BLE_DEVICES = "discoveryBleDevices"
        const val STOP_DISCOVERY_BLE_DEVICES = "stopDiscoveryBleDevices"
    }

    private val usbBroadcastReceiver by lazy { UsbBroadcastReceiver() }
    private val bleBroadcastReceiver by lazy { BlueToothBroadcastReceiver {

    } }

    private val methodCallHandler =
        MethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when(call.method) {
                GET_USB_DEVICES -> {
                    // 获取USB设备的逻辑
                    val devicesList = usbBroadcastReceiver.getUsbDevices()
                    val data = sendDeviceToFlutter(devicesList)
                    result.success(data)
                }
                REGISTER_USB -> {
                    usbBroadcastReceiver.onRegister()
                    result.success(true)
                }
                UN_REGISTER_USB -> {
                    usbBroadcastReceiver.onDestroy()
                    result.success(true)
                }

                REGISTER_BLE -> {
                    bleBroadcastReceiver.onReceive()
                    result.success(true)
                }

                UN_REGISTER_BLE -> {
                    bleBroadcastReceiver.onDestroy()
                    result.success(true)
                }

                DISCOVERY_BLE_DEVICES -> {
                    val start = BlueToothHelper.getInstance().discoveryBleDevice()
                    result.success(start)
                }

                STOP_DISCOVERY_BLE_DEVICES -> {
                    val stop = BlueToothHelper.getInstance().stopDiscovery()
                    result.success(stop)
                }
                else -> result.notImplemented()
            }
        }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler(methodCallHandler)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        initEven()
    }

    private fun initEven() {
        usbBroadcastReceiver.setOnUsbReceiveListener(object :UsbBroadcastReceiver.OnUsbReceiveListener {
            override fun onUsbAttached(intent: Intent) {

            }

            override fun onUsbDetached(intent: Intent) {
            }

            override fun onUsbPermission(intent: Intent) {

            }
        })
    }

    private fun sendDeviceToFlutter(device: Set<UsbDevice>) :String{
        return if (device.isNotEmpty()) {
            val result = mutableListOf<Map<String, Any>>()
            for (usbDevice in device) {
                result.add(mutableMapOf<String, Any>().apply {
                    put("deviceName", usbDevice.deviceName)
                    put("vendorId", usbDevice.vendorId)
                    put("productId", usbDevice.productId)
                })
            }
            Gson().toJson(result)
        } else {
            ""
        }
    }
}
