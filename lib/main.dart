import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app_final/const/images.dart';
import 'quiz_intro.dart';
import 'const/colors.dart';
import 'const/text_style.dart';
import 'package:tuple/tuple.dart';
import 'score_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        fontFamily: "quick",
      ),
      title: "Demo",
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  static List<Tuple2<int, int>> pairList = [];
  // static List scorelist = [2,3,4];
  static List<Score> scorelist = [];
  @override
  @override
  State<HomeScreen> createState() => _HomeScreenState();

}
late SharedPreferences sp;
saveIntoSp() async {
    sp = await SharedPreferences.getInstance();
    List<String> scoreListString =
        HomeScreen.scorelist.map((e) => jsonEncode(e.toJson())).toList();
    sp.setStringList("myData", scoreListString);
  }

class _HomeScreenState extends State<HomeScreen> {
  

  

  loadFromSp() async {
    sp = await SharedPreferences.getInstance();
    List<String>? scoreListString = sp.getStringList('myData');
    if (scoreListString != null) {
      HomeScreen.scorelist =
          scoreListString.map((e) => Score.fromJson(json.decode(e))).toList();
    }
    setState(() {});
  }
  void clearScorelist() async {
  HomeScreen.scorelist.clear();
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.remove("myData");
  setState(() {
    
  });
}
  @override
  void initState() {
    super.initState();
    if(HomeScreen.scorelist.isEmpty){
      loadFromSp();
    }
    
  }

  // getSharedPreferences() async{
  //   sp = await SharedPreferences.getInstance();
  //   loadFromSp();
  // }
  //  saveIntoSp(){
  //  List<String> scoreListString =  HomeScreen.scorelist.map((e) => jsonEncode(e.toJson())).toList();
  //   sp.setStringList("myData", scoreListString);
  // }
  // loadFromSp(){
  //   List<String>? scoreListString = sp.getStringList('myData');
  //    if (scoreListString != null) {
  //     HomeScreen.scorelist = scoreListString
  //         .map((e) => Score.fromJson(json.decode(e)))
  //         .toList();
  //   }
  //   setState(() {

  //   });
  // }

  // @override
  // void initState() {
  //   getSharedPreferences();
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    print("i am in build");
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [blue, darkBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: headingText(
                      color: Colors.white,
                      size: 30,
                      text: "What Subject do you want to improve today?")),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizApp(
                                    whatscreen: 0,
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      color: darkBlue,
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(trafic_img),
                            width: 100,
                          ),
                          const SizedBox(height: 10),
                          normalText(
                              size: 20, color: Colors.white, text: "Trafic")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizApp(whatscreen: 1)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      color: darkBlue,
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(math_img),
                            width: 100,
                          ),
                          const SizedBox(height: 10),
                          normalText(
                              size: 20, color: Colors.white, text: "Maths")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizApp(whatscreen: 2)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      color: darkBlue,
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(physics_img),
                            width: 100,
                          ),
                          const SizedBox(height: 10),
                          normalText(
                              size: 20, color: Colors.white, text: "Physics")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                
                  Align(
                  alignment: Alignment.centerLeft,
                  child: headingText(
                      color: Colors.white,
                      size: 25,
                      text: "Your Past Results")),
                  ElevatedButton(onPressed: (){
                    clearScorelist();
                  }, child: normalText(
                    color: Colors.black, size: 15, text: "Clear")),
                ],
              ),
              
              const SizedBox(height: 10),
              if (HomeScreen.scorelist.isEmpty)
                normalText(
                    color: Colors.white,
                    size: 15,
                    text: "You have not taken any quiz yet")
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: HomeScreen.scorelist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: blue,
                      ),
                      child: Row(
                        children: [
                          if (HomeScreen.scorelist[index].quiz_subject == 0)
                            const Image(
                              image: AssetImage(trafic_img),
                              width: 100,
                            )
                          else if (HomeScreen.scorelist[index].quiz_subject ==
                              1)
                            const Image(
                              image: AssetImage(math_img),
                              width: 100,
                            )
                          else
                            const Image(
                              image: AssetImage(physics_img),
                              width: 100,
                            ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              if (HomeScreen.scorelist[index].quiz_subject == 0)
                                headingText(
                                    text: "Trafic Quiz",
                                    size: 22,
                                    color: Colors.white)
                              else if (HomeScreen
                                      .scorelist[index].quiz_subject ==
                                  1)
                                headingText(
                                    text: "Math Quiz",
                                    size: 22,
                                    color: Colors.white)
                              else
                                headingText(
                                    text: "Physics Quiz",
                                    size: 22,
                                    color: Colors.white),
                              normalText(
                                  text:
                                      "score =  ${HomeScreen.scorelist[index].score}",
                                  size: 25,
                                  color: Colors.white),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),

              // if (widget.score!=0)
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: blue,
              //   ),

              //   child: Row(
              //     children: [
              //       if(widget.quiz_subject==0)
              //       const Image(image:
              //       AssetImage(trafic_img),
              //       width: 100)
              //       else if(widget.quiz_subject==1)
              //       const Image(image:
              //       AssetImage(math_img),
              //       width: 100,)
              //       else
              //       const Image(image:
              //       AssetImage(physics_img),
              //       width: 100,),

              //       const SizedBox(
              //         width: 30,
              //       ),
              //       normalText(text: "score =  ${widget.score}",size: 25,color: Colors.white,),
              //     ]),
              // )
            ]),
          ),
        ),
      ),
    );
  }
}
