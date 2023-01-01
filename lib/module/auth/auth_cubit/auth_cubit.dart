import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String role,
    String? specialty,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        password: password,
        gender: gender,
        role: role,
        uId: value.user!.uid,
        specialty: specialty,
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      RegisterErrorState(error.toString());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String role,
    String? specialty,
    String? uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      gender: gender,
      uId: uId!,
      role: role,
      specialty: specialty,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      // getUser(uid:value.user!.uid);
      getUserData(email: value.user!.email!);

      // isDoctor();
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }


  getUserData({required String email}) async {
    late String role;

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      // You can then retrieve the value from the Map like this:
      emit(LoginSuccessState(
          uID: data['uId'],
          role: data['role'],
          email: data['email'],
          name: data['name']));
    }



  }
}