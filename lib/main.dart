import 'package:flutter/material.dart';
import 'package:instant_torch/torch.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'utilities.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: customOrangeColor,
    ));
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Torch(),
        ),
      ),
    );
  }
}
