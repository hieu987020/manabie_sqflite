import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manabie_todoapp/data/model/todo.dart';
import 'package:manabie_todoapp/domain/domains.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);
  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _name = new TextEditingController();
  TextEditingController _detail = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCreateBloc, TodoCreateState>(
      listener: (context, state) {
        if (state is TodoCreateLoaded) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Task'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                LabelWidget(text: 'Name'),
                SizedBox(height: 15),
                Container(
                  child: TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter name of task',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                LabelWidget(text: 'Detail'),
                SizedBox(height: 15),
                Container(
                  child: TextFormField(
                    controller: _detail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter detail of task',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<TodoCreateBloc>(context)
                            .add(TodoCreateSubmitEvent(
                          todo: Todo(
                            name: _name.text,
                            detail: _detail.text,
                            date: DateTime.now().toIso8601String(),
                          ),
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
      alignment: Alignment.centerLeft,
    );
  }
}
