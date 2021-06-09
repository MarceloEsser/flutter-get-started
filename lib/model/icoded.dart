class Icoded {
  final String name;
  final bool loveTransformers;
  final String description;
  final int luckyNumber;

  Icoded(this.name, this.loveTransformers, this.description, this.luckyNumber);

  Icoded.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        loveTransformers = json['loveTransformers'],
        description = json['description'],
        luckyNumber = json['luckyNumber'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'loveTransformers': loveTransformers,
        'description': description,
        'luckyNumber': luckyNumber,
      };
}