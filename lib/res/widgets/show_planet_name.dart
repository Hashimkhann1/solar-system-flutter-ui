import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_system/res/constants/constants.dart';

class ShowPlanetName extends StatelessWidget {

  String planetName;
  String planetDescripition;
  double opacity;

  ShowPlanetName({super.key,required this.planetName,required this.planetDescripition,required this.opacity});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: opacity, duration: Duration(seconds: 1),
          child: Text(planetName,style: GoogleFonts.exo(
            textStyle: TextStyle(
              color: kWhietCOlor,
              fontSize: 45,
              fontWeight: FontWeight.bold
            )
          ),),
        ),
        AnimatedOpacity(
          opacity: opacity, duration: Duration(seconds: 1),
          child: Text(planetDescripition,style: GoogleFonts.exo(
            textStyle: TextStyle(
              color: kWhietCOlor,
              fontSize: 20,
              // fontWeight: FontWeight.bold
            )
          ),),
        ),
      ],
    );
  }
}
