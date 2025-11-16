import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final Dio _dio = Dio();
  final String _apiKey = 'c0f8a9d3d339beeb8930642d1c1a5c5a';

  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;

  // ✅ 라임골드 팔레트
  static const Map<int, Color> _limeGold = {
    1: Color(0xFFF9FFE8),
    2: Color(0xFFEBFFB9),
    3: Color(0xFFDBFF84),
    4: Color(0xFFAAEB44),
    5: Color(0xFF89C83A),
    6: Color(0xFF6BA32F),
    7: Color(0xFF4F7A23),
  };

  Future<void> _fetchWeather() async {
    setState(() => _isLoading = true);
    try {
      const double taipeiLat = 25.0666;
      const double taipeiLon = 121.5523;

      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'lat': taipeiLat,
          'lon': taipeiLon,
          'appid': _apiKey,
          'units': 'metric',
          'lang': 'kr',
        },
      );
      setState(() => _weatherData = response.data);
    } catch (e) {
      debugPrint('❌ 날씨 불러오기 실패: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final weather = _weatherData?['weather']?[0];
    final main = _weatherData?['main'];
    final rain = _weatherData?['rain'];
    final snow = _weatherData?['snow'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF213547),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _limeGold[4]!.withOpacity(0.4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: _limeGold[7]!.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: _isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.white),
      )
          : _weatherData == null
          ? const Center(
        child: Text(
          '날씨 정보를 불러오지 못했습니다',
          style: TextStyle(color: Colors.white70),
        ),
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ✅ 도시 이름
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🇹🇼 타이베이',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: _limeGold[3],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.location_on_outlined,
                  color: Colors.white54, size: 16),
            ],
          ),
          const SizedBox(height: 8),

          // ✅ 날씨 설명 + 아이콘
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weather?['description'] ?? '',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              if (weather?['icon'] != null)
                Image.network(
                  'https://openweathermap.org/img/wn/${weather!['icon']}@2x.png',
                  width: 42,
                  height: 42,
                  errorBuilder: (context, error, stack) =>
                  const Icon(Icons.wb_sunny,
                      color: Colors.white54),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // ✅ 현재 온도
          Text(
            '${((main?['temp'] ?? 0) - 2).toStringAsFixed(1)}°C',
            style: TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.w900,
              color: _limeGold[3],
              shadows: [
                Shadow(
                  color: _limeGold[7]!.withOpacity(0.5),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // ✅ 체감온도 / 습도
          Text(
            '체감 ${((main?['feels_like'] ?? 0) - 2).toStringAsFixed(1)}°C',
            style: TextStyle(
              color: _limeGold[2],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '습도 ${main?['humidity'] ?? '--'}%',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 4),

          // ✅ 강수량 / 적설 여부
          Text(
            rain != null
                ? '강수량: ${rain['1h'] ?? rain['3h'] ?? 0} mm ☔️'
                : snow != null
                ? '적설량: ${snow['1h'] ?? snow['3h'] ?? 0} mm ❄️'
                : '비/눈 없음 ☀️',
            style: TextStyle(
              color: _limeGold[1],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          // ✅ 새로고침 버튼
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _fetchWeather,
            style: ElevatedButton.styleFrom(
              backgroundColor: _limeGold[4]!.withOpacity(0.2),
              foregroundColor: _limeGold[3],
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: _limeGold[4]!),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text(
              '새로고침',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

