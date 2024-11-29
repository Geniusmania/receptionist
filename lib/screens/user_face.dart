import 'package:flutter/material.dart';
import 'package:front_desk/screens/check_in.dart';
import 'package:front_desk/screens/check_out.dart';

class UserFace extends StatelessWidget {
  const UserFace({super.key});

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height*.10,),
              InkWell(
               onTap: () {
  print("CHECK-IN button tapped");
  Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckIn()));
},
                child: Container(
                 
                  width: size.width*.2,
                  height: size.height*.25,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: const BoxDecoration(color: Colors.greenAccent,shape: BoxShape.rectangle,),
                  child: const Center(
                      child: Text(
                    'CHECK-IN',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )),
                ),
              ),

SizedBox(height: size.height*.20,),

               InkWell(
                onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context) => const CheckOut())) ,
                 child: Container(
                 
                  width: size.width*.2,
                  height: size.height*.25,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: const BoxDecoration(color: Colors.redAccent,shape: BoxShape.rectangle,),
                  child: const Center(
                      child: Text(
                    'CHECK-OUT',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  )),
                               ),
               ),
              // const Text('Check OUT'),
            ],
          ),
        ),
      ),
    );
  }
}
