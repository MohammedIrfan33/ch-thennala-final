
class ChallengeModel {
  String id;
  String challenge_name;
  String challenge_image;
  String challenge_startdate;
  String challenge_enddate;
  String location;
  String description;
  String showdistrictandassembly;


  ChallengeModel({
    required this.id,
    required this.challenge_name,
    required this.challenge_image,
    required this.challenge_startdate,
    required this.challenge_enddate,
    required this.location,
    required this.description,
    required this.showdistrictandassembly
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) => ChallengeModel(
    id: json["id"],
    challenge_name: json["challenge_name"],
    challenge_image: json["challenge_image"],
    challenge_startdate: json["challenge_startdate"],
    challenge_enddate: json["challenge_enddate"],
    location: json["location"],
    description: json["description"],
    showdistrictandassembly: json["showdistrictandassembly"]

  );

}