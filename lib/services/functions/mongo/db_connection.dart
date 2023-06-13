import 'package:app_cats/services/models/db_user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDBService {
  final String mongoUrl;
  final String dbName;

  MongoDBService({required this.mongoUrl, required this.dbName});

  Future<UserMongo>findUserByEmailAndPassword(String email, String password) async {
    final db = await Db.create(mongoUrl);
    final collection = db.collection(dbName);
    await db.open();

    final mongoUserList = await collection.find(
      where
        .eq('email', email)
        .eq('password', password)
    ).toList();
    List<UserMongo> users = [];
    for (var item in mongoUserList) {
      final user = UserMongo(
        item['email'].toString(),
        item['imageUrl'].toString(),
        item['name'].toString(),
        item['password'].toString(),
        item['surname'].toString(),
      );
      users.add(user);
    }
    await db.close();
    return users.isNotEmpty ? users[0] : UserMongo(email, '', '', '', '');
  }
}
