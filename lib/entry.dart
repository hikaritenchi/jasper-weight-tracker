import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entry.g.dart';

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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EntryForm(),
            WeightList(),
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
  db
      .collection("weights-${FirebaseAuth.instance.currentUser?.uid}")
      .add(weight)
      .then((_) {
    controller.text = "";
    valid.value = false;
  });
}

@riverpod
Stream<QuerySnapshot> weightStream(WeightStreamRef ref) {
  return FirebaseFirestore.instance
      .collection("weights-${FirebaseAuth.instance.currentUser?.uid}")
      .snapshots();
}

class WeightList extends ConsumerWidget {
  const WeightList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weightStream = ref.watch(weightStreamProvider);

    return Expanded(
      child: weightStream.when(
          data: (snapshot) {
            final docs = snapshot.docs;
            docs.sort((left, right) {
              final leftData = left.data()! as Map<String, dynamic>;
              final rightData = right.data()! as Map<String, dynamic>;
              final leftTimestamp = leftData['time'] as Timestamp?;
              final rightTimestamp = rightData['time'] as Timestamp?;

              if (null == leftTimestamp || null == rightTimestamp) return 0;

              return rightTimestamp.millisecondsSinceEpoch -
                  leftTimestamp.millisecondsSinceEpoch;
            });
            return ListView(
              children: docs.map(
                (doc) {
                  final data = doc.data()! as Map<String, dynamic>;
                  final time = data['time'] as Timestamp?;
                  if (null == time) return Container();
                  return ListTile(
                      title: Text(data['weight']),
                      subtitle: Text(DateFormat("yyyy-MM-dd HH:mm:ss")
                          .format(time.toDate())));
                },
              ).toList(),
            );
          },
          error: (e, a) => const Text("error"),
          loading: () => const Text("loading")),
    );
  }
}
