import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prescriotion/module/doctor/cubit/doctor_cubit.dart';
import '../../../shared/component/widgets/bottun.dart';
import '../../../shared/theme/size_config.dart';
import '../../../shared/theme/theme.dart';

class OldPrescriptionScreen extends StatelessWidget {

  final String patientEmail;

  OldPrescriptionScreen({Key? key, required this.patientEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) =>
      DoctorCubit()
        ..getOldPrescription(patientEmail: patientEmail),
      child: BlocConsumer<DoctorCubit, DoctorState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {


          oldP(int index) {
              return SizedBox(
                width: SizeConfig.screenWidth!,
                height: 65,
                child: myButton(
                  onPressed: () {
                    // DoctorCubit.get(context).getOldPrescription(patientEmail: patientEmail);
                  },
                  color: Colors.white,
                  elevation: 4,
                  circleRadius: SizeConfig.defaultSize! * 10,
                  inButtonSpace: SizeConfig.defaultSize! * 1,
                  child: Text(
                    "${DoctorCubit.get(context).oldPrescriptions[index]['doctor_name']+DoctorCubit.get(context).oldPrescriptions[index]['created_at']}",
                    // 'next',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }


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
                    SvgPicture.asset('assets/images/patient.svg'),
                    SizedBox(height: SizeConfig.defaultSize! * 4),
                          for(int i= 0 ; i<DoctorCubit.get(context).oldPrescriptions.length;i++)
                            Column(
                              children: [
                                oldP(i),
                                SizedBox(height: SizeConfig.defaultSize! * 2),

                              ],
                            ),
                    ],
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
