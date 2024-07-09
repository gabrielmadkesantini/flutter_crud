import 'package:flutter/material.dart';
import './widgets/novo_telefone.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController currentTextFieldValue = TextEditingController();
  final TextEditingController currentDropDownValue = TextEditingController();
  final List<TextEditingController> editingTextFieldControllers = [];
  final List<TextEditingController> editingDropDownControllers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    editingTextFieldControllers.map((e) => e.dispose());
    editingDropDownControllers.map((e) => e.dispose());
    currentTextFieldValue.dispose();
    currentDropDownValue.dispose();
  }

  void toggleAddTextEditing() {
    if (currentTextFieldValue.text != "") {
      setState(() => editingTextFieldControllers
          .add(TextEditingController(text: currentTextFieldValue.text)));
    }
  }

  void toggleAddDropDown() {
    if (currentDropDownValue.text != "") {
      setState(() => editingDropDownControllers
          .add(TextEditingController(text: currentDropDownValue.text)));
    }
  }

   toggleRemoveTextEditing(int index) {
    print(editingTextFieldControllers[index].text);
    setState(() {
      editingTextFieldControllers.removeAt(index);
      editingDropDownControllers.removeAt(index);
    });

  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = ["item1", "item2", "item3"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: 400,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.blue[100], // Cor de fundo do Container.
            borderRadius: BorderRadius.circular(10.0), // Bordas arredondadas.
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: currentTextFieldValue,
                          decoration: const InputDecoration(
                              labelText: "Telefone",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0)),
                              constraints: BoxConstraints(maxWidth: 150)),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: DropdownMenu(
                            controller: currentDropDownValue,
                            expandedInsets: const EdgeInsets.all(1),
                            hintText: "Tipo",
                            dropdownMenuEntries: items.map((value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              );
                            }).toList()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton.outlined(
                        onPressed: () {
                          toggleAddTextEditing();
                          toggleAddDropDown();
                        },
                        icon: const Icon(Icons.add),
                      )
                    ]),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: editingTextFieldControllers.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(editingTextFieldControllers[index].text);
                      return NovoTelefone(
                        textFieldController: editingTextFieldControllers[index],
                        dropDownEditingController:
                            editingDropDownControllers[index],
                        removeTextEditingController: (int idx) => toggleRemoveTextEditing(index),
                        index: index,
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
