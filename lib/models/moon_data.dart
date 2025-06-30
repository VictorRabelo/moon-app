class MoonData {
  final String phase;
  final double illumination;
  final String nextPhase;
  final DateTime nextPhaseDate;

  MoonData({
    required this.phase,
    required this.illumination,
    required this.nextPhase,
    required this.nextPhaseDate,
  });

  factory MoonData.fromJson(Map<String, dynamic> json) {
    return MoonData(
      phase: json['Phase'] ?? '',
      illumination: double.tryParse(json['Illumination'].toString()) ?? 0,
      nextPhase: json['NextPhase'] ?? '',
      nextPhaseDate: DateTime.tryParse(json['NextPhaseDate'] ?? '') ?? DateTime.now(),
    );
  }
}
