import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:laundro/components/check_numeric.dart';
import 'package:laundro/constants.dart';
import 'package:laundro/model/user_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressUpdatePage extends StatefulWidget {
  @override
  _AddressUpdatePageState createState() => _AddressUpdatePageState();
}

class _AddressUpdatePageState extends State<AddressUpdatePage> {
  bool showSpinner = false;
  GoogleMapController _controller;
  Position currentPosition =
      Position(latitude: User.lattitude, longitude: User.longitude);
  String locality = '', pincode = '', administrativeArea = '', placeName = '';
  String inputAddress = '', inputLandmark = '';
  String phoneNumber = '';

  SharedPreferences prefs;
  final _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      showSpinner = true;
      // getCurrentLocation();
      instantiateSP();
    });
    setState(() {
      showSpinner = false;
    });
  }

  void instantiateSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  void getCurrentLocation() async {
    Position position;
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position.longitude == null || position.latitude == null) {
      position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    }
    setState(() {
      currentPosition = position;
      //print(currentPosition.latitude.toString());
    });
    moveCameraToPosition(currentPosition);
    getAddressFromPosition(currentPosition);
  }

  void moveCameraToPosition(Position position) {
    _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18,
        ),
      ),
    );
  }

  void getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        locality = placemark[0].locality;
        pincode = placemark[0].postalCode;
        administrativeArea = placemark[0].administrativeArea;
        placeName = placemark[0].name;
      });
    } catch (e) {
      print(e);
    }
  }

  void _updatePosition(CameraPosition _position) {
    Position newPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude);
    setState(() {
      currentPosition = newPosition;
    });
    moveCameraToPosition(currentPosition);
    getAddressFromPosition(currentPosition);
  }

  getLocationFromAddress(Placemark address) {
    setState(() {
      locality = address.locality;
      pincode = address.postalCode;
      placeName = address.name;
      administrativeArea = address.administrativeArea;
      currentPosition = address.position;
    });
  }

  void getCustomLocation() async {
    Prediction pred = await PlacesAutocomplete.show(
      context: context,
      strictbounds: currentPosition == null ? false : true,
      apiKey: "AIzaSyBe2JYm0NdPeRQlyOxk9HmRymw4WOSwkuM",
      mode: Mode.fullscreen,
      language: "en",
      location: Location(currentPosition.latitude, currentPosition.longitude),
      radius: currentPosition == null ? null : 100000,
      components: [Component(Component.country, "in")],
    );
    if (pred != null) {
      List<Placemark> plcmrk =
          await Geolocator().placemarkFromAddress(pred.description.toString());
      getLocationFromAddress(plcmrk[0]);
      moveCameraToPosition(currentPosition);
    }
  }

  Widget _getMap() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,
        onMapCreated: (controller) {
          mapCreated(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(User.lattitude, User.longitude),
          zoom: 17,
        ),
        onCameraMove: ((_position) => _updatePosition(_position)),
        markers: Set.of(<Marker>[
          Marker(
            markerId: MarkerId('currentPos'),
            position:
                LatLng(currentPosition.latitude, currentPosition.longitude),
          ),
        ]),
      ),
    );
  }

  Widget _getAddressText() {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.center,
          child: TextFormField(
            scrollPadding: EdgeInsets.all(0),
            initialValue: inputAddress,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              hintText: 'HOUSE / FLAT / BLOCK NO.',
            ),
            onChanged: (value) {
              setState(() {
                inputAddress = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _getLandmarkText() {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.center,
          child: TextFormField(
            scrollPadding: EdgeInsets.all(0),
            initialValue: inputLandmark,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              hintText: 'LANDMARK',
            ),
            onChanged: (value) {
              setState(() {
                inputLandmark = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _getPhoneNumber() {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.center,
          child: TextFormField(
            scrollPadding: EdgeInsets.all(0),
            initialValue: inputLandmark,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              hintText: 'Phone Number',
            ),
            onChanged: (value) {
              setState(() {
                phoneNumber = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _getSubmitButton() {
    return Container(
      height: 50,
      child: RaisedButton(
        color: mainColor,
        onPressed: () {
          try {
            if (inputAddress != null &&
                inputLandmark != null &&
                currentPosition != null &&
                phoneNumber != null &&
                phoneNumber.length == 10 &&
                isNumeric(phoneNumber) == true) {
              setState(() {
                User.primaryAddress = inputAddress;
                User.landmark = inputLandmark;
                User.lattitude = currentPosition.latitude;
                User.longitude = currentPosition.longitude;
                User.locality = locality;
                User.administrativeArea = administrativeArea;
                User.placeName = placeName;
                User.pincode = pincode;
                User.phone = phoneNumber;
                User.selectedShopId = '';
                User.selectedShopName = '';
                User.selectedShopNumber = '';
              });
              //remove prefs
              prefs.remove('loggedInUserPlaceName');
              prefs.remove('loggedInUserLocality');
              prefs.remove('loggedInUserPincode');
              prefs.remove('loggedInUserAdminstrativeArea');
              prefs.remove('loggedInUserPrimaryAddress');
              prefs.remove('loggedInUserLandmark');
              prefs.remove('loggedInUserLattitude');
              prefs.remove('loggedInUserLongitude');
              prefs.remove('loggedInUserAllocatedShopId');
              prefs.remove('loggedInUserAllocatedShopPhoneNumber');
              prefs.remove('loggedInUserPhoneNumber');

              //set preferences
              prefs.setString('loggedInUserPhoneNumber', User.phone);
              prefs.setString('loggedInUserPlaceName', User.placeName);
              prefs.setString('loggedInUserLocality', User.locality);
              prefs.setString('loggedInUserPincode', User.pincode);
              prefs.setString(
                  'loggedInUserAdminstrativeArea', User.administrativeArea);
              prefs.setString(
                  'loggedInUserPrimaryAddress', User.primaryAddress);
              prefs.setString('loggedInUserLandmark', User.landmark);
              prefs.setDouble('loggedInUserLattitude', User.lattitude);
              prefs.setDouble('loggedInUserLongitude', User.longitude);
              _firestore.document('users/' + User.uid).updateData({
                'uid': User.uid,
                'email': User.email,
                'displayName': User.displayName,
                'phoneNumber': User.phone,
                'gender': User.gender,
                'dob': User.dob.toString(),
                'placeName': User.placeName,
                'locality': User.locality,
                'administrativeArea': User.administrativeArea,
                'pincode': User.pincode,
                'primaryAddress': User.primaryAddress,
                'landmark': User.landmark,
                'geoLocation': GeoPoint(User.lattitude, User.longitude),
                'phoneNumber': User.phone,
                //'allocatedShopId': User.allocatedShopid,
                //'allocatedShopPhoneNumber': User.allocatedShopNumber,
              });
              Navigator.pop(context);
            } else {
              Alert(
                  context: context,
                  title: 'Please fill all the information correctly',
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ]).show();
            }
          } catch (e) {
            print(e);
            Alert(
                context: context,
                title: 'Cant update information.',
                desc:
                    'Please close the application and try again in some time.',
                buttons: [
                  DialogButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Okay',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ]).show();
          }
        },
        child: Text(
          'Save and Proceed',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 18,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Stack(
            children: <Widget>[
              ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: _getMap(),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.40,
                minChildSize: 0.35,
                maxChildSize: 0.6,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FloatingActionButton(
                                onPressed: () {
                                  getCurrentLocation();
                                },
                                backgroundColor: mainColor,
                                child: Icon(
                                  Icons.my_location,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          //
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            Icons.location_on,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: AutoSizeText(
                                            placeName,
                                            minFontSize: 15,
                                            maxFontSize: 20,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: RaisedButton(
                                        color: mainColor,
                                        onPressed: () async {
                                          getCustomLocation();
                                        },
                                        child: Text(
                                          'CHANGE',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Text(
                                          locality +
                                              ',' +
                                              administrativeArea +
                                              '-' +
                                              pincode,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _getAddressText(),
                                SizedBox(
                                  height: 10,
                                ),
                                _getLandmarkText(),
                                SizedBox(
                                  height: 20,
                                ),
                                _getPhoneNumber(),
                                SizedBox(
                                  height: 20,
                                ),
                                _getSubmitButton(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
