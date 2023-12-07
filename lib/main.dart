import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jasper_weight_tracker/entry.dart';
import 'package:jasper_weight_tracker/firebase_options.dart';
import 'package:jasper_weight_tracker/login.dart';
import 'package:jasper_weight_tracker/status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

@riverpod
Stream<User?> loggedInUser(LoggedInUserRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedInUser = ref.watch(loggedInUserProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: loggedInUser.when(
        data: (user) => null == user
            ? const LoginPage(title: "Login")
            : EntryPage(title: "Jasper Weight Tracker"),
        error: (a, b) => const StatusPage(title: "Error"),
        loading: () => const StatusPage(title: "Loading"),
      ),
    );
  }
}
