import 'dart:convert';
import 'dart:math';

class Activity {
  String activity;
  String type;
  int participants;
  double price;
  String key;
  double accessibility;
  String? link;

  Activity({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.key,
    required this.accessibility,
    this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'activity': activity,
      'type': type,
      'participants': participants,
      'price': price,
      'key': key,
      'accessibility': accessibility,
      'link': link,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      activity: map['activity'] ?? '',
      type: map['type'] ?? '',
      participants: map['participants']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      key: map['key'] ?? Random().nextInt(100000).toString(),
      accessibility: map['accessibility']?.toDouble() ?? 0.0,
      link: map['link'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) => Activity.fromMap(json.decode(source));
}
