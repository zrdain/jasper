import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jasper_heatlh_app/src/presentation/auth/login_controller.dart';
import 'package:jasper_heatlh_app/src/util/utils.dart';

import '../settings/settings_view.dart';
import '../../data/weight_item.dart';
import 'weight_item_details_view.dart';

/// Displays a list of Weight Log Entries.
class WeightHistoryListView extends StatelessWidget {
  const WeightHistoryListView({super.key, required this.loginController});

  static const routeName = '/weight_history_list';

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(loginController.getCurrentUser()?.uid ?? "").orderBy("loggedTime", descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
                List<WeightItem> items = getDataFromSnapshot(snapshot.data);
                return ListView.builder(
                  // Providing a restorationId allows the ListView to restore the
                  // scroll position when a user leaves and returns to the app after it
                  // has been killed while running in the background.
                  restorationId: 'weightHistoryListView',
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                      WeightItem item = items[index];
                      return ListTile(
                        title: Text('${item.weight} lbs'),
                        leading: const CircleAvatar(
                          // Display the Flutter Logo image asset.
                          foregroundImage: AssetImage('assets/images/flutter_logo.png'),
                        ),
                        trailing: Text(Utilities.formatDate(item.loggedTime)),
                        onTap: () {
                          // Navigate to the details page. If the user leaves and returns to
                          // the app after it has been killed while running in the
                          // background, the navigation stack is restored.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WeightItemDetailsView(),
                              // Pass the arguments as part of the RouteSettings. The
                              // DetailScreen reads the arguments from these settings.
                              settings: RouteSettings(
                                arguments: item,
                              ),
                            ),
                          );
                        });
                      
                    
                    });
              }}),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final TextEditingController weightController = TextEditingController();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: const Text('Add Weight Log'),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: weightController,
                            decoration: const InputDecoration(
                              labelText: 'Weight',
                              icon: Icon(Icons.scale),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          String? id = loginController.getCurrentUser()?.uid;
                          String weight = weightController.text;
                          
                          if(id != null) {
                            WeightItem weightItem = WeightItem(userId: id, weight: weight, loggedTime: DateTime.now().millisecondsSinceEpoch);
                            postItemToFirestore(weightItem);
                            Navigator.pop(context);
                          }
                        })
                  ],
                );
              });
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void postItemToFirestore(WeightItem weightItem) {
    FirebaseFirestore.instance.collection(weightItem.userId)
      .doc(weightItem.loggedTime.toString())
      .set(weightItem.toMap())
      .onError((e, _) => print("Error writing document: $e"));
  }

  List<WeightItem> getDataFromSnapshot(QuerySnapshot? data) {
    // Get data from docs and convert map to List
    return data?.docs.map((doc) => WeightItem.fromJson(doc.data() as Map<String, dynamic>)).toList() ?? List.empty();
  }
  
}
