import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FludgetTile extends StatefulWidget {
  @override
  _FludgetTileState createState() => _FludgetTileState();
}

class _FludgetTileState extends State<FludgetTile> {
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot docsSnapShot =
        await firestore.collection("user").getDocuments();
    return docsSnapShot.documents;
  }

  var colors = [0xff03a9f4, 0xff4db6ac, 0xfff44336, 0xffe91e63, 0xff7c4dff];
  var random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(colors[random.nextInt(colors.length - 1)]),
      child: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Loading...",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, letterSpacing: 1.0)),
                    )
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Card(
//                      color:
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(snapshot.data[index].data['faculty']),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data[index].data["name"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 23.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              onTap: null
//                      ()
//                      {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => ApplicationDetails(
//                                    snapshot.data[index], userDetails)));
//                      },
                              ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}