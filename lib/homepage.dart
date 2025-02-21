import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data.dart';
import 'package:newsapp/discover_page.dart';
import 'package:newsapp/news_page.dart';

class Homepage extends StatefulWidget{
  @override
  State<Homepage> createState()=> _homepageState();
}
class _homepageState extends State<Homepage>{

  final List<Widget> _pages = [
    Homepage(),
    DiscoverPage(),
  ];
  int _selectedIndex = 0;

  // Function to update the selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Active icon color
        unselectedItemColor: Colors.grey, // Inactive icon color
        type: BottomNavigationBarType.fixed, // Keeps all labels visible
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}