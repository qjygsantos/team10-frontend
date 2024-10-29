// package com.example.psykitz

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity()
package com.example.psykitz
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import android.provider.DocumentsContract
import androidx.core.content.FileProvider
import java.io.FileInputStream
import java.io.IOException
import java.io.OutputStream
import java.util.*


// IMPORTS FOR ARDUINO FILE TRANSFER

import android.bluetooth.BluetoothSocket

// NEW IMPLEMENTATION

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel
import java.io.InputStream


import android.Manifest
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodCall

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.psykitz/file_transfer"
    private val MY_UUID: UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")
    private var bluetoothSocket: BluetoothSocket? = null
    private var outputStream: OutputStream? = null

    private val STREAM = "bluetoothStream"
    private var inputStream: InputStream? = null
    private var thread: Thread? = null
    private var eventSink: EventChannel.EventSink? = null

    private val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
    private val REQUEST_CODE = 1

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendFile") {
                val filePath = call.argument<String>("filePath")
                val deviceAddress = call.argument<String>("deviceAddress")
                if (filePath != null && deviceAddress != null) {
                    sendFile(this, filePath, deviceAddress)
                    result.success("File sent")
                } else {
                    result.error("INVALID_ARGUMENT", "File path or device address is null", null)
                }
            } else if(call.method == "sendFileToArduino") {
                val filePath = call.argument<String>("filePath")
                val deviceAddress = call.argument<String>("deviceAddress")
                if (filePath != null && deviceAddress != null) {
                    sendFileToArduino(filePath, deviceAddress)
                    result.success("File sent")
                } else {
                    result.error("INVALID_ARGUMENT", "File path or device address is null", null)
                }
            }else if(call.method == "connectBluetooth") {
                val address = call.argument<String>("address")
                if (address != null) {
                    connectToBluetoothDevice(address)
                    result.success("Connected to $address")
                } else {
                    result.error("UNAVAILABLE", "Bluetooth device address not provided", null)
                }
            }else if(call.method == "sendData"){
                val data = call.argument<String>("data")
                if (data != null) {
                    sendDataToBluetoothDevice(data)
                    result.success("Data sent: $data")
                } else {
                    result.error("UNAVAILABLE", "No data to send", null)
                }
            }else if(call.method == "sendBluetoothMessage"){
                if (ContextCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH) != PackageManager.PERMISSION_GRANTED ||
                    ContextCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_ADMIN) != PackageManager.PERMISSION_GRANTED ||
                    ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.BLUETOOTH, Manifest.permission.BLUETOOTH_ADMIN, Manifest.permission.ACCESS_FINE_LOCATION), REQUEST_CODE)
                }else{
                    val deviceAddress = call.argument<String>("deviceAddress")
                    val message = call.argument<String>("message")
                    val option = call.argument<String>("option")
                    if (deviceAddress != null && message != null && option != null) {
                        if(option == "1"){
                            result.success(sendBluetoothMessage(deviceAddress, message))
                        }else{
                            result.success(sendBluetoothMessageSecondOption(deviceAddress, message))
                        }
                    } else {
                        result.error("UNAVAILABLE", "Device address or message not available.", null)
                    }
                }
            }else{
                result.notImplemented()

            }
        }

        EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, STREAM).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                startListeningForData()
            }

            override fun onCancel(arguments: Any?) {
                stopListeningForData()
            }
        })
    }

    private fun sendFile(context: Context, filePath: String, deviceAddress: String) {
        val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
        val device: BluetoothDevice? = bluetoothAdapter?.getRemoteDevice(deviceAddress)
    
        if (device != null) {
            val file = File(filePath)
            
            // Use FileProvider to get a content URI
            val fileUri: Uri = FileProvider.getUriForFile(
                context,
                "${context.packageName}.provider",
                file
            )
    
            val intent = Intent()
            intent.action = Intent.ACTION_SEND
            intent.type = "*/*" // MIME type of the file
            intent.putExtra(Intent.EXTRA_STREAM, fileUri)
            
            // Grant read permission to the receiving app
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
    
            // Start the Bluetooth file transfer activity
            context.startActivity(Intent.createChooser(intent, "Send file via Bluetooth"))
        } else {
            Log.d("BluetoothFileTransfer", "Device not found")
        }
    }

    private fun sendFileToArduino(filePath: String, deviceAddress: String) {
        val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
        val device: BluetoothDevice? = bluetoothAdapter?.getRemoteDevice(deviceAddress)

        if (device != null) {
            val file = File(filePath)
            val fileInputStream = FileInputStream(file)
            
            // Create a BluetoothSocket for the connection
            val bluetoothSocket: BluetoothSocket = device.createRfcommSocketToServiceRecord(MY_UUID)
            bluetoothSocket.connect()
            
            val outputStream: OutputStream = bluetoothSocket.outputStream

            val buffer = ByteArray(1024) // Adjust size as needed
            var bytesRead: Int
            while (fileInputStream.read(buffer).also { bytesRead = it } != -1) {
                outputStream.write(buffer, 0, bytesRead)
            }

            fileInputStream.close()
            outputStream.flush()
            outputStream.close()
            bluetoothSocket.close()
        } else {
            Log.d("BluetoothFileTransfer", "Device not found")
        }
    }

    private fun connectToBluetoothDevice(address: String) {
        val bluetoothAdapter: BluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        val device: BluetoothDevice = bluetoothAdapter.getRemoteDevice(address)

        try {
            bluetoothSocket = device.createRfcommSocketToServiceRecord(MY_UUID)
            bluetoothSocket?.connect()
            outputStream = bluetoothSocket?.outputStream

        } catch (e: IOException) {
            e.printStackTrace()
        }
    }

    private fun sendDataToBluetoothDevice(data: String) {
        try {
            outputStream?.write(data.toByteArray())
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }

    private fun startListeningForData() {
        thread = Thread {
            while (true) {
                try {
                    val buffer = ByteArray(1024)
                    val bytes = inputStream?.read(buffer)
                    if (bytes != null && bytes > 0) {
                        val receivedData = String(buffer, 0, bytes)
                        eventSink?.success(receivedData)
                    }
                } catch (e: IOException) {
                    e.printStackTrace()
                    break
                }
            }
        }
        thread?.start()
    }

    private fun stopListeningForData() {
        thread?.interrupt()
        thread = null
    }

    private fun sendBluetoothMessage(deviceAddress: String, message: String): String {
        val device = bluetoothAdapter?.getRemoteDevice(deviceAddress)
        device?.let {
            return try {
                val method = device.javaClass.getMethod("createRfcommSocket", Int::class.javaPrimitiveType)
                val socket = method.invoke(device, 2) as BluetoothSocket
                socket.connect()
                val outputStream: OutputStream = socket.outputStream
                outputStream.write(message.toByteArray())
                outputStream.flush()
                socket.close()
                 "SUCCESS"
            } catch (e: Exception) {
                e.printStackTrace()
                 "FAILED"
            }
        } ?: return "Device not found."
    }

    private fun sendBluetoothMessageSecondOption(deviceAddress: String, message: String): String {
        val device = bluetoothAdapter?.getRemoteDevice(deviceAddress)
        device?.let {
            return try {
                val uuid = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB") // SPP UUID
                val socket = device.createRfcommSocketToServiceRecord(uuid)
                socket.connect()
                val outputStream: OutputStream = socket.outputStream
                outputStream.write(message.toByteArray())
                outputStream.flush()
                socket.close()
                "SUCCESS"
            } catch (e: Exception) {
                e.printStackTrace()
                "FAILED"
            }
        } ?: return "Device not found."
    }
}