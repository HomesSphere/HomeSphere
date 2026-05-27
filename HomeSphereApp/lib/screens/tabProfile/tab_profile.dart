import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TabProfile extends StatefulWidget {
  const TabProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<TabProfile> {
  final TextEditingController _controller = TextEditingController(
    text: "world",
  );
  String phonetic = "";
  int? score;
  String feedback = "";
  final FlutterTts flutterTts = FlutterTts();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  final Map<String, String> arpabetToReadable = {
    "AA": "ɑ",
    "AE": "æ",
    "AH": "(ə)",
    "AO": "ɔ",
    "AW": "aʊ",
    "AY": "aɪ",
    "B": "b",
    "CH": "ch",
    "D": "d",
    "DH": "th",
    "EH": "e",
    "ER": "ər",
    "EY": "ey",
    "F": "f",
    "G": "g",
    "HH": "h",
    "IH": "i",
    "IY": "ee",
    "JH": "j",
    "K": "k",
    "L": "l",
    "M": "m",
    "N": "n",
    "NG": "ng",
    "OW": "oʊ",
    "OY": "ɔɪ",
    "P": "p",
    "R": "r",
    "S": "s",
    "SH": "sh",
    "T": "t",
    "TH": "th",
    "UH": "ʊ",
    "UW": "oo",
    "V": "v",
    "W": "w",
    "Y": "y",
    "Z": "z",
    "ZH": "zh",
  };

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> fetchPhonetic() async {
    final word = _controller.text;
    final url = Uri.parse(
      "https://api.datamuse.com/words?sp=$word&qe=sp&md=fr&max=1",
    );
    try {
      final res = await http.get(url);
      final data = json.decode(res.body);

      String phon = "Phonetic not found";
      if (data.length > 0 && data[0]['tags'] != null) {
        final pronTag = (data[0]['tags'] as List<dynamic>).firstWhere(
          (t) => (t as String).startsWith("pron:"),
          orElse: () => "",
        );
        if (pronTag != "") {
          phon = arpabetToReadableString(pronTag.replaceFirst("pron:", ""));
        }
      }

      setState(() {
        phonetic = phon;
      });
    } catch (e) {
      setState(() {
        phonetic = "Error fetching phonetic";
      });
    }
  }

  String arpabetToReadableString(String arpabet) {
    final phonemes = arpabet.split(" ");
    final result = phonemes
        .map((ph) {
          final key = ph.replaceAll(RegExp(r'[0-2]'), "");
          return arpabetToReadable[key] ?? ph.toLowerCase();
        })
        .join(" ");

    // replace optional schwa
    return result.replaceAll(RegExp(r'\(?ə\)?'), "uh");
  }

  Future<void> playWord() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(_controller.text);
  }

  void checkPronunciation() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) {
            final spokenText = val.recognizedWords.toLowerCase();
            final target = _controller.text.toLowerCase();
            final scoreVal = pronunciationScore(target, spokenText);

            setState(() {
              score = scoreVal;
              if (scoreVal > 85) {
                feedback = "Excellent! ✅";
              } else if (scoreVal > 70) {
                feedback = "Good! Keep practicing 👍";
              } else {
                feedback = "Try again! 🔁";
              }
            });
          },
          localeId: "en_US",
        );
      }
    } else {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  int pronunciationScore(String target, String spoken) {
    final dist = levenshteinDistance(target, spoken);
    final maxLen = target.length > spoken.length
        ? target.length
        : spoken.length;
    return ((1 - dist / maxLen) * 100).round();
  }

  int levenshteinDistance(String a, String b) {
    final m = List.generate(b.length + 1, (_) => List.filled(a.length + 1, 0));
    for (int i = 0; i <= b.length; i++) {
      m[i][0] = i;
    }
    for (int j = 0; j <= a.length; j++) {
      m[0][j] = j;
    }

    for (int i = 1; i <= b.length; i++) {
      for (int j = 1; j <= a.length; j++) {
        if (b[i - 1] == a[j - 1]) {
          m[i][j] = m[i - 1][j - 1];
        } else {
          m[i][j] = [
            m[i - 1][j - 1] + 1,
            m[i][j - 1] + 1,
            m[i - 1][j] + 1,
          ].reduce((a, b) => a < b ? a : b);
        }
      }
    }
    return m[b.length][a.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("English Pronunciation Trainer")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter word",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: fetchPhonetic,
                  child: Text("🔍 Phonetic"),
                ),
                ElevatedButton(onPressed: playWord, child: Text("🔊 Play")),
                ElevatedButton(
                  onPressed: checkPronunciation,
                  child: Text("🎤 Speak"),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (phonetic.isNotEmpty)
              Text(
                "Phonetic: $phonetic",
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
            if (score != null)
              Text(
                "Score: $score%\n$feedback",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
