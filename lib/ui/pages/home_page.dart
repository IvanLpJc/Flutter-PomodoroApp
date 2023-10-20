import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:retrowave_pomodoro_app/ui/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  bool isDrawerOpen = false;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (isDrawerOpen) {
          _triggerAnimation();
          setState(() {
            isDrawerOpen = !isDrawerOpen;
          });
        }

        SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            const _Background(),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 100),
              child: CassetteMainBackground(
                width: size.width,
                height: size.height,
              ),
            ),
            AnimatedMenuButton(
              controller: controller,
              onPressed: () {
                _triggerAnimation();
                setState(() {
                  isDrawerOpen = !isDrawerOpen;
                });
              },
            ),
            const Positioned(top: 26, child: Clock()),
            IgnorePointer(
              child: AnimatedOpacity(
                opacity: isDrawerOpen ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: Material(
                  elevation: 6,
                  color: Colors.pink.withOpacity(0.4),
                  child: const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SettingsMenu(
              animationController: controller,
            ),
          ],
        ),
      ),
    );
  }

  _triggerAnimation() {
    if (isDrawerOpen) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}

class _Background extends StatefulWidget {
  const _Background();

  @override
  State<_Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<_Background> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/vaporwave.mp4');
    _controller
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..setVolume(100)
      ..initialize().then((value) => setState(() {}))
      ..play();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      // child: Image(
      //   image: AssetImage('assets/background.jpg'),
      //   fit: BoxFit.cover,
      // ),
      child: VideoPlayer(_controller),
    );
  }
}
