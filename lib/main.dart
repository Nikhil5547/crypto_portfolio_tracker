import 'package:crypto_portfolio_tracker/core/export_file.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.getInstance();
  Get.put(PortfolioController());
  Get.put(AssAssetController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringConstants.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
