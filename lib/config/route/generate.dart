import 'package:flutter/material.dart';
import 'package:todo/screen/add_task/add_task.dart';
import 'package:todo/screen/detail_task/detail_task.dart';
import 'package:todo/screen/home/home.dart';
import 'package:todo/screen/show_image/show_image.dart';
import 'package:todo/screen/splash/splash.dart';

import 'const.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    return Routes.fadeThrough(settings, (context) {
      switch (settings.name) {
        case RouteName.init:
          return const Splash();
        case RouteName.home:
          return const Home();
        case RouteName.addTask:
          return const AddTask();
        case RouteName.showImage:
          return ShowImage(image: args as String);
        case RouteName.detailTask:
          return DetailTask(
            index: args as int,
          );
        default:
          return _errorRoute(settings.name);
      }
    });
  }

  static Widget _errorRoute(routeName) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text('ERROR : $routeName route not found'),
      ),
    );
  }
}

class Routes {
  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 400}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
