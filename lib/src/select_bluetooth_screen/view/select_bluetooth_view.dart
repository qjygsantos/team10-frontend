import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:psykitz/config/app_colors.dart';
import 'package:psykitz/config/app_fontsizes.dart';
import 'package:psykitz/services/bluetooth_service.dart';
import 'package:sizer/sizer.dart';
import '../../../services/open_bluetooth_setting_dialog.dart';
import '../controller/select_bluetooth_controller.dart';

class SelectBluetoothPage extends GetView<SelectBluetoothController> {
  const SelectBluetoothPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SelectBluetoothController());
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: SpinKitThreeBounce(
                    size: 30.sp,
                    color: AppColors.lightblue,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 7.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Devices",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.superextraLarge, color: AppColors.lightblue),
                            ),
                            Row(
                              children: [
                                // IconButton(
                                //     onPressed: () {
                                //       Get.to(() => const ListenToDataPage());
                                //     },
                                //     icon: const Icon(
                                //       Icons.add,
                                //       color: Colors.blue,
                                //     )),
                                IconButton(
                                    onPressed: () {
                                      controller.getBluetoothDevices();
                                    },
                                    icon: const Icon(
                                      Icons.bluetooth_searching,
                                      color: Colors.blue,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            itemCount: controller.devices.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: SizedBox(
                                  height: 10.h,
                                  width: 100.w,
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 2.w, top: 1.h, right: 2.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.devices[index].device.name ?? controller.devices[index].device.address,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSizes.medium, color: AppColors.lightblue),
                                              ),
                                              Text(
                                                controller.devices[index].device.name == null ? "" : controller.devices[index].device.address,
                                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: AppFontSizes.regular, color: AppColors.lightblue),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightblue),
                                                onPressed: () async {
                                                  if (!await Get.find<BluetoothAppService>().checkBlueToothEnabled()) {
                                                    OpenBluetoothSettingsDialog.showBluetoothSettingsDialog();
                                                  } else {
                                                    // SelectBluetoothChooseOptionDialog.showOptions(deviceAddress: controller.devices[index].device.address);
                                                    // controller.tesConnection(option: "2", address: controller.devices[index].device.address, message: "<F><F><F>");
                                                    controller.sendMessage(message: "<F><F><F>");
                                                  }
                                                },
                                                child: const Text(
                                                  "TEST",
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    // SelectBluetoothChooseOptionDialog.showOptions(deviceAddress: controller.devices[index].device.address);
                                                    // controller.connectToDeviceAndSendMessage(option: "2", address: controller.devices[index].device.address, message: "<F>");
                                                    controller.bluetoothConnect(address: controller.devices[index].device.address);
                                                  },
                                                  icon: Obx(
                                                    () => Icon(
                                                      Icons.bluetooth_connected_rounded,
                                                      color: controller.devices[index].device.address == controller.macAddressConnected.value ? Colors.blue : null,
                                                    ),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Obx(
                          () => controller.macAddressConnected.value.isNotEmpty
                              ? ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    "Continue",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightblue),
                                  ))
                              : const SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
