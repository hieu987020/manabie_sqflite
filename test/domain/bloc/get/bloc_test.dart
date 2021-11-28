import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/domain/domains.dart';

Future<void> main() async {
  List<Todo> todos = [];
  Todo todo = Todo(
    name: 'Todo A',
    detail: 'Detail A',
    date: DateTime.now().toIso8601String(),
  );
  todos.add(todo);
  group('Todo Bloc', () {
    late TodoBloc todoBloc;
    setUp(() {
      todoBloc = TodoBloc();
    });
    test('initial state is TodoInitialState()', () {
      expect(todoBloc.state, TodoInitialState());
    });

    blocTest<TodoBloc, TodoState>(
      'emits [] when nothing is added',
      build: () => TodoBloc(),
      expect: () => [],
    );
    blocTest<TodoBloc, TodoState>(
      'emits [loading,error] when All Todo is fetched',
      build: () => TodoBloc(),
      act: (bloc) => bloc.add(TodoFetchEvent(status: '')),
      expect: () => [TodoLoading(), TodoFetchError()],
      // expect: () => [TodoLoading(), TodoFetchSuccess(todos)],
    );
    blocTest<TodoBloc, TodoState>(
      'emits [error] when Todo is loading',
      build: () => TodoBloc(),
      act: (bloc) => bloc.add(TodoFetchEvent(status: '')),
      skip: 1,
      expect: () => [TodoFetchError()],
    );
    blocTest<TodoBloc, TodoState>(
      'emits [loading,error] when Todo is updated',
      build: () => TodoBloc(),
      act: (bloc) => bloc.add(TodoUpdateEvent(todo: todo, indexPage: 1)),
      expect: () => [TodoLoading(), TodoUpdateFailure()],
    );
    blocTest<TodoBloc, TodoState>(
      'emits [error] when Todo Update is loading',
      build: () => TodoBloc(),
      act: (bloc) => bloc.add(TodoUpdateEvent(todo: todo, indexPage: 1)),
      skip: 1,
      expect: () => [TodoUpdateFailure()],
    );
  });
}
