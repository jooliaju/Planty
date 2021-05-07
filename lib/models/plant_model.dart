class Plant {
  final String name;
  final String type;
  final String bio;
  final DateTime nextWaterDate;
  final int waterTime;
  final String imageUrl;
    final String plantId;


  Plant(this.plantId, 
      {this.name,
      this.bio,
      this.imageUrl,
      this.type,
      this.nextWaterDate,
      this.waterTime});
}

class PlantId {
  final String scientificName;
  final double score;
  final String commonName;

  PlantId( {this.scientificName, this.score, this.commonName});

  // factory PlantId.fromJson(Map<String, dynamic> json) {
  //   return PlantId(
  //     score: json['results'][0]['score'] as double,
  //     scientificName: json['results'][0]['species']
  //         ['scientificNameWithoutAuthor'] as String,
  //         commonName: json['results'][0]['species']['commonNames'][0];
  //   );
  // }
}
