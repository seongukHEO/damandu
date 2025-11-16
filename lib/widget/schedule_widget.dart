import 'package:damandu/common/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // ✅ 임시 일정 데이터 (나중에 Firestore로 대체 가능)
  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2025, 11, 15): ['회의', '프로젝트 정리'],
    DateTime.utc(2025, 11, 16): ['대만 여행 일정 확인'],
    DateTime.utc(2025, 11, 17): ['팀 회의', '앱 업데이트 검토'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ✅ 상단 달력
              TableCalendar(
                locale: 'ko_KR',
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon:
                  Icon(Icons.chevron_right, color: Colors.white),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: AppColors.limeGold(7),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFFAAEB44), // limeGold(4)
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(color: Colors.black),
                  weekendTextStyle: TextStyle(color: Colors.orangeAccent),
                ),
              ),
              const SizedBox(height: 8),
              Divider(height: 1, color: Colors.grey.shade400,),
              const SizedBox(height: 8),

              // ✅ 하단 일정 목록
              Expanded(
                child: selectedEvents.isEmpty
                    ? const Center(
                  child: Text(
                    '일정이 없습니다.',
                    style:
                    TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                )
                    : ListView.builder(
                  itemCount: selectedEvents.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: AppColors.limeGold(2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.event_note,
                                    color: Colors.black, size: 20),
                                const SizedBox(width: 10),
                                Text(
                                  selectedEvents[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15,)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
