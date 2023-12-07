import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final db = FirebaseFirestore.instance;

class EntryPage extends StatelessWidget {
  EntryPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final list = List<String>.generate(15, (i) => "item $i");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EntryForm(),
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(list[index]));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class EntryForm extends HookWidget {
  const EntryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final controller = useTextEditingController();
    final valid = useState(false);
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            onChanged: (value) {
              valid.value = formKey.currentState!.validate();
            },
            validator: (value) {
              if (null == value) return "Can't be empty";
              if (double.tryParse(value) == null) {
                return "Invalid Input";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Enter your weight"),
          ),
          ElevatedButton(
            onPressed: !valid.value ? null : () {
              final weight = <String, dynamic>{
                "weight": controller.text,
                "time": DateTime.now().millisecondsSinceEpoch,
              };
              db.collection("weights").add(weight).then((_) {
                controller.text = "";
                valid.value = false;
              } );
            },
            child: const Text("Enter"),
          ),
        ],
      ),
    );
  }
}
