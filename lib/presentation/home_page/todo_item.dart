import 'package:flutter/material.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/domain/bloc/blocs.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);
  final int selectedIndex;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<TodoBloc>(context).state;
    List<Todo>? todos;
    if (state is TodoFetchSuccess) {
      todos = state.todos;
    }
    List<bool> checked = [];
    todos?.forEach((element) {
      element.status.contains('Complete')
          ? checked.add(true)
          : checked.add(false);
    });
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: todos?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.0,
                      color: todos?.elementAt(index).status == 'Complete'
                          ? Colors.green
                          : Colors.yellow,
                      width: double.infinity,
                      child: CheckboxListTile(
                        value: checked.elementAt(index),
                        onChanged: (value) {
                          setState(() {
                            BlocProvider.of<TodoBloc>(context)
                                .add(TodoUpdateEvent(
                              todo: todos?.elementAt(index),
                              indexPage: widget.selectedIndex,
                            ));
                          });
                        },
                        title: Text(
                          todos?.elementAt(index).name ?? 'nothing',
                          style: Theme.of(context).textTheme.headline5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          todos?.elementAt(index).detail ?? 'nothing',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
