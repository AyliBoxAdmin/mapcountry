
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

import 'package:location/location.dart';
import 'dart:ui' as ui;
import 'package:mapcountry/global.dart' as globals;

import '../main.dart';
import '../utilities/routebuilder.dart';
import '../utilities/utilities.dart';
import 'infocountry.dart';


class MapCountry extends StatefulWidget {
  const MapCountry({Key? key}) : super(key: key);

  @override
  State<MapCountry> createState() => MapCountryState();
}

class MapCountryState extends State<MapCountry> with WidgetsBindingObserver {

  late ThemeData _theme;
  late TextTheme _textTheme;
  late ColorScheme _colorScheme;

  late GoogleMapController _googleMapController;
  BitmapDescriptor? _markerIcon;
  //list of markers
  final List<Marker> _markers = [];
  double _currentZoom = 4.0;
  bool _changeZoom = false;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo result = await codec.getNextFrame();
    return (await result.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static const _initialCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(50.83333333,4.0),
    zoom: 4.0,
    tilt: 0.0,
  );

  ///---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

    asyncInitState();

    Timer.periodic(
      const Duration(seconds: 2),          // Si pas de changement apres 3 seconde save SQL
          (Timer timer) {
        if (_changeZoom == true) {
          _changeZoom = false;
          setState(() {
            _setMarkerIcon();
          });
        }
      },
    );

  }
  void asyncInitState() async {
    globals.listCountry = await MyApp.getAPI();
    await _setMarkerIcon();

    if( globals.useLocalisation == true ) {
      await _permissionLocation();
    }
  }
  Future _setMarkerIcon() async {
    /// Icons by assets folder
    final Uint8List markerIcon = await getBytesFromAsset('assets/country.png', toolsScalingValue(_currentZoom, 3,20,50,300 ).toInt() ); /// Size
    _markerIcon = BitmapDescriptor.fromBytes(markerIcon);

    /// Add all Markers
    _markers.clear();
    //globals.listCountry = await MyApp.getAPI();
    for(int i = 0; i<globals.listCountry.length; i++){
      if( globals.listCountry[i].latlng != null && globals.listCountry[i].latlng!.length == 2 ) {
        _addMarker(LatLng(globals.listCountry[i].latlng![0], globals.listCountry[i].latlng![1]), name: globals.listCountry[i].name );
      }
    }
  }

  Future _permissionLocation() async {
    Location location = Location();
    LocationData _locationData;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    if (kDebugMode) {
      print(_locationData.latitude);
      print(_locationData.longitude);
    }
    CameraPosition _kPointer = CameraPosition(
      bearing: 0.0,
      target: LatLng(_locationData.latitude!, _locationData.longitude!),
      zoom: 4.0,
      tilt: 0.0,
    );
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(_kPointer));
    return true;
  }

  ///---------------------------------------------------------------------------
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
  ///---------------------------------------------------------------------------
  /// Restore map after app resume
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _googleMapController.setMapStyle("[]");
    }
  }
  ///---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _textTheme = _theme.textTheme;
    _colorScheme = _theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: Set<Marker>.of(_markers),
            onCameraMove:(CameraPosition cameraPosition) async{
              if( cameraPosition.zoom != _currentZoom ){
                _currentZoom = cameraPosition.zoom;
                _changeZoom = true;
              }
            },
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
/*
                ActionChip(
                  backgroundColor: _colorScheme.primary,
                  shadowColor: _colorScheme.secondary,
                  avatar: Icon(Icons.delete, color: _colorScheme.onPrimary),
                  label: Text( "Delete", style: _textTheme.bodyText2!.copyWith(color: _colorScheme.onPrimary) ),
                  labelStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                  labelPadding: const EdgeInsets.all(10.0),
                  onPressed: () async{
                    setState(() {
                      _markers.removeAt(0);
                      print(_markers.toString());
                    });
                  },
                ),
                ActionChip(
                  backgroundColor: _colorScheme.primary,
                  shadowColor: _colorScheme.secondary,
                  avatar: Icon(Icons.highlight_remove_outlined, color: _colorScheme.onPrimary),
                  label: Text( "Move", style: _textTheme.bodyText2!.copyWith(color: _colorScheme.onPrimary) ),
                  labelStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                  labelPadding: const EdgeInsets.all(10.0),
                  onPressed: () => _googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: _markers[0].position,
                        zoom: 14.5,
                        tilt: 50.0,
                      ),
                    ),
                  ),
                ),
*/
                ActionChip(
                  backgroundColor: _colorScheme.primary,
                  shadowColor: _colorScheme.secondary,
                  avatar: Icon(Icons.refresh, color: _colorScheme.onPrimary),
                  label: Text( "Actualiser", style: _textTheme.bodyText2!.copyWith(color: _colorScheme.onPrimary) ),
                  labelStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                  labelPadding: const EdgeInsets.all(10.0),
                  onPressed: () async{
                    setState(() {
                      globals.listCountry = [];
                      _markers.clear();
                    });
                    globals.listCountry = await MyApp.getAPI();
                    await _setMarkerIcon();
                    setState(() {});
                  },
                ),

              if( globals.useLocalisation == true )
                ActionChip(
                  backgroundColor: _colorScheme.primary,
                  shadowColor: _colorScheme.secondary,
                  avatar: Icon(Icons.my_location, color: _colorScheme.onPrimary),
                  label: Text( "Position", style: _textTheme.bodyText2!.copyWith(color: _colorScheme.onPrimary) ),
                  labelStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                  labelPadding: const EdgeInsets.all(10.0),
                  onPressed: _permissionLocation,
                ),

              ],
            ),
          ),

        ],
      ),



    );
  }
  ///---------------------------------------------------------------------------



  void _addMarker(LatLng pos,{ String name = "" }) async {
    if(name != ""){
      final MarkerId markerId = MarkerId(name);
      final Marker marker = Marker(
        markerId: markerId,
        position: pos,
        //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        icon: _markerIcon!,
        infoWindow: InfoWindow(
          title: name,
          //snippet: markerId.toString(),
        ),
        onTap: () {
          final index = globals.listCountry.indexWhere((element) => element.name == name);
          if (index >= 0) {
            Navigator.push( // push or pushReplacement
              context,
              ZoomInRoute(  // FadeInRoute  // ZoomInRoute  // RotationInRoute
                page: InfoCountry( thisCountry: globals.listCountry[index] ),
                routeName: "/info",
              ),
            );
          }
        },
      );
      setState(() {
        _markers.add(marker);
      });
    }
  }


}