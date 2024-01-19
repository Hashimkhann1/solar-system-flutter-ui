

class PlanetDescripitionModel {
  String? name;
  String? descripition;

  PlanetDescripitionModel({this.name, this.descripition});

  PlanetDescripitionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    descripition = json['descripition'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name':name,
      'descripition':descripition,
    };
  }
}
