import 'package:flutter/material.dart';
import 'package:my_todolist/models/todo.dart';
import 'package:date_field/date_field.dart';

class HomePage extends StatefulWidget {
  String? user;
  HomePage({super.key, this.user});

  get getUser {
    return user;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _todolist = [];

  void _refrechtodo() async {
    final data = await Todo.getTodos();
    setState(() {
      _todolist = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refrechtodo();
  }

  final TextEditingController _titlecontroller = TextEditingController();
  DateTime? selectedDate;

  void _showForm(int? id) async {
    if (id != null) {
      final existingTodo =
          _todolist.firstWhere((element) => element['id'] == id);
      _titlecontroller.text = existingTodo['name'];
      try {
        selectedDate = DateTime.parse(existingTodo['date']);
      } on FormatException {
        print("Invalid date format in 'existingTodo'");
      }
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 120),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titlecontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          labelText: "Name"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeFormField(
                      mode: DateTimeFieldPickerMode.date,
                      decoration: InputDecoration(
                          labelText: 'Enter Date',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onChanged: (DateTime? value) {
                        selectedDate = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.8),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (id == null) {
                          await Todo.insertTodo(
                              _titlecontroller.text, selectedDate.toString());
                          _refrechtodo();
                          Navigator.of(context).pop();
                        }
                        if (id != null) {
                          await Todo.updateTodo(id, _titlecontroller.text,
                              selectedDate.toString(), false);
                          _refrechtodo();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(id == null ? "Ajouter" : "Modifier"),
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todolist${HomePage(user: "").getUser}",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(null);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          //padding: const EdgeInsets.all(12),
          itemCount: _todolist.length,
          itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text("${_todolist[index]['name']}"),
                  subtitle: Text("${_todolist[index]['date']}"),
                  leading: (_todolist[index]['statut'] as int) == 1
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _showForm(_todolist[index]['id']);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              await Todo.deleteTodo(_todolist[index]['id']);
                              _refrechtodo();
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ),
                  onTap: () async {
                    await Todo.updateTodo(
                        _todolist[index]['id'],
                        _todolist[index]['name'],
                        _todolist[index]['date'],
                        true);
                    _refrechtodo();
                  },
                ),
              )),
    );
  }
}
