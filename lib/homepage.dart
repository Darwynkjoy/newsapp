import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data_model.dart';
import 'package:newsapp/news_page.dart';

class Homepage extends StatefulWidget{
  @override
  State<Homepage> createState()=> _homepageState();
}
class _homepageState extends State<Homepage>{
  late Future <NewsappApImodel?> futureData;
  @override

  void initState(){
    super.initState();
    futureData= getData();
  }

  Future<NewsappApImodel?> getData() async{
    try{
      String url="https://newsapi.org/v2/everything?q=apple&from=2025-02-18&to=2025-02-18&sortBy=popularity&apiKey=82e09c57322740199b14c3f78f979326";
      http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode == 200){
        return NewsappApImodel.fromJson(json.decode(res.body));
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
              onPressed: (){}, icon: Icon(Icons.notifications_outlined)),
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
                Text("Breaking News",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                TextButton(onPressed: (){}, child: Text("View all",style: TextStyle(fontSize: 15,color: Colors.blue),)),
              ],
            ),
            FutureBuilder(
              future: futureData,
            builder: (context,snaphot){
              if(snaphot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage(image: article.urlToImage, title: article.title, description: article.description,content: article.content,name: article.source.name,)));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 110,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),image: DecorationImage(image: NetworkImage("${article.urlToImage}"),fit: BoxFit.cover))
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
      )
      
      
    );
  }
}