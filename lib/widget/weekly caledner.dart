
import 'package:intl/intl.dart';
import 'package:formify/constants/export.dart';

class MonthlyCalendar extends StatefulWidget {
  const MonthlyCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.backgroundColor = Colors.white,
    this.headerBackgroundColor = kPrimaryColor,
    this.selectedDayBackgroundColor = kPrimaryColor,
    this.selectedDayTextColor = Colors.white,
    this.dayTextColor = kBlack,
    this.weekdayTextColor = kBlack,
  });

  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Color backgroundColor;
  final Color headerBackgroundColor;
  final Color selectedDayBackgroundColor;
  final Color selectedDayTextColor;
  final Color dayTextColor;
  final Color weekdayTextColor;

  @override
  _MonthlyCalendarState createState() => _MonthlyCalendarState();
}

class _MonthlyCalendarState extends State<MonthlyCalendar> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  final List<String> _weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity != null) {
              if (details.primaryVelocity! < 0) {
                _nextMonth(); // Swipe Left
              } else if (details.primaryVelocity! > 0) {
                _previousMonth(); // Swipe Right
              }
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildWeekdayHeader(),
              _buildCalendarGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: widget.headerBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Bounce(
            duration: Duration(milliseconds: 100),
            onTap: _previousMonth,
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          MyText(
            text: DateFormat('MMMM yyyy').format(_currentMonth),
            size: 16,
            weight: FontWeight.w600,
            color: Colors.white,
          ),
          Bounce(
            duration: Duration(milliseconds: 100),
            onTap: _nextMonth,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            _weekdays.map((day) {
              return SizedBox(
                width: 32,
                child: Center(
                  child: MyText(
                    text: day,
                    size: 14,
                    color: widget.weekdayTextColor,
                    weight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    // First day of the month
    final DateTime firstDay = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );

    // Calculate how many empty cells before the first day of the month
    int firstWeekdayOfMonth = firstDay.weekday % 7; // 0-6 where 0 is Sunday

    // Calculate the number of days in the month
    final DateTime nextMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      1,
    );
    final int daysInMonth = nextMonth.difference(firstDay).inDays;

    // Build calendar days
    List<Widget> calendarDays = [];

    // Add empty cells for days before the first day of the month
    for (int i = 0; i < firstWeekdayOfMonth; i++) {
      calendarDays.add(SizedBox(width: 32));
    }

    // Add cells for each day of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime currentDate = DateTime(
        _currentMonth.year,
        _currentMonth.month,
        day,
      );
      final bool isSelected =
          currentDate.year == _selectedDate.year &&
          currentDate.month == _selectedDate.month &&
          currentDate.day == _selectedDate.day;

      calendarDays.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = currentDate;
            });
            widget.onDateSelected(currentDate);
          },
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: isSelected ? widget.selectedDayBackgroundColor : kWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color:
                    isSelected
                        ? widget.selectedDayBackgroundColor
                        : kTransperentColor,
              ),
            ),
            child: Center(
              child: MyText(
                text: day.toString(),
                size: 14,
                weight: isSelected ? FontWeight.w500 : FontWeight.w500,
                color:
                    isSelected
                        ? widget.selectedDayTextColor
                        : widget.dayTextColor,
              ),
            ),
          ),
        ),
      );
    }

    // Calculate rows needed for the grid
    int totalCells = firstWeekdayOfMonth + daysInMonth;
    int rowCount = (totalCells / 7).ceil();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: List.generate(rowCount, (rowIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (colIndex) {
              final index = rowIndex * 7 + colIndex;
              if (index < calendarDays.length) {
                return calendarDays[index];
              } else {
                return SizedBox(width: 32);
              }
            }),
          );
        }),
      ),
    );
  }
}

// Usage example:
void showMonthlyCalendar(BuildContext context) {
  DateTime selectedDate = DateTime.now();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return MonthlyCalendar(
        selectedDate: selectedDate,
        onDateSelected: (date) {
          selectedDate = date;
        },
        headerBackgroundColor: kPrimaryColor,
        selectedDayBackgroundColor: kPrimaryColor,
      );
    },
  );
}

//SCROLABLE

