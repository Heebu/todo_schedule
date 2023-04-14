import 'package:flutter/material.dart';
import 'package:my_todo/Resueables/todo_items.dart';
import '../Resueables/mySchedules.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todoList = Todo.todoList();
  final _todoController = TextEditingController();
  List<Todo> _foundTodo = [];

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _ableToChange(Todo todo) {
      setState(() {
        todo.isDone = !todo.isDone;
      });
    }

    void _ableToDelete(String id) {
      setState(() {
        todoList.removeWhere((item) => item.id == id);
      });
    }

    void _ableToAdd(String todo) {
      setState(() {
        todoList.add(Todo(
          id: (todoList.length + 1).toString(),
          todoItem: todo,
        ));
      });
      _todoController.clear();
    }

    void _runFilter(String enteredKeyword) {
      List<Todo> results = [];
      if (enteredKeyword.isEmpty) {
        results = todoList;
      } else {
        results = todoList
            .where((item) => item.todoItem!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }
      setState(() {
        _foundTodo = results;
      });
    }

    var screenHeight = MediaQuery.of(context).size.height; //height = 868.6
    var screenWidth = MediaQuery.of(context).size.width;

    double height2 = screenHeight / 434.3;
    double height5 = screenHeight / 173.72;
    double height10 = screenHeight / 86.86;
    double height20 = screenHeight / 43.43;
    double height30 = screenHeight / 28.95;

    double width10 = screenWidth / 41.14;
    double width20 = screenWidth / 20.57;

    //

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Todo App',
              style: TextStyle(fontSize: height30, fontWeight: FontWeight.bold),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          SizedBox(
            height: height20,
          ),
          Container(
            padding: EdgeInsets.only(left: width10, right: width10),
            margin: EdgeInsets.only(left: width10, right: width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TextField(
              onChanged: (value) {
                _runFilter(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: height10 + height5 + height2),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          SizedBox(
            height: height30,
          ),
          Text(
            'My Schedules',
            style: TextStyle(
              fontSize: height30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: height20),
              margin: EdgeInsets.only(
                top: height20,
                left: width10,
                right: width10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(children: [
                for (Todo todos in _foundTodo)
                  MySchedules(
                    todo: todos,
                    ableToChange: _ableToChange,
                    ableToDelete: _ableToDelete,
                  ),
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: height5,
                    right: width20,
                    left: width20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + height10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _todoController,
                        decoration: InputDecoration(hintText: 'Add a Task'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _ableToAdd(_todoController.text);
                        },
                        child: Text('Add'),
                      )
                    ],
                  ),
                );
              });
        },
        child: (Icon(Icons.add)),
      ),
    );
  }
}

//
