import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tazzakhabar/Models/news_list_model_view.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Network/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "Sports",
    "Entertainment",
    "Business",
    "Science",
    "Health",
    "Technology",
    "General",
  ];
  late NewsListModel _newsListModel;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Tazza Khabar',
          style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              color: CupertinoColors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search box
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search...',
                      ),
                      style: TextStyle(fontFamily: 'Ubuntu'),
                    ),
                  ),
                ],
              ),
            ),

            // categories
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 25,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _isLoading = true;
                        getNews(categories[index]);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
              ),
            ),

            const SizedBox(
              height: 17,
            ),
            _isLoading == true
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.6781,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.6781,
                    // height: MediaQuery.of(context).size.height * 0.753,
                    child: ListView.builder(
                        itemCount: _newsListModel.articles!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 1,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            // height: 300,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 2,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              // color: CupertinoColors.systemGrey5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _newsListModel.articles![index].urlToImage ==
                                        null
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    : Image.network(_newsListModel
                                            .articles![index].urlToImage
                                            .toString() ??
                                        ""),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  _newsListModel.articles![index].title
                                      .toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                _newsListModel.articles![index].description ==
                                        null
                                    ? const Text('')
                                    : Text(
                                        _newsListModel
                                            .articles![index].description
                                            .toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                        maxLines: 8,
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(_newsListModel
                                        .articles![index].url
                                        .toString()));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      border: Border.all(
                                          color: Colors.blueAccent, width: 2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    width: 100,
                                    child: const Center(
                                      child: Text(
                                        "Read",
                                        style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  Future getData() async {
    try {
      var response = await http.get(Uri.parse(API.baseUrl.toString()));
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
          _newsListModel = NewsListModel.fromJson(jsonDecode(response.body));
        });
      }
    } catch (e) {
      print("error => ${e.toString()}");
    }
  }

  Future getNews(String category) async {
    try {
      var response =
          await http.get(Uri.parse("${API.baseUrl}&category=$category"));
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
          _newsListModel = NewsListModel.fromJson(jsonDecode(response.body));
        });
      }
    } catch (e) {
      print("error => ${e.toString()}");
    }
  }
}
