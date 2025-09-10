
class EventModel {
  final String id;
  final String title;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String location;
  final String imageUrl;
  final bool isHosting;

  EventModel({
    required this.id,
    required this.title,
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
    required this.imageUrl,
    this.isHosting = false,
  });
}