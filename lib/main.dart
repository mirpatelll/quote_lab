import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QuoteList(),
    );
  }
}

class Quote {
  final String text;
  final String author;
  String category;
  int likes;

  Quote({
    required this.text,
    required this.author,
    this.category = 'General',
    this.likes = 0,
  });
}

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(
      text: 'Be yourself; everyone else is already taken.',
      author: 'Oscar Wilde',
      category: 'Inspiration',
    ),
    Quote(
      text: 'Two things are infinite: the universe and human stupidity.',
      author: 'Albert Einstein',
      category: 'Humor',
    ),
    Quote(
      text: 'Be the change you wish to see in the world.',
      author: 'Mahatma Gandhi',
      category: 'Inspiration',
    ),
    Quote(
      text: 'In the middle of every difficulty lies opportunity.',
      author: 'Albert Einstein',
      category: 'Motivation',
    ),
  ];

  Color cardColor(String c) => switch (c.toLowerCase()) {
    'inspiration' => Colors.blueAccent.shade100.withOpacity(0.15),
    'humor' => Colors.amber.shade100,
    'motivation' => Colors.green.shade100,
    _ => Colors.grey.shade100,
  };

  void _deleteQuote(Quote quote) {
    setState(() {
      quotes.remove(quote);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Quote App'),
      ),
      body: ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          final quote = quotes[index];
          return Card(
            color: cardColor(quote.category),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(quote.text, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(
                    '- ${quote.author}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(label: Text(quote.category)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up),
                            onPressed: () => setState(() => quote.likes++),
                          ),
                          Text('${quote.likes}'),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteQuote(quote),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
