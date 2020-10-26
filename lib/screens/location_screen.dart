import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:c19_app/services/data.dart';
import 'country_name.dart';
import 'package:c19_app/utilities/date_time.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationData, this.locationTravel});

  final locationData;
  final locationTravel;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  DataModel weather = DataModel();

  String countryName;
  String flag;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int todayRecovered;
  int active;
  int tests;
  String travelMessage;
  String id;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationData, widget.locationTravel);
  }

  void updateUI(dynamic casesData, dynamic travelData) {
    setState(() {
      if (casesData == null) {
        cases = 0;
        flag = 'Unable to get weather data';
        countryName = '';
        return;
      }

      cases = casesData['cases'];
      countryName = casesData['country'];
      todayCases = casesData['todayCases'];
      deaths = casesData['deaths'];
      todayDeaths = casesData['todayDeaths'];
      recovered = casesData['recovered'];
      todayRecovered = casesData['todayRecovered'];
      active = casesData['active'];
      tests = casesData['tests'];
      flag = casesData['countryInfo']['flag'];
      String str = '';
      for(var i=0;i<2;i++){
        str+=countryName[i];
      }
      id = str;
      //print(countryName);
      id = id.toUpperCase();
      //print(id);
      travelMessage = travelData['data']['$id']['advisory']['message'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF111328),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Row(
                    children: [
                      FlatButton(
                        onPressed: () async {
                          var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CountryScreen();
                          }));
                          //print(typedName);
                          if(typedName != null){
                            var weatherData = await weather.getCountryData(typedName);
                            var weatherData1 = await weather.getTravel(typedName);
                            updateUI(weatherData, weatherData1);
                          }
                        },
                        child: Icon(
                          Icons.search,
                          size: 35.0,
                        ),
                      ),
                      SizedBox(
                        width: 178,
                      ),
                      FlatButton(
                        onPressed: () async {
                          var weatherData = await weather.getLocationData();
                          var weatherData1 = await weather.getLocationTravel();
                          updateUI(weatherData, weatherData1);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 35.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text('Last updated',
                    style: TextStyle(
                      fontFamily: 'Poppins'
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        date(),
                        style: TextStyle(
                            fontFamily: 'Poppins'
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 1,
                        width: 16,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        time(),
                        style: TextStyle(
                            fontFamily: 'Poppins'
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(top: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network('$flag',
                                  scale: 3,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  '$countryName',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //color: Colors.pink,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Total cases: $cases',
                                        style: TextStyle(
                                        fontFamily: 'Unica'
                                        ),
                                      ),
                                      Text('Total deaths: $deaths',
                                        style: TextStyle(
                                            fontFamily: 'Unica'
                                        ),
                                      ),
                                      Text('Total recovered: $recovered',
                                        style: TextStyle(
                                            fontFamily: 'Unica'
                                        ),
                                      ),
                                      Text('Active cases: $active',
                                        style: TextStyle(
                                            fontFamily: 'Unica'
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('New cases: $todayCases',
                                        style: TextStyle(
                                            fontFamily: 'Unica'
                                        ),
                                      ),
                                      Text('New deaths: $todayDeaths',
                                        style: TextStyle(
                                            fontFamily: 'Unica'
                                        ),
                                      ),
                                      Text('New recovered: $todayRecovered',
                                        style: TextStyle(
                                            fontFamily: 'Unica'
                                        ),
                                      ),
                                      Text('Total tests: $tests',
                                        style: TextStyle(
                                            fontFamily: 'Unica'
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 30.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Travel Alert',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                      Image.network("http://pngimg.com/uploads/plane/plane_PNG5237.png",
                        scale: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 38.0, right: 38.0, bottom: 5.0),
                        child: Text(
                          '$travelMessage',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Unica',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}