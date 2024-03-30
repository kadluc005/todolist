// import 'package:flutter/material.dart';
// import 'package:my_todolist/models/todo.dart';
// import 'package:date_field/date_field.dart';

// class AddPage extends StatelessWidget {
//   final Todo? todos;
//   const AddPage({super.key, this.todos});

//   @override
//   Widget build(BuildContext context) {
//     final _nameController = TextEditingController();
//     final _dateController = TextEditingController();
//     if (todos != null) {
//       _nameController.text = todos!.name;
//       _dateController.text = todos!.date;
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Add a new Todo",
//           style: TextStyle(fontSize: 30),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Form(
//             child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                     labelText: "Name"),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: DateTimeFormField(
//                 //key: _dateController,
//                 mode: DateTimeFieldPickerMode.date,
//                 //dateFormat: DateFormat.yMd(),
//                 decoration: InputDecoration(
//                     labelText: 'Enter Date',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30))),
//                 //firstDate: DateTime.now().add(const Duration(days: 10)),
//                 //lastDate: DateTime.now().add(const Duration(days: 40)),
//                 onChanged: (DateTime? value) {
//                   //selectedDate = value;
//                 },
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final name = _nameController.value.text;
//                 final date = _dateController.value.text;

//                 if (name.isEmpty || date.isEmpty) {
//                   return;
//                 }

//                 final Todo model =
//                     Todo(name: name, date: date, statut: 1, id: todos?.id);

//                 if (todos == null) {
//                   await Todo.insertTodo(model);
//                 } else {
//                   await Todo.updateTodo(model);
//                 }

//                 Navigator.pop(context);
//               },
//               child: const Text("Add"),
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }
