import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data.dart';
import 'package:newsapp/news_page.dart';

class DiscoverPage extends StatefulWidget{
  @override
  State<DiscoverPage> createState()=> _DiscoverPageState();
}
class _DiscoverPageState extends State<DiscoverPage>{

  List<String> categories = ["All","Sports", "Education", "Business", "Technology"];

  int current = 0;
  PageController pageController = PageController();


  late Future <Newsappapimodel?> futureData;
  @override

  void initState(){
    super.initState();
    futureData= getData();
  }

  Future<Newsappapimodel?> getData() async{
    try{
      String url="https://newsapi.org/v2/everything?q=apple&from=2025-02-20&to=2025-02-20&sortBy=popularity&apiKey=82e09c57322740199b14c3f78f979326";
      http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode == 200){
        return Newsappapimodel.fromJson(json.decode(res.body));
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
          onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Discover",style: TextStyle(fontSize: 28,color: Colors.black,fontWeight: FontWeight.bold),),
            Text("News form all around the world",style: TextStyle(fontSize: 15,color: Colors.grey),),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (Context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                            pageController.animateToPage(
                              current,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? Colors.blue
                                  : const Color.fromARGB(136, 219, 219, 219),
                              borderRadius: current == index
                                  ? BorderRadius.circular(12)
                                  : BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    categories[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: current == index
                                          ? Colors.white
                                          : Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 550,
              child: PageView.builder(
                itemCount: categories.length,
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage(image: article.urlToImage, title: article.title, description: article.description,content: article.content,name: article.source.name,time: article.publishedAt,author: article.author,)));
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
                  );
                },
              ),
            ),
          ],
        ),
      )
      
    );
  }
}