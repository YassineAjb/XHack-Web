class Patient {
  final String? id;
  final int recipientAge;
  final String hlaLocus;
  final String recipientBloodType;
  final int praLevel;
  final String? isCrossmatchPositive;
  final String? recipientDiabetes;
  final int? previousTransplants;
  late final bool isUsed;
  final String? doctor;
  final int? urgency;
  final String? cin;

  Patient({
    this.id,
    required this.recipientAge,
    required this.hlaLocus,
    required this.recipientBloodType,
    required this.praLevel,
    this.isCrossmatchPositive,
    this.recipientDiabetes,
    this.previousTransplants,
    this.isUsed = false,
    required this.doctor,
    required this.urgency,
    required this.cin,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'],
      recipientAge: json['recipientAge'],
      hlaLocus: json['hlaLocus'],
      recipientBloodType: json['recipientBloodType'],
      praLevel: json['praLevel'],
      isCrossmatchPositive: json['isCrossmatchPositive'],
      recipientDiabetes: json['recipientDiabetes'],
      previousTransplants: json['previousTransplants'],
      isUsed: json['isUsed'] ?? false,
      doctor: json['doctor'] is Map ? json['doctor']['_id'] : json['doctor'],
      urgency: json['urgency'],
      cin: json['cin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientAge': recipientAge,
      'hlaLocus': hlaLocus,
      'recipientBloodType': recipientBloodType,
      'praLevel': praLevel,
      if (isCrossmatchPositive != null)
        'isCrossmatchPositive': isCrossmatchPositive,
      if (recipientDiabetes != null) 'recipientDiabetes': recipientDiabetes,
      if (previousTransplants != null)
        'previousTransplants': previousTransplants,
      'isUsed': isUsed,
      'doctor': doctor,
      'urgency': urgency,
      'cin':cin,
    };
  }
}
