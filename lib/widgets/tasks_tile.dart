import 'package:flutter/material.dart';
class TaskTile extends StatelessWidget {
final bool ischecked;
final String taskTitle; 
final Function checkboxcallback;
final Function longpresscallback;

// void checkboxcallback(bool newvalue){   // generally in callbacks we make anonymous functions so instead of this what we do
//                                     // is just copy the code with arguments and put it as a whole into the parameter.
//   // setState(() {
//   //   ischecked=newvalue;
//   // });

// }  
TaskTile({this.ischecked,this.taskTitle,this.checkboxcallback,this.longpresscallback});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress:longpresscallback ,
title: Text(taskTitle,
style:TextStyle(
decoration: ischecked?TextDecoration.lineThrough:null
)
),
trailing: Checkbox(
      activeColor: Colors.teal[400],
      value: ischecked,
      onChanged:checkboxcallback
      
      ),

    );
  }
}
