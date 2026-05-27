import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final DateTime createdAt;

  Quote({
    required this.text,
    required this.author,
    this.category = 'General',
    this.likes = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
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
      createdAt: DateTime(2024, 1, 15),
    ),
    Quote(
      text: 'Two things are infinite: the universe and human stupidity.',
      author: 'Albert Einstein',
      category: 'Humor',
      createdAt: DateTime(2024, 3, 22),
    ),
    Quote(
      text: 'Be the change you wish to see in the world.',
      author: 'Mahatma Gandhi',
      category: 'Inspiration',
      createdAt: DateTime(2024, 6, 10),
    ),
    Quote(
      text: 'In the middle of every difficulty lies opportunity.',
      author: 'Albert Einstein',
      category: 'Motivation',
      createdAt: DateTime(2025, 1, 5),
    ),
  ];

  Color cardColor(String c) => switch (c.toLowerCase()) {
    'inspiration' => Colors.blueAccent.shade100.withOpacity(0.15),
    'humor' => Colors.amber.shade100,
    'motivation' => Colors.green.shade100,
    _ => Colors.grey.shade100,
  };

  Future<void> _deleteQuote(Quote quote) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete quote?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ?? false;

    if (ok) setState(() => quotes.remove(quote));
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
          final dateStr = DateFormat('MMM d, yyyy').format(quote.createdAt);
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
                  Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Chip(label: Text(quote.category)),
                      Text(
                        dateStr,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
            ),
          );
        },
      ),
    );
  }
}