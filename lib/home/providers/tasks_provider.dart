import 'package:flutter/cupertino.dart';
import 'package:todo_final/database/my_database.dart';

import '../../database/task.dart';

class TasksProvider extends ChangeNotifier{

  List<Task>tasks=[];
  void refreshTasks(DateTime selectedDate)async{
    //to get data from firebase
   var snapshot= await MyDatabase.getAllTasks(selectedDate);
   snapshot.docs.map((e) => tasks.add(e.data())).toList();

    notifyListeners();
  }
}