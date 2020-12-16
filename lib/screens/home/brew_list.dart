import 'package:brew_crew_new/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    
    final brews = Provider.of<List<Brew>>(context);

    if (brews != null) {
      brews.forEach((brew) {
        print(brew.name);
        print(brew.sugars);
        print(brew.strength);
     });
    } else {
      print('Brews is null');
    }

   

    return Container(
      
    );
  }
}