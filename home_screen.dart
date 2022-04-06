// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Task Manager'),
          )
      ),
      body: Center(
        child: Text('No Tasks added yet'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[500],
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => Container(
                    //height: 500,
                    color: Colors.blue[200],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Add Text',
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.blue[500],
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