class ScrollableMonthlyCalendar extends StatefulWidget {
  const ScrollableMonthlyCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.backgroundColor = Colors.white,
    this.headerBackgroundColor = kPrimaryColor,
    this.selectedDayBackgroundColor = kPrimaryColor,
    this.selectedDayTextColor = Colors.white,
    this.dayTextColor = kBlack,
    this.weekdayTextColor = kBlack,
  });

  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Color backgroundColor;
  final Color headerBackgroundColor;
  final Color selectedDayBackgroundColor;
  final Color selectedDayTextColor;
  final Color dayTextColor;
  final Color weekdayTextColor;

  @override
  _ScrollableMonthlyCalendarState createState() =>
      _ScrollableMonthlyCalendarState();
}

class _ScrollableMonthlyCalendarState extends State<ScrollableMonthlyCalendar> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  final List<String> _weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  // Controller for detecting vertical swipes
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    _pageController = PageController(
      initialPage: 1000,
    ); // Start at a large number to allow scrolling both ways
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousMonth() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextMonth() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  DateTime _getMonthForPage(int page) {
    // Base month is the current month when the widget initializes
    final baseMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    // Calculate offset from base month (1000)
    final monthOffset = page - 1000;
    // Return the month at the offset
    return DateTime(baseMonth.year, baseMonth.month + monthOffset, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildWeekdayHeader(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentMonth = _getMonthForPage(page);
                });
              },
              itemBuilder: (context, page) {
                final monthToShow = _getMonthForPage(page);
                return _buildCalendarGrid(monthToShow);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: widget.headerBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Bounce(
            duration: Duration(milliseconds: 100),
            onTap: _previousMonth,
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          MyText(
            text: DateFormat('MMMM yyyy').format(_currentMonth),
            size: 16,
            weight: FontWeight.w600,
            color: Colors.white,
          ),
          Bounce(
            duration: Duration(milliseconds: 100),
            onTap: _nextMonth,
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            _weekdays.map((day) {
              return SizedBox(
                width: 32,
                child: Center(
                  child: MyText(
                    text: day,
                    size: 14,
                    color: widget.weekdayTextColor,
                    weight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildCalendarGrid(DateTime month) {
    // First day of the month
    final DateTime firstDay = DateTime(month.year, month.month, 1);

    // Calculate how many empty cells before the first day of the month
    int firstWeekdayOfMonth = firstDay.weekday % 7; // 0-6 where 0 is Sunday

    // Calculate the number of days in the month
    final DateTime nextMonth = DateTime(month.year, month.month + 1, 1);
    final int daysInMonth = nextMonth.difference(firstDay).inDays;

    // Build calendar days
    List<Widget> calendarDays = [];

    // Add empty cells for days before the first day of the month
    for (int i = 0; i < firstWeekdayOfMonth; i++) {
      calendarDays.add(SizedBox(width: 32));
    }

    // Add cells for each day of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime currentDate = DateTime(month.year, month.month, day);
      final bool isSelected =
          currentDate.year == _selectedDate.year &&
          currentDate.month == _selectedDate.month &&
          currentDate.day == _selectedDate.day;

      calendarDays.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = currentDate;
            });
            widget.onDateSelected(currentDate);
          },
          child: Container(
            height: 29,
            width: 29,
            decoration: BoxDecoration(
              color:
                  isSelected ? widget.selectedDayBackgroundColor : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color:
                    isSelected
                        ? widget.selectedDayBackgroundColor
                        : Colors.transparent,
              ),
            ),
            child: Center(
              child: MyText(
                text: day.toString(),
                size: 14,
                weight: isSelected ? FontWeight.w500 : FontWeight.w500,
                color:
                    isSelected
                        ? widget.selectedDayTextColor
                        : widget.dayTextColor,
              ),
            ),
          ),
        ),
      );
    }

    // Calculate rows needed for the grid
    int totalCells = firstWeekdayOfMonth + daysInMonth;
    int rowCount = (totalCells / 7).ceil();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: List.generate(rowCount, (rowIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (colIndex) {
              final index = rowIndex * 7 + colIndex;
              if (index < calendarDays.length) {
                return calendarDays[index];
              } else {
                return SizedBox(width: 32);
              }
            }),
          );
        }),
      ),
    );
  }
}
