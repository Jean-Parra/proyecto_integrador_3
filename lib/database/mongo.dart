import 'package:mongo_dart/mongo_dart.dart';

class MongoDB {
  late final Db db;


  Future<void> connect() async {
    db = await Db.create("mongodb+srv://usuario_upb:contrasena_upb@cluster0.ya3bz0q.mongodb.net/proyecto?retryWrites=true&w=majority");
    await db.open();
  }

  Future<void> insert(String collection, Map<String, dynamic> data) async {
    await db.collection(collection).insert(data);
  }

  Future<List<Map<String, dynamic>>> find(String collection) async {
    var result = await db.collection(collection).find().toList();
    return result;
  }

  Future<void> update(String collection, Map<String, dynamic> selector,
      Map<String, dynamic> data) async {
    await db.collection(collection).update(selector, data);
  }

  Future<void> delete(String collection, Map<String, dynamic> data) async {
    await db.collection(collection).remove(data);
  }

  Future<void> close() async {
    await db.close();
  }
}
