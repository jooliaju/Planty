import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:dio/adapter.dart';
import "package:http_parser/http_parser.dart";

class PlantIdService {
  final String findPlantIdUrl =
      "https://my-api.plantnet.org/v2/identify/all?api-key=";
  final String apiKey = "2b10wBiq68CxwmKgX5we6aY9e";

  // Future<List<PlantId>> getPlantId(File file) async {
  //   Response res = await post(findPlantIdUrl + apiKey);

  //      Map<String, String> _headers = {
  //       "Content-type": "application/json",
  //       "Authorization": "Bearer $apiKey"
  //     };

  //      Map<String, dynamic> _data = Map();
  //     _data["images"] = file;
  //     _data["organs"] = "flower";

  //   if (res.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(res.body);

  //     List<PlantId> plantIds =
  //         body.map((dynamic item) => PlantId.fromJson(item)).toList();

  //     return plantIds;
  //   } else {
  //     throw "not called properly";
  //   }
  // }

  Future<PlantId> upload({String imageFile, String imagePath}) async {
    PlantId plantId;

    FormData formData = new FormData.fromMap({
      "organs": "leaf",
      "images": await MultipartFile.fromFile(imagePath,
          filename: imageFile, contentType: new MediaType("images", "png"))
    });

    Dio dio = new Dio();

    Response response = await dio.post(
        "https://my-api.plantnet.org/v2/identify/all?api-key=" + apiKey,
        data: formData,
        options: Options());

    int statusCode = response.statusCode;
    print(statusCode);

    if (statusCode == 200) {
      print("status code: " + statusCode.toString() + "... it worked!");
      final jsonResponse = jsonDecode(response.toString());
      print(jsonResponse);

      print("results:" + jsonResponse["results"].toString());

      List listOfPlants;
      listOfPlants = jsonResponse["results"];

      //
      // plantRecommendation.score = listOfPlants[0]["score"].toString()
      //

      print("score: " + listOfPlants[0]["score"].toString());
      double _score = listOfPlants[0]['score'];

      print("Scientific name: " +
          listOfPlants[0]["species"]["scientificNameWithoutAuthor"]);
      String _scientificName =
          listOfPlants[0]["species"]["scientificNameWithoutAuthor"];

      print("common name :) " + listOfPlants[0]["species"]["commonNames"][0]);
      String _commonName = listOfPlants[0]["species"]["commonNames"][0];

      plantId = new PlantId(
          commonName: _commonName,
          scientificName: _scientificName,
          score: _score);

      return plantId;
    }
  }
}
