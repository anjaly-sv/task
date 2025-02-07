import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController searchController;
  late Query searchQuery;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchQuery = FirebaseFirestore.instance.collection('all_product');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(hintText: 'Search Products'),
          onChanged: _onSearchTextChanged,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: searchQuery.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No results found'));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['itemName']),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'DescriptionScreen',
                    arguments: data,
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _onSearchTextChanged(String newText) {
    String capitalized = newText.isNotEmpty
        ? newText[0].toUpperCase() + newText.substring(1)
        : '';
    setState(() {
      searchQuery = FirebaseFirestore.instance
          .collection('all_product')
          .where('itemName', isGreaterThanOrEqualTo: capitalized)
          .where('itemName', isLessThanOrEqualTo: capitalized + 'z');
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
