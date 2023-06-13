import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  final String mongoUrl;
  final String dbName;

  MongoDBService({required this.mongoUrl, required this.dbName});

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await Db.create(mongoUrl);
    final collection = db.collection('$dbName.users');
    await db.open();
    final users = await collection.find().toList();
    await db.close();
    return users;
  }

  Future<List<Map<String, dynamic>>> findUserByEmailAndPassword(String email, String password) async {
    final db = await Db.create(mongoUrl);
    final collection = db.collection('$dbName.users');
    await db.open();

    final users = await collection
        .find(where.eq('email', email).eq('password', password))
        .toList();

    await db.close();
    return users;
  }
}
