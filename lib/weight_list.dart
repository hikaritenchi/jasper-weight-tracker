import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jasper_weight_tracker/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weight_list.g.dart';

@riverpod
Stream<QuerySnapshot> weightStream(WeightStreamRef ref) {
  return FirebaseFirestore.instance.collection(weightsCollection).snapshots();
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
