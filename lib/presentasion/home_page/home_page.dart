import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manabie_todoapp/domain/bloc/blocs.dart';
import 'package:manabie_todoapp/presentasion/create_page/create_pages.dart';
import 'package:manabie_todoapp/presentasion/home_page/home_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    String status = '';
    if (index == 1) {
      status = 'Complete';
    } else if (index == 2) {
      status = 'Incomplete';
    }
    BlocProvider.of<TodoBloc>(context).add(TodoFetchEvent(status: status));

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(TodoFetchEvent(status: ''));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCreateBloc, TodoCreateState>(
      listener: (context, state) {
        if (state is TodoCreateLoaded) {
          _onItemTapped(2);
        }
        if (state is TodoCreateShowNotification) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Create successful!')));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "Create Task") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateTask()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Create Task', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: CustomeItem(
                  imageURL: "assets/images/all.png", color: Colors.grey),
              activeIcon: CustomeItem(
                  imageURL: "assets/images/all.png", color: Colors.blue),
              label: 'All Tasks',
            ),
            BottomNavigationBarItem(
              icon: CustomeItem(
                  imageURL: "assets/images/complete.png", color: Colors.grey),
              activeIcon: CustomeItem(
                  imageURL: "assets/images/complete.png", color: Colors.blue),
              label: 'Complete',
            ),
            BottomNavigationBarItem(
              icon: CustomeItem(
                  imageURL: "assets/images/incomplete.png", color: Colors.grey),
              activeIcon: CustomeItem(
                  imageURL: "assets/images/incomplete.png", color: Colors.blue),
              label: 'Incomplete',
            ),
          ],
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoFetchSuccess) {
              return TodoPage(
                selectedIndex: _selectedIndex,
              );
            } else if (state is TodoFetchError) {
              return Center(
                child: Container(
                  child: Text("Error"),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomeItem extends StatelessWidget {
  final String imageURL;
  final Color color;

  CustomeItem({
    Key? key,
    required this.imageURL,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Image.asset(
        imageURL,
        color: color,
        fit: BoxFit.fill,
      ),
    );
  }
}
