
// ignore: camel_case_types
class UserModel {
  String id;
  String name;
  String email;
  

  UserModel({
    required this.id,
    required this.name,
    required this.email,
 
  });

  // from JSON (Firestore) to Dart
   UserModel.fromJson(Map<String, dynamic> json):this(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    
    );
  

  // from Dart to JSON (Firestore)
 
  Map<String, dynamic> toJson()=> {
      'id': id,
      'name': name,
      'email': email,
    };
  }
