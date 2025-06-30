import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/moon_service.dart';
import 'viewmodels/moon_view_model.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MoonApp());
}

class MoonApp extends StatelessWidget {
  const MoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoonViewModel(MoonService())..fetchMoon(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'SpaceMono'),
        ),
        home: const HomeView(),
      ),
    );
  }
}
