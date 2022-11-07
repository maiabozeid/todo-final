import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_final/database/task.dart';

import '../date_utils.dart';

class MyDatabase {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance.collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: (snapshot, options) {
          return Task.fromFirestore(snapshot.data()!);
        },
        toFirestore: (task, options) {
          return task.toFirestore();
        });
  }

  //To create task
  static Future<void> insertTask(Task task) {
    var tasksCollection = getTaskCollection();
    var tasksDoc = tasksCollection.doc(); //create new document
    task.id = tasksDoc.id;
    return tasksDoc.set(task);
  }

  static  Future<QuerySnapshot<Task>>getAllTasks(DateTime selectedDate) async {
    return await getTaskCollection().
        where('dateTime',isEqualTo:  dateOnly(selectedDate).millisecondsSinceEpoch).
    get();
    //read data once
  }

  static Stream<QuerySnapshot<Task>> listenForRealTimeUpdates(DateTime selectedDate){
    //listen for real time updates
return getTaskCollection().
where('dateTime',isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
    .snapshots();
  }

  static Future<void> deleteTask(Task task){
    var tasksDoc = getTaskCollection() //create new document
    .doc(task.id);
    return tasksDoc.delete();

  }
}