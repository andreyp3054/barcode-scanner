import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription>
    cameras; // this is the variable for containing the list of available cameras

Future<void> runCamera() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ensure that the framework is properly initialized
  //binding - binds the platform-specific codes with the framework to ensure widget and widget-related functionalities
  cameras = await availableCameras(); // cameras is then set to the list of available cameras of devices
  runApp(const CameraPage());
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => CameraPageState();
}
class CameraPageState extends State<CameraPage> {
  late CameraController cameraController;

  @override
  void initState() {
    // initializes the state of this stateful widget
    super.initState();
    super.initState();
    runCamera(); // get the list of available cameras
    cameraController = CameraController(cameras[0], ResolutionPreset
        .high); // cameraController is now the literal camera controller and is the first camera in the list
    try {
      cameraController.initialize().then((_) {    //async is not allowed, but then is only allowed in initState()
        if (!context.mounted) {  // if widget is still in the widget tree
          return;
        }
        setState(() {});
      });
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {       //e.code is a String and is the name of the EXCEPTION
          case "CameraAccessDenied":
            print("CAMERA ACCESS IS DENIED");
            break;
          case "CameraAccessRestricted":
            print("CAMERA ACCESS IS RESTRICTED");
            break;
          case "CameraAccessNotGranted":
            print("CAMERA ACCESS IS NOT GRANTED");
            break;
          case "CameraAccessLimited":
            print("CAMERA ACCESS IS LIMITED");
            break;
          default:
            print("UNKNOWN EXCEPTION OCCURED");
            break;
        }
      }
    }
  }
  @override
  void dispose(){
    cameraController.dispose();       //dispose() is to release cameraController and its resources
    super.dispose();                  //it is essential to dispose also from its parent class
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized == false) {      // if camera is not initialize, build only the default page
      return Container();
    }
    else {
      return MaterialApp(home: CameraPreview(cameraController!));
    }
  }
}