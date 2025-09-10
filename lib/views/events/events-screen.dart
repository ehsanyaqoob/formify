import 'dart:ui';
import 'package:formify/constants/export.dart';
import 'package:formify/controller/events-controller.dart';
import 'package:formify/model/events-model.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final EventsController controller = Get.put(EventsController());
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDynamicBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 36.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCalendar(
                  focusedDay: _focusedDay,
                  selectedDay: controller.selectedDate.value,
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.selectDate(selectedDay);
                    setState(() => _focusedDay = focusedDay);
                  },
                  onFormatChanged: (format) {
                    setState(() => _calendarFormat = format);
                  },
                  eventLoader: controller.getEventsForDay,
                ),
                Gap(30),
                MyText(
                  text: "My Events",
                  color: kDynamicText,
                  size: 12,
                  weight: FontWeight.w500,
                ),
                Divider(thickness: 1, color: kDynamicText.withOpacity(0.7)),
                EventsList(),
                Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCalendar extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final List<EventModel> Function(DateTime) eventLoader;

  const CustomCalendar({
    Key? key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.eventLoader,
  }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _expandedDate;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: kDynamicContainer.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
            child: Column(
              children: [
                TableCalendar<EventModel>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: widget.focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: widget.eventLoader,
                  selectedDayPredicate: (day) =>
                      isSameDay(widget.selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    widget.onDaySelected(selectedDay, focusedDay);
                    setState(() {
                      if (_expandedDate != null &&
                          isSameDay(_expandedDate, selectedDay)) {
                        _expandedDate = null;
                      } else {
                        _expandedDate = selectedDay;
                      }
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                      _expandedDate = null;
                    });
                    widget.onFormatChanged(format);
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: _buildChevron(Icons.chevron_left),
                    rightChevronIcon: _buildChevron(Icons.chevron_right),
                    titleTextStyle: TextStyle(fontSize: 2),
                    headerPadding: EdgeInsets.only(bottom: 20.0),
                    leftChevronPadding: EdgeInsets.zero,
                    rightChevronPadding: EdgeInsets.zero,
                  ),
                  calendarBuilders: CalendarBuilders(
                    headerTitleBuilder: (context, date) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyText(
                            text: _formatMonth(date),
                            color: kDynamicText,
                            size: 18,
                            weight: FontWeight.w700,
                          ),
                          SizedBox(height: 2),
                          MyText(
                            text: "${date.year}",
                            color: kDynamicText.withOpacity(0.8),
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      );
                    },
                    markerBuilder: (context, date, events) {
                      if (events.isEmpty) return null;
                      final eventCount = events.length;
                      final markerCount = eventCount > 3 ? 3 : eventCount;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(markerCount, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 1.5,
                              vertical: 0,
                            ),
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: _getMarkerColor(index),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      );
                    },
                    todayBuilder: (context, date, _) {
                      if (widget.selectedDay == null ||
                          !isSameDay(widget.selectedDay, date)) {
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kDynamicContainer.withOpacity(0.6),
                          ),
                          alignment: Alignment.center,
                          child: MyText(
                            text: '${date.day}',
                            color: kDynamicText,
                            size: 13,
                            weight: FontWeight.bold,
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: kDynamicText,
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                    ),
                    weekendStyle: TextStyle(
                      color: kDynamicText,
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(
                      color: kDynamicText,
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                    ),
                    weekendTextStyle: TextStyle(
                      color: kDynamicText,
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                    ),
                    outsideTextStyle: TextStyle(
                      color: kDynamicText,
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    cellMargin: EdgeInsets.all(10.0),
                  ),
                  rowHeight: 40,
                ),
                if (_expandedDate != null &&
                    widget.eventLoader(_expandedDate!).isNotEmpty)
                  _buildExpandedEventsSection(_expandedDate!),
              ],
            ),
          ),
        ),
      );
    });
  }

  Color _getMarkerColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.red;
      case 2:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Widget _buildEventItem(EventModel event, int index) {
    final markerColor = _getMarkerColor(index);

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          margin: EdgeInsets.only(bottom: 6),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: markerColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: MyText(
                  text: event.title,
                  color: kDynamicText,
                  size: 13,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              MyText(
                text:
                    "${_formatTime(event.startDateTime)} - ${_formatTime(event.endDateTime)}",
                color: kDynamicText.withOpacity(0.8),
                size: 14,
                weight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedEventsSection(DateTime date) {
    final events = widget.eventLoader(date);

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: _formatDateSlash(date),
            color: kDynamicText,
            size: 12,
            weight: FontWeight.w400,
          ),
          Divider(thickness: 2, color: kDynamicText.withOpacity(0.5)),
          Column(
            children: events
                .asMap()
                .entries
                .map((entry) => _buildEventItem(entry.value, entry.key))
                .toList(),
          ),
        ],
      ),
    );
  }

  String _formatDateSlash(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = _getShortMonthName(date.month);
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  String _getShortMonthName(int month) {
    return {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    }[month]!;
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final period = hour < 12 ? 'AM' : 'PM';
    final displayHour = hour % 12;
    return '${displayHour == 0 ? 12 : displayHour}$period';
  }

  Widget _buildChevron(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kDynamicText, width: 1.4),
        color: kDynamicContainer.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(5),
      child: Icon(icon, color: kDynamicText, size: 28),
    );
  }

  String _formatMonth(DateTime date) {
    return {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December",
    }[date.month]!;
  }
}

class EventsList extends StatefulWidget {
  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  final EventsController controller = Get.find<EventsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final events = controller.selectedDayEvents;

      if (events.isEmpty) {
        return Center(
          child: MyText(
            text: "No events for this day",
            color: kDynamicText,
            size: 20,
            weight: FontWeight.bold,
          ),
        );
      }

      return ListView.builder(
        itemCount: events.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        itemBuilder: (context, index) {
          final event = events[index];
          return _buildEventCard(event);
        },
      );
    });
  }

  Widget _buildEventCard(EventModel event) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: kDynamicContainer.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: AssetImage(Assets.Imagesofeventcard),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4.0,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: event.isHosting
                            ? kPrimaryColor
                            : kPrimaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: MyText(
                          text: event.isHosting ? "Hosting" : "Attending",
                          size: 10,
                          weight: FontWeight.bold,
                          color: kWhite.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 12, top: 12, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: event.title,
                        color: kDynamicText,
                        size: 16,
                        weight: FontWeight.bold,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              text:
                                  "${event.startDateTime.day}/${event.startDateTime.month}/${event.startDateTime.year}, ${_formatTime(event.startDateTime)} - ${_formatTime(event.endDateTime)}",
                              size: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              text: event.location,
                              size: 12,
                              color: Colors.grey,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final period = hour < 12 ? 'AM' : 'PM';
    final displayHour = hour % 12;
    return '${displayHour == 0 ? 12 : displayHour}$period';
  }
}
