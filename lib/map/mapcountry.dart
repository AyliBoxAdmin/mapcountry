
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;
import 'package:mapcountry/global.dart' as globals;

import '../main.dart';
import '../utilities/utilities.dart';


class MapCountry extends StatefulWidget {
  const MapCountry({Key? key}) : super(key: key);

  @override
  State<MapCountry> createState() => MapCountryState();
}

class MapCountryState extends State<MapCountry> {

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
    globals.listCountry = await HomePage.getAPI();
    await _setMarkerIcon();
    await _permissionLocation();
  }
  Future _setMarkerIcon() async {
    /// Icons by assets folder
    final Uint8List markerIcon = await getBytesFromAsset('assets/country.png', toolsRangeValue(_currentZoom, 3,20,50,300 ).toInt() ); /// Size
    _markerIcon = BitmapDescriptor.fromBytes(markerIcon);
    /// Icons by Network
    /*
    String imgurl = "https://www.asyoulikekit.com/api_HHM/country.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
        .load(imgurl))
        .buffer
        .asUint8List();
    _markerIcon = BitmapDescriptor.fromBytes(bytes);*/
    /// Icons by Canvas
    //final Uint8List markerIcon = await getBytesFromCanvas(200, 100);
    //_markerIcon = BitmapDescriptor.fromBytes(markerIcon);

    /// Add All Markers
    _markers.clear();
    //globals.listCountry = await HomePage.getAPI();
    for(int i = 0; i<globals.listCountry.length; i++){
      if( globals.listCountry[i].latlng != null && globals.listCountry[i].latlng!.length == 2 ) {
        _addMarker(LatLng(globals.listCountry[i].latlng![0], globals.listCountry[i].latlng![1]), name: globals.listCountry[i].name );
      }
    }
  }
  /// Icons by Canvas
  Future<Uint8List> getBytesFromCanvas(int width, int height) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.blue;
    const Radius radius = Radius.circular(20.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = const TextSpan(
      text: 'Belgique',
      style: TextStyle(fontSize: 25.0, color: Colors.white),
      children: [
        TextSpan(text: "...", ),
      ],
    );
    painter.layout();
    painter.paint(canvas, Offset((width * 0.5) - painter.width * 0.5, (height * 0.5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
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
                  backgroundColor: Colors.amber,
                  shadowColor: Colors.amberAccent,
                  avatar: const Icon(Icons.delete),
                  label: Text( "Delete", style: Theme.of(context).textTheme.bodyText2, ),
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
                  backgroundColor: Colors.amber,
                  shadowColor: Colors.amberAccent,
                  avatar: const Icon(Icons.highlight_remove_outlined),
                  label: Text( "Move", style: Theme.of(context).textTheme.bodyText2, ),
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
                  backgroundColor: Colors.amber,
                  shadowColor: Colors.amberAccent,
                  avatar: const Icon(Icons.refresh),
                  label: Text( "Refresh", style: Theme.of(context).textTheme.bodyText2, ),
                  labelStyle: const TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                  labelPadding: const EdgeInsets.all(10.0),
                  onPressed: () async{
                    setState(() {
                      globals.listCountry = [];
                      _markers.clear();
                    });
                    globals.listCountry = await HomePage.getAPI();
                    await _setMarkerIcon();
                    setState(() {});
                  },
                ),
                ActionChip(
                  backgroundColor: Colors.amber,
                  shadowColor: Colors.amberAccent,
                  avatar: const Icon(Icons.my_location),
                  label: Text( "Location", style: Theme.of(context).textTheme.bodyText2, ),
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



  void _addMarker(LatLng pos,{  String name = "" }) async {
    if(name != ""){
      var markerIdVal = name;
      final MarkerId markerId = MarkerId(markerIdVal.toString());
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        position: pos,
        //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        icon: _markerIcon!,
        infoWindow: InfoWindow(
          title: name,
          //snippet: "${_markersId.toString()}",
        ),
      );
      setState(() {
        _markers.add(marker);
      });
    }
  }


}