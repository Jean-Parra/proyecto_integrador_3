import 'package:mongo_dart/mongo_dart.dart';
import '../user.dart';

class MongoDB {
  late Db db;

  MongoDB() {
    connect();
  }

  Future<void> connect() async {
    db = await Db.create(
        "mongodb+srv://usuario_upb:contrasena_upb@cluster0.ya3bz0q.mongodb.net/proyecto?retryWrites=true&w=majority");
    await db.open();
  }

  Future<void> insert(String collection, Map<String, dynamic> data) async {
    await db.collection(collection).insert(data);
  }

  Future<List<Map<String, dynamic>>> find(
      String collection, Map<String, String> map) async {
    var result = await db.collection(collection).find().toList();
    return result;
  }

  Future<void> update(String collection, Map<String, dynamic> selector,
      Map<String, dynamic> data) async {
    await db.collection(collection).update(selector, data);
  }

  Future<bool> delete(String collection, Map<String, String> data) async {
    try {
      await db.collection(collection).deleteMany(data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> close() async {
    await db.close();
  }

  Future<User?> login(String email, String password) async {
    final user = await db.collection("usuarios").findOne({"correo": email});
    if (user != null && user['contrasena'] == password) {
      return User(
        name: user['nombre'],
        lastname: user["apellido"],
        phone: user["telefono"],
        email: user['correo'],
        password: user["contrasena"],
        role: user['tipo'],
      );
    } else {
      return null;
    }
  }

  Future<void> updatePassword(String email, String newPassword) async {
    await db.collection("usuarios").update(
      {"correo": email},
      {
        r"$set": {"contrasena": newPassword},
      },
    );
  }

  Future<User?> getUserByEmail(String email) async {
    final user = await db.collection("usuarios").findOne({"correo": email});
    if (user != null) {
      return User(
        name: user['nombre'],
        lastname: user["apellido"],
        phone: user["telefono"],
        email: user['correo'],
        password: user["contrasena"],
        role: user['role'],
      );
    } else {
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    final users = await db.collection("usuarios").find().toList();
    return users
        .map((user) => User(
              name: user['nombre'],
              lastname: user["apellido"],
              phone: user["telefono"],
              email: user['correo'],
              password: user["contrasena"],
              role: user['role'],
            ))
        .toList();
  }
}
