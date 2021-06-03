import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:get_quotes/quote_model.dart';

Future<QuoteModel> getQuote() async {
  final url = 'https://api.quotable.io/random';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonQuote = jsonDecode(response.body);
    return QuoteModel.fromJson(jsonQuote);
  } else {
    throw Exception();
  }
}
