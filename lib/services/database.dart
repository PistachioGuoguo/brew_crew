import 'package:brew_crew_new/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  
  DatabaseService({this.uid});

  // collection reference

  final CollectionReference brewCollection = Firestore.instance.collection('brews');
  // if not exist before, will automatically create one

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }

  // brew list from snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
      );
    }).toList();
  }


  Stream<List<Brew>> get brews{
    // print(brewCollection.get());
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }


}