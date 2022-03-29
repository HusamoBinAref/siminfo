import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'form_recorder.dart';

class NewRecordScreen2 extends StatefulWidget {
  var location = new Location();

  final LocationData? dataLocation;

  NewRecordScreen2({Key? key, this.dataLocation}) : super(key: key);

  @override
  _NewRecordScreenState createState() => _NewRecordScreenState();
}

class _NewRecordScreenState extends State<NewRecordScreen2> {
  late GoogleMapController mapController;
  Location location = Location();
  //PlateNumberModel platemodel = PlateNumberModel();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CL

  void _add(String markerIdVal) {
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker1 = Marker(
      markerId: markerId,
      position: LatLng(
          current!.latitude!
          //+ sin(1 * pi / 6.0) / 20.0
          , //_markerIdCounter
          current!.longitude! //+ cos(1 * pi / 6.0) / 20.0,
          ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );

    setState(() {
      // adding a new marker to map
      //marker = marker1;
      // adding a new marker to map
      markers[markerId] = marker1;
    });
  }

  LocationData? current;

  int i = 0;

  getloc() async {
    bool stateService = await location.serviceEnabled();

    if (stateService) {
      //location.enableBackgroundMode(enable: true);
      try {
        /*_getStartLocation().then((value) {
          setState(() {
            current = value;
          });
        });*/

        setState(() {
          current = widget.dataLocation;
        });
        // location.enableBackgroundMode(enable: true);

        location.onLocationChanged.listen((location) async {
          //i++;
          if (markers != null) {
            // mapController.removeMarker(marker);
            markers.clear();
          }
          /* marker = await mapController?.addMarker(MarkerOptions(
        position: LatLng(location.latitude, location.longitude),
      ));*/
          /* setState(() {
            current = location;
          });*/
          _add(i.toString());

          mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  location.latitude!,
                  location.longitude!,
                ),
                zoom: 16.0,
                // bearing: 30,
                // tilt: 30
              ),
            ),
          );
        });
      } catch (ex) {
        //رجوع للواجهة الرئيسية
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Cars'),
        //actions: [Icon(Icons.arrow_back_ios)],
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios),
                Text('كراش'),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            //500, // double.infinity, //,
            width: double.infinity, //MediaQuery.of(context).size.width,

            child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(current!.latitude!, current!.longitude!),
                    zoom: 16),
                //myLocationEnabled: false,
                buildingsEnabled: true, // تمكين المباني
                compassEnabled: true, // تمكين البوصلة
                indoorViewEnabled: true,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                trafficEnabled: false,
                zoomControlsEnabled: false,
                markers: Set<Marker>.of(markers.values)),
          ),
          FormView(),

          // ListView(
          // children: <Widget>[
//Here Form
          //],
          //  ),
          /* Column(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [Text('.')],
          ),*/
          /* Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 9), labelText: 'حرف 1'),
                ),
              ),

              /* new ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                     
                      /* new OutlineButton(
                        onPressed: () {},
                        child: new Text(
                          "Login",
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                      new RaisedButton(
                        color: Colors.white,
                        onPressed: () {},
                        child: new Text(
                          "Register",
                          style: new TextStyle(color: Colors.black),
                        ),
                      )*/
                    ],
                  ),
                */
            ),
          ),
        */
        ],
      ),
    );
  }
}
