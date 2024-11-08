package com.example.universal_printer_flutter

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.hardware.usb.UsbDevice
import android.os.Bundle
import android.text.TextUtils
import android.util.Log
import android.widget.Toast
import com.example.universal_printer_flutter.utils.BlueToothBroadcastReceiver
import com.example.universal_printer_flutter.utils.BlueToothHelper
import com.example.universal_printer_flutter.utils.PermissionUtil
import com.example.universal_printer_flutter.utils.UsbBroadcastReceiver
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    private companion object {
        const val TAG = "MainActivity"
        const val CHANNEL = "AndroidSupports"
        const val GET_USB_DEVICES = "getUsbDevices"
        const val REGISTER_USB = "registerUsbService"
        const val UN_REGISTER_USB = "unRegisterUsbService"
        const val REGISTER_BLE = "registerBleService"
        const val UN_REGISTER_BLE = "unRegisterBleService"
        const val DISCOVERY_BLE_DEVICES = "discoveryBleDevices"
        const val STOP_DISCOVERY_BLE_DEVICES = "stopDiscoveryBleDevices"
        const val START_DISCOVERY_BLE_DEVICES = "startDiscoveryBleDevices"
        const val SCAN_BLE_DEVICES_RESULT = "scanBleDevicesResult"
        const val BLE_GET_DISCOVERY_STATE = "bleDiscoveryStateCallBack"

        const val REQUEST_CODE_BLE_PERMISSION = 0x0A1
    }

    private var methodChannel: MethodChannel? = null
    private val gson by lazy { Gson() }


    private val usbBroadcastReceiver by lazy { UsbBroadcastReceiver() }
    private val bleBroadcastReceiver by lazy {
        BlueToothBroadcastReceiver {
            activeMsgToFlutter(
                SCAN_BLE_DEVICES_RESULT,
                gson.toJson(mutableMapOf<String, String>().apply {
                put("deviceName", if (!TextUtils.isEmpty(it.name)) it.name else "null")
                put("address", it.address)
            })
            )
        }
    }

    private val methodCallHandler =
        MethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                GET_USB_DEVICES -> {
                    // 获取USB设备的逻辑
                    val devicesList = usbBroadcastReceiver.getUsbDevices()
                    val data = convertUsbDeviceData(devicesList)
                    result.success(data)
                }

                REGISTER_USB -> {
                    //注册USB广播
                    usbBroadcastReceiver.onRegister()
                    result.success(true)
                }

                UN_REGISTER_USB -> {
                    //销毁USB广播
                    usbBroadcastReceiver.onDestroy()
                    result.success(true)
                }

                REGISTER_BLE -> {
                    //注册蓝牙广播
                    bleBroadcastReceiver.onReceive()
                    result.success(true)
                }

                UN_REGISTER_BLE -> {
                    //销毁蓝牙广播
                    BlueToothHelper.getInstance().stopDiscovery()
                    bleBroadcastReceiver.onDestroy()
                    result.success(true)
                }

                DISCOVERY_BLE_DEVICES -> {
                    //开启蓝牙扫描
                    checkBluetoothPermission()
                    result.success(true)
                }

                BLE_GET_DISCOVERY_STATE -> {
                    result.success(BlueToothHelper.getInstance().isDiscovering())
                }

                STOP_DISCOVERY_BLE_DEVICES -> {
                    //停止蓝牙扫描
                    BlueToothHelper.getInstance().stopDiscovery()
                    val discovering = BlueToothHelper.getInstance().isDiscovering()
                    Log.d(TAG, "蓝牙扫描状态：${discovering}")
//                    activeMsgToFlutter(BLE_GET_DISCOVERY_STATE, discovering)
                    result.success(discovering)
                }

                START_DISCOVERY_BLE_DEVICES -> {
                    BlueToothHelper.getInstance().discoveryBleDevice()
//                    activeMsgToFlutter(BLE_GET_DISCOVERY_STATE, BlueToothHelper.getInstance().isDiscovering())
                    val discovering = BlueToothHelper.getInstance().isDiscovering()
                    Log.d(TAG, "蓝牙扫描状态：${discovering}")
                    result.success(discovering)
                }

                else -> result.notImplemented()
            }
        }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler(methodCallHandler)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        initEven()
    }

    private fun initEven() {
        usbBroadcastReceiver.setOnUsbReceiveListener(object :
            UsbBroadcastReceiver.OnUsbReceiveListener {
            override fun onUsbAttached(intent: Intent) {

            }

            override fun onUsbDetached(intent: Intent) {
            }

            override fun onUsbPermission(intent: Intent) {

            }
        })
    }

    private fun convertUsbDeviceData(device: Set<UsbDevice>): String {
        return if (device.isNotEmpty()) {
            val result = mutableListOf<Map<String, Any>>()
            for (usbDevice in device) {
                result.add(mutableMapOf<String, Any>().apply {
                    put("deviceName", usbDevice.deviceName)
                    put("vendorId", usbDevice.vendorId)
                    put("productId", usbDevice.productId)
                })
            }
            gson.toJson(result)
        } else {
            ""
        }
    }

    private fun activeMsgToFlutter(methodName: String, data:Any) {
        methodChannel?.invokeMethod(methodName, data)
    }


    private fun checkBluetoothPermission() {
        PermissionUtil.getInstance().checkPermissionV1(
            permissions = mutableListOf<String>().apply {
                add(Manifest.permission.BLUETOOTH)
                add(Manifest.permission.ACCESS_FINE_LOCATION)
                add(Manifest.permission.ACCESS_COARSE_LOCATION)
                addAll(PermissionUtil.getInstance().getPermissionFromSDKVersionS())
            }, onSuccess = {
                //Permission all pass
                BlueToothHelper.getInstance().discoveryBleDevice()
                activeMsgToFlutter(BLE_GET_DISCOVERY_STATE, BlueToothHelper.getInstance().isDiscovering())
            }, onFailure = {
                //申请权限
                requestPermissions(it.toTypedArray(), REQUEST_CODE_BLE_PERMISSION)
            })
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_CODE_BLE_PERMISSION) {
            val result = grantResults.filter { it == PackageManager.PERMISSION_DENIED }
            if (result.isEmpty()) {
                BlueToothHelper.getInstance().discoveryBleDevice()
                activeMsgToFlutter(BLE_GET_DISCOVERY_STATE, BlueToothHelper.getInstance().isDiscovering())
            } else {
                Toast.makeText(this, "蓝牙权限申请失败", Toast.LENGTH_SHORT).show()
            }
        }
    }
}
