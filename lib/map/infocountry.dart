import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapcountry/global.dart' as globals;
import '../data/country.dart';
import '../widget/textdata.dart';

class InfoCountry extends StatefulWidget {
  const InfoCountry({Key? key,required this.thisCountry}) : super(key: key);

  final Country thisCountry;

  @override
  _InfoCountryState createState() => _InfoCountryState();
}

class _InfoCountryState extends State<InfoCountry> { // SingleTickerProviderStateMixin {

  late ThemeData _theme;
  late TextTheme _textTheme;
  late ColorScheme _colorScheme;

  double _screenWidth =0;
  double _screenHeight =0;

  bool _iniFlag = false;

  @override
  void initState() {
    super.initState();
    _iniFlag = false;
    asyncMethod();
  }
  void asyncMethod() async {
    await Future.delayed(const Duration(milliseconds: 100), () async{
      setState(() {
        _iniFlag = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _textTheme = _theme.textTheme;
    _colorScheme = _theme.colorScheme;
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[

              /// Back Gradiant
              Positioned.fill(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        _colorScheme.onBackground, //  Orange
                        _colorScheme.background,
                      ],
                      stops: globals.isPortraitMode ? [0.01, 0.13] : [0.01, 0.28],
                    ),
                  ),
                ),
              ),

              /// Image Flag
              Positioned(
                top:   40,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                  alignment: Alignment.center,
                  decoration:BoxDecoration(
                    color: _colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all( color: _colorScheme.primary, width: 3, ),
                  ),
                  child: AnimatedContainer(
                      width: _iniFlag ? 100 : 0,
                      height: _iniFlag ? 40 : 0,
                      alignment: Alignment.center,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: Image.network( "${widget.thisCountry.flags!.png}" )
                  ),
                ),
              ),

              /// Data
              SizedBox(
                width: _screenWidth,
                height: _screenHeight,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 0.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      const SizedBox(height: 120),

                      TextData(beforeText: "Pays: ", setText: widget.thisCountry.name,),
                      TextData(beforeText: "Capitale: ", setText: widget.thisCountry.capital,),
                      TextData(beforeText: "Région: ", setText: widget.thisCountry.region,),
                      TextData(beforeText: "Sous-région: ", setText: widget.thisCountry.subregion,),

                      const SizedBox(height: 10),
                      TextData(beforeText: "Population: ", setText: widget.thisCountry.population.toString(),),
                      TextData(beforeText: "Superficie: ", setText: widget.thisCountry.area.toString(), afterText: " km²",),

                      const SizedBox(height: 10),
                      const TextData(beforeText: "devises: "),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if(widget.thisCountry.currencies != null)
                          for(final currency in widget.thisCountry.currencies!)...[
                            const SizedBox(height: 10,),
                            TextData(beforeText: "nom: ",setText: currency!.name!),
                            TextData(beforeText: "code: ",setText: currency.code!),
                            TextData(beforeText: "symbole: ",setText: currency.symbol!),
                            ],
                          if(widget.thisCountry.currencies == null)
                            const TextData(setText: null),
                          ],
                        ),
                      ),



                      const SizedBox(height: 120),

                    ],
                  ),
                ),
              ),

              /// ButtonBack
              Positioned(
                bottom: 20,
                right:  20,
                child: Container(
                  alignment: Alignment.center,
                  decoration:BoxDecoration(
                    color: _colorScheme.background,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all( color: _colorScheme.primary, width: 3, ),
                  ),
                  child:IconButton(
                    icon: const Icon(Icons.arrow_back,color: Colors.amber,size: 30,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }













}