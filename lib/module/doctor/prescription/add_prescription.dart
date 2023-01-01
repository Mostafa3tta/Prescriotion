import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prescriotion/module/doctor/cubit/doctor_cubit.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:prescriotion/module/doctor/doctor_screen.dart';
import 'package:prescriotion/shared/component/navigator.dart';
import '../../../shared/component/widgets/bottun.dart';
import '../../../shared/component/widgets/form_field.dart';
import '../../../shared/component/widgets/toast_msg.dart';
import '../../../shared/theme/size_config.dart';
import '../../../shared/theme/theme.dart';

class AddPrescriptionScreen extends StatelessWidget {

  TextEditingController doctorNameController = TextEditingController();
  TextEditingController prescriptionDateController = TextEditingController(text: DateFormat('dd-MMM-y-H:m').format(DateTime.now()));
  TextEditingController prescriptionDetailsController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final String patientEmail;
  AddPrescriptionScreen({Key? key, required this.patientEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCubit(),
      child: BlocConsumer<DoctorCubit, DoctorState>(
        listener: (context, state) {

          if(state is EnterPrescriptionSuccessState ){
              defaultToastMsg(
                Message: "Add Prescription Sucess ",
                state: ToastStates.SUCCESS,
              );
              Navigator.of(context).pop();
          }
          if(state is EnterPrescriptionErrorState ){
            defaultToastMsg(
              Message: "Error When Prescription ",
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
                                controller: doctorNameController,
                                type: TextInputType.name,
                                label: 'Doctor Name',
                                hint: 'Enter your name Doctor',
                                prefixIcon: Icons.person,
                                isVaildator: true,
                              ),
                              SizedBox(
                                height: SizeConfig.defaultSize! * 3,
                              ),
                              myFormField(
                                controller: prescriptionDateController,
                                isClickable: false,
                                type: TextInputType.datetime,
                                label: 'prescriptionDate',
                                hint: 'prescriptionDate',
                                prefixIcon: Icons.date_range,
                                isVaildator: true,
                              ),
                              SizedBox(
                                height: SizeConfig.defaultSize! * 3,
                              ),
                              myFormField(
                                controller: prescriptionDetailsController,
                                type: TextInputType.multiline,
                                maxLength: null,
                                minLines: 1,
                                // expands: true,
                                label: 'Prescription Details',
                                hint: 'Enter Prescription Details',
                                isVaildator: true,
                                FormFieldHeight: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight! / 5),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.defaultSize! * 1),
                          child: SizedBox(
                            width: double.infinity,
                            height: 65,
                            child: myButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  DoctorCubit.get(context).addPrescription(
                                    doctor_name: doctorNameController.text,
                                    created_at: prescriptionDateController.text,
                                    details: prescriptionDetailsController.text,
                                    patientEmail: patientEmail,
                                  );
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
