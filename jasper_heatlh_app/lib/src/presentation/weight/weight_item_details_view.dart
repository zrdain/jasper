import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jasper_heatlh_app/src/data/weight_item.dart';

/// Displays detailed information about a SampleItem.
class WeightItemDetailsView extends StatelessWidget {
  const WeightItemDetailsView({super.key});

  static const routeName = '/weight_item';

  @override
  Widget build(BuildContext context) {
    final WeightItem weightItem = ModalRoute.of(context)!.settings.arguments as WeightItem;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Log Details'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete weight item',
            onPressed: () {
              FirebaseFirestore.instance.collection(weightItem.userId).doc(weightItem.loggedTime.toString()).delete().then(
                (doc) => print("Weight item deleted"),
                onError: (e) => print("Error updating document $e"),
              );
              Navigator.pop(context);
            },
          )]
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
