import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

String title = "SnipSnap -  Don't get snippy, get SnipSnap - your ultimate hair appointment app!";
List<String> letters = title.split("");

class TitleAnimation extends StatefulWidget {
  const TitleAnimation({super.key});

  @override
  State<TitleAnimation> createState() => _TitleAnimationState();
}

class _TitleAnimationState extends State<TitleAnimation> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child :Column (
        children :
        [
          const Text(
            "SnipSnap",
           style : TextStyle(
              fontSize: 18.0,
              fontFamily: 'Agne',
            ),
          ),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
      //width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 15.0,
          fontFamily: 'Agne',
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('Don\'t get snippy, get SnipSnap'),
          ],
          onTap: () {
            if (kDebugMode) {
              print("Tap Event");
            }
          },
        ),
      ),
    )]
    ));
  }


}
