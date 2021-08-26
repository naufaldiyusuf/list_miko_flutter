part of '../data.dart';

class ListDao {
  final provider = ListDB.provider;

  Future<int> insert(ListModel model) async {
    final db = await provider.database;

    return await db!.transaction((txn) async {
      return await txn.insert("list", model.toMap());
    });
  }

  Future<List<ListModel?>> getList() async {
    final db = await provider.database;

    return await db!.transaction((trx) async {
      var result = await trx.rawQuery("SELECT * FROM list");

      List<ListModel> requests = [];

      if (result.isNotEmpty) {
        result.map((e) => requests.add(ListModel.fromMap(e))).toList();
      }

      return requests;
    });
  }
  
  Future<int> delete(int? id) async {
    final db = await provider.database;
    return await db!.transaction((trx) async {
      return await trx.rawDelete("DELETE FROM list WHERE id = $id");
    });
  }
}