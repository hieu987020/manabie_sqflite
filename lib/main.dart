import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manabie_todoapp/domain/domains.dart';
import 'package:manabie_todoapp/presentation/presentations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // BlocOverrides.runZoned(
  //   () {
  //     // Use cubits...
  //     //TodoBloc();
  //   },
  //   blocObserver: AppBlocObserver(),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => TodoBloc(),
        ),
        BlocProvider<TodoCreateBloc>(
          create: (BuildContext context) => TodoCreateBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App Manabie',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: HomePage(key: key),
      ),
    );
  }
}
