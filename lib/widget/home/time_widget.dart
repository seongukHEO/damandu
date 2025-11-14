import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class TimeWidget extends StatefulWidget {
  const TimeWidget({super.key});

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  late final tz.Location _seoul;
  late final tz.Location _taipei;
  late Timer _timer;

  String _seoulTime = '';
  String _taipeiTime = '';

  @override
  void initState() {
    super.initState();
    tzdata.initializeTimeZones();
    _seoul = tz.getLocation('Asia/Seoul');
    _taipei = tz.getLocation('Asia/Taipei');
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final nowSeoul = tz.TZDateTime.now(_seoul);
    final nowTaipei = tz.TZDateTime.now(_taipei);

    final format = DateFormat('HH:mm:ss');
    final dateFormat = DateFormat('yyyy.MM.dd (E)', 'ko_KR');

    setState(() {
      _seoulTime =
      '${dateFormat.format(nowSeoul)}  ${format.format(nowSeoul)}';
      _taipeiTime =
      '${dateFormat.format(nowTaipei)}  ${format.format(nowTaipei)}';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF213547),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('🇰🇷 서울', _seoulTime),
          const SizedBox(height: 10),
          _buildRow('🇹🇼 타이베이', _taipeiTime),
          const SizedBox(height: 8),
          const Text(
            '※ 한국은 대만보다 1시간 빠릅니다.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String timeText) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            timeText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
