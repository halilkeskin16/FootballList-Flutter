class EuropeCountryModel {
  final int id;
  final String name;
  final String? flag;
  final int parentAreaId;
  final String parentArea;

  EuropeCountryModel(
      this.id, this.name, this.flag, this.parentAreaId, this.parentArea);
  
  EuropeCountryModel.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json['id'].toString()) ?? 0,
        name = json['name'],
        flag = json['flag'],
        parentAreaId = int.tryParse(json['parentAreaId'].toString()) ?? 0,
        parentArea = json['parentArea'];
}
