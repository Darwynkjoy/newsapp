import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String content;
  final String name;
  const NewsPage({super.key,required this.image,required this.title,required this.description,required this.content,required this.name});

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
                    image: NetworkImage(widget.image),
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
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
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
                  Row(
                    children: [
                      Text("${widget.name}",style: TextStyle(fontSize: 25,color: Colors.black),),
                      Icon(Icons.verified_rounded,color: Colors.blue,)
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('''${widget.content}''',style: TextStyle(fontSize: 15,color: Colors.black),textAlign: TextAlign.justify,overflow: TextOverflow.ellipsis,maxLines: 20,)
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
