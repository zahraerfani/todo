import 'package:flutter/material.dart';
import 'package:todo/config/route/const.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) =>
        Navigator.of(context)
            .pushNamedAndRemoveUntil(RouteName.home, (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Center(
          child: Text("Loading...", style: textTheme.bodyText1),
        ),
      ),
    );
  }
}
