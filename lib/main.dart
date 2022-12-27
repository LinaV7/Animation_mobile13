import 'package:flutter/material.dart';
import '/container_section.dart';
import 'dart:math' as math;

import 'package:lottie/lottie.dart';

const doge = 'assets/images/placeholder.jpg';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const LottieAnim(),
        '/home': (context) => const AnimationPage(),
      },
    );
  }
}

class LottieAnim extends StatefulWidget {
  const LottieAnim({Key? key}) : super(key: key);

  @override
  State<LottieAnim> createState() => _LottieAnimState();
}

class _LottieAnimState extends State<LottieAnim> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, '/home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/loading.json');
  }
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  bool show = false;

  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  late final AnimationController _controller2 = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));

  late final AnimationController _controller3 = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 5000))
    ..repeat();

  late AnimationController _controllerFade;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _heightAnimation = Tween<double>(begin: 0, end: 90).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    )..addListener(() => setState(() {}));

    _controllerFade = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..repeat(reverse: true)
      ..forward();
    _animation = CurvedAnimation(
      parent: _controllerFade,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controllerFade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedBuilder(
                  animation: _controller3,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _controller3.value * 2 * math.pi,
                      child: child,
                    );
                  },
                  child: FadeTransition(
                    opacity: _animation,
                    child: ClipOval(
                      child: Image.asset(
                        doge,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!show) {
                      _controller.forward();
                      _controller2.forward();
                    } else {
                      _controller.reverse();
                      _controller2.reverse();
                    }
                    show = !show;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor: MaterialStateProperty.all(
                        const Color.fromARGB(150, 42, 43, 44)),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(5),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 10.0, right: 10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        show
                            ? 'Winnie the Pooh hide'
                            : 'Winnie the Pooh appears',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      AnimatedBuilder(
                        animation: _controller2,
                        builder: (_, child) => Transform.rotate(
                          angle: _controller2.value * math.pi,
                          child: child,
                        ),
                        child: const Icon(
                          Icons.arrow_downward,
                          size: 27,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: _heightAnimation.value,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(100, 42, 43, 44),
                      offset: Offset(0, 3),
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    'Type: Honey bear \n Color: Brown or Yellow \n Song: V golove moiyei opilki..'),
              ),
              FadeTransition(
                opacity: _animation,
                child: ContainerSection(imageUrls: characterImages['winnie']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, List<String>> characterImages = {
  'winnie': [
    'https://avatars.dzeninfra.ru/get-zen_doc/1661927/pub_5de3cda1d5bbc300ae3bd228_5de3cfdd34808200b02ef3b3/scale_1200',
  ],
};
