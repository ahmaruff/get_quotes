import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get_quotes/quote_model.dart';
import 'package:get_quotes/quote_service.dart';
import 'package:get_quotes/fav_button.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<QuoteModel> futureQuoteModel;

  @override
  void initState() {
    super.initState();
    futureQuoteModel = getQuote();
  }

  // @override
  // void didChangeDependencies(){
  //   super.didChangeDependencies()

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: Center(
                //heightFactor: 3.0,
                child: Text(
                  'Inspiring Quotes',
                  style: TextStyle(
                    fontFamily: 'Berkshire Swash',
                    color: Colors.purple[300],
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            FutureBuilder<QuoteModel>(
              future: futureQuoteModel,
              builder: (context, snapshoot) {
                if (snapshoot.connectionState == ConnectionState.done) {
                  if (snapshoot.hasData) {
                    var quoteModel = snapshoot.data!;
                    final quote = quoteModel;
                    return Expanded(
                      child: Container(
                        width: 250,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                '${quote.content}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Dancing Script',
                                  fontSize: 20.0,
                                  //fontSize: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                '~ ${quote.author} ~',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Oops!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Berkshire Swash',
                              fontSize: 40,
                              //fontSize: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Text(
                            'Please Check Your Connection or Try Again Later',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return Center(
                    heightFactor: 2.0,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 64,
        width: 250,
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  color: Colors.purple,
                  onPressed: () {
                    setState(() {
                      futureQuoteModel = getQuote();
                    });
                  },
                ),
                Text(
                  'Refresh',
                  style: TextStyle(color: Colors.purple),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                FavoriteButton(),
                Text(
                  'Favorite',
                  style: TextStyle(color: Colors.purple),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.bookmark_border),
                  color: Colors.purple,
                  onPressed: () {},
                ),
                Text(
                  'Collection',
                  style: TextStyle(color: Colors.purple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
