import 'package:flutter/material.dart';
import 'package:ketto_submission/api%20services/api_manager.dart';
import 'package:ketto_submission/models/quote_model.dart';

class QuoteView extends StatefulWidget {
  const QuoteView({Key? key}) : super(key: key);

  @override
  State<QuoteView> createState() => _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  late Future<Quotes?> _quoteModel;

  @override
  void initState() {
    // TODO: implement initState
    _quoteModel = QuoteManager().getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TextStyle for quotes
    TextStyle quoteTextStyle = const TextStyle(
        fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 30);

    //TextStyle for authors
    TextStyle authorTextStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
        actions: [
          IconButton(
            onPressed: () => refreshPage(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<Quotes?>(
            future: _quoteModel,
            builder: (context, snapshot) {
              var quotes = snapshot.data;
              if (snapshot.hasData) {
                return Center(
                    child: GestureDetector(
                  onLongPress: refreshPage,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "\"${quotes!.content.toString()}\"",
                        style: quoteTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "~ ${quotes.author.toString()}",
                        style: authorTextStyle,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height *0.01 ,),
                      const Text("Long press to change the quote"),
                    ],
                  ),
                ));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }


//Writing function on the same page as there's just one function
  void refreshPage() {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => const QuoteView(),
            transitionDuration: const Duration(seconds: 0)));
  }
}
