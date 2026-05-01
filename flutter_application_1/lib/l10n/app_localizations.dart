import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @loginTitle.
  ///
  /// In zh, this message translates to:
  /// **'歡迎回來'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'繼續我們的心靈之旅'**
  String get loginSubtitle;

  /// No description provided for @email.
  ///
  /// In zh, this message translates to:
  /// **'電子信箱'**
  String get email;

  /// No description provided for @password.
  ///
  /// In zh, this message translates to:
  /// **'密碼'**
  String get password;

  /// No description provided for @loginBtn.
  ///
  /// In zh, this message translates to:
  /// **'登 入'**
  String get loginBtn;

  /// No description provided for @fgtpassword.
  ///
  /// In zh, this message translates to:
  /// **'忘記密碼？'**
  String get fgtpassword;

  /// No description provided for @orLoginWith.
  ///
  /// In zh, this message translates to:
  /// **'或以其他方式登入'**
  String get orLoginWith;

  /// No description provided for @noAccountText.
  ///
  /// In zh, this message translates to:
  /// **'還沒有帳號嗎？ '**
  String get noAccountText;

  /// No description provided for @registerText.
  ///
  /// In zh, this message translates to:
  /// **'註 冊'**
  String get registerText;

  /// No description provided for @registerTitle.
  ///
  /// In zh, this message translates to:
  /// **'加入我們'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'展開一場心靈之旅'**
  String get registerSubtitle;

  /// No description provided for @usersname.
  ///
  /// In zh, this message translates to:
  /// **'使用者名稱'**
  String get usersname;

  /// No description provided for @cfmpassword.
  ///
  /// In zh, this message translates to:
  /// **'確認密碼'**
  String get cfmpassword;

  /// No description provided for @haveAccountText.
  ///
  /// In zh, this message translates to:
  /// **'已經有帳號了嗎？'**
  String get haveAccountText;

  /// No description provided for @verifyTitle.
  ///
  /// In zh, this message translates to:
  /// **'輸入驗證碼'**
  String get verifyTitle;

  /// No description provided for @verifySubtitle.
  ///
  /// In zh, this message translates to:
  /// **'完成帳號註冊'**
  String get verifySubtitle;

  /// No description provided for @verifyInstruction1.
  ///
  /// In zh, this message translates to:
  /// **'我們已傳送6位數驗證碼至您的信箱。'**
  String get verifyInstruction1;

  /// No description provided for @verifyInstruction2.
  ///
  /// In zh, this message translates to:
  /// **'請前往查看並輸入驗證碼。'**
  String get verifyInstruction2;

  /// No description provided for @confirmBtn.
  ///
  /// In zh, this message translates to:
  /// **'確認'**
  String get confirmBtn;

  /// No description provided for @helloTitle.
  ///
  /// In zh, this message translates to:
  /// **'Hello!'**
  String get helloTitle;

  /// No description provided for @helloSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'看來我們又有一位新夥伴了！'**
  String get helloSubtitle;

  /// No description provided for @nicknameHint.
  ///
  /// In zh, this message translates to:
  /// **'輸入你的暱稱'**
  String get nicknameHint;

  /// No description provided for @goBtn.
  ///
  /// In zh, this message translates to:
  /// **'出發！'**
  String get goBtn;

  /// No description provided for @welcomeJoin.
  ///
  /// In zh, this message translates to:
  /// **'歡迎加入，'**
  String get welcomeJoin;

  /// No description provided for @welcomePara1.
  ///
  /// In zh, this message translates to:
  /// **'在這裡，你不需要說明一切。\n只要依直覺拾取當下的心情。\n我們會在你情緒起伏時溫柔提醒，\n隨時為你留一盞光，\n與你一起慢慢認識自己的情緒節奏。'**
  String get welcomePara1;

  /// No description provided for @welcomePara2.
  ///
  /// In zh, this message translates to:
  /// **'在這趟陪伴之旅開始前，\n我們想先聽聽你最近過得如何。\n接下來的幾個小問題，\n只是為了讓ECHO更懂你。\n請放心回答，\n你的感受在這裡都是安全的。'**
  String get welcomePara2;

  /// No description provided for @readyBtn.
  ///
  /// In zh, this message translates to:
  /// **'我準備好了！'**
  String get readyBtn;

  /// No description provided for @termsOfUse.
  ///
  /// In zh, this message translates to:
  /// **'使用條款'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In zh, this message translates to:
  /// **'隱私政策'**
  String get privacyPolicy;

  /// No description provided for @consentText.
  ///
  /// In zh, this message translates to:
  /// **'使用此應用程式，即表示您同意其使用條款。'**
  String get consentText;

  /// No description provided for @privacyTitle.
  ///
  /// In zh, this message translates to:
  /// **'我們重視您的隱私權'**
  String get privacyTitle;

  /// No description provided for @privacyPara1.
  ///
  /// In zh, this message translates to:
  /// **'我們根據隱私法規處理您的資料。'**
  String get privacyPara1;

  /// No description provided for @privacyPara2.
  ///
  /// In zh, this message translates to:
  /// **'我們希望使用您的 Google Ads ID 來衡量廣告成效，並偵測可疑的欺詐活動，絕不會用於廣告定位功能。這項資訊有助於我們改進服務，提供更好的體驗。'**
  String get privacyPara2;

  /// No description provided for @privacyPara3.
  ///
  /// In zh, this message translates to:
  /// **'Google Ads ID 以尊重使用者隱私為依歸，絕不提供使用者的任何個人資料。'**
  String get privacyPara3;

  /// No description provided for @agreeBtn.
  ///
  /// In zh, this message translates to:
  /// **'同意'**
  String get agreeBtn;

  /// No description provided for @disagreeBtn.
  ///
  /// In zh, this message translates to:
  /// **'不同意'**
  String get disagreeBtn;

  /// No description provided for @termsTitle.
  ///
  /// In zh, this message translates to:
  /// **'陪伴旅程的約定'**
  String get termsTitle;

  /// No description provided for @termsPara1.
  ///
  /// In zh, this message translates to:
  /// **'歡迎來到這裡。為了確保這趟心靈之旅的安全與舒適，我們訂定了以下簡單的約定。'**
  String get termsPara1;

  /// No description provided for @termsPara2.
  ///
  /// In zh, this message translates to:
  /// **'這裡是一個包容且絕對安全的空間，請尊重並善待自己。我們承諾保護您的個人隱私，而您也同意不將本服務用於任何非法或惡意濫用的行為。'**
  String get termsPara2;

  /// No description provided for @termsPara3.
  ///
  /// In zh, this message translates to:
  /// **'我們會持續傾聽，讓這個空間變得更好。如果您繼續使用，即表示您願意與我們共同守護這份溫暖的約定。'**
  String get termsPara3;

  /// No description provided for @disagreePrivacyTitle.
  ///
  /// In zh, this message translates to:
  /// **'不同意隱私政策並退出？'**
  String get disagreePrivacyTitle;

  /// No description provided for @disagreeTermsTitle.
  ///
  /// In zh, this message translates to:
  /// **'不同意條款並退出？'**
  String get disagreeTermsTitle;

  /// No description provided for @thinkAgainBtn.
  ///
  /// In zh, this message translates to:
  /// **'再想想'**
  String get thinkAgainBtn;

  /// No description provided for @exitBtn.
  ///
  /// In zh, this message translates to:
  /// **'不同意並退出'**
  String get exitBtn;

  /// No description provided for @quizIntroTitle.
  ///
  /// In zh, this message translates to:
  /// **'心靈節奏探索'**
  String get quizIntroTitle;

  /// No description provided for @quizIntroSubtitle1.
  ///
  /// In zh, this message translates to:
  /// **'請參考你「最近一個月」的感受，'**
  String get quizIntroSubtitle1;

  /// No description provided for @quizIntroSubtitle2.
  ///
  /// In zh, this message translates to:
  /// **'依直覺回答「是」或「否」。'**
  String get quizIntroSubtitle2;

  /// No description provided for @startExploreBtn.
  ///
  /// In zh, this message translates to:
  /// **'開始探索'**
  String get startExploreBtn;

  /// No description provided for @yesBtn.
  ///
  /// In zh, this message translates to:
  /// **'是'**
  String get yesBtn;

  /// No description provided for @noBtn.
  ///
  /// In zh, this message translates to:
  /// **'否'**
  String get noBtn;

  /// No description provided for @finishExploreBtn.
  ///
  /// In zh, this message translates to:
  /// **'探索完成'**
  String get finishExploreBtn;

  /// No description provided for @almostThereTitle.
  ///
  /// In zh, this message translates to:
  /// **'還差一點點喔！'**
  String get almostThereTitle;

  /// No description provided for @missingAnswersText.
  ///
  /// In zh, this message translates to:
  /// **'以下段落還有問題沒有回答到：\n\n'**
  String get missingAnswersText;

  /// No description provided for @goCompleteBtn.
  ///
  /// In zh, this message translates to:
  /// **'去完成'**
  String get goCompleteBtn;

  /// No description provided for @exploreSuccessMsg.
  ///
  /// In zh, this message translates to:
  /// **'太棒了！探索完成！即將進入結果分析...'**
  String get exploreSuccessMsg;

  /// No description provided for @quizPage1Title.
  ///
  /// In zh, this message translates to:
  /// **'最近的日常感受'**
  String get quizPage1Title;

  /// No description provided for @quizPage2Title.
  ///
  /// In zh, this message translates to:
  /// **'睡眠與休息'**
  String get quizPage2Title;

  /// No description provided for @quizPage3Title.
  ///
  /// In zh, this message translates to:
  /// **'生活中的緊繃感'**
  String get quizPage3Title;

  /// No description provided for @quizPage4Title.
  ///
  /// In zh, this message translates to:
  /// **'思緒與片刻回憶'**
  String get quizPage4Title;

  /// No description provided for @quizPage5Title.
  ///
  /// In zh, this message translates to:
  /// **'想避開的事與想法'**
  String get quizPage5Title;

  /// No description provided for @quizPage6Title.
  ///
  /// In zh, this message translates to:
  /// **'生活影響程度'**
  String get quizPage6Title;

  /// No description provided for @quizPage7Title.
  ///
  /// In zh, this message translates to:
  /// **'更細微的感受'**
  String get quizPage7Title;

  /// No description provided for @q1_1.
  ///
  /// In zh, this message translates to:
  /// **'最近比平常更容易感到緊繃或放鬆不下？'**
  String get q1_1;

  /// No description provided for @q1_2.
  ///
  /// In zh, this message translates to:
  /// **'最近心情起伏比以前明顯嗎？'**
  String get q1_2;

  /// No description provided for @q1_3.
  ///
  /// In zh, this message translates to:
  /// **'最近比較容易感到煩躁或沒耐心？'**
  String get q1_3;

  /// No description provided for @q2_1.
  ///
  /// In zh, this message translates to:
  /// **'最近睡眠變得比較淺，或容易醒來？'**
  String get q2_1;

  /// No description provided for @q2_2.
  ///
  /// In zh, this message translates to:
  /// **'最近覺得睡得不太踏實或恢復感不足？'**
  String get q2_2;

  /// No description provided for @q2_3.
  ///
  /// In zh, this message translates to:
  /// **'有時腦中的畫面或想法會影響入睡？'**
  String get q2_3;

  /// No description provided for @q3_1.
  ///
  /// In zh, this message translates to:
  /// **'最近比較容易被突然的聲音或動作嚇到？'**
  String get q3_1;

  /// No description provided for @q3_2.
  ///
  /// In zh, this message translates to:
  /// **'最近是否常常覺得很難真正放鬆下來？'**
  String get q3_2;

  /// No description provided for @q3_3.
  ///
  /// In zh, this message translates to:
  /// **'最近常常覺得身體或心裡處於緊繃狀態？'**
  String get q3_3;

  /// No description provided for @q4_1.
  ///
  /// In zh, this message translates to:
  /// **'最近比較難集中精神或專心做事？'**
  String get q4_1;

  /// No description provided for @q4_2.
  ///
  /// In zh, this message translates to:
  /// **'有時想起一些畫面或回憶，讓你有點不舒服？'**
  String get q4_2;

  /// No description provided for @q4_3.
  ///
  /// In zh, this message translates to:
  /// **'最近出現過讓你感到不安的夢境？'**
  String get q4_3;

  /// No description provided for @q5_1.
  ///
  /// In zh, this message translates to:
  /// **'會刻意避開某些引起不舒服回憶的人事物？'**
  String get q5_1;

  /// No description provided for @q5_2.
  ///
  /// In zh, this message translates to:
  /// **'覺得自己和身邊的人距離變遠、不想聊天？'**
  String get q5_2;

  /// No description provided for @q5_3.
  ///
  /// In zh, this message translates to:
  /// **'偶爾會因某些事情而責怪自己或感到愧疚？'**
  String get q5_3;

  /// No description provided for @q5_4.
  ///
  /// In zh, this message translates to:
  /// **'最近對以前感興趣的事情，比較提不起勁？'**
  String get q5_4;

  /// No description provided for @q6_1.
  ///
  /// In zh, this message translates to:
  /// **'這些感受是否讓日常生活變得比較吃力？'**
  String get q6_1;

  /// No description provided for @q6_2.
  ///
  /// In zh, this message translates to:
  /// **'最近是否因為這些狀態而感到疲累或困擾？'**
  String get q6_2;

  /// No description provided for @q7_1.
  ///
  /// In zh, this message translates to:
  /// **'某些場景、聲音或對話會讓你有些不舒服？'**
  String get q7_1;

  /// No description provided for @q7_2.
  ///
  /// In zh, this message translates to:
  /// **'有時候好像回到一個不到好受的時刻？'**
  String get q7_2;

  /// No description provided for @q7_3.
  ///
  /// In zh, this message translates to:
  /// **'某些記憶，偶爾仍會影響你的情緒？'**
  String get q7_3;

  /// No description provided for @resultTitle.
  ///
  /// In zh, this message translates to:
  /// **'你的心靈守護者是'**
  String get resultTitle;

  /// No description provided for @guardianQuokkaName.
  ///
  /// In zh, this message translates to:
  /// **'葵葵'**
  String get guardianQuokkaName;

  /// No description provided for @guardianQuokkaDesc1.
  ///
  /// In zh, this message translates to:
  /// **'短尾矮袋鼠天生樂觀，\n遇到環境變化時會先觀察，再慢慢適應。\n最近的你，也許偶爾感到緊繃或疲倦，\n但內在仍保有彈性與恢復力。'**
  String get guardianQuokkaDesc1;

  /// No description provided for @guardianQuokkaDesc2.
  ///
  /// In zh, this message translates to:
  /// **'給自己一點休息時間，你會很快找回平衡。'**
  String get guardianQuokkaDesc2;

  /// No description provided for @guardianPenguinName.
  ///
  /// In zh, this message translates to:
  /// **'絨絨'**
  String get guardianPenguinName;

  /// No description provided for @guardianPenguinDesc1.
  ///
  /// In zh, this message translates to:
  /// **'國王企鵝寶寶在寒冷中依靠群體取暖，\n表面平靜，其實需要穩定的支持。\n最近的你，可能變得比較警覺、容易疲累，\n偶爾也會被回憶或情緒拉走注意力。'**
  String get guardianPenguinDesc1;

  /// No description provided for @guardianPenguinDesc2.
  ///
  /// In zh, this message translates to:
  /// **'你不需要獨自承受，可以適度靠近信任的人。'**
  String get guardianPenguinDesc2;

  /// No description provided for @guardianRabbitName.
  ///
  /// In zh, this message translates to:
  /// **'蹦蹦'**
  String get guardianRabbitName;

  /// No description provided for @guardianRabbitDesc1.
  ///
  /// In zh, this message translates to:
  /// **'荷蘭侏儒兔天生敏銳。\n最近的你，也許常常保持警戒，\n情緒來得快，回憶也偶爾突然出現。'**
  String get guardianRabbitDesc1;

  /// No description provided for @guardianRabbitDesc2.
  ///
  /// In zh, this message translates to:
  /// **'安全感不是天生的，而是可以慢慢建立的。\n讓自己停下來，重新確認「現在是安全的」。'**
  String get guardianRabbitDesc2;

  /// No description provided for @guardianHedgehogName.
  ///
  /// In zh, this message translates to:
  /// **'糰糰'**
  String get guardianHedgehogName;

  /// No description provided for @guardianHedgehogDesc1.
  ///
  /// In zh, this message translates to:
  /// **'歐洲刺蝟在感受到威脅時會蜷縮成球，\n這不是退縮，而是一種自我保護。\n最近的你，也許很努力地撐著，\n有時覺得疲憊、麻木，或不想被打擾。'**
  String get guardianHedgehogDesc1;

  /// No description provided for @guardianHedgehogDesc2.
  ///
  /// In zh, this message translates to:
  /// **'放下防備，不代表脆弱。\n有些重量，可以交給專業的人陪你一起分擔。'**
  String get guardianHedgehogDesc2;

  /// No description provided for @enableNotifBtn.
  ///
  /// In zh, this message translates to:
  /// **'開啟通知並繼續'**
  String get enableNotifBtn;

  /// No description provided for @skipNotifBtn.
  ///
  /// In zh, this message translates to:
  /// **'不開啟通知並繼續'**
  String get skipNotifBtn;

  /// No description provided for @homePromptText.
  ///
  /// In zh, this message translates to:
  /// **'放點此刻的心情進瓶子裡吧'**
  String get homePromptText;

  /// No description provided for @homePickMoodBtn.
  ///
  /// In zh, this message translates to:
  /// **'挑選心情'**
  String get homePickMoodBtn;

  /// No description provided for @navHome.
  ///
  /// In zh, this message translates to:
  /// **'首頁'**
  String get navHome;

  /// No description provided for @navData.
  ///
  /// In zh, this message translates to:
  /// **'數據'**
  String get navData;

  /// No description provided for @navStore.
  ///
  /// In zh, this message translates to:
  /// **'商城'**
  String get navStore;

  /// No description provided for @navProfile.
  ///
  /// In zh, this message translates to:
  /// **'個人'**
  String get navProfile;

  /// No description provided for @categoryWarm.
  ///
  /// In zh, this message translates to:
  /// **'溫暖時刻'**
  String get categoryWarm;

  /// No description provided for @categoryCalm.
  ///
  /// In zh, this message translates to:
  /// **'靜靜感受'**
  String get categoryCalm;

  /// No description provided for @categoryStorm.
  ///
  /// In zh, this message translates to:
  /// **'情緒風暴'**
  String get categoryStorm;

  /// No description provided for @categoryMixed.
  ///
  /// In zh, this message translates to:
  /// **'交織心情'**
  String get categoryMixed;

  /// No description provided for @moodHappy.
  ///
  /// In zh, this message translates to:
  /// **'快樂'**
  String get moodHappy;

  /// No description provided for @moodJoy.
  ///
  /// In zh, this message translates to:
  /// **'喜悅'**
  String get moodJoy;

  /// No description provided for @moodExpectant.
  ///
  /// In zh, this message translates to:
  /// **'期待'**
  String get moodExpectant;

  /// No description provided for @moodBlessed.
  ///
  /// In zh, this message translates to:
  /// **'幸福'**
  String get moodBlessed;

  /// No description provided for @moodRelieved.
  ///
  /// In zh, this message translates to:
  /// **'安心'**
  String get moodRelieved;

  /// No description provided for @moodPeaceful.
  ///
  /// In zh, this message translates to:
  /// **'平靜'**
  String get moodPeaceful;

  /// No description provided for @moodHope.
  ///
  /// In zh, this message translates to:
  /// **'希望'**
  String get moodHope;

  /// No description provided for @moodLove.
  ///
  /// In zh, this message translates to:
  /// **'愛'**
  String get moodLove;

  /// No description provided for @moodTender.
  ///
  /// In zh, this message translates to:
  /// **'溫柔'**
  String get moodTender;

  /// No description provided for @moodAtEase.
  ///
  /// In zh, this message translates to:
  /// **'自在'**
  String get moodAtEase;

  /// No description provided for @putInBottleBtn.
  ///
  /// In zh, this message translates to:
  /// **'放入情緒球'**
  String get putInBottleBtn;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
