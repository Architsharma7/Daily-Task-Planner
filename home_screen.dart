// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modal/task.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _taskController;
  var _tasks;
  late List<bool> _tasksDone;

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Task t = Task.fromString(_taskController.text);

    //prefs.setString('task', json.encode(t.getMap()));
    //_taskController.text = '';

    String? tasks = prefs.getString('tasks');
    List list = (tasks == null) ? [] : json.decode(tasks);
    print(list);
    list.add(json.encode(t.getMap()));
    print(list);
    prefs.setString('tasks', json.encode(list));
    _taskController.text = '';
    Navigator.of(context).pop();
    _getTasks();
  }

  void _getTasks() async {
    _tasks = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasks = prefs.getString('tasks');
    List list = (tasks == null) ? [] : json.decode(tasks);
    for (dynamic d in list) {
      _tasks.add(Task.fromMap(json.decode(d)));
    }
    print(_tasks);
    _tasksDone = List.generate(_tasks.length, ((index) => false));
    setState(() {});
  }

  void updatePendingList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Task> pendingList = [];
    for (var i = 0; i < _tasks.length; i++)
      if (!_tasksDone[i]) pendingList.add(_tasks[i]);
    var pendingListEncoded = List.generate(
        pendingList.length, (i) => json.encode(pendingList[i].getMap()));
    prefs.setString('task', json.encode(pendingListEncoded));
    _getTasks();
  }

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _getTasks();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Task Manager', style: GoogleFonts.roboto()),
          actions: [
            IconButton(
                onPressed: () => updatePendingList, icon: Icon(Icons.save)),
            IconButton(
                onPressed: () => () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('tasks', json.encode([]));
                      _getTasks();
                    },
                icon: Icon(Icons.delete))
          ]),
      body: (_tasks == null)
          ? Center(
              child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/clipboard.jpg',
                      height: 400.0,
                      width: 400.0,
                    ),
                  ),
                  Center(
                      child: Text(
                    "You have a free day !!",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400),
                  )),
                ],
              ),
            ))
          : SingleChildScrollView(
              child: Column(
                children: _tasks
                    .map<Widget>((e) => Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(),
                            color: Color.fromARGB(255, 58, 57, 57),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.task,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              Checkbox(
                                value: _tasksDone[_tasks.indexOf(e)],
                                onChanged: (val) {
                                  setState(() {
                                    _tasksDone[_tasks.indexOf(e)] = val!;
                                  });
                                },
                                key: GlobalKey(),
                                activeColor: Colors.blue,
                                visualDensity: VisualDensity(
                                    horizontal: 4.0, vertical: 4.0),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[500],
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Container(
            height: 250,
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (() => Navigator.of(context).pop()),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.blue[500],
                  thickness: 1.2,
                  height: 1.2,
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Add any task.'),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //height: ,
                  child: Row(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        child: ElevatedButton(
                          child: Text(
                            'Reset',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () => _taskController.text = '',
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        child: ElevatedButton(
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () => saveData(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
