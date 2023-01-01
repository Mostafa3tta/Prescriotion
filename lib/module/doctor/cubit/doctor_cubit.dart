import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/prescription.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  static DoctorCubit get(context) => BlocProvider.of(context);

  getPatientData({required String email}) async {
    emit(EnterPatientLoadingState());

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      // You can then retrieve the value from the Map like this:
      // data['uId'];
      print(data);
      emit(EnterPatientSuccessState(
        patientEmail: data['email'],
        patientName: data['name'],
      ));
    } else {
      emit(EnterPatientErrorState('Patient Not Found'));
    }
  }

  void addPrescription({
    required String doctor_name,
    required String created_at,
    required String details,
    required String patientEmail,
  }) {
    emit(EnterPrescriptionLoadingState());

    PrescriptionModel model = PrescriptionModel(
      doctor_name: doctor_name,
      created_at: created_at,
      details: details,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(patientEmail)
        .collection('prescription')
        .doc("${doctor_name+ created_at}")
        .set(model.toMap())
        .then((value) {
      emit(EnterPrescriptionSuccessState());
    }).catchError((error) {
      emit(EnterPrescriptionErrorState());
    });
  }


List oldPrescriptions = [];

  getOldPrescription({
    required String patientEmail,
  }) async {
    emit(GetOldPrescriptionLoadingState());
    oldPrescriptions.clear();
    CollectionReference oldPrescriptionRef = FirebaseFirestore.instance.collection('users').doc(patientEmail).collection('prescription');

     await oldPrescriptionRef.get().then((value){
       List<QueryDocumentSnapshot> OldPrescriptionDocsList =  value.docs;
       for(var item in OldPrescriptionDocsList){
         oldPrescriptions.add(item.data());
       }
      emit(GetOldPrescriptionSuccessState());
     }).catchError((onError){
       emit(GetOldPrescriptionErrorState());
     });

    return oldPrescriptions;

  }
}
