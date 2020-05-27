import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;
List<String> data=[];
class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[

  ];
  int length;


void addtask(String newtasktitle) async{
  getdata();
  var data=await getdata();
  data.add(newtasktitle);
  try{
    
  _firestore.collection('tasks').add({
'title':newtasktitle,
  });
  for(var i in data){
    _tasks.add(Task(name:i));
    notifyListeners();
      }      
     }catch(e){
     }   // we cant update the values without this function as it auto rebuild again the widgets who are listening
                   // to this property according to it's updated value.
}
Future getdata() async{
  
  await _firestore.collection("tasks").getDocuments().then((querySnapshot) {
    querySnapshot.documents.forEach((result) {
       data.add(result.data['title']);
    });

  });
  
   return data;
}

int get taskcount{
  return _tasks.length;
}

 UnmodifiableListView<Task> get tasks {
   getdata();
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

