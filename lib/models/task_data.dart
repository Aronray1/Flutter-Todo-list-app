import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;
class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[

  ];
  int length;
int get taskcount{
  return _tasks.length;
}

void addtask(String newtasktitle){
  try{
final task=Task(name: newtasktitle);
  _firestore.collection('tasks').add({
'title':task,
  });
  _tasks.add(task);
  notifyListeners();
     }catch(e){
       
     }   // we cant update the values without this function as it auto rebuild again the widgets who are listening
                   // to this property according to it's updated value.
}
Widget getdata(){
  StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('tasks').snapshots(),
      builder:(context,snapshot){
if(!snapshot.hasData){
  return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            )
  );

}
final tasks = snapshot.data.documents;
length=tasks.length;
for( var task in tasks){
  _tasks.add(task.data['title']);

}
return null;
    },);

    return null;
}

int  getlength(){
return length;
}
 UnmodifiableListView<Task> get tasks {
  return UnmodifiableListView(_tasks);
}
void updateTask(Task task){
  task.toggleDone();
  notifyListeners();
}

void deletetask(Task task){
  _tasks.remove(task);
  notifyListeners();
}

}

