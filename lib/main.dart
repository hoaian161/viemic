import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viemic/screens/login/login.dart';
import 'package:viemic/utils/theme.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
        if (!details.toString().contains('overflow')) {
            FlutterError.presentError(details);
        }
    };
    runApp(const App());
}

class App extends StatelessWidget {
    const App({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: "VieMic",
            theme: DefaultTheme(),
            debugShowCheckedModeBanner: false,
            home: Login(),
        );
    }
}