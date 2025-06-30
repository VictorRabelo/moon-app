import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/moon_data.dart';
import '../utils/constants.dart';

class MoonService {
  static const _baseUrl = 'https://api.farmsense.net/v1/moonphases/?d=';

  Future<MoonData> fetchMoonData() async {
    final now = DateTime.now();
    final response = await http.get(Uri.parse('$_baseUrl${now.millisecondsSinceEpoch ~/ 1000}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch moon data');
    }
    final List<dynamic> body = jsonDecode(response.body);
    final data = body.first as Map<String, dynamic>;
    final phase = data['Phase'] ?? '';
    final illumination = double.tryParse(data['Illumination'].toString()) ?? 0;
    final nextInfo = await _findNextPhase(now, phase);
    return MoonData(
      phase: phase,
      illumination: illumination,
      nextPhase: nextInfo['phase'] as String,
      nextPhaseDate: nextInfo['date'] as DateTime,
    );
  }

  Future<Map<String, dynamic>> _findNextPhase(DateTime start, String currentPhase) async {
    DateTime date = start.add(const Duration(days: 1));
    while (true) {
      final response = await http.get(Uri.parse('$_baseUrl${date.millisecondsSinceEpoch ~/ 1000}'));
      if (response.statusCode != 200) break;
      final List<dynamic> body = jsonDecode(response.body);
      final data = body.first as Map<String, dynamic>;
      final phase = data['Phase'] ?? '';
      if (phase != currentPhase) {
        return {
          'phase': phase,
          'date': date,
        };
      }
      date = date.add(const Duration(days: 1));
    }
    final index = kPhases.indexOf(currentPhase);
    final nextIndex = (index + 1) % kPhases.length;
    return {
      'phase': kPhases[nextIndex],
      'date': date,
    };
  }
}
