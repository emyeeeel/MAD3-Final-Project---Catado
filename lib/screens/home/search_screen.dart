import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {

  static const String route = '/search';
  static const String name = "Search Screen";

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 45,
          width: MediaQuery.of(context).size.width - 80,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              SizedBox(width: 5,),
              Icon(Icons.search),
              SizedBox(width: 5,),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 120,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 18
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Search Screen'),
      ),
    );
  }
}