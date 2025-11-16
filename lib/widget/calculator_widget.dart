import 'package:damandu/common/app_fonts.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../component/textField_component.dart';


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart'; // 통화 포맷용 (₩43,200)

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final TextEditingController _controller = TextEditingController();
  final Dio _dio = Dio();

  double? _result;
  double? _exchangeRate;
  bool _isLoading = false;

  Future<void> _fetchExchangeRate() async {
    setState(() => _isLoading = true);
    try {
      final response = await _dio.get('https://open.er-api.com/v6/latest/TWD');

      final rate = response.data?['rates']?['KRW']; // ✅ null-safe 접근
      if (rate == null) {
        throw Exception('환율 데이터 없음');
      }

      setState(() {
        _exchangeRate = rate;
      });
    } catch (e) {
      debugPrint('❌ 환율 가져오기 실패: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('환율 정보를 불러오지 못했습니다.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }


  // ✅ 계산하기
  Future<void> _calculate() async {
    final amount = double.tryParse(_controller.text);
    if (amount == null) return;

    if (_exchangeRate == null) await _fetchExchangeRate();

    setState(() {
      _result = amount * (_exchangeRate ?? 0);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchExchangeRate(); // 첫 실행 시 환율 로드
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'ko_KR', symbol: '₩'); // ₩ 표시용

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text('환율 계산', style: AppFonts.preBold(size: 20)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: TextFieldComponent(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      hintText: "금액을 입력해주세요",
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 3,
                    child: Text(
                      '🇹🇼 대만 달러',
                      style: AppFonts.preSemiBold(size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: _isLoading ? null : _calculate,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.limeGold(5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                      "계산하기",
                      style: AppFonts.preBold(size: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  _result == null
                      ? ''
                      : '${formatter.format(_result)}원',
                  style: AppFonts.preBold(size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
