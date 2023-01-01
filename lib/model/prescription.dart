
class PrescriptionModel
{
  late String doctor_name;
  late String created_at;
  late String details;



  PrescriptionModel({
    required this.created_at,
    required this.doctor_name,
    required  this.details,
  });
  PrescriptionModel.fromJson(Map<String,dynamic>json)
  {
    created_at=json['created_at'];
    doctor_name=json['doctor_name'];
    details=json['details'];
  }

  Map <String,dynamic> toMap()
  {
    return
      {
        'doctor_name':doctor_name,
        'created_at':created_at,
        'details':details,
      };
  }
}