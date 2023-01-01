import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prescriotion/module/doctor/doctor_screen.dart';
import 'package:prescriotion/module/doctor/prescription/old_prescription.dart';
import 'package:prescriotion/shared/component/widgets/bottun.dart';
import 'package:prescriotion/shared/theme/size_config.dart';
import '../shared/component/navigator.dart';
import '../shared/component/widgets/form_field.dart';
import '../shared/theme/theme.dart';

class PatientHomeScreen extends StatelessWidget {



  final String patientName ;
  final String patientEmail;

  PatientHomeScreen({super.key, required this.patientName,required this.patientEmail});

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
        child: Form(
          key: formKey,
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
                      SvgPicture.asset('assets/images/patient.svg'),
                      SizedBox(height: SizeConfig.defaultSize! * 2),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize! * 5),
                        child: Column(
                          children: [
                            myFormField(
                              type: TextInputType.text,
                              label: 'Patient Name',
                              isClickable: false,
                              hint: patientName,
                              prefixIcon: Icons.numbers,
                              isVaildator: true,
                            ),
                          ],
                        ),
                      ), //emailAndPassword
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 1),
                        child: SizedBox(
                          width: double.infinity,
                          height: 65,
                          child: myButton(
                            onPressed: () {
                              navigateTo(context, OldPrescriptionScreen(patientEmail: patientEmail));
                            },
                            color: defaultBlue ,
                            circleRadius: SizeConfig.defaultSize! * 10,
                            inButtonSpace: SizeConfig.defaultSize! * 8.5,
                            child: const Text(
                              "ٍShow Prescription",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 1),
                        child: SizedBox(
                          width: double.infinity,
                          height: 65,
                          child: myButton(
                            onPressed: () {
                            },
                            color: defaultBlue ,
                            circleRadius: SizeConfig.defaultSize! * 10,
                            inButtonSpace: SizeConfig.defaultSize! * 10,
                            child: const Text(
                              "ٍShow Rays",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
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
          ),
        ));
  }
}


