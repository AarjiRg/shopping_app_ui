import 'package:flutter/material.dart';
import 'package:shopping_app_ui/view/screen_two/screentwo.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://images.pexels.com/photos/16809903/pexels-photo-16809903/free-photo-of-men-in-sportswear-and-accessories-posing-in-white-studio.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // ElevatedButton(
          //     style: ButtonStyle(
          //       elevation: WidgetStatePropertyAll(20),
          //       shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20),
          //           side: BorderSide(width: 5))),
          //       foregroundColor: WidgetStatePropertyAll(Colors.white),
          //       backgroundColor: WidgetStatePropertyAll(Colors.black),
          //       padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
          //     ),
          //     onPressed: () {
          //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScreenTwo(),));
          //     },
          //     child: Text("Get Started ->")),
          InkWell(
            onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScreenTwo(),));
             
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Get Started",style: TextStyle(color: Colors.white,fontSize: 20),),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward,color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
