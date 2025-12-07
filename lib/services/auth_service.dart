import '../database/database_helper.dart';
import '../models/user_model.dart';


class AuthService {
  final db = DatabaseHelper();


  Future<String?> register(UserModel user, String confirmPassword) async {
    if (user.email.isEmpty || user.password.isEmpty) return 'Fields cannot be empty';
    if (user.password != confirmPassword) return 'Password doesn\'t match';


    final existing = await db.getUserByEmail(user.email);
    if (existing != null) return 'Email already registered';


    await db.insertUser(user.toMap());
    return null; // success
  }


  Future<UserModel?> login(String email, String password) async {
    final record = await db.getUserByEmail(email);
    if (record == null) return null;
    if (record['password'] == password) return UserModel.fromMap(record);
    return null;
  }
}