import 'package:brew_crew_new/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<QuerySnapshot>(context);

    if (brews != null){
      for (var doc in brews.docs){
        print(doc.data());
      }
    }else{
      print('brews is null');
    }


    return Container(
      
    );
  }
}