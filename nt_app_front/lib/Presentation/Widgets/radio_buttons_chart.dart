import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:nt_app_front/Presentation/Screens/Hompage/controller.dart';

class RadioSelection extends StatelessWidget {
  const RadioSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageViewController>();
    return Container(
        child: Column(
      children: controller.chartTypes
          .map((e) => Obx(
                () => RadioButton(
                    description: e,
                    value: e,
                    groupValue: controller.selectedChart.value,
                    onChanged: (value) {
                      controller.updateSelectedChart(value.toString());
                    },
                    activeColor: Colors.red),
              ))
          .toList(),
    ));
  }
}
