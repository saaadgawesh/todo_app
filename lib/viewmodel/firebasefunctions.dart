import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/model/tasks_model.dart';
import 'package:todo_app/model/user_model.dart';

class Firebasefunctions {
  //for tasks
  // static CollectionReference<TaskModel> taskscollectionref(String userid) =>
  //     usercollectionref()
  //         .doc(userid)
  //         .collection('tasks')
  //         .withConverter<TaskModel>(
  //           fromFirestore:
  //               (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
  //           toFirestore: (taskmodel, _) => taskmodel.toJson(),
  //         );

  // //for tasks
  // static Future<void> addtasktofirestore(TaskModel task, String userid) async {
  //   final docRef = taskscollectionref(userid).doc();
  //   task.id = docRef.id;
  //   return await docRef.set(task);
  // }

  // static Future<void> deletetaskfromfirestore(
  //   TaskModel task,
  //   String userid,
  // ) async {
  //   await taskscollectionref(userid).doc(task.id).delete();
  // }

  // static Future<List<TaskModel>> gettaskfromfirestore(String userid) async {
  //   // QuerySnapshot<TaskModel> querysnapshot =
  //   //     await taskscollectionref(userid).get();
  //   // return querysnapshot.docs.map((e) => e.data()).toList();

  //   return ((((((await taskscollectionref(userid).get())))))).docs
  //       .map((e) => e.data())
  //       .toList();
  // }

  /***                                     */ //for users
  static CollectionReference<UserModel> usercollectionref() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore:
            (docsnapshot, _) => UserModel.fromJson(docsnapshot.data()!),
        toFirestore: (e, _) => e.toJson(),
      );

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final credentialid = credential.user!.uid;
    try {
      await usercollectionref()
          .doc(credentialid)
          .set(UserModel(id: credentialid, name: name, email: email));
    } catch (e) {
      print(
        '$e.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
      );
    }

    return UserModel(id: credentialid, name: name, email: email);
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final credentialid = credential.user!.uid;
    return (await usercollectionref().doc(credentialid).get()).data()!;

    // print(credential.user!.uid);
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
