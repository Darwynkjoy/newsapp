import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data_modal.dart';
import 'package:newsapp/discover_page.dart';
import 'package:newsapp/hotnews_modal.dart';
import 'package:newsapp/news_page.dart';

class Homepage extends StatefulWidget{
  @override
  State<Homepage> createState()=> _homepageState();
}
class _homepageState extends State<Homepage>{
  late Future <GeneralNewsApi?> futureData;
  late Future <HotNewsApi?> hotNewsData;
  @override

  void initState(){
    super.initState();
    futureData= getData();
    hotNewsData= hotData();
  }

  Future<GeneralNewsApi?> getData() async{
    try{
      String url="https://newsapi.org/v2/everything?q=trending&from=2025-02-23&to=2025-02-23&apiKey=82e09c57322740199b14c3f78f979326";
      http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode == 200){
        return GeneralNewsApi.fromJson(json.decode(res.body));
      }
      else{
        throw Exception("failed to load data");
      }
    }
    catch (e){
      debugPrint(e.toString());
    }
    return null;
  }

  Future<HotNewsApi?> hotData() async{
    try{
      String url="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=82e09c57322740199b14c3f78f979326";
      http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode == 200){
        return HotNewsApi.fromJson(json.decode(res.body));
      }
      else{
        throw Exception("failed to load data");
      }
    }
    catch (e){
      debugPrint(e.toString());
    }
    return null;
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 241, 241, 241))),
          onPressed: (){}, icon: Icon(Icons.menu)),
          actions: [
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 241, 241, 241))),
              onPressed: (){}, icon: Icon(Icons.search)),
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 241, 241, 241))),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DiscoverPage()));
              }, icon: Icon(Icons.notifications_outlined)),
            ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Breaking news",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                TextButton(onPressed: (){}, child: Text("View all",style: TextStyle(fontSize: 15,color: Colors.blue),)),
              ],
             ),

            FutureBuilder(
              future: hotNewsData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.articles.isNotEmpty) {
                  final articles = snapshot.data!.articles.take(10).toList(); // ✅ Show only 5 articles

                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 250,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: .82,
                    ),
                    items: articles.map((article) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsPage(
                                image: article.urlToImage,
                                title: article.title,
                                description: article.description,
                                content: article.content,
                                name: article.source.name,
                                time: article.publishedAt,
                                author: article.author,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 200,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                    image: NetworkImage(article.urlToImage),
                                    fit: BoxFit.cover,
                                  ),
                            color: Colors.grey.shade300,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),
                              Row(
                                children: [
                                  Text("${article.source.name}"),
                                  Icon(Icons.verified_rounded,color: Colors.blue,size: 15,)
                                ],
                              ),
                              Text("${article.title}",style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,)
                            ],
                          )
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Center(child: Text("No articles found"));
                }
              },
            ),
            Text("Hot News",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
            FutureBuilder(
              future: futureData,
            builder: (context,snaphot){
              if(snaphot.connectionState == ConnectionState.waiting){
                return Expanded(child: Center(child: CircularProgressIndicator()));
              }
              else if(snaphot.hasError){
                return Center(child: Text("error:${snaphot.error}"));
              }
              else if(snaphot.hasData && snaphot.data != null){
                final articlesData=snaphot.data!.articles;
                return Expanded(
              child: ListView.separated(
                itemBuilder: (context,index){
                  final article=articlesData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage(image: article.urlToImage!, title: article.title, description: article.description!,content: article.content,name: article.source.name,time: article.publishedAt,author: article.author,)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        children: [
                          ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/kOnzy.gif',
                                    image: article.urlToImage ?? '',
                                    fit: BoxFit.cover,
                                    width: 110,
                                    height: 100,
                                    placeholderFit: BoxFit.contain,
                                    imageErrorBuilder: (context,Error, stackTrace) {
                                      return Container(
                                        width: 110,
                                        height: 100,
                                        color: Colors.grey.shade300,
                                        child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                      );
                                    },
                                  ),
                                ),
                          SizedBox(width: 10,),
                          Container(
                            width: 237,
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Text("${article.title}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black,overflow: TextOverflow.ellipsis),maxLines: 2,),
                                Spacer(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text("${article.source.name}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey,overflow: TextOverflow.ellipsis))),
                                    SizedBox(width: 10,),
                                    Center(child: CircleAvatar(radius: 2,backgroundColor: Colors.grey,)),
                                    SizedBox(width: 10,),
                                    Text("${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey)),
                                  ],
                                ),
                                ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height: 10,);
                },
                itemCount: articlesData.length),
            );
              }
              else{
                return Center(child: Text("no articles found"),);
              }
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DiscoverPage()));
      },
      child: Icon(Icons.public,size: 35,color: Colors.blue,),),
    );
  }
}