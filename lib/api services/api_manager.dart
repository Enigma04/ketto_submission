import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ketto_submission/models/quote_model.dart';

class QuoteManager {
  Future <Quotes?> getQuotes() async {
    var client = http.Client();
    var quoteModel = null;
    try {
      var response = await client.get(Uri.http("api.quotable.io", "random"));
      if(response.statusCode == 200)
        {
          var jsonString = response.body;
          var jsonMap = json.decode(jsonString);
          quoteModel = Quotes.fromJson(jsonMap);
        }
      return quoteModel;
    }
    catch(exception)
    {
      return quoteModel;
    }
  }
}