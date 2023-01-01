import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prescriotion/layout/doctor_home_screen.dart';
import 'package:prescriotion/layout/patient_home_screen.dart';
import 'package:prescriotion/model/user_model.dart';
import 'package:prescriotion/module/auth/auth_cubit/auth_cubit.dart';
import 'package:prescriotion/shared/component/widgets/form_field.dart';
import '../../../shared/component/navigator.dart';
import '../../../shared/component/widgets/bottun.dart';
import '../../../shared/component/widgets/toast_msg.dart';
import '../../../shared/theme/size_config.dart';
import '../../../shared/theme/theme.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            defaultToastMsg(
              Message: "Welcome back",
              state: ToastStates.SUCCESS,
            );

            if(state.role=='doctor'){
              navigateAndFinish(context, DoctorHomeScreen());
            }
            else if(state.role=='patient'){
              navigateAndFinish(context, PatientHomeScreen(patientName: state.name,patientEmail:state.email));
            }
            // else if(state.role=='doctor'){}

          }
          if (state is LoginErrorState) {
            defaultToastMsg(
              Message: state.onError,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/logo.svg'),
                      SizedBox(height: SizeConfig.defaultSize! * 2),
                      const Text(
                        'The Prescriotion',
                        style: TextStyle(
                          fontFamily: 'Agency FB',
                          fontSize: 38,
                          color: Color(0x99000000),
                          letterSpacing: 0.35625,
                          fontWeight: FontWeight.w700,
                          height: 0.631578947368421,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                        softWrap: false,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize! * 8),
                        child: Column(
                          children: [
                            myFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: 'email',
                              hint: 'abc.gmail.com',
                              prefixIcon: Icons.email,
                              isVaildator: true,
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 3,
                            ),
                            myFormField(
                                controller: passwordController,
                                obscureText: true,
                                type: TextInputType.visiblePassword,
                                label: 'Password',
                                hint: 'Your Password',
                                prefixIcon: Icons.lock,
                                isVaildator: true,
                                suffixIcon: Icons.remove_red_eye),
                          ],
                        ),
                      ), //emailAndPassword
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 1),
                        child: SizedBox(
                          width: double.infinity,
                          height: 65,
                          child: state is LoginLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : myButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      print(emailController.text);
                                      AuthCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  color: defaultBlue,
                                  circleRadius: SizeConfig.defaultSize! * 10,
                                  inButtonSpace: SizeConfig.defaultSize! * 12,
                                  child: const Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't Have Account ?",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: const Text("Register Now ",
                                style: TextStyle(color: Color(0xff5669FF))),
                          ),
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
