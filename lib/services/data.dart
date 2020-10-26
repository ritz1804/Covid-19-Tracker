import 'package:c19_app/services/location.dart';
import 'package:c19_app/services/networking.dart';

const casesURL = 'https://disease.sh/v3/covid-19/countries/';
const travel = 'https://www.travel-advisory.info/api?countrycode=';

class DataModel {

  Future<dynamic> getCountryData(String countryName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$casesURL$countryName');

    var weatherData = await networkHelper.getData();
    //print(weatherData);
    return weatherData;
  }

  Future<dynamic> getTravel(String cityName) async {
    NetworkHelper networkHelper1 = NetworkHelper(
        '$travel$cityName');

    var weatherData1 = await networkHelper1.getData();
    //print(weatherData1);
    return weatherData1;
  }

  Future<dynamic> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$casesURL' + 'india');

    var weatherData = await networkHelper.getData();
    //print(weatherData);
    return weatherData;
  }

  Future<dynamic> getLocationTravel() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper1 = NetworkHelper(
        '$travel' + 'india');

    var weatherData1 = await networkHelper1.getData();
    //print(weatherData1);
    return weatherData1;
  }

}