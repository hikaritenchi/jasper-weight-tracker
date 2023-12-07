import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jasper_weight_tracker/constants.dart';

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
            onChanged: (_) {
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
            onPressed:
                !valid.value ? null : () => addWeightToDb(controller, valid),
            child: const Text("Enter"),
          ),
        ],
      ),
    );
  }
}

addWeightToDb(final controller, final valid) {
  final weight = <String, dynamic>{
    "weight": controller.text,
    "time": FieldValue.serverTimestamp(),
  };
  FirebaseFirestore.instance
      .collection(weightsCollection)
      .add(weight)
      .then((_) {
    controller.text = "";
    valid.value = false;
  });
}
