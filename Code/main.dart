 ///
 /// Author: Ricardo Gonzalez
 /// Class: CS 474
 /// Professor: Ugo Buy
 /// Title: Animation Catalog app
 ///
 /// Description:
 /// The app presents an animation catalog from which users can select an animation
 /// to display. Each animation is implemented in its own widget.
 ///

import 'package:flutter/material.dart';
import 'animation_list_widget.dart';
import 'animation_display_widget.dart';

 // Main function to run the app.
 void main() {
   runApp(MyApp());
 }

 // MyApp widget, the root of the application.
 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Flutter Animation App',
       theme: ThemeData.dark().copyWith(
         primaryColor: Colors.blueGrey,
         colorScheme: ThemeData.dark().colorScheme.copyWith(
           secondary: Colors.lightGreen,
         ),
         cardTheme: CardTheme(
           color: Colors.grey[900],
           elevation: 5,
         ),
       ),
       home: HomeScreen(),
     );
   }
 }

 // HomeScreen widget, representing the main screen of the app.
 class HomeScreen extends StatefulWidget {
   @override
   _HomeScreenState createState() => _HomeScreenState();
 }

 class _HomeScreenState extends State<HomeScreen> {
   bool isAnimationSelected = false;
   String selectedAnimation = '';

   // Function to handle animation selection.
   void onAnimationSelected(String animationName) {
     setState(() {
       isAnimationSelected = true;
       selectedAnimation = animationName;
     });
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Animation Catalog'),
         centerTitle: true,
       ),
       body: Row(
         children: <Widget>[
           Expanded(
             flex: isAnimationSelected ? 1 : 4,
             child: AnimationListWidget(
               onSelectAnimation: onAnimationSelected,
               selectedAnimation: selectedAnimation,
               isFullWidth: !isAnimationSelected,
             ),
           ),
           if (isAnimationSelected)
             Expanded(
               flex: 3,
               child: Container(
                 color: Colors.grey[800],
                 child: AnimationDisplayWidget(animationType: selectedAnimation),
               ),
             ),
         ],
       ),
     );
   }
 }