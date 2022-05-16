
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'data/country.dart';
import 'map/mapcountry.dart';
import 'package:http/http.dart' as http;
import 'package:mapcountry/global.dart' as globals;


void main() {
  /// For SplashScreen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapCountry',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const HomePage(title: 'MapCountry'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  ///---------------------------------------------------------------------------
  static Future<List<Country>> getAPI() async {
    globals.listCountry = [];
    final response = await http.get(Uri.parse('https://restcountries.com/v2/all'));
    if (response.statusCode == 200) {
      List<dynamic>? dataAPI = jsonDecode(utf8.decode(response.bodyBytes)); /// Decode
      List<Country> listAPI = dataAPI!.map((data) => Country.fromJson(data)).toList() ;
      return listAPI;
    } else {
      throw Exception('apiError: ${response.statusCode}');
    }
  }
  ///---------------------------------------------------------------------------


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  ///---------------------------------------------------------------------------
  /// Controle Orientation
  /// https://stackoverflow.com/questions/63467726/listen-to-orientation-state-in-flutter-before-after-rotation
  /// State<AyliApp> with WidgetsBindingObserver {
  @override
  void didChangeMetrics() {
    if (kDebugMode) {
      print('$WidgetsBindingObserver metrics changed ${DateTime.now()}: ''${WidgetsBinding.instance!.window.physicalSize.aspectRatio > 1 ? Orientation.landscape : Orientation.portrait}');
    }
    globals.screenHeight = double.parse(WidgetsBinding.instance!.window.physicalSize.height.toStringAsFixed(0));
    globals.screenWidth = double.parse(WidgetsBinding.instance!.window.physicalSize.width.toStringAsFixed(0));
    if (kDebugMode) {
      print("Main ScreenSize=> width: ${globals.screenWidth} height: ${globals.screenHeight}");
    }
    if( WidgetsBinding.instance!.window.physicalSize.aspectRatio > 1){
      globals.isPortraitMode = false;
    }else{
      globals.isPortraitMode = true;
    }
  }
  ///---------------------------------------------------------------------------
  @override
  void dispose() {
    /// Controle Orientation
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  ///---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    /// Controle Orientation
    didChangeMetrics();
    WidgetsBinding.instance!.addObserver(this);

    asyncMethod();
  }

  void asyncMethod() async {
    await iniAPPorWeb();
    //globals.listCountry = await HomePage.getAPI();
    /// For SplashScreen
    removeSplash();
  }

  Future iniAPPorWeb() async {
    if (kIsWeb) {
      globals.isWeb = true;
    }else if( Platform.isAndroid ){
      globals.isWeb = false;
      globals.isAndroid = true;
    }else if( Platform.isIOS ){
      globals.isWeb = false;
      globals.isIOS = true;
    }
    /// Detection si web sur mobile
    globals.isWebOnMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);
    if (kDebugMode) {
      print("isWebOnMobile ${globals.isWebOnMobile}");
    }
    return true;
  }
  ///---------------------------------------------------------------------------
  /// For SplashScreen
  void removeSplash() async {
    await Future.delayed(const Duration(milliseconds: 1000), () async{
      FlutterNativeSplash.remove();
    });
  }

  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapCountry',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MapCountry(),
    );
  }



}