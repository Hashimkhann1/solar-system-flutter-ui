import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solar_system/model/planet_descripition_model.dart';
import 'package:solar_system/res/constants/constants.dart';
import 'package:solar_system/res/widgets/back_shining.dart';
import 'package:solar_system/res/widgets/show_planet.dart';
import 'package:solar_system/res/widgets/show_planet_detials.dart';
import 'package:solar_system/res/widgets/show_planet_name.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late AnimationController _marsAnimationController;
  late AnimationController _marsHeightAnimationController;

  late Animation<double> _earthOpicatyAnimation;
  late Animation<double> _marsOpicatyAnimation;
  late Animation<double> _welcomeOpacityAnimation;
  late Animation<double> _earthReverseAnimation;
  late Animation<double> _marsReverseAnimation;
  late Animation<double> _earthAnimation;
  late Animation<double> _marsAnimation;

  double customHeight = 0.0;
  double _marsHeight = 750.0;
  double customWidth = 0.0;
  double backShiningHeight = 400.0;
  double backShiningInitialHeight = 400.0;
  double backShiningFinalHeight = 150.0;

  double marsInitialHeight = 750.0;
  double marsFinalHeight = 300.0;

  List<PlanetDescripitionModel> planetValues = [];

  double _welcomeOpacity = 1.0;
  double _earthOpacity = 1.0;
  double _marsOpacity = 0.0;

  int index = 0;
  bool showMars = false;
  bool isExpanded = false;
  bool showDetails = false;
  bool showDetailsAnimation = false;

  addDetails() {
    planetValues.add(PlanetDescripitionModel(name: 'EARTH',descripition: "Our lovely planet"));
    planetValues.add(PlanetDescripitionModel(name: 'MARS',descripition: "Neigbor"));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addDetails();

    _animationController = AnimationController(
        vsync: this,
      duration: Duration(milliseconds: 1500)
    );

    // mars animation controller
    _marsAnimationController = AnimationController(
        vsync: this,
      duration: Duration(milliseconds: 800)
    );

    _marsHeightAnimationController = AnimationController(
        vsync: this,
      duration: Duration(milliseconds: 1500)
    );

    _earthOpicatyAnimation = Tween<double>(begin: 1.0,end: 0.0).animate(_animationController);
    _welcomeOpacityAnimation = Tween<double>(begin: 1.0,end: 0.0).animate(_marsAnimationController);
    _marsOpicatyAnimation = Tween<double>(begin: 0.8,end: 1.0).animate(_marsAnimationController);
    _earthReverseAnimation = Tween<double>(begin: 0.1,end: 0.5).animate(_animationController);
    _marsReverseAnimation = Tween<double>(begin: 0.04,end: 0.1).animate(_marsAnimationController);
    print(_marsReverseAnimation.value);
    // mars reverse animation
    // _marsReverseAnimation = Tween<double>(begin: 0.04,end: 0.1).animate(_marsAnimationController);

    _earthAnimation = CurvedAnimation(
      curve: Curves.easeOut,
      parent: _earthReverseAnimation
    );

    _marsAnimation = CurvedAnimation(
      curve: Curves.easeOut,
      parent: _marsReverseAnimation
    );

    _animationController.addListener(() {
      setValues();

      if(_animationController.isCompleted){
        setState(() {
          index = index == 1 ? 0:1;
        });
      }

      if(_earthOpicatyAnimation.value == 1.0){
        _stratMarsAnimation();
      }
    });


    _marsAnimationController.addListener(() {
      setMarsValues();
    });

    _marsHeightAnimationController.addListener(() {
      setState(() {
        _marsHeight = Tween<double>(
          begin: marsInitialHeight,
          end: marsFinalHeight
        ).animate(_marsHeightAnimationController).value;
      });

      backShiningHeight = Tween<double>(
          begin: backShiningInitialHeight,
          end: backShiningFinalHeight
      ).animate(_marsHeightAnimationController).value;

      if(_marsHeightAnimationController.isCompleted){
        setMarsDetailsAnimation();
      }
    });
  }

  void setValues() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _earthOpacity = _earthOpicatyAnimation.value;
    });
  }

  setMarsValues() async {
    setState(() {
      showMars = true;
      _marsOpacity = _marsOpicatyAnimation.value;
    });
  }

  void startanimation() {
    _animationController.reset();
    _animationController.forward();
  }

  _stratMarsAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    _marsAnimationController.reset();
    _marsAnimationController.forward();
  }

  _startChangeMarsPositionAnimation() {
    setState(() {
      isExpanded = true;
      _marsHeightAnimationController.forward();
      _welcomeOpacity = _welcomeOpacityAnimation.value;
    });
  }

  setMarsDetailsAnimation() async {
    setState(() {
      showDetails = true;
    });
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      showDetailsAnimation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    customHeight = MediaQuery.of(context).size.height;
    customWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(color: kBGColor,),
          setPlanets(),
          Positioned(
            left: customHeight * 0.03,
              top: customHeight * 0.06,
              child: AnimatedOpacity(
                opacity: _welcomeOpacity,
                duration: Duration(milliseconds: 1500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome",style: GoogleFonts.exo(
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: kWhietCOlor,
                        fontWeight: FontWeight.bold
                      )
                    ),),
                    const SizedBox(height: 20,),
                    Text("Clarie Maiden",style: GoogleFonts.exo(
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: kWhietCOlor,
                        fontWeight: FontWeight.bold
                      )
                    ),),
                  ],
                ),
              ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
              top: isExpanded ? 150 : customHeight * 0.38,
              child: BackShining(backHeight: backShiningHeight,)
          ),
          Positioned(
              top: customHeight * 0.35,
              left:  customWidth * 0.34,
              child: Center(
                child: ShowPlanetName(
                  planetName: planetValues[0].name.toString(),
                  planetDescripition: planetValues[0].descripition.toString(),
                  opacity: _earthOpacity,
                ),
              )
          ),
          Positioned(
            top: customHeight * 0.44,
              right: -85,
              child: ShowPlanet(
                index: 0,
                imageHeight: 600,
                opicaty: _earthOpacity,
                opicatyDuration: 100,
                onTap: startanimation,
                customAnimation: _earthAnimation,
              )
          ),
          showMars ? AnimatedPositioned(
              top: isExpanded ? 60 : customHeight * 0.35,
              left: isExpanded ? customWidth * 0.35 : customWidth * 0.34,
              duration: Duration(milliseconds: 1500),
              child: Center(
                child: ShowPlanetName(
                  planetName: planetValues[1].name.toString(),
                  planetDescripition: planetValues[1].descripition.toString(),
                  opacity: _marsOpacity,
                ),
              )
          ) : const SizedBox(),

          showMars ? AnimatedPositioned(
              top: isExpanded ? 120 : customHeight * 0.35,
              right: isExpanded ? 70 : -140,
              duration: Duration(milliseconds: 1500),
              child: ShowPlanet(
                index: 1,
                imageHeight: _marsHeight,
                opicaty: _marsOpacity,
                opicatyDuration: 800,
                onTap: _startChangeMarsPositionAnimation,
                customAnimation: _marsAnimation,
              )
          ) : SizedBox(),

          showDetails ? AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: customHeight * 0.20,
            right: showDetailsAnimation ? customWidth * 0.09 : -customWidth,
            child: Center(
              child: ShowTempature(),
            ),
          ) : SizedBox(),

          showDetails ? AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: customHeight * 0.500,
              right: showDetailsAnimation ? customWidth * 0.32 : -customWidth,
              child: Center(
                child: ShowText(),
              )
          ) : SizedBox(),

          showDetails ? AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: customHeight * 0.52,
              right: showDetailsAnimation ? customWidth * 0 : -customWidth,
              child: Center(
                child: ShowPlanetDetails(),
              )
          ) : SizedBox(),

        ],
      ),
    );
  }

  Widget setPlanets() {
    return Stack(
      children: [
        Positioned(
            left: customHeight * 0.24,
            top: customHeight * 0.1,
            child: planetCircle(height: 5.0)
        ),
        Positioned(
            left: customHeight * 0.35,
            top: customHeight * 0.2,
            child: planetCircle(height: 3.0)
        ),
        Positioned(
            left: customHeight * 0.4,
            top: customHeight * 0.3,
            child: planetCircle(height: 4.0)
        ),
        Positioned(
            left: customHeight * 0.15,
            top: customHeight * 0.24,
            child: planetCircle(height: 3.0)
        ),
        Positioned(
            left: customHeight * 0.03,
            top: customHeight * 0.4,
            child: planetCircle(height: 2.0)
        ),
      ],
    );
  }

  Widget planetCircle({height}) {
    return CircleAvatar(
      backgroundColor: Colors.white30,
      radius: height,
    );
  }
}


class ShowTempature extends StatelessWidget {
  const ShowTempature({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.115,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(kTemperatureImage,color: kWhietCOlor,),
          ),
          Text('-75',style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

class ShowText extends StatelessWidget {
  const ShowText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "PLANET",
          style: GoogleFonts.exo(
            textStyle: TextStyle(
              fontSize: 21,
              color: Colors.white.withOpacity(0.8)
            )
          ),
        ),
        Text(
          "INFORMATION",
          style: GoogleFonts.exo(
            textStyle: TextStyle(
              fontSize: 22,
              color: Colors.white
            )
          ),
        ),
      ],
    );
  }
}

