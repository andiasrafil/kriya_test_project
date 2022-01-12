import 'package:kriya_test_project/domain/entities/home_data.dart';

class HomeDataModel extends HomeData {
  HomeDataModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  }) : super(userId: userId, id: id, title: title, completed: completed);

  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );
}
