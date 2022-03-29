class Farze1Model {
  String? id;
  String? company;
  String? plateNumber;
  String? vehicleModel;
  String? vehicleMarker;
  String? moserColor;
  String? bank;
  String? date;

  String? note;
  double? lat;
  double? log;

  Farze1Model(
      {this.id,
      this.company,
      this.bank,
      this.plateNumber,
      this.date,
      this.note,
      this.lat,
      this.log,
      this.moserColor,
      this.vehicleMarker,
      this.vehicleModel});

     
  Farze1Model.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    plateNumber = json['plateNumber'];
    date = json['date'];
    note = json['note'];
    lat = json['lat'];
    log = json['log'];

    bank=json['bank'];
    company=json['company'];
    vehicleModel=json['vehicleModel'];
    vehicleMarker=json['vehicleMarker'];
    moserColor=json['moserColor'];

  }
}
