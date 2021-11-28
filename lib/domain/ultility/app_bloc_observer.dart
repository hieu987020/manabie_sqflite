import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  // }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('ON CLOSE: ' + bloc.toString().substring(12));
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('ON CREATE : ' + bloc.toString().substring(12));
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('ON ERROR : $error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('ON EVENT : $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("ON TRANSITION : " + bloc.toString().substring(12) + "\n");
    print(
        "---- 1.Current State = " + transition.currentState.toString() + "\n");
    print("---- 2.Event         = " + transition.event.toString() + "\n");
    print("---- 3.Next State    => " + transition.nextState.toString() + "\n");
  }
}
