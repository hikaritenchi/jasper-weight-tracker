import 'package:flutter/material.dart';
import 'package:jasper_weight_tracker/weight_list.dart';

import 'entry_form.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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
