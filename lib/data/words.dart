import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Words {
  final Map<String, List<String>> alphabetMap = {};

  loadMapFromAssets(BuildContext context) async {
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final images = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/quiz_images'))
        .toList();
    images.forEach((String path) {
      if (kDebugMode) {
        print(path);
      }
      var tmp = path.replaceAll('assets/quiz_images/', '');
      var part = tmp.split('/');
      var alphabet = part[0];
      //var filename = part[1];

      if (!alphabetMap.containsKey(alphabet)) {
        alphabetMap[alphabet] = [];
      }
      alphabetMap[alphabet]!.add(path);
    });
  }

  String randomAlphabet() {
    return alphabetMap.keys
        .elementAt(Random().nextInt(alphabetMap.length))
        .toLowerCase();
  }

  List<String> randomChoice(String alphabet) {
    // สุ่ม choice ที่เป็นคำตอบ (1 choice)
    var answer =
        alphabetMap[alphabet]![Random().nextInt(alphabetMap[alphabet]!.length)];
    List<String> choiceList = [];
    choiceList.add(answer);

    List<String> tmpList = [];
    // สุ่ม choice ที่เป็นตัวหลอก (4 choice)
    alphabetMap.forEach((key, value) {
      if (key != alphabet) {
        tmpList.addAll(value);
      }
    });
    tmpList.shuffle();
    choiceList.add(tmpList[0]);
    choiceList.add(tmpList[1]);
    choiceList.add(tmpList[2]);
    choiceList.add(tmpList[3]);

    choiceList.shuffle();
    return choiceList;
  }
}
