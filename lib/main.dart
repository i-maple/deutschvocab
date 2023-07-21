import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deutschvocab/model/vocabulary_model.dart';
import 'package:deutschvocab/services/add_data.dart';
import 'package:deutschvocab/services/check_connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final CheckConnectivity _connectivity = CheckConnectivity();
  late TextEditingController _english;
  late TextEditingController _deutsch;
  late TextEditingController _search;
  Stream<QuerySnapshot>? _searchStream;

  bool conn = false;

  loadS() async {
    conn = await _connectivity.isConnected();
  }

  @override
  void initState() {
    super.initState();
    loadS();
    _english = TextEditingController();
    _deutsch = TextEditingController();
    _search = TextEditingController();
  }

  @override
  void dispose() {
    _english.dispose();
    _deutsch.dispose();
    _search.dispose();
    super.dispose();
  }

  void _startSearch(String searchText) {
    setState(() {
      // Update the searchStream with the merged results of both queries
      _searchStream = _getQueryForField('german', searchText);
    });
  }

  _getQueryForField(
      String field, String searchText) {
    return FirebaseFirestore.instance
        .collection('items')
        .where(field, isGreaterThanOrEqualTo: searchText)
        .where(field, isLessThanOrEqualTo: '$searchText\uf8ff');
  }

  submitAddition() {
    AddData add = AddData();
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
    add.addData(vocabModel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _deutsch,
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
                  _startSearch(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: _searchStream ??
                    FirebaseFirestore.instance
                        .collection('vocabulary')
                        .orderBy('english', descending: false)
                        .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                  return const Text('No Data Found');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
