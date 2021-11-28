import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/data/model/todo.dart';
import 'package:manabie_todoapp/domain/bloc/blocs.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    on<TodoFetchEvent>(_onFetch);
    on<TodoUpdateEvent>(_onUpdate);
  }
  void _onFetch(TodoFetchEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      List<Todo> result = await TodosDatabase.instance.readAll(event.status);
      emit(TodoFetchSuccess(result));
    } catch (e) {
      print(e.toString());
      emit(TodoFetchError());
    }
  }

  void _onUpdate(TodoUpdateEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      Todo? todo = event.todo;
      if (todo != null) {
        Todo newTodo = todo;
        newTodo.status == 'Complete'
            ? newTodo.status = 'Incomplete'
            : newTodo.status = 'Complete';
        newTodo.date = DateTime.now().toIso8601String();
        print(DateTime.now().toIso8601String());
        int check = await TodosDatabase.instance.update(todo);
        if (check == 1) {
          String status = '';
          if (event.indexPage == 1) {
            status = 'Complete';
          } else if (event.indexPage == 2) {
            status = 'Incomplete';
          }
          List<Todo> result = await TodosDatabase.instance.readAll(status);
          emit(TodoFetchSuccess(result));
        } else {
          emit(TodoUpdateFailure());
        }
      } else {
        emit(TodoUpdateFailure());
      }
    } catch (e) {
      emit(TodoUpdateFailure());
    }
  }
}
