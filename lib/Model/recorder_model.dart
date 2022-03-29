class RecorderRequestModel {
  int? userid;
  String? sim;
  RecorderRequestModel({this.userid, this.sim});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['sim'] = this.sim;

    return data;
  }
}

class RecorderResponseModel {
  int? id;
  String? plateNumber;
  String? date;
  String? note;
  double? lat;
  double? log;
  

  RecorderResponseModel(
      {this.id, this.plateNumber, this.date, this.note, this.lat, this.log});

  RecorderResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plateNumber = json['plateNumber'];
    date = json['date'];
    note = json['note'];
    lat = json['lat'];
    log = json['log'];
  }
}

////////
///
