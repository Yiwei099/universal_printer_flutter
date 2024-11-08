package com.example.universal_printer_flutter.utils

import android.bluetooth.BluetoothDevice
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import com.example.universal_printer_flutter.BaseApplication

class BlueToothBroadcastReceiver(
    private var listener: ((BluetoothDevice) -> Unit)
) : BroadcastReceiver() {

    companion object{
        const val TAG = "BlueBroadcastReceiver"
    }

    override fun onReceive(context: Context, intent: Intent) {
        when(intent.action){
            BluetoothDevice.ACTION_FOUND->{
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE,BluetoothDevice::class.java)
                } else {
                    intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE)
                }?.let {
                    listener.invoke(it)
                }
            }
            else->{}
        }
    }

    fun onReceive() {
        Log.d(TAG, "BlueToothBroadcastReceiver onReceive")
        BaseApplication.getInstance().registerReceiver(this, IntentFilter(BluetoothDevice.ACTION_FOUND))
    }

    fun onDestroy(){
        Log.d(TAG, "BlueToothBroadcastReceiver onDestroy")
        BaseApplication.getInstance().unregisterReceiver(this)
    }
}