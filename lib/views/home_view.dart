import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../viewmodels/moon_view_model.dart';
import '../widgets/moon_widget.dart';
import '../widgets/starfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MoonViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(gradient: kBackgroundGradient),
        child: Stack(
          children: [
            const Positioned.fill(child: StarfieldWidget()),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (vm.isLoading) const CircularProgressIndicator(),
                    if (vm.error != null) Text(vm.error!),
                    if (vm.data != null) ...[
                      MoonWidget(illumination: vm.data!.illumination),
                      const SizedBox(height: 16),
                      Text(
                        '${kPhaseEmojis[vm.data!.phase] ?? ''} ${vm.data!.phase}',
                        style: GoogleFonts.spaceMono(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Illumination: ${vm.data!.illumination.toStringAsFixed(1)}%',
                        style: GoogleFonts.spaceMono(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Next: ${vm.data!.nextPhase} on ${vm.data!.nextPhaseDate.toLocal().toString().split(' ').first}',
                        style: GoogleFonts.spaceMono(color: Colors.white70),
                      ),
                    ],
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: vm.fetchMoon,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
