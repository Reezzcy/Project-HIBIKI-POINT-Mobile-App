import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/providers/auth_provider.dart';
import 'package:project_hibiki_point_mobile_app/providers/campaign_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:project_hibiki_point_mobile_app/splash_screen.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const HibikiPointApp());
  });
}

class HibikiPointApp extends StatelessWidget {
  const HibikiPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CampaignProvider()),
        // Add other providers as needed
      ],
      child: MaterialApp(
        title: 'Hibiki Points App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
