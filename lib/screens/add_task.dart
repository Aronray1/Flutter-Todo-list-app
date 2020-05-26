import 'package:flutter/material.dart';
//import 'package:todo/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';
class Addtaskscreen extends StatefulWidget {
  @override
  _AddtaskscreenState createState() => _AddtaskscreenState();
}
class _AddtaskscreenState extends State<Addtaskscreen> {
  bool _validate=false;
  final _text=TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newTasktitle;
    return Container(
  color:Color(0xff757575),
   child:Container(
     padding: EdgeInsets.all(20.0),
     decoration: BoxDecoration(
    color:Colors.white,
    borderRadius: BorderRadius.only(
    topLeft:Radius.circular(20.0),
    topRight: Radius.circular(20.0)
  )

   ),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: <Widget>[
Text('Add Task',
textAlign: TextAlign.center,
style:TextStyle(
fontSize: 30.0,
color:Colors.teal[400],
)
),

TextField(    // auto enable the text fieldps when the bottom sheet pops up.
 controller: _text,
 autofocus: true,
decoration: InputDecoration(
labelText: 'Enter Task',
labelStyle: TextStyle(
  color:Colors.teal[400],
),
errorText: _validate?'Can\'t be Empty':null,

),
textAlign: TextAlign.center,
onChanged: (newtext){
  try{
  if(newtext.length>0){
  newTasktitle=newtext;
  }
  }catch(e){
        print(e);
  }
  
},
 
  ),
  SizedBox(
    height:10.0
  ),

  FlatButton(onPressed: (){
setState(() {
  _text.text.isEmpty?_validate=true:_validate=false;
});
if(_validate==false){
Provider.of<Taskdata>(context).addtask(newTasktitle);
Navigator.pop(context);
}
  },
   child: Text('Add',
   style:TextStyle(
     color:Colors.white,
   )
   ),
   color:Colors.teal[400],
  
  
  )




  ],



)

   )

  
    );
  }
}