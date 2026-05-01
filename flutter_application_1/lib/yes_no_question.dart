import 'l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class YesNoQuestion extends StatelessWidget {
  final String questionText;
  final bool? selectedValue; // 接收目前的選擇 (true:是, false:否, null:未選)
  final ValueChanged<bool?> onChanged; // 當點擊時，把新選擇回報給上一層

  const YesNoQuestion({
    super.key,
    required this.questionText,
    required this.selectedValue,
    required this.onChanged,
  });

  void _handleTap(bool isYes) {
    if (selectedValue == isYes) {
      onChanged(null); // 如果點了已經選的 -> 取消
    } else {
      onChanged(isYes); // 否則 -> 選這個
    }
  }

  Widget _buildOptionButton(String text, bool isYes) {
    final isSelected = selectedValue == isYes;

    return GestureDetector(
      onTap: () => _handleTap(isYes),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        width: isSelected ? 88.0 : 76.0,
        height: isSelected ? 88.0 : 76.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFFD6E3B8) : const Color(0xFFE4EDF4),
          border: Border.all(
            color: const Color(0xFF4A5D6A),
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: isSelected ? 20.0 : 18.0,
            color: const Color(0xFF4A5D6A),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF5D4037),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOptionButton(AppLocalizations.of(context)!.yesBtn, true), // 👈 換成字典
                    const SizedBox(width: 40),
                    _buildOptionButton(AppLocalizations.of(context)!.noBtn, false), // 👈 換成字典
                  ],
                ), // 👈 這是你原本的第 78 行 (關閉 Row)
        
        const SizedBox(height: 40), // 加上底部的留白空間
      ], // 👈 補上這個！關閉 Column 的 children 清單
    ); // 👈 補上這個！關閉整個 Column
  }
}