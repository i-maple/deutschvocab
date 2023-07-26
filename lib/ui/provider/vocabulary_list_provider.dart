import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class VocabularyListProvider extends ChangeNotifier {
  var _vocabularyStream = _firestore
      .collection('vocabulary')
      .orderBy('english', descending: false)
      .snapshots();

  get vocabularyStream => _vocabularyStream;

  startSearchInVocabulary(String searchText, String searchField) {
    _vocabularyStream = _firestore
        .collection('vocabulary')
        .where(searchField.toLowerCase(), isGreaterThanOrEqualTo: searchText.toLowerCase())
        .where(searchField.toLowerCase(), isLessThanOrEqualTo: '$searchText\uf8ff'.toLowerCase())
        .snapshots();
    notifyListeners();
  }
}
