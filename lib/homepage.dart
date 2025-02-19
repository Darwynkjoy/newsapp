import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data_model.dart';
class Homepage extends StatefulWidget{
  @override
  State<Homepage> createState()=> _homepageState();
}
class _homepageState extends State<Homepage>{
  late Future <Newpaper?> futureData;
  @override

  void initState(){
    super.initState();
    futureData= getData();
  }

  Future<Newpaper?> getData() async{
    try{
      String url="https://newsapi.org/v2/everything?q=apple&from=2025-02-18&to=2025-02-18&sortBy=popularity&apiKey=82e09c57322740199b14c3f78f979326";
      http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode == 200){
        return Newpaper.fromJson(json.decode(res.body));
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
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
//82e09c57322740199b14c3f78f979326 api key