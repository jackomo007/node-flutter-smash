import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smash/screens/cities_list_screen.dart';

class CountriesListScreen extends StatelessWidget {
  const CountriesListScreen({Key? key}) : super(key: key);
  static const backgroundColor = Color(0xFFF2F2F2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        toolbarHeight: 100.0,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('countries').get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data?.docs.isEmpty ?? true) {
              return const Center(child: Text('No countries found.'));
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600, maxHeight: 500), 
                child: Container(
                    color: backgroundColor, 
                    child:ListView.separated(
                  shrinkWrap: true, 
                  itemCount: documents.length,
                  separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                    return Container(
                      color: Color(0xFFF2F2F2),
                      child: ListTile(
                        title: Text(
                          data['name'],
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CitiesListScreen(countryId: documents[index].id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
