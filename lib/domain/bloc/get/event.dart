import 'package:equatable/equatable.dart';
import 'package:manabie_todoapp/data/data.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class TodoFetchEvent extends TodoEvent {
  TodoFetchEvent({required this.status});
  final String status;
}

class TodoUpdateEvent extends TodoEvent {
  TodoUpdateEvent({
    required this.todo,
    required this.indexPage,
  });
  final Todo? todo;
  final int indexPage;
}
