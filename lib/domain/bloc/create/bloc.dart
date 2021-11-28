import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/domain/bloc/create/event.dart';
import 'package:manabie_todoapp/domain/bloc/create/state.dart';
import 'package:manabie_todoapp/domain/domains.dart';

class TodoCreateBloc extends Bloc<TodoCreateEvent, TodoCreateState> {
  TodoCreateBloc() : super(TodoCreateInitialState()) {
    on<TodoCreateSubmitEvent>(_onSubmit);
  }
  void _onSubmit(TodoCreateSubmitEvent event, Emitter emit) async {
    try {
      emit(TodoCreateLoading());
      Todo todo = await TodosDatabase.instance.create(event.todo);
      if (todo.id == 0) {
        emit(TodoCreateError());
      } else {
        emit(TodoCreateLoaded());
        await Future.delayed(Duration(seconds: 1));
        emit(TodoCreateShowNotification(todo));
        print(todo.toString());
      }
    } catch (e) {
      print(e.toString());
      emit(TodoCreateError());
    }
  }
}
