part of'../data.dart';

class ListModel {
  final int? id;
  final String? activity;
  final String? date;
  final String? time;

  ListModel({this.id, this.activity, this.date, this.time});

  factory ListModel.fromMap(Map<String, dynamic> data) =>
    ListModel(id: data['id'], activity: data['activity'], date: data['date'], time: data['time']);

  Map<String, dynamic> toMap() {
    return {'id': id, 'activity': activity, 'date': date, 'time': time};
  }
}