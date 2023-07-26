import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/firestore_services.dart';

class VocabularyList extends StatefulWidget {
  const VocabularyList({super.key});

  @override
  State<VocabularyList> createState() => _VocabularyListState();
}

class _VocabularyListState extends State<VocabularyList> {
  Stream<QuerySnapshot>? _searchStream;
  final FirestoreServices _firestoreServices = FirestoreServices();
  void _startSearch(String searchText) {
    setState(() {
      _searchStream = _firestoreServices.getQueryForField('german', searchText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _searchStream ??
          FirebaseFirestore.instance
              .collection('vocabulary')
              .orderBy('english', descending: false)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List items = [];
        if (snapshot.hasData && !snapshot.hasError) {
          items = snapshot.data.docs.toList()
            ..sort((a, b) => (a['german'].toString().toLowerCase())
                .compareTo(b['english'].toString().toLowerCase()));
          return ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(items[index]['english']),
                  trailing: Text(items[index]['german']),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
