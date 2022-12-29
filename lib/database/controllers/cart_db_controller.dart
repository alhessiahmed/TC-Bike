import 'package:tcbike/pref/shared_pref_controller.dart';
import '../db_controller.dart';
import '../db_operations.dart';
import '../../model/cart.dart';
import 'package:sqflite/sqflite.dart';

class CartDbController implements DbOperations<Cart> {
  final Database _database = DbController().database;

  @override
  Future<int> create(Cart cart) {
    return _database.insert(Cart.tableName, cart.toMap());
  }

  @override
  Future<List<Cart>> read() async {
    List<Map<String, dynamic>> rowMaps = await _database.query(
      Cart.tableName,
      where: 'user_id = ?',
      whereArgs: [SharedPrefController().getByKey<int>(key: UserInfo.id.name)],
    );
    return rowMaps.map<Cart>((rowMap) => Cart.fromMap(rowMap)).toList();
  }

  @override
  Future<bool> update(Cart cart) async {
    int numberOfUpdatedRows = await _database.update(
      Cart.tableName,
      cart.toMap(),
      where: 'id = ? AND user_id = ?',
      whereArgs: [
        cart.id,
        SharedPrefController().getByKey<int>(key: UserInfo.id.name),
      ],
    );
    // print(numberOfUpdatedRows);
    return numberOfUpdatedRows == 1;
  }

  @override
  Future<bool> delete(int id) async {
    int numberOfDeletedRows = await _database.delete(
      Cart.tableName,
      where: 'id = ? AND user_id = ?',
      whereArgs: [
        id,
        SharedPrefController().getByKey<int>(key: UserInfo.id.name),
      ],
    );
    return numberOfDeletedRows == 1;
  }

  Future<bool> clear() async {
    int numberOfDeletedRows = await _database.delete(Cart.tableName);
    return numberOfDeletedRows >= 1;
  }

  Future<bool> changeQuantity(int itemId, int newQuantity) async {
    int userId = SharedPrefController().getByKey(key: UserInfo.id.name);
    int countOfUpdatedRows = await _database.rawUpdate(
        'UPDATE ${Cart.tableName} SET quantity = $newQuantity WHERE id = $itemId AND user_id = $userId');
    return countOfUpdatedRows > 0;
  }
}
