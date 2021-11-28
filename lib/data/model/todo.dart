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

class Todo {
  int id = 0;
  String name;
  String detail;
  String status;
  String date;
  Todo({
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
}
