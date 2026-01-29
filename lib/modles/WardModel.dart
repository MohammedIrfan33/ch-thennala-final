

class WardModel {
  String id;
  String name;

  WardModel({
    required this.id,
    required this.name,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) => WardModel(
    id: json["id"],
    name: json["name"],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WardModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => name;
}