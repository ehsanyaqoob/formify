import 'package:get/get.dart';
import 'package:formify/model/events-model.dart';

class EventsController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var events = <EventModel>[].obs;
  var eventsMap = <DateTime, List<EventModel>>{}.obs;
  RxList<EventModel> selectedDayEvents = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyEvents();
    _filterEventsForSelectedDate();
  }

  void _loadDummyEvents() {
 final dummyEvents = [
  EventModel(
    id: "1",
    title: "Event X",
    startDateTime: DateTime(2025, 9, 15, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 15, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "2",
    title: "Event Y",
    startDateTime: DateTime(2025, 9, 15, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 15, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "3",
    title: "Event Z",
    startDateTime: DateTime(2025, 9, 15, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 15, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
  EventModel(
    id: "4",
    title: "Event X",
    startDateTime: DateTime(2025, 9, 16, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 16, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
  EventModel(
    id: "5",
    title: "Event Y",
    startDateTime: DateTime(2025, 9, 16, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 16, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "6",
    title: "Event Z",
    startDateTime: DateTime(2025, 9, 17, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 17, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "7",
    title: "Event X",
    startDateTime: DateTime(2025, 9, 17, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 17, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
  EventModel(
    id: "8",
    title: "Event Y",
    startDateTime: DateTime(2025, 9, 18, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 18, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
  EventModel(
    id: "9",
    title: "Event Z",
    startDateTime: DateTime(2025, 9, 18, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 18, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "10",
    title: "Event X",
    startDateTime: DateTime(2025, 9, 19, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 19, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "11",
    title: "Event Y",
    startDateTime: DateTime(2025, 9, 20, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 20, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
  EventModel(
    id: "12",
    title: "Event Z",
    startDateTime: DateTime(2025, 9, 20, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 20, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "13",
    title: "Event X",
    startDateTime: DateTime(2025, 9, 21, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 21, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "14",
    title: "Event Y",
    startDateTime: DateTime(2025, 9, 22, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 22, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
  EventModel(
    id: "15",
    title: "Event Z",
    startDateTime: DateTime(2025, 9, 22, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 22, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "16",
    title: "Event X",
    startDateTime: DateTime(2025, 9, 23, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 23, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
  EventModel(
    id: "17",
    title: "Event Y",
    startDateTime: DateTime(2025, 9, 24, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 24, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
  EventModel(
    id: "18",
    title: "Event Z",
    startDateTime: DateTime(2025, 9, 24, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 24, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "19",
    title: "Event X",
    startDateTime: DateTime(2025, 9, 25, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 25, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: true,
  ),
  EventModel(
    id: "20",
    title: "Event Y",
    startDateTime: DateTime(2025, 9, 25, 15, 0), // 3PM
    endDateTime: DateTime(2025, 9, 25, 23, 0),  // 11PM
    location: "Kempenski Hotel, Wedding Hall 1",
    imageUrl: "",
    isHosting: false,
  ),
];

    events.assignAll(dummyEvents);

    // Initialize the events map
    final Map<DateTime, List<EventModel>> tempMap = {};
    
    for (var event in dummyEvents) {
      final dateKey = DateTime(
        event.startDateTime.year, 
        event.startDateTime.month, 
        event.startDateTime.day
      );
      
      if (tempMap.containsKey(dateKey)) {
        tempMap[dateKey]!.add(event);
      } else {
        tempMap[dateKey] = [event];
      }
    }
    
    eventsMap.value = tempMap;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    _filterEventsForSelectedDate();
  }

  void _filterEventsForSelectedDate() {
    final dateKey = DateTime(
      selectedDate.value.year, 
      selectedDate.value.month, 
      selectedDate.value.day
    );
    
    selectedDayEvents.value = eventsMap[dateKey] ?? [];
  }

  // Helper method to get events for a specific day
  List<EventModel> getEventsForDay(DateTime day) {
    final dateKey = DateTime(day.year, day.month, day.day);
    return eventsMap[dateKey] ?? [];
  }
}