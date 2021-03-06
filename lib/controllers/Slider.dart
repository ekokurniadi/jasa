
import 'package:http/http.dart' as http;
import 'package:jasa_app/models/Slider.dart';
import '../configuration/config.dart';

class SliderController {
  Future getData() async {
    final response = await http.get(Config.BASE_URL + "photos");
    final data = sliderFromJson(response.body);

    return data;
  }
}
