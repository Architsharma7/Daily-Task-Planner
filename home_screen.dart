// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Task Manager', style: GoogleFonts.roboto()),
      )),
      body: Center(
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
      )),
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
                                onPressed: () => print('pressed reset'),
                              ),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width / 2) - 10,
                              child: ElevatedButton(
                                child: Text(
                                  'Add',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                onPressed: () => print('pressed add'),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
