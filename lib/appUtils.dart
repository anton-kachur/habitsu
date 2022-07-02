import 'package:flutter/material.dart';



// Text field border decoration
UnderlineInputBorder textFieldStyle = UnderlineInputBorder(
  borderSide: BorderSide(color: Color.fromARGB(255, 231, 231, 231)),
);


// Window which displays error or waiting
Widget waitingOrErrorWindow(var text, var context) {
  return Container(
    height: MediaQuery.of(context).size.height, 
    width: MediaQuery.of(context).size.width,
    color: Colors.transparent,
    child: Padding(
      padding: EdgeInsets.fromLTRB(130, MediaQuery.of(context).size.height/2, 0.0, 0.0),

      child: Text(
        text,
        style: TextStyle(fontSize: 20, decoration: TextDecoration.none, color: Color.fromARGB(255, 255, 255, 255)),
      ),
    )
  );
}


// Function which creates standart app button
Widget button({List<Function>? functions, String? text, BuildContext? context, String? route, List? routingArgs, double? minWidth, EdgeInsetsGeometry? edgeInsetsGeometry, double? rightPadding}) {
  
  return Padding(
    padding: edgeInsetsGeometry?? EdgeInsets.fromLTRB((rightPadding == null? 0.0 : rightPadding), 7.0, 0.0, 0.0),

    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(minWidth?? 100.0, 30.0),
        primary: Color.fromARGB(222, 130, 130, 130), 
        textStyle: TextStyle(color: Colors.white, fontSize: 14.0),
        side: BorderSide(color: Color.fromARGB(0, 0, 0, 0), width: 1.0),
        shadowColor: Color.fromARGB(218, 131, 131, 131), 
        surfaceTintColor: Color.fromARGB(218, 0, 0, 0), 
      ),

      child: Text(text!, style: TextStyle(color: Color.fromARGB(221, 255, 255, 255))),

      onPressed: () {
        for (var func in functions!) {
          func();
        }

        /*if (route!=null && context!=null) { 
          switch(route) {
            case '/projects_page': Navigator.pop(context, false); break;
            case '/home': Navigator.pushNamedAndRemoveUntil(context, route, ModalRoute.withName(route)); break;
            //case 'soundings': Navigator.push(context, MaterialPageRoute(builder: (context) => Soundings(routingArgs![0]))); break;
            //case 'projects': Navigator.push(context, MaterialPageRoute(builder: (context) => Projects())); break;
          } 
        }*/
      },

    ),
  );
}
