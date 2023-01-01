
class UserModel
{
  late String name;
  late String email;
  late String gender;
  late String uId;
  late String role;
  late String ? specialty;


  UserModel({
    required this.email,
    required this.name,
    required  this.gender,
    required this.uId,
    required this.role,
    this.specialty,
  });
  UserModel.fromJson(Map<String,dynamic>json)
  {
    email=json['email'];
    name=json['name'];
    gender=json['gender'];
    uId=json['uId'];
    role =json['role'];
    specialty=json['specialty'];
  }

  Map <String,dynamic> toMap()
  {
    return
      {
        'name':name,
        'email':email,
        'gender':gender,
        'uId':uId,
        'role': role,
        'specialty':specialty,

      };
  }
}