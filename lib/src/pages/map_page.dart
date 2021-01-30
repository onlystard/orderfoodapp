import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class GoogleMapDemo extends StatefulWidget {
  @override
  _GoogleMapDemoState createState() => _GoogleMapDemoState();
}

class _GoogleMapDemoState extends State<GoogleMapDemo>
    with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();
  final islocationpermission = false;

  static const LatLng _center = const LatLng(15.995496, 108.258635);
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'Checkout this Place',
            snippet: 'Rate now',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet)));
    });
  }

  void showMenuSelection(String value) {
    setState(() {
      switch (value) {
        case 'normal':
          {
            _currentMapType = MapType.normal;
          }
          break;
        case 'hybrid':
          {
            _currentMapType = MapType.hybrid;
          }
          break;
        case 'satellite':
          {
            _currentMapType = MapType.satellite;
          }
          break;
        case 'terrain':
          {
            _currentMapType = MapType.terrain;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Map ",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: showMenuSelection,
            tooltip: "Choose MapType",
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                value: 'normal',
                child: Text('Normal'),
              ),
              const PopupMenuItem<String>(
                value: 'hybrid',
                child: Text('HyBrid'),
              ),
              const PopupMenuItem<String>(
                value: 'satellite',
                child: Text('Satellite'),
              ),
              const PopupMenuItem<String>(
                value: 'terrain',
                child: Text('Terrain'),
              )
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            mapType: _currentMapType,
            onMapCreated: _onMapCreated,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            compassEnabled: true,
            onCameraMove: _onCameraMove,
            markers: _markers,
            // trackCameraPosition: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 10.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add_location, size: 36.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
