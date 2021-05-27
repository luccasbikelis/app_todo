import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<String> item = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Lista de Tarefas')),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: item.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '${index + 1} - ${item[index]}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(height: 1),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          redirectToNewPage(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void redirectToNewPage(context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => FormPage(),
      ),
    )
        .then((value) {
      print(value);
      if (value != null) {
        setState(() {
          item.add(value);
        });
      }
    });
  }
}

class FormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Formulário"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: itemController,
                  onSaved: (value) {
                    itemController.text = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O item é obrigatório!';
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print(itemController.text);
                        Navigator.of(context).pop(itemController.text);
                      }
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(fontSize: 15),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
