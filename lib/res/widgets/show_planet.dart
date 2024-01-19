import 'package:flutter/material.dart';
import 'package:solar_system/res/constants/constants.dart';

class ShowPlanet extends StatelessWidget {
  ShowPlanet(
      {super.key,
      required this.onTap,
      required this.index,
      required this.imageHeight,
      required this.opicaty,
      required this.opicatyDuration,
        required this.customAnimation
      });

  int index = 0;
  double imageHeight = 0.0;
  double opicaty = 0.0;
  int opicatyDuration = 0;
  void Function()? onTap;
  Animation<double> customAnimation;

  List imageList = [kEarthImage, kMarsImage];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: Duration(seconds: 2),
        transitionBuilder: (Widget child , Animation<double> animation){
          return RotationTransition(
              turns: customAnimation.drive(
                  Tween<double>(
                    begin: 0.1,
                    end: -0.5,
                  ),
              ),
            child: SlideTransition(
              position: Tween<Offset>(
                  begin: index == 0 ? const Offset(0.15, 0.1) : const Offset(0.7, 0.4),
                  end: index == 0 ? const Offset(0-0.6, -0.5) : const Offset(-3.5, -2.2)
              ).animate(customAnimation),
              child: child,
            ),
          );
        },
        child: AnimatedOpacity(
          opacity: opicaty,
          duration: Duration(milliseconds: opicatyDuration),
          child: SizedBox(
            height: imageHeight,
            child: Image.asset(imageList[index]),
          ),
        ),
      ),
    );
  }
}
