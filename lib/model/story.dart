import 'dart:convert';

class Story {
  final String id;
  final String quote;
  final String author;

  Story({
    required this.id,
    required this.quote,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'] ?? '',
      quote: map['quote'] ?? '',
      author: map['author'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source));

  @override
  String toString() => 'Story(id: $id, quote: $quote, author: $author)';
}

final quotes = [
  Story(
    id: "1",
    quote:
        "Cleaning code does NOT take time. NOT cleaning code does take time.",
    author: "Robert C. Martin",
  ),
  Story(
    id: "2",
    quote: "Debugging time increases as a square of the program's size.",
    author: "Chris Wenham",
  ),
  Story(
    id: "3",
    quote: "Adding manpower to a late software project makes it later.",
    author: "Edsger W. Dijkstra",
  ),
  Story(
    id: "4",
    quote: "Deleted code is debugged code.",
    author: "Jeff Sickel",
  ),
  Story(
    id: "5",
    quote:
        "A program that produces incorrect results twice as fast is infinitely slower.",
    author: "John Ousterhout",
  ),
];