part of 'doctor_cubit.dart';

@immutable
abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class EnterPatientLoadingState extends DoctorState {}
class EnterPatientSuccessState extends DoctorState {

  final String patientName;
  final String patientEmail;

  EnterPatientSuccessState({required this.patientName,required this.patientEmail});

}
class EnterPatientErrorState extends DoctorState {

  final String error;

  EnterPatientErrorState(this.error);

}

class EnterPrescriptionLoadingState extends DoctorState {}
class EnterPrescriptionSuccessState extends DoctorState {}
class EnterPrescriptionErrorState extends DoctorState {}


class GetOldPrescriptionLoadingState extends DoctorState {}
class GetOldPrescriptionSuccessState extends DoctorState {}
class GetOldPrescriptionErrorState extends DoctorState {}
