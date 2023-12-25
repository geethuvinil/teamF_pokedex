import 'dart:convert';
import 'package:app/main.dart';
import 'package:app/shared/utils/demo_localization.dart';
import 'package:app/shared/utils/languages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
 final String? userEmailid;
  HomePage({Key? key, this.userEmailid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List<dynamic> pokedex = [];

void changeLanguage(Languages languages){
  Locale tempLocal;
  switch(languages.languageCode){
    case 'en':
    tempLocal = Locale(languages.languageCode ?? '','US');
    break;
     case 'hi':
    tempLocal = Locale(languages.languageCode ?? '','IN');
     break;
     case 'ar':
    tempLocal = Locale(languages.languageCode ?? '','UM');
     break;
     default:
         tempLocal = Locale(languages.languageCode ?? '','UM');
   
  }

  MyApp.setLocale(context,tempLocal);
}

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children:[
          Positioned(
            top:-25,
            right:-50,
           child:  Image.asset('assets/images/pball.png',color: Colors.grey,
           height: 230,
           width: 230,)
           ),
    //        Positioned(
    //   top: 66, // Adjust this value to center the drawer button vertically
    //   right: 41, // Adjust this value to center the drawer button horizontally
    //   child: IconButton(
    //     icon: Icon(Icons.menu),
    //     onPressed: () {
    //       // Add your drawer opening logic here
    //     },
    //   ),
    // ),
    Positioned(
      top: 66,
      right: 41,
      child:DropdownButton(
    items: Languages.languageList().map((lang) {
      return DropdownMenuItem(
        value: lang, // You can change this to another property if needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Text(lang.flag ?? '',
          style: TextStyle(fontSize: 18),),
          Text(lang.name ?? '',
          style: TextStyle(fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.w800),),
        ],

        ), // Assuming 'name' is a property in Languages
      );
    }).toList(),
    onChanged: (selectedLanguage) {
    print(selectedLanguage?.name );
    changeLanguage(selectedLanguage!);
      // Handle the selection here
    },
    icon: Icon(Icons.language),
  ),
),
           Positioned(
                top: 100,
                left: 20,
                child: Text(
                      DemoLocalization.of(context).getTransalatedValue('home_page') ?? '',
                  // 'Pokedex',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              
 
//  Positioned(
//       top: 23, 
//       left: 70, 
//       child: Lottie.asset(
//         'assets/lotties/movingpika.json', 
//         height: 185, 
//         width: 185, 
//       ),
//     ),


           Positioned(
            top: 150,
            bottom: 0,
            width: width,
             child: Column(
                     children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: pokedex.length,
                  itemBuilder: (context, index) {
                    var type = pokedex[index]['type'][0];
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      child: Container(
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: type == 'Grass'
                          ? Colors.greenAccent
                          : type == 'Fire'
                              ? Colors.redAccent
                              : type == 'Water'
                                  ? Colors.blueAccent
                                  : type == 'Electric'
                                      ? Colors.yellowAccent
                                      : type == 'Rock'
                                          ? Colors.grey
                                          : type == 'Ground'
                                              ? Colors.brown
                                              : type == 'Psychic'
                                                  ? Colors.indigo
                                                  : type == 'Fighting'
                                                      ? Colors.orange
                                                      : type == 'Bug'
                                                          ? Colors.lightGreen
                                                         : type == 'Ghost' 
                                                         ? Colors.deepPurpleAccent
                                                              : type == 'Normal'
                                                                  ? Colors.black26
                                                                  : type == 'Poison'
                                                                      ? Colors.deepPurple : Colors.pinkAccent,
                                                                      border: Border.all(color: Colors.black)
                          
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -10,
                              right: -8,
                              child: Image.asset(
                                'assets/images/pball.png',
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Positioned(
                              top: 16,
                              left: 10,
                              child: Text(
                                pokedex[index]['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              left: 20,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  child: Text(
                                    type.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: CachedNetworkImage(
                                imageUrl: pokedex[index]['img'],
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
                     ],
                   ),
           ),
      ]),
    );
  }

  Future<void> fetchPokemonData() async {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedJsonData = jsonDecode(response.body);
        setState(() {
          pokedex = decodedJsonData['pokemon'];
        });
      }
    } catch (error) {
      print("Error fetching Pokemon data: $error");
    }
  }
}