/// Import with --> import 'package:mapcountry/global.dart' as globals;
/// Use with    --> globals.isWeb = false;
/// Value Global
library mapcountry.globals;

import 'data/country.dart';

bool isWeb = false;  // Si Web ne demarre pas NoSQL Sembast !!  AyliApp().IsWeb
bool isWebOnMobile = false;
bool isAndroid = false;
bool isIOS = false;

bool isPortraitMode = true;  // Memorise l'etat de la view portrait OU landscape

double screenWidth = 0;// 1920;
double screenHeight = 0;// 1080;


List<Country> listCountry = [];





