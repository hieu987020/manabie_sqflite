import 'package:equatable/equatable.dart';

final String tableTodos = 'todos';

class TodoFields {
  static final List<String> values = [
    /// Add all fields
    id, name, detail, status, date
  ];

  static final String id = 'id';
  static final String name = 'name';
  static final String detail = 'detail';
  static final String status = 'status';
  static final String date = 'date';
}

class Todo extends Equatable {
  final int? id;
  final String name;
  final String detail;
  final String status;
  final String date;
  Todo({
    this.id,
    required this.name,
    required this.detail,
    this.status = "Incomplete",
    required this.date,
  });

  Todo.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        detail = res["detail"],
        status = res["status"],
        date = res["date"];

  Map<String, Object?> toMap() {
    return {'name': name, 'detail': detail, 'status': status, 'date': date};
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      detail,
      status,
      date,
    ];
  }

  Todo copyWith({
    int? id,
    String? name,
    String? detail,
    String? status,
    String? date,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }
}
