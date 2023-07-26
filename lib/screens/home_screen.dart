import 'dart:async';
import 'package:deutschvocab/provider/vocabulary_list_provider.dart';
import 'package:deutschvocab/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/widgets/vocabulary_list.dart';
import '../model/vocabulary_model.dart';
import '../services/check_connectivity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CheckConnectivity _connectivity = CheckConnectivity();
  late TextEditingController _english;
  late TextEditingController _deutsch;
  late TextEditingController _search;
  final FirestoreServices _firestoreServices = FirestoreServices();
  StreamSubscription? _streamSubscription;

  bool conn = false;

  void startListeningToStream() {
    // Replace fetchYourData with your method that returns a Stream
    _streamSubscription =
        _connectivity.getConnectedStream().listen((bool data) {
      conn = data;
    }, onError: (error) {
      throw error;
    });
  }

  @override
  void initState() {
    super.initState();
    _english = TextEditingController();
    _deutsch = TextEditingController();
    _search = TextEditingController();
    startListeningToStream();
  }

  @override
  void dispose() {
    _english.dispose();
    _deutsch.dispose();
    _search.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  submitAddition() {
    VocabularyModel vocabModel = VocabularyModel(
      german: _deutsch.text,
      english: _english.text,
    );
    if (_english.text.isEmpty || _deutsch.text.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No fields should be empty'),
        ),
      );
      return;
    }
    _firestoreServices.addData(vocabModel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var vocabularyListProvider =
        Provider.of<VocabularyListProvider>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!conn) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please Connect To Internet to add datas'),
              ),
            );
            return;
          } else {
            setState(() {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Add Your Vocab',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              controller: _english,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: 'English',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _deutsch,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: 'Deutsch',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: submitAddition,
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            });
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Card(
                child: ListTile(
                  title: Text(
                    'English',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  trailing: Text(
                    'German',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Search',
                  ),
                  onChanged: (value) {
                    vocabularyListProvider.startSearchInVocabulary(
                        value, 'english');
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: VocabularyList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
