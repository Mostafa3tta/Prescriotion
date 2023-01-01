import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prescriotion/module/doctor/prescription/old_prescription.dart';
import 'package:prescriotion/shared/component/navigator.dart';
import 'package:prescriotion/shared/component/widgets/form_field.dart';
import 'package:prescriotion/shared/theme/size_config.dart';

import '../../shared/component/widgets/bottun.dart';
import '../../shared/theme/theme.dart';
import 'prescription/add_prescription.dart';

class DoctorScreen extends StatelessWidget {
  final patientName;
  final patientEmail;

  DoctorScreen({Key? key, this.patientName, this.patientEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    TextEditingController patientIDController = TextEditingController(text: "patient Name : $patientName");

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          width: double.infinity,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.defaultSize! * 2),
                SvgPicture.asset('assets/images/doctor.svg'),
                SizedBox(height: SizeConfig.defaultSize! * 2),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.defaultSize! * 5),
                  child: Column(
                    children: [
                      myFormField(
                        controller: patientIDController,
                        type: TextInputType.text,
                        label: 'Patient ID',
                        hint: 'Patient ID',
                        prefixIcon: Icons.numbers,
                        isVaildator: true,
                        isClickable: false,
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                        child: SizedBox(
                          width: SizeConfig.screenWidth!/2,
                          height: 65,
                          child: myButton(
                            onPressed: () {
                              navigateTo(context, AddPrescriptionScreen(patientEmail:patientEmail));
                            },
                            color: defaultBlue ,
                            circleRadius: SizeConfig.defaultSize! * 10,
                            inButtonSpace: SizeConfig.defaultSize!*1.1,
                            child: const Text(
                              "Add Prescription",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                        child: SizedBox(
                          width: SizeConfig.screenWidth!/2,
                          height: 65,
                          child: myButton(
                            onPressed: () {
                              navigateTo(context,OldPrescriptionScreen(patientEmail:patientEmail));

                            },
                            color: defaultBlue ,
                            circleRadius: SizeConfig.defaultSize! * 10,
                            inButtonSpace: SizeConfig.defaultSize!*1.1,
                            child: const Text(
                              "Old Prescription",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                        child: SizedBox(
                          width: SizeConfig.screenWidth!/2,
                          height: 65,
                          child: myButton(
                            onPressed: () {
                            },
                            color: defaultBlue ,
                            circleRadius: SizeConfig.defaultSize! * 10,
                            inButtonSpace: SizeConfig.defaultSize!*1.1,
                            child: const Text(
                              "Add analysis",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                        child: SizedBox(
                          width: SizeConfig.screenWidth!/2,
                          height: 65,
                          child: myButton(
                            onPressed: () {
                            },
                            color: defaultBlue ,
                            circleRadius: SizeConfig.defaultSize! * 10,
                            inButtonSpace: SizeConfig.defaultSize!*1.1,
                            child: const Text(
                              "Old analysis",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                        child: SizedBox(
                          width: SizeConfig.screenWidth!/2,
                          height: 65,
                          child: myButton(
                            onPressed: () {
                            },
                            color: defaultBlue ,
                            circleRadius: SizeConfig.defaultSize! * 10,
                            inButtonSpace: SizeConfig.defaultSize!*1.1,
                            child: const Text(
                              "Add rays",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                        child: SizedBox(
                          width: SizeConfig.screenWidth!/2,
                          height: 65,
                          child: myButton(
                            onPressed: () {
                            },
                            color: defaultBlue ,
                            circleRadius: SizeConfig.defaultSize! * 10,
                            inButtonSpace: SizeConfig.defaultSize!*2,
                            child: const Text(
                              "Old rays",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                  child: SizedBox(
                    width: SizeConfig.screenWidth!/2,
                    height: 65,
                    child: myButton(
                      onPressed: () {
                      },
                      color: defaultAmber,
                      circleRadius: SizeConfig.defaultSize! * 10,
                      inButtonSpace: SizeConfig.defaultSize!*6.7,
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
