import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userRef = Firestore.instance.collection('users');

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppList(),
    );
  }
}

class AppList extends StatefulWidget {
  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Widget>> getApps() async {
      List<Widget> totalApps = [];
      List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true,
        // includeAppIcons: true,
      );
      print('method is being called again and again');
      apps.forEach((element) {
        Application app = element;
        ListTile object = ListTile(
          // leading: app is ApplicationWithIcon
          //     ? CircleAvatar(
          //         backgroundImage: MemoryImage(app.icon),
          //         backgroundColor: Colors.white,
          //       )
          //     : null,
          title: Text('${element.appName}'),
          // title: Text('welcome'),
        );
        setState(() {
          totalApps.add(object);
        });
      });
      // userRef.add({'title': 'Welcome'});
      return totalApps;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      body: FutureBuilder(
        future: getApps(), //returns a future;
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('no data present at the moment');
          return ListView(children: snapshot.data);
        },
      ),
    );
  }
}
