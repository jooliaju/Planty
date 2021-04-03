
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import "package:http_parser/http_parser.dart";


Future<PlantRecommendation> upload({String imageFile, String imagePath}) async {
  String apiKey = "2b10SIEW7oBMIMc6FWThazVk";

  FormData formData = new FormData.fromMap({
    "organs": "flower",
    "images": await MultipartFile.fromFile(imagePath,filename: imageFile, contentType: new MediaType("images", "png"))
  });

  Dio dio = new Dio();

  Response response = await dio.post("https://my-api.plantnet.org/v2/identify/all?api-key=" + apiKey, data: formData, options: Options());

  int statusCode = response.statusCode;
  print (statusCode);

  if (statusCode == 200) {

    print("status code: " + statusCode.toString() + "... it worked!");
    final jsonResponse = jsonDecode(response.toString());
    print (jsonResponse);

    print("results:" + jsonResponse["results"].toString());

    List listOfPlants;
    listOfPlants = jsonResponse["results"];

    PlantRecommendation plantRecommendation = new PlantRecommendation();
    //
    // plantRecommendation.score = listOfPlants[0]["score"].toString()
    //


    print("score: " + listOfPlants[0]["score"].toString());

    print("Scientific name: " + listOfPlants[0]["species"]["scientificNameWithoutAuthor"]);

    print("common name :) " + listOfPlants[0]["species"]["commonNames"][0]);



  }

  else{
    print("error status code: " + statusCode.toString() + " ... :(");
  }


}

class PlantRecommendation {

  List results;
  double score;


  PlantRecommendation({
    this.results,
    this.score
  });

}




///TODO: Figure out if you need this code lol
//
// class PlantId {
//
//   PlantId({
//     this.language,
//     this.results,
//   });
//
//   String language;
//   List<Result> results;
//
//   factory PlantId.fromJson(Map<String, dynamic> json) => PlantId(
//     language: json["language"],
//     results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "language": language,
//     "results": List<dynamic>.from(results.map((x) => x.toJson())),
//
//   };
//
//
// }
//
// class Result {
//   Result({
//     this.score,
//     this.species,
//   });
//
//   double score;
//   Species species;
//
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     score: json["score"].toDouble(),
//     species: Species.fromJson(json["species"]),
//
//   );
//
//   Map<String, dynamic> toJson() => {
//     "score": score,
//     "species": species.toJson(),
//   };
// }
//
// class Species {
//   Species({
//     this.scientificNameWithoutAuthor,
//     this.scientificNameAuthorship,
//     this.genus,
//     this.family,
//     this.commonNames,
//   });
//
//   String scientificNameWithoutAuthor;
//   String scientificNameAuthorship;
//   Family genus;
//   Family family;
//   List<String> commonNames;
//
//   factory Species.fromJson(Map<String, dynamic> json) => Species(
//     scientificNameWithoutAuthor: json["scientificNameWithoutAuthor"],
//     scientificNameAuthorship: json["scientificNameAuthorship"],
//     genus: Family.fromJson(json["genus"]),
//     family: Family.fromJson(json["family"]),
//     commonNames: List<String>.from(json["commonNames"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "scientificNameWithoutAuthor": scientificNameWithoutAuthor,
//     "scientificNameAuthorship": scientificNameAuthorship,
//     "genus": genus.toJson(),
//     "family": family.toJson(),
//     "commonNames": List<dynamic>.from(commonNames.map((x) => x)),
//   };
// }
//
// class Family {
//   Family({
//     this.scientificNameWithoutAuthor,
//     this.scientificNameAuthorship,
//   });
//
//   String scientificNameWithoutAuthor;
//   String scientificNameAuthorship;
//
//   factory Family.fromJson(Map<String, dynamic> json) => Family(
//     scientificNameWithoutAuthor: json["scientificNameWithoutAuthor"],
//     scientificNameAuthorship: json["scientificNameAuthorship"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "scientificNameWithoutAuthor": scientificNameWithoutAuthor,
//     "scientificNameAuthorship": scientificNameAuthorship,
//   };
// }
