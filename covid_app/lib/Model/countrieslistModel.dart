class CountryInfo {
  CountryInfo({
    required this.id,
    required this.iso2,
    required this.iso3,
    required this.lat,
    required this.long,
    required this.flag,
  });

  final num id;
  final String iso2;
  final String iso3;
  final num lat;
  final num long;
  final String flag;

  CountryInfo.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        iso2 = json['iso2'],
        iso3 = json['iso3'],
        lat = json['lat'],
        long = json['long'],
        flag = json['flag'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'iso2': iso2,
      'iso3': iso3,
      'lat': lat,
      'long': long,
      'flag': flag,
    };
  }
}
