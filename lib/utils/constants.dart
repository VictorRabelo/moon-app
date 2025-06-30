import 'package:flutter/material.dart';

const List<String> kPhases = [
  'New Moon',
  'Waxing Crescent',
  'First Quarter',
  'Waxing Gibbous',
  'Full Moon',
  'Waning Gibbous',
  'Last Quarter',
  'Waning Crescent',
];

const Map<String, String> kPhaseEmojis = {
  'New Moon': '🌑',
  'Waxing Crescent': '🌒',
  'First Quarter': '🌓',
  'Waxing Gibbous': '🌔',
  'Full Moon': '🌕',
  'Waning Gibbous': '🌖',
  'Last Quarter': '🌗',
  'Waning Crescent': '🌘',
};

final Gradient kBackgroundGradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF000428), Color(0xFF004e92)],
);
