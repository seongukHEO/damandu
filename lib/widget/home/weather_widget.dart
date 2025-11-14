import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final Dio _dio = Dio();
  final String _apiKey = 'c0f8a9d3d339beeb8930642d1c1a5c5a'; // ✅ OpenWeatherMap API 키

  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;

  Future<void> _fetchWeather() async {
    setState(() => _isLoading = true);

    try {
      // ✅ 타이베이 고정 좌표
      const double taipeiLat = 25.0330;
      const double taipeiLon = 121.5654;

      // ✅ 무료 버전 /weather API 사용
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF213547),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
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
          const Text(
            '🇹🇼 타이베이',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),

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
                  const Icon(Icons.wb_sunny, color: Colors.white54),
                ),
            ],
          ),
          const SizedBox(height: 8),

          // ✅ 현재 온도
          Text(
            '${main?['temp']?.toStringAsFixed(1) ?? '--'}°C',
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),

          // ✅ 체감온도 / 습도
          Text(
            '체감 ${main?['feels_like']?.toStringAsFixed(1) ?? '--'}°C',
            style: const TextStyle(color: Colors.white70),
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
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),

          // ✅ 새로고침 버튼
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _fetchWeather,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.refresh,
                color: Colors.white, size: 18),
            label: const Text(
              '새로고침',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
