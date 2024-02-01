import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_final/const/text_style.dart';
import 'package:quiz_app_final/quiz_screen.dart';
import 'const/colors.dart';
import 'const/images.dart';

class QuizApp extends StatelessWidget {
  final int whatscreen;
  QuizApp({Key? key, required this.whatscreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    return Scaffold(
    body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [blue, darkBlue],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 2,color: lightgrey),
                ),
                child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
               icon: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 20,
              )),
              ),
              if (whatscreen == 0)
                Image(image: AssetImage(trafic_img))
              else if(whatscreen ==1)
                Image(image: AssetImage(math_img))
              else if(whatscreen ==2)
                Image(image: AssetImage(physics_img))
              ,
              
              const SizedBox(
                height: 20,
              ),
              normalText(color: lightgrey,size: 18,text: "Welcome to our"),
              if (whatscreen == 0)
                headingText(color: Colors.white,size: 32,text: "Trafic Quiz")
              else if(whatscreen ==1)
                headingText(color: Colors.white,size: 32,text: "Math Quiz")
              else if(whatscreen ==2)
                headingText(color: Colors.white,size: 32,text: "Physics Quiz"),
            
              const SizedBox(
                height: 18,
              ),
              normalText(color: lightgrey,size: 18,text: "Do you feel confident? Here you will face our most difficult questions!"),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  QuizScreen(selectedquiz: whatscreen,)));
                  },
                  child: Container(
                    width: size.width -100,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: headingText(color: blue,size: 18,text: "Continue")),
                  
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}