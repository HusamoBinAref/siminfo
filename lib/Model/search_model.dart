class SearchRequestModel {
  String? plateNumber;
  String? note;
  String? date;
  double? lat;

  double? log;
  int? userid; //long
  String? sim;

  SearchRequestModel(
      {this.plateNumber,
      this.note,
      this.lat,
      this.log,
      this.date,
      this.sim,
      this.userid});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plateNumber'] = this.plateNumber;
    data['note'] = this.note;
    data['lat'] = this.lat;
    data['log'] = this.log;
    data['sim'] = this.sim;
    data['date'] = this.date;
    data['userid'] = this.userid;

    return data;
  }
}
