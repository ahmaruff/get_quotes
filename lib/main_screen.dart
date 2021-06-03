//import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get_quotes/quote_model.dart';
import 'package:get_quotes/quote_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20),
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
                if (snapshoot.hasData) {
                  final quote = snapshoot.data!;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: ListView(
                        children: <Widget>[
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
                } else if (snapshoot.hasError) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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
                return Center(
                  heightFactor: 2.0,
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: new FloatingActionButton(
      //   onPressed: setState(() {
      //     futureQuoteModel = getQuote();
      //   }),
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
