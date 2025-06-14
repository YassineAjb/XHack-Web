class Organ {
  final String? id;
  final int donorAge;
  final String bloodType;
  final String hlaLocus;
  final double coldIschemiaTimeHr;
  final double distanceKm;
  final bool isUsed;

  Organ({
    this.id,
    required this.donorAge,
    required this.bloodType,
    required this.hlaLocus,
    required this.coldIschemiaTimeHr,
    required this.distanceKm,
    this.isUsed = false,
  });

  factory Organ.fromJson(Map<String, dynamic> json) {
    return Organ(
      id: json['_id'],
      donorAge: json['donor_age'],
      bloodType: json['blood_type'],
      hlaLocus: json['hlaLocus'],
      coldIschemiaTimeHr: json['cold_ischemia_time_hr'].toDouble(),
      distanceKm: json['distance_km'].toDouble(),
      isUsed: json['isUsed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'donor_age': donorAge,
      'blood_type': bloodType,
      'hlaLocus': hlaLocus,
      'cold_ischemia_time_hr': coldIschemiaTimeHr,
      'distance_km': distanceKm,
      'isUsed': isUsed,
    };
  }
}
