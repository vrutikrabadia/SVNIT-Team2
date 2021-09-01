import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:nt_app_front/Presentation/Screens/Hompage/controller.dart';

class RadioSelectionTime extends StatelessWidget {
  const RadioSelectionTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageViewController>();
    return Container(
        child: Column(
      children: controller.timeTypes
          .map((e) => Obx(
                () => RadioButton(
                    description: e.toString() + "Days",
                    value: e,
                    groupValue: controller.selectedTime.value,
                    onChanged: (value) async {
                      controller.updateSelectedTime(value as int);
                      await controller.getChartData();
                    },
                    activeColor: Colors.red),
              ))
          .toList(),
    ));
  }
}
