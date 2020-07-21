import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:wisdom_quotes/helpers/db_helper.dart';

class QuotesListScreen extends StatefulWidget {
  final Function resetState;

  const QuotesListScreen({
    this.resetState,
  });

  @override
  _QuotesListScreenState createState() => _QuotesListScreenState();
}

class _QuotesListScreenState extends State<QuotesListScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  /// Used to share quote to different apps.
  void shareQuote(String quote, String author) =>
      Share.share('$quote - $author');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Quotes'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: dbHelper.queryAllRows(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? snapshot.data.length != 0
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 12,
                        );
                      },
                      itemCount: snapshot.data.length as int,
                      itemBuilder: (context, index) {
                        final item = snapshot.data[index];
                        return ListTile(
                          title: Text(item['quote'] as String),
                          subtitle: Text(item['author'] as String),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  shareQuote(
                                    item['quote'] as String,
                                    item['author'] as String,
                                  );
                                },
                                child: Icon(Icons.share),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    dbHelper.delete(item['_id'] as int);
                                  });
                                  // reset state of `QuoteContainer` screen
                                  widget.resetState();

                                  // Show snackbar
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      elevation: 2,
                                      backgroundColor:
                                          Colors.purple[800].withOpacity(0.6),
                                      content: Text(
                                        "Quote deleted",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Mali",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(child: Text('No saved quotes!'))
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
