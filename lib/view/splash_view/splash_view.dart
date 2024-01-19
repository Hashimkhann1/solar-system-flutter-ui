import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_system/res/constants/constants.dart';
import 'package:solar_system/view/home_view/home_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.colorBurn),
            image: AssetImage(kSplashImage)
          )
        ),
        child: imageText(context),
      )
    );
  }

  Widget imageText(BuildContext context){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("EXPLORE",style: GoogleFonts.exo2(
            textStyle: const TextStyle(
              fontSize: 35,
              color: kWhietCOlor
            )
          ),),
          Text("SOLOR",style: GoogleFonts.exo2(
            textStyle: const TextStyle(
              fontSize: 35,
              color: kWhietCOlor
            )
          ),),
          Text("SYSTEM",style: GoogleFonts.exo2(
            textStyle: const TextStyle(
              fontSize: 35,
              color: kWhietCOlor
            )
          ),),
          const SizedBox(height: 10,),
          CupertinoButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
            },
              minSize: 0,
              padding: EdgeInsets.zero,
              child: Icon(Icons.arrow_forward,size: 30,color: Colors.white30,)
          ),
          const SizedBox(height: 120,),
        ],
      ),
    );
  }

}
