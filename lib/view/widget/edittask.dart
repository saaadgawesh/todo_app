// import 'package:flutter/material.dart';
// import 'package:todo_app/appthem.dart';
// import 'package:todo_app/view/tasks/defaultelevatedbotton.dart';
// import 'package:todo_app/view/tasks/defaulttextfield.dart';

// class Edittask extends StatelessWidget {
//   TextEditingController titlecontroller = TextEditingController();
//   TextEditingController detaliscontroller = TextEditingController();

//   Edittask({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.6,
//       width: MediaQuery.of(context).size.width * 0.6,
//       decoration: BoxDecoration(
//         color: Appthem.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         children: [
//           const Text('edit task'),
//           Defaulttextfield(controller: titlecontroller, label: 'this is title'),
//           Defaulttextfield(
//             controller: detaliscontroller,
//             label: 'task details',
//           ),
//           const Text('select time'),
//           GestureDetector(
//             onTap:
//                 () => showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime.now().add(const Duration(days: 360)),
//                 ),
//             child: const Text('19/7/2025'),
//           ),
//           defaultelevatedbotton(label: 'save change', onpress: () {}),
//         ],
//       ),
//     );
//   }
// }
