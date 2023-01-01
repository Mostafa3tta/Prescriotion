import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prescriotion/module/doctor/cubit/doctor_cubit.dart';
import 'package:prescriotion/module/doctor/doctor_screen.dart';
import 'package:prescriotion/shared/component/widgets/bottun.dart';
import 'package:prescriotion/shared/theme/size_config.dart';
import '../shared/component/navigator.dart';
import '../shared/component/widgets/form_field.dart';
import '../shared/component/widgets/toast_msg.dart';
import '../shared/theme/theme.dart';

class DoctorHomeScreen extends StatelessWidget {

  TextEditingController patientEmailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) => DoctorCubit(),
      child: BlocConsumer<DoctorCubit, DoctorState>(
        listener: (context, state) {
          // TODO: implement listener

          if(state is EnterPatientSuccessState){
            navigateTo(context, DoctorScreen(patientName: state.patientName, patientEmail:state.patientEmail,));
          }

          if(state is EnterPatientErrorState){
            defaultToastMsg(
              Message: state.error,
              state: ToastStates.ERROR,
            );

          }

        },
        builder: (context, state) {
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
                            SvgPicture.asset('assets/images/doctor.svg'),
                            SizedBox(height: SizeConfig.defaultSize! * 2),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.defaultSize! * 5),
                              child: Column(
                                children: [
                                  myFormField(
                                    controller: patientEmailController,
                                    type: TextInputType.emailAddress,
                                    label: 'Enter Patient Email',
                                    hint: 'Enter Patient Email',
                                    prefixIcon: Icons.person,
                                    isVaildator: true,
                                  ),
                                ],
                              ),
                            ), //emailAndPassword
                            Padding(
                              padding: EdgeInsets.all(
                                  SizeConfig.defaultSize! * 1),
                              child: SizedBox(
                                width: double.infinity,
                                height: 65,
                                child: myButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      DoctorCubit.get(context).getPatientData(email: patientEmailController.text);
                                    }
                                  },
                                  color: defaultBlue,
                                  circleRadius: SizeConfig.defaultSize! * 10,
                                  inButtonSpace: SizeConfig.defaultSize! * 13,
                                  child: const Text(
                                    "Next",
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
        },
      ),
    );
  }
}


