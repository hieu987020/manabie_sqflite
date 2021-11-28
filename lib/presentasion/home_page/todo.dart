import 'package:flutter/material.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/domain/bloc/blocs.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);
  final int selectedIndex;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
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

  // confirmDialog(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (_) => Dialog(
  //       // backgroundColor: Colors.transparent,
  //       child: Container(
  //         alignment: FractionalOffset.center,
  //         height: 250,
  //         padding: const EdgeInsets.all(20.0),
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Container(
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     'Finish this task?',
  //                     style: TextStyle(
  //                       fontSize: 25,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 Container(
  //                   height: 50,
  //                   width: 100,
  //                   decoration: BoxDecoration(color: Colors.blue),
  //                   child: TextButton(
  //                     child: Text(
  //                       'Yes',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     onPressed: () {},
  //                   ),
  //                 ),
  //                 Container(
  //                   height: 50,
  //                   width: 100,
  //                   decoration: BoxDecoration(color: Colors.grey),
  //                   child: TextButton(
  //                     child: Text(
  //                       'No',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
