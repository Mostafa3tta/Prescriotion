import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prescriotion/module/auth/auth_cubit/auth_cubit.dart';
import 'package:prescriotion/module/auth/login/login_screen.dart';
import 'package:prescriotion/shared/component/navigator.dart';
import 'package:prescriotion/shared/component/widgets/form_field.dart';
import 'package:prescriotion/shared/component/widgets/toast_msg.dart';
import '../../../shared/component/widgets/bottun.dart';
import '../../../shared/theme/size_config.dart';
import '../../../shared/theme/theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController specializationController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  UserType _userType = UserType.patient;
  Gender _userGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var cubit = AuthCubit.get(context);

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            defaultToastMsg(
              Message: state.onEror,
              state: ToastStates.ERROR,
            );
          }
          if (state is CreateUserSuccessState) {
            defaultToastMsg(
              Message: "Create User Success",
              state: ToastStates.SUCCESS,
            );
            navigateAndFinish(context, LoginScreen());
          }
          if (state is CreateUserErrorState) {
            defaultToastMsg(
              Message: "Create User Failed",
              state: ToastStates.WARNING,
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
                      SizedBox(height: SizeConfig.defaultSize! * 2),
                      SvgPicture.asset('assets/images/signup.svg'),
                      SizedBox(height: SizeConfig.defaultSize! * 2),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.defaultSize! * 5),
                        child: Column(
                          children: [
                            myFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              label: 'name',
                              hint: 'Your name',
                              prefixIcon: Icons.email,
                              isVaildator: true,
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 3,
                            ),
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
                            SizedBox(
                              height: SizeConfig.defaultSize! * 3,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your Gender',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                ListTile(
                                  title: const Text('Male'),
                                  leading: Radio(
                                    value: Gender.male,
                                    groupValue: _userGender,
                                    onChanged: (Gender? value) {
                                      setState(() {
                                        _userGender = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Female'),
                                  leading: Radio(
                                    value: Gender.female,
                                    groupValue: _userGender,
                                    onChanged: (Gender? value) {
                                      setState(() {
                                        _userGender = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 3,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('You are a',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                ListTile(
                                  title: const Text('Patient/pharmacist'),
                                  leading: Radio(
                                    value: UserType.patient,
                                    groupValue: _userType,
                                    onChanged: (UserType? value) {
                                      setState(() {
                                        _userType = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Doctor'),
                                  leading: Radio(
                                    value: UserType.doctor,
                                    groupValue: _userType,
                                    onChanged: (UserType? value) {
                                      setState(() {
                                        _userType = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Analysis'),
                                  leading: Radio(
                                    value: UserType.analysis,
                                    groupValue: _userType,
                                    onChanged: (UserType? value) {
                                      setState(() {
                                        _userType = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 3,
                            ),
                            _userType.name == 'doctor'
                                ? myFormField(
                                    controller: specializationController,
                                    type: TextInputType.name,
                                    label: 'specialization',
                                    hint: 'Your specialization',
                                    prefixIcon: Icons.person_pin,
                                    isVaildator: true,
                                  )
                                : SizedBox(
                                    height: SizeConfig.defaultSize! * 3,
                                  ),
                          ],
                        ),
                      ),
                      //emailAndPassword
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.defaultSize! * 1),
                        child: SizedBox(
                          width: double.infinity,
                          height: 65,
                          child: state is RegisterLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : myButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        gender: _userGender.name,
                                        role: _userType.name,
                                        specialty: specializationController.text,
                                      );
                                    }
                                  },
                                  color: defaultBlue,
                                  circleRadius: SizeConfig.defaultSize! * 10,
                                  inButtonSpace: SizeConfig.defaultSize! * 13,
                                  child: const Text(
                                    "SIGN UP",
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
                            "Already Have Account ?",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, LoginScreen());
                            },
                            child: const Text("Sign in",
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

enum UserType { doctor, patient, analysis }

enum Gender { male, female }
