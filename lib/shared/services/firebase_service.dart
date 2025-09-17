import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../firebase_options.dart';

class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance => _instance ??= FirebaseService._();

  FirebaseService._();

  late FirebaseApp _app;
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;
  late FirebaseFunctions _functions;

  FirebaseApp get app => _app;
  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  FirebaseStorage get storage => _storage;
  FirebaseFunctions get functions => _functions;

  Future<void> initialize() async {
    _app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _functions = FirebaseFunctions.instance;
  }

  // Firestore 컬렉션 참조들
  CollectionReference get usersCollection => _firestore.collection('users');
  CollectionReference get itemsCollection => _firestore.collection('items');
  CollectionReference get ordersCollection => _firestore.collection('orders');
  CollectionReference get bankTxCollection => _firestore.collection('bankTx');
  CollectionReference get auditLogsCollection =>
      _firestore.collection('auditLogs');
  CollectionReference get reportsCollection => _firestore.collection('reports');

  // Storage 참조들
  Reference get itemsStorageRef => _storage.ref().child('items');
  Reference get secureStorageRef => _storage.ref().child('secure');
}
