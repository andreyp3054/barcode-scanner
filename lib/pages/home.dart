import 'package:bar_code/services/permission_handler.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {

  Handler permit = Handler();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barcode Scanner"),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: TextButton.icon(
                onPressed: () async{
                 await permit.requestPermission();
                 if(await permit.checkPermissionStatus()){
                  if(context.mounted) Navigator.pushReplacementNamed(context, "/camera_page");
                 }
                },
                icon: const Icon(
                  Icons.camera,
                  size: 50,
                ),
                label: const Text(
                  "OPEN CAMERA",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.history),
            label: const Text(
              "OPEN SCAN HISTORY",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
