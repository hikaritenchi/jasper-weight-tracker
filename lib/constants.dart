
import 'package:firebase_auth/firebase_auth.dart';

final weightsCollection = "weights-${FirebaseAuth.instance.currentUser?.uid}";
