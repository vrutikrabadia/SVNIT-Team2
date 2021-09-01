import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_front/Presentation/Screens/Hompage/controller.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageViewController>();
    return Obx(
      () => controller.isCompany.value == true
          ? (controller.c?.companyName == null
              ? Text('no such company')
              : Container(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          controller.c!.companyName!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        controller.c!.description.toString(),
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ))
          : Text(
              'No Company Selected',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
    );
  }
}
