class UserModel {
  final int? id;
  final String email;
  final String password;
  final String? name;


  UserModel({this.id, required this.email, required this.password, this.name});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
    };
  }


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String?,
    );
  }
}