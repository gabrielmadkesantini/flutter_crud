import 'package:flutter/material.dart';

class NovoTelefone extends StatefulWidget {
  final TextEditingController textFieldController;
  final TextEditingController dropDownEditingController;
  final Function(int) removeTextEditingController;
  final int index;

  const NovoTelefone(
      {super.key,
      required this.textFieldController,
      required this.dropDownEditingController,
      required this.removeTextEditingController,
      required this.index});

  @override
  State<NovoTelefone> createState() => _NovoTelefoneState();
}

class _NovoTelefoneState extends State<NovoTelefone> {
  

  @override
  Widget build(BuildContext context) {
    final List<String> items = ["item1", "item2", "item3"];
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: widget.textFieldController,
              decoration: const InputDecoration(
                  labelText: "Telefone",
                  border:
                      OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
                  constraints: BoxConstraints(maxWidth: 150)),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: DropdownMenu(
                controller: widget.dropDownEditingController,
                onSelected: (val) {},
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
              print(widget.index);
              widget.removeTextEditingController(widget.index);
            },
            icon: const Icon(Icons.remove),
          )
        ]),
      ],
    );
  }
}
