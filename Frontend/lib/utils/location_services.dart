import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = 'AIzaSyBC1gKXR25mpST0waFJM52jHwR4HFIrePs';

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    // print(json['candidates']);
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);
    return placeId;
  }
}
