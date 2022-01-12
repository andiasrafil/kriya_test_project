import 'package:equatable/equatable.dart';

class HomeData extends Equatable {
  HomeData({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;
  int qty = 0;

  @override
  List<Object?> get props => [userId, id, title, completed, qty];
}
