
import 'package:flutter/material.dart';

/// https://flutter.dev/docs/cookbook/navigation/named-routes
/// https://medium.com/flutter/flutter-web-navigating-urls-using-named-routes-307e1b1e2050

/// https://stackoverflow.com/questions/56792479/flutter-animate-transition-to-named-route
/// https://www.youtube.com/watch?v=6vPF2IqCJ9Q

//Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen()));
/* // NICKEL SANS ANIMATION
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return ContactScreen();
                        }
                ));*/



/// Use
/*
Navigator.push( // push or pushReplacement
context,
FadeInRoute(
routeName: RouteNames.home,
page: MyHomeScreen(),
),
);
*/

class FadeInRoute extends PageRouteBuilder {
  final Widget page;

  /// UPDATE DATE USER STATUT POUR OUVERTURE AUTOMATIQUE SUR BONNE VIEW

  FadeInRoute({required this.page, required String routeName})
      : super(
    settings: RouteSettings(name: routeName),            // set name here
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
    FadeTransition(
      opacity: animation,
      child: child,
    ),
    transitionDuration: const Duration(milliseconds: 500),
  );
}



/*
 // Zoom Centrale
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 2),
          transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secAnimation,
          Widget child){
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },

          pageBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation) {
                return ContactScreen();
              }
          ));*/
class ZoomInRoute extends PageRouteBuilder {
  final Widget page;

  ZoomInRoute({required this.page, required String routeName})
      : super(
    settings: RouteSettings(name: routeName),            // set name here
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        ScaleTransition(
          alignment: Alignment.center,
          scale: animation,
          child: child,
        ),
    transitionDuration: const Duration(milliseconds: 500),
  );
}


/*
 // Rotation
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(seconds: 2),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child){
                  animation =CurvedAnimation(parent: animation, curve: Curves.elasticInOut);

                  return ScaleTransition(
                    alignment: Alignment.center,
                    scale: animation,
                    child: child,
                  );
                },

            pageBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return ContactScreen();
            }
        ));*/
class RotationInRoute extends PageRouteBuilder {
  final Widget page;

  RotationInRoute({required this.page, required String routeName})
      : super(
    settings: RouteSettings(name: routeName),            // set name here
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ){
      animation =CurvedAnimation(parent: animation, curve: Curves.elasticInOut);

      return ScaleTransition(
        alignment: Alignment.center,
        scale: animation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 700),
  );
}









