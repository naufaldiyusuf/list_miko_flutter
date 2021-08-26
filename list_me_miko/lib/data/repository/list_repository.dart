part of '../data.dart';

class ListRepository {
  final listdao = ListDao();

  Future insert(ListModel model) =>listdao.insert(model);

  Future getList({int? id}) => listdao.getList();

  Future delete(int? id) => listdao.delete(id);
}