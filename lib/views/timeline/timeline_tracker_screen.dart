// lib/views/timeline/timeline_tracker_screen.dart

import 'package:flutter/material.dart';

class TimelineTrackerScreen extends StatefulWidget {
  const TimelineTrackerScreen({Key? key}) : super(key: key);

  @override
  State<TimelineTrackerScreen> createState() => _TimelineTrackerScreenState();
}

class _TimelineTrackerScreenState extends State<TimelineTrackerScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  int currentNavIndex = 1;
  bool isOffline = false;

  final List<DeadlineItem> upcomingDeadlines = [
    DeadlineItem(
      icon: Icons.school,
      iconColor: Colors.blue,
      title: "College Application Due",
      subtitle: "Stanford University",
      date: "Dec 15",
    ),
    DeadlineItem(
      icon: Icons.assignment,
      iconColor: Colors.green,
      title: "Scholarship Essay",
      subtitle: "Merit-based scholarship",
      date: "Dec 20",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // This will completely hide the app bar
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Calendar Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildCustomCalendar(),
              ),
              
              // Upcoming Deadlines Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Upcoming Deadlines',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildDeadlineList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeadlineList() {
    if (upcomingDeadlines.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 48.0,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16.0),
            Text(
              'No upcoming deadlines',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: upcomingDeadlines.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _buildDeadlineCard(upcomingDeadlines[index]),
        );
      },
    );
  }

  Widget _buildCustomCalendar() {
    return Column(
      children: [
        // Month/Year Header with navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                setState(() {
                  focusedDate = DateTime(focusedDate.year, focusedDate.month - 1);
                });
              },
            ),
            Text(
              _getMonthYearString(focusedDate),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A237E),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                setState(() {
                  focusedDate = DateTime(focusedDate.year, focusedDate.month + 1);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Days of week header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
              .map((day) => SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        _buildCalendarGrid(),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    // Get the first day of the month and the number of days in the month
    final firstDayOfMonth = DateTime(focusedDate.year, focusedDate.month, 1);
    final daysInMonth = DateTime(focusedDate.year, focusedDate.month + 1, 0).day;
    
    // Get the weekday of the first day (0 = Sunday, 6 = Saturday)
    final firstWeekday = firstDayOfMonth.weekday % 7; // Make Sunday = 0
    
    // Calculate the number of rows needed (4-6 weeks)
    final firstDayOffset = firstDayOfMonth.weekday % 7; // 0-6 (Sun-Sat)
    final totalDaysShown = daysInMonth + firstDayOffset;
    final totalRows = ((totalDaysShown + 6) / 7).ceil(); // Round up to nearest integer
    final totalCells = totalRows * 7; // Total cells needed
    final rowHeight = 48.0; // Height for each row (including padding)
    
    return Container(
      height: (totalRows * rowHeight) + 32, // Dynamic height based on rows needed
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling since height is dynamic
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.0,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemCount: totalCells,
        itemBuilder: (context, index) {
          // Calculate the day number to display
          final dayNumber = index - firstWeekday + 1;
          final isCurrentMonth = dayNumber > 0 && dayNumber <= daysInMonth;
          
          // Calculate the actual date for this cell
          DateTime cellDate;
          if (dayNumber <= 0) {
            // Previous month
            final prevMonth = focusedDate.month == 1 ? 12 : focusedDate.month - 1;
            final prevYear = focusedDate.month == 1 ? focusedDate.year - 1 : focusedDate.year;
            final daysInPrevMonth = DateTime(prevYear, prevMonth + 1, 0).day;
            cellDate = DateTime(prevYear, prevMonth, daysInPrevMonth + dayNumber);
          } else if (dayNumber > daysInMonth) {
            // Next month
            final nextMonth = focusedDate.month == 12 ? 1 : focusedDate.month + 1;
            final nextYear = focusedDate.month == 12 ? focusedDate.year + 1 : focusedDate.year;
            cellDate = DateTime(nextYear, nextMonth, dayNumber - daysInMonth);
          } else {
            // Current month
            cellDate = DateTime(focusedDate.year, focusedDate.month, dayNumber);
          }
          
          final isToday = cellDate.year == DateTime.now().year &&
                         cellDate.month == DateTime.now().month &&
                         cellDate.day == DateTime.now().day;
          
          return Container(
            margin: const EdgeInsets.all(2.0),
            child: Center(
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isToday ? const Color(0xFF1A237E).withOpacity(0.8) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    cellDate.day.toString(),
                    style: TextStyle(
                      color: isToday 
                          ? Colors.white 
                          : isCurrentMonth 
                              ? Colors.black 
                              : Colors.grey[400],
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeadlineCard(DeadlineItem deadline) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: deadline.iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(deadline.icon, color: deadline.iconColor),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deadline.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  deadline.subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Text(
            deadline.date,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.orange,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getMonthYearString(DateTime date) {
    return '${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    return [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ][month - 1];
  }
}

class DeadlineItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String date;

  DeadlineItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.date,
  });
}