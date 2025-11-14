import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';


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

  // ✅ 도시 이름을 한글로 변환
  String _translateCity(String city) {
    switch (city.toLowerCase()) {
      case 'seoul':
        return '서울';
      case 'Uijeongbu-si':
        return '의정부';
      case 'busan':
        return '부산';
      case 'incheon':
        return '인천';
      case 'daegu':
        return '대구';
      case 'daejeon':
        return '대전';
      case 'gwangju':
        return '광주';
      case 'ulsan':
        return '울산';
      case 'jeju city':
        return '제주';
      case 'taipei':
        return '타이베이';
      case 'kaohsiung':
        return '가오슝';
      default:
        return city;
    }
  }

  Future<void> _fetchWeather() async {
    setState(() => _isLoading = true);

    try {
      // ✅ 위치 권한 확인
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoading = false);
          return;
        }
      }

      // ✅ 현재 위치 가져오기
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // ✅ 날씨 데이터 요청
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'lat': pos.latitude,
          'lon': pos.longitude,
          'appid': _apiKey,
          'units': 'metric',
          'lang': 'kr', // ✅ 한글 번역
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
    _fetchWeather(); // 첫 로드 시 1회 실행
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF213547),
        borderRadius: BorderRadius.circular(16),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ✅ 도시 이름
          Text(
            _translateCity(_weatherData!['name'] ?? '—'),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),

          // ✅ 날씨 설명
          Text(
            _weatherData!['weather'][0]['description'] ?? '',
            style:
            const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),

          // ✅ 온도
          Text(
            '${_weatherData!['main']['temp'].toStringAsFixed(1)}°C',
            style:
            const TextStyle(fontSize: 36, color: Colors.white),
          ),
          const SizedBox(height: 4),

          // ✅ 습도
          Text(
            '습도 ${_weatherData!['main']['humidity']}%',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 4),

          // ✅ 강수량 (비/눈 여부)
          Text(
            _weatherData!['rain'] != null
                ? '강수량: ${_weatherData!['rain']['1h'] ?? _weatherData!['rain']['3h'] ?? 0} mm ☔️'
                : _weatherData!['snow'] != null
                ? '적설량: ${_weatherData!['snow']['1h'] ?? _weatherData!['snow']['3h'] ?? 0} mm ❄️'
                : '비/눈 없음 ☀️',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 12),

          // ✅ 새로고침 버튼
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _fetchWeather,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
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
