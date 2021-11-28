import 'package:equatable/equatable.dart';
import 'package:manabie_todoapp/data/model/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object?> get props => [];
}

class TodoInitialState extends TodoState {}

class TodoFetchSuccess extends TodoState {
  TodoFetchSuccess(this.todos);
  final List<Todo> todos;
}

class TodoUpdateFailure extends TodoState {}

class TodoFetchError extends TodoState {}

class TodoLoading extends TodoState {}
