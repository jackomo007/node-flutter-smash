import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CitiesListScreen extends StatelessWidget {
  final String countryId;

  const CitiesListScreen({Key? key, required this.countryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color(0xFFF2F2F2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cities'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        toolbarHeight: 100.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('countries').doc(countryId).collection('cities').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data?.docs.isEmpty ?? true) {
            return const Center(child: Text('No cities found for this country.'));
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600, maxHeight: 500), 
              child: Container(
                    color: backgroundColor,
                    child: ListView.separated(
                shrinkWrap: true, 
                itemCount: documents.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.black, height: 13.0,),
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                  return Container(
                    color: backgroundColor, 
                    child: ListTile(
                      title: Text(
                        data['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                       Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
              ),
            ),
          );
        },
      ),
    );
  }
}
