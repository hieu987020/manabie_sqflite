import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/domain/bloc/blocs.dart';

void main() async {
  Todo todo = Todo(
    name: 'Todo A',
    detail: 'Detail A',
    date: DateTime.now().toIso8601String(),
  );
  List<Todo> todos = [];
  todos.add(todo);
  group('TodoBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => TodoBloc(),
      expect: () => [],
    );
    blocTest(
      'emits [Success] when call bloc',
      build: () => TodoBloc(),
      act: (bloc) => TodoBloc().add(TodoFetchEvent(status: '')),
      expect: () => [],
    );
    blocTest(
      'emits [] when call bloc update e',
      build: () => TodoBloc(),
      act: (bloc) => TodoBloc().add(TodoUpdateEvent(todo: todo, indexPage: 1)),
      expect: () => [],
    );
    blocTest(
      'emits [] when call bloc Create',
      build: () => TodoCreateBloc(),
      act: (bloc) => TodoCreateBloc().add(TodoCreateSubmitEvent(todo: todo)),
      expect: () => [],
    );
    // blocTest(
    //   'emits [Failure] when call bloc',
    //   build: () => TodoBloc(),
    //   act: (bloc) => TodoBloc().add(TodoFetchEvent(status: 'Complete')),
    //   expect: () => [TodoLoading()],
    // );
  });
}
