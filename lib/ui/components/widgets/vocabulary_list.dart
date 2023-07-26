import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deutschvocab/ui/components/dialog/modal.dart';
import 'package:deutschvocab/ui/provider/vocabulary_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VocabularyList extends StatefulWidget {
  const VocabularyList({super.key});

  @override
  State<VocabularyList> createState() => _VocabularyListState();
}

class _VocabularyListState extends State<VocabularyList> {
  @override
  Widget build(BuildContext context) {
    var vocabularyListProvider =
        Provider.of<VocabularyListProvider>(context, listen: false);

    return StreamBuilder<QuerySnapshot>(
      stream: vocabularyListProvider.vocabularyStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List items = [];
        String textInEnglish;
        String textInGerman;
        if (snapshot.hasData && !snapshot.hasError) {
          items = snapshot.data.docs.toList()
            ..sort(
              (a, b) => (a['german'].toString().toLowerCase()).compareTo(
                b['english'].toString().toLowerCase(),
              ),
            );
          return ListView.builder(
            itemCount: items.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              textInEnglish = items[index]['english'];
              textInGerman = items[index]['german'];
              return GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (_) {
                      textInEnglish = items[index]['english'];
                      textInGerman = items[index]['german'];
                      return Modal(title: textInEnglish, message: textInGerman);
                    }),
                child: Card(
                  child: ListTile(
                    title: Text(textInEnglish),
                    trailing: Text(textInGerman),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            value: 30,
          ),
        );
      },
    );
  }
}
