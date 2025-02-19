import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viemic/screens/home/home.dart';

void main() {
    runApp(const App());
}

class App extends StatelessWidget {
    const App({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: "VieMic",
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                textTheme: GoogleFonts.nunitoTextTheme(),
            ),
            debugShowCheckedModeBanner: false,
            home: Home(),
        );
    }
}