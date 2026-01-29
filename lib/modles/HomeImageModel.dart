
class HomeImageModel {
  String challengeImage;

  HomeImageModel({
    required this.challengeImage,
  });

  factory HomeImageModel.fromJson(Map<String, dynamic> json) => HomeImageModel(
    challengeImage: json["challenge_image"],
  );


}
