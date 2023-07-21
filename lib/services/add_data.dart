import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deutschvocab/model/vocabulary_model.dart';

class AddData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addData(VocabularyModel model) async {
    _firestore.collection('vocabulary').add({
      'english': model.english,
      'german': model.german,
      'isApproved': true,
      'user': model.user,
      'addedOn': DateTime.now(),
    });
  }
}
