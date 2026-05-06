import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'yes_no_question.dart';
import 'result_screen.dart'; // 🌟 引入結果頁面

class QuizPageData {
  final String title;
  final List<String> questions;
  QuizPageData({required this.title, required this.questions});
}

class QuizPagerScreen extends StatefulWidget {
  // 🌟 1. 宣告要從上一頁接過來的四個變數
  final String name;
  final String username;
  final String password;
  final String email;

  // 🌟 2. 規定跳轉過來時一定要帶上這四個資料
  const QuizPagerScreen({
    super.key,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
  });

  @override
  State<QuizPagerScreen> createState() => _QuizPagerScreenState();
}

class _QuizPagerScreenState extends State<QuizPagerScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late List<List<bool?>> userAnswers;

  @override
  void initState() {
    super.initState();
    final List<int> questionsPerPage = [3, 3, 3, 3, 4, 2, 3];
    userAnswers = questionsPerPage.map((count) => List<bool?>.filled(count, null)).toList();
  }

  void _submitQuiz(AppLocalizations loc, List<QuizPageData> quizPages) {
    List<String> incompletePages = [];
    
    // 檢查有沒有漏填的題目
    for (int i = 0; i < quizPages.length; i++) {
      if (userAnswers[i].contains(null)) {
        incompletePages.add(quizPages[i].title);
      }
    }

    if (incompletePages.isNotEmpty) {
      // 有漏填 -> 跳出警告框
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(loc.almostThereTitle, style: const TextStyle(color: Color(0xFF5D4037))),
          content: Text('${loc.missingAnswersText}${incompletePages.join('\n')}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.goCompleteBtn, style: const TextStyle(color: Color(0xFFE99D87), fontSize: 16)),
            ),
          ],
        ),
      );
    } else {
      // 🌟 全部填完啦！開始計算「是 (true)」的數量
      int totalScore = 0;
      for (var pageAnswers in userAnswers) {
        for (var answer in pageAnswers) {
          if (answer == true) {
            totalScore++;
          }
        }
      }

      // 帶著分數跳轉到結果頁面
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen( 
            score: totalScore,         // 保留原本算好的分數
            // 🌟 把手上接到的個人資料一起傳給下一棒（因為這頁是 Stateful，所以要加 widget.）
            name: widget.name,             
            username: widget.username,
            password: widget.password,
            email: widget.email,
          ), // 結束 ResultScreen
          ), // 結束 MaterialPageRoute
        ); // 🌟 真正結束 Navigator.pushReplacement (這裡只要用 ); 就好！)
      } // 🌟 結束 else 區塊的大括號
    } // 🌟 結束 _submitQuiz 函數的大括號

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final List<QuizPageData> quizPages = [
      QuizPageData(title: loc.quizPage1Title, questions: [loc.q1_1, loc.q1_2, loc.q1_3]),
      QuizPageData(title: loc.quizPage2Title, questions: [loc.q2_1, loc.q2_2, loc.q2_3]),
      QuizPageData(title: loc.quizPage3Title, questions: [loc.q3_1, loc.q3_2, loc.q3_3]),
      QuizPageData(title: loc.quizPage4Title, questions: [loc.q4_1, loc.q4_2, loc.q4_3]),
      QuizPageData(title: loc.quizPage5Title, questions: [loc.q5_1, loc.q5_2, loc.q5_3, loc.q5_4]),
      QuizPageData(title: loc.quizPage6Title, questions: [loc.q6_1, loc.q6_2]),
      QuizPageData(title: loc.quizPage7Title, questions: [loc.q7_1, loc.q7_2, loc.q7_3]),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: Stack(
        children: [
          // 頂部漸層波浪
          ClipPath(
            clipper: QuizWaveClipper(),
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0x66F79A8B), Color(0x66FFD194)], // 淡淡的漸層
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: quizPages.length,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemBuilder: (context, pageIndex) {
                      final pageData = quizPages[pageIndex];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              pageData.title,
                              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                            ),
                            const SizedBox(height: 135),// 🌟 就是這裡！把原本的 60 改大，例如改成 90 或 100
                            
                            ...List.generate(pageData.questions.length, (qIndex) {
                              return YesNoQuestion(
                                questionText: pageData.questions[qIndex],
                                selectedValue: userAnswers[pageIndex][qIndex],
                                onChanged: (newValue) {
                                  setState(() {
                                    userAnswers[pageIndex][qIndex] = newValue;
                                  });
                                },
                              );
                            }),

                            if (pageIndex == quizPages.length - 1)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: ElevatedButton(
                                    onPressed: () => _submitQuiz(loc, quizPages),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 254, 210, 107),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      loc.finishExploreBtn,
                                      style: const TextStyle(fontSize: 18, color: Color(0xFF5D4037), fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                // 底部進度點點
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      quizPages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: _currentPage == index ? 24 : 12,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: _currentPage == index
                              ? const LinearGradient(colors: [Color(0xFFFFD194), Color(0xFFF79A8B)])
                              : null,
                          color: _currentPage != index ? const Color(0xFFD9E2E8) : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= 【問卷頁面專用的波浪剪裁器】 =================
class QuizWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}