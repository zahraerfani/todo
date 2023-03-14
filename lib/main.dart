import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:todo/config/route/const.dart';
import 'package:todo/config/route/generate.dart';
import 'package:todo/config/themes/themes_data.dart';
import 'package:todo/data/hive/hive_helpers.dart';
import 'package:todo/data/repository.dart';
import 'package:todo/provider/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.initializes();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MultiProvider(providers: providers, child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        child: MaterialApp(
      navigatorKey: Repository.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      locale: const Locale("en", "US"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      theme: themeData,
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 800,
          minWidth: 400,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.autoScale(400, name: MOBILE),
            ResponsiveBreakpoint.resize(800, name: TABLET),
            ResponsiveBreakpoint.resize(600, name: DESKTOP),
            ResponsiveBreakpoint.resize(1700, name: 'XL')
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      darkTheme: themeData,
      initialRoute: RouteName.init,
      onGenerateRoute: RouteGenerator.generateRoute,
    ));
  }
}
