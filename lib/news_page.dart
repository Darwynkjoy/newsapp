import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String content;
  final String name;
  final DateTime time;
  final dynamic author;
  const NewsPage({super.key,required this.image,required this.title,required this.description,required this.content,required this.name,required this.time,required this.author});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

String timeAgo() {
  final duration = DateTime.now().difference(widget.time);
  
  if (duration.inDays >= 1) {
    return "${duration.inDays} days ago";
  } else if (duration.inHours >= 1) {
    return "${duration.inHours} hours ago";
  } else {
    return "${duration.inMinutes} minutes ago";
  }
}



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
                height: 380, 
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/kOnzy.gif',
                        image: widget.image.isNotEmpty ? widget.image : '',
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image,color: Colors.white,size: 50,);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            "${widget.title}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              backgroundColor: Colors.black26
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            timeAgo(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              backgroundColor: Colors.black26
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(52, 0, 0, 0),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Center(
                        child: Icon(
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
            top: 360,
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
                    spreadRadius: 10,
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
                  Text('''${widget.description}''',style: TextStyle(fontSize: 15,color: Colors.black),textAlign: TextAlign.justify,),
                  Text('''${widget.content}''',style: TextStyle(fontSize: 15,color: Colors.black),textAlign: TextAlign.justify),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "- ${widget.author}" ?? "- Unknown Author",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
