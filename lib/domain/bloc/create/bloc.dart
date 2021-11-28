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
      TodosDatabase.instance.create(event.todo);
      emit(TodoCreateLoaded());
      await Future.delayed(Duration(seconds: 1));
      emit(TodoCreateShowNotification());
    } catch (e) {
      print(e.toString());
      emit(TodoCreateError());
    }
  }
}
