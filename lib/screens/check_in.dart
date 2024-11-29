import 'package:flutter/material.dart';
import 'package:front_desk/screens/visitor.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({super.key});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            InkWell(
               onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context) => const Visitor())) ,
              child: Container(
                width: size.width * .2,
                height: size.height * .25,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.rectangle,
                ),
                child: const Center(
                    child: Text(
                  'VISITOR',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                )),
              ),
            ),
            const Spacer(),
            
             InkWell(
              // onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context) => const CheckOut())) ,
              child: Container(
                width: size.width * .2,
                height: size.height * .25,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.rectangle,
                ),
                child: const Center(
                    child: Text(
                  'STAFF',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                )),
              ),
            ),
          
            const Spacer(),
             InkWell(
              // onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context) => const CheckOut())) ,
              child: Container(
                width: size.width * .2,
                height: size.height * .25,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.rectangle,
                ),
                child: const Center(
                    child: Text(
                  'DELIVERY',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                )),
              ),
            ),
            
                  ],
                ),
          ),
        ));
  }
}
