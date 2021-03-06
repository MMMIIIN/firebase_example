import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/memoPage.dart';
import 'package:firebase_example/src/data_controller.dart';
import 'package:firebase_example/src/firestore_test_page.dart';
import 'package:firebase_example/tabsPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      // home: FirebaseApp(analytics: analytics, observer: observer),
      // home: MemoPage(),
      initialBinding: InitBinding(),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            // _initFirebaseMessaging(context);
            // _getToken();
            // return MemoPage();
            return FirebaseStoreTestPage();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _initFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title);
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('??????'),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) { });
  }

  _getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    print('messaging.getToken(), ${await messaging.getToken()}');
  }

}

class FirebaseApp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  const FirebaseApp({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  @override
  _FirebaseAppState createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  _FirebaseAppState(this.analytics, this.observer);

  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  String _message = '';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'hello flutter',
        'int': 100,
      },
    );
    setMessage('Analytics ????????? ??????');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _sendAnalyticsEvent, child: Text('?????????')),
            Text(_message, style: const TextStyle(color: Colors.blueAccent))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.tab),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<TabsPage>(
              settings: RouteSettings(name: '/tab'),
              builder: (context) {
                return TabsPage(observer);
              },
            ),
          );
        },
      ),
    );
  }
}

class InitBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(DataController());
  }
}