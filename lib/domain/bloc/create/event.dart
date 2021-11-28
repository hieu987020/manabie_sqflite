import 'package:equatable/equatable.dart';

import 'package:manabie_todoapp/data/data.dart';

abstract class TodoCreateEvent extends Equatable {
  const TodoCreateEvent();
  @override
  List<Object?> get props => [];
}

class TodoCreateSubmitEvent extends TodoCreateEvent {
  TodoCreateSubmitEvent({
    required this.todo,
  });
  final Todo todo;
}
