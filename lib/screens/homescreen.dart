import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/search.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference items =
      FirebaseFirestore.instance.collection("all_product");
  TextEditingController searchController = TextEditingController();

  List<DocumentSnapshot> productList = [];
  bool isLoading = false;
  bool showAll = false;

  void initState() {
    super.initState();
    fetchInitialProducts(); // Load only 8 items initially
  }
  Future<void> fetchInitialProducts() async {
    setState(() => isLoading = true);

    QuerySnapshot snapshot = await items.limit(8).get();

    setState(() {
      productList = snapshot.docs;
      isLoading = false;
    });
  }
  Future<void> fetchAllProducts() async {
    setState(() => isLoading = true);

    QuerySnapshot snapshot = await items.get();

    setState(() {
      productList = snapshot.docs; // Show all items
      showAll = true; // Hide button after loading all items
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb5d0a6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("HomePage",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff1c4c36),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultScreen(),));
                },
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded),
                      SizedBox(width: 16,),
                      Text("Search Products",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: items.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      itemCount:  productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final DocumentSnapshot itemSnap = productList[index];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(context,"DescriptionScreen",arguments: {
                            "itemName": itemSnap["itemName"],
                            "imageUrl":itemSnap['imageUrl'],
                            "description":itemSnap['description']
                          }),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    itemSnap['imageUrl'] ??
                                        'https://via.placeholder.com/100',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(itemSnap['itemName'] ?? 'No Title'),
                                SizedBox(height: 5,),
                                Expanded(child: Text(itemSnap['description'] ?? 'No Description')),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: Text("Data Not Fouund"));
                },
              ),
            ),
            if (!showAll) // Show button only if all items are not displayed
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: fetchAllProducts,
                  child: isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Load More'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
