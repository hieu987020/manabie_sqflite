import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/domain/bloc/blocs.dart';

void main() {
  List<Todo> todos = [];
  Todo todo = Todo(
    name: 'Todo A',
    detail: 'Detail A',
    date: DateTime.now().toIso8601String(),
  );
  // Todo todoB = Todo(
  //   name: 'Todo B',
  //   detail: 'Detail B',
  //   status: 'Complete',
  //   date: DateTime.now().toIso8601String(),
  // );
  todos.add(todo);
  // todos.add(todoB);

  group('TodoCreate Bloc', () {
    blocTest<TodoCreateBloc, TodoCreateState>(
      'emits [] when nothing is added',
      build: () => TodoCreateBloc(),
      expect: () => [],
    );
    blocTest<TodoCreateBloc, TodoCreateState>(
      'emits [loading,error] when create Todo',
      build: () => TodoCreateBloc(),
      act: (bloc) => bloc.add(TodoCreateSubmitEvent(todo: todo)),
      expect: () => [TodoCreateLoading(), TodoCreateError()],
      // expect: () => [],
    );
    blocTest<TodoCreateBloc, TodoCreateState>(
      'emits [error] when Todo Create is loading',
      build: () => TodoCreateBloc(),
      act: (bloc) => bloc.add(TodoCreateSubmitEvent(todo: todo)),
      skip: 1,
      expect: () => [TodoCreateError()],
      // expect: () => [],
    );
  });
}
