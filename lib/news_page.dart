import 'package:flutter/material.dart';
import 'package:newsapp/data_model.dart';

class NewsPage extends StatefulWidget {
  final Newpaper newpaper;
  const NewsPage({super.key,required this.newpaper});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children:[ 
              Container(
                height: 400, // Adjust height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/photo-1533450718592-29d45635f0a9.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(52, 0, 0, 0), // Semi-transparent black
                      shape: BoxShape.circle, // Makes it circular
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                )
              )
              ]
            ),
          ),

          Positioned(
            top: 320,
            left: 0,
            right: 0,
            bottom: 0, 
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("title",style: TextStyle(fontSize: 25,color: Colors.black),),
                  SizedBox(height: 20,),
                  Text('''The quiet hum of the city at dawn was interrupted by the distant sound of waves 
                  crashing against the shore. As the sun slowly rose, casting a golden hue over the skyline,
                   Amelia sipped her coffee, lost in thought. The world around her seemed to pause for a moment, 
                   allowing her to soak in the serenity before the inevitable chaos of the day began. Birds 
                   fluttered between rooftops, and the streets, still damp from last night’s rain, reflected the 
                   soft glow of streetlights. It was in these fleeting moments of stillness that she found clarity, 
                   a brief escape from the relentless pace of life.''',style: TextStyle(fontSize: 15,color: Colors.black),textAlign: TextAlign.justify,overflow: TextOverflow.ellipsis,maxLines: 20,)
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
