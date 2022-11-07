import 'package:flutter/material.dart';
import 'package:todo_final/database/my_database.dart';

import '../database/task.dart';
import '../date_utils.dart';
import '../dialoge_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
var titleController = TextEditingController();
  var descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.70,
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add New Task',

              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,),
            TextFormField(
              controller: titleController,
              validator: (text) {
                if (text == null || text
                    .trim()
                    .isEmpty) {
                  return 'Please Enter title';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 12,),
            TextFormField(
              controller: descController ,
              validator: (text) {
                if (text == null || text
                    .trim()
                    .isEmpty) {
                  return 'Please Enter description';
                }
                return null;
              },
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
              maxLines: 4,
              minLines: 4,
              decoration: InputDecoration(
                  labelText: 'Description'
              ),
            ),
            SizedBox(height: 12,),
            Text('Select Date',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,),
            InkWell(
              onTap:(){
 showDateDialoge();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('${selectedDate.year}/${selectedDate.month}/'
                    '${selectedDate.day}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,),
              ),
            ),
            ElevatedButton(onPressed: () {
              addTask();
            },
                child: Text('Sumbit',
                style: TextStyle(
                  fontSize: 20,
                ),)),
          ],
        ),
      ),
    );
  }
DateTime selectedDate = DateTime.now();
  void showDateDialoge() async{
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days:365)));
    if(date!=null){

      setState(() {
        selectedDate=date;
      });
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      String title = titleController.text;
      String desc = descController.text;
      Task task = Task(
          title: title,
          description: desc,
          dateTime:  dateOnly(selectedDate),
          isDone: false);

showLoading(context, 'Loading.....' , isCancelable: false);
      MyDatabase.insertTask(task).
      then((value) {
        hideLoading(context);
        ShowMessage(context, 'Task Added Sucessfully',
            posActionName: 'Ok',
        posAction: (){
          Navigator.pop(context);
        });
      }).onError((error, stackTrace) {
        ShowMessage(context, 'Something went wrong , try again later');
      }).timeout(Duration(seconds: 5),
          onTimeout: () {
            ShowMessage(context, 'Task Saved Locally');
          }
      );
    }
  }
}