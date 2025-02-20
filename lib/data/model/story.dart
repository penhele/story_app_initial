import 'dart:convert';

class Story {
  final String id;
  final String story;
  final String author;

  Story({required this.id, required this.story, required this.author});

  Map<String, dynamic> toMap() {
    return {'id': id, 'story': story, 'author': author};
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'] ?? '',
      story: map['story'] ?? '',
      author: map['author'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source));

  @override
  String toString() => 'Story(id: $id, story: $story, author: $author)';
}

final stories = [
  Story(
    id: "1",
    story:
        "Cleaning code does NOT take time. NOT cleaning code does take time.",
    author: "Robert C. Martin",
  ),
  Story(
    id: "2",
    story: "Debugging time increases as a square of the program's size.",
    author: "Chris Wenham",
  ),
  Story(
    id: "3",
    story: "Adding manpower to a late software project makes it later.",
    author: "Edsger W. Dijkstra",
  ),
  Story(
    id: "4",
    story: "Deleted code is debugged code.",
    author: "Jeff Sickel",
  ),
  Story(
    id: "5",
    story:
        "A program that produces incorrect results twice as fast is infinitely slower.",
    author: "John Ousterhout",
  ),
];
