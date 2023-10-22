import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_app/helpers/system_utils.dart';
import 'package:pomodoro_app/shared_preferences/preferences.dart';
import 'package:pomodoro_app/themes/theme_provider.dart';

import 'package:pomodoro_app/ui/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController settingsMenuController;
  late AnimationController playController;

  bool isDrawerOpen = false;
  bool isPlaying = false;

  @override
  void initState() {
    settingsMenuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    playController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    // animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    super.initState();
  }

  @override
  void dispose() {
    settingsMenuController.dispose();
    playController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
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
                showClock: true,
              ),
            ),
            if (!isPlaying)
              Positioned(
                top: 10,
                right: 20,
                child: AnimatedOpacity(
                  opacity: !isPlaying ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedMenuButton(
                    controller: settingsMenuController,
                    onPressed: () async {
                      _triggerAnimation();
                      setState(() {
                        isDrawerOpen = !isDrawerOpen;
                      });
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return SettingsMenu(
                              animationController: settingsMenuController,
                              themeProvider: themeProvider,
                            );
                          });
                      _triggerAnimation();
                      setState(() {
                        isDrawerOpen = !isDrawerOpen;
                      });
                    },
                  ),
                ),
              ),
            Positioned(
              bottom: 40,
              child: AnimatedPlayButton(
                controller: playController,
                onPressed: () {
                  _triggerPlayAnimation();
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _triggerAnimation() {
    if (isDrawerOpen) {
      settingsMenuController.reverse();
    } else {
      settingsMenuController.forward();
    }
  }

  _triggerPlayAnimation() {
    if (isPlaying) {
      resetBrightness();
      playController.reverse();
    } else {
      if (Preferences.customBrightness) {
        setBrightness(Preferences.screenBrightness);
      }

      playController.forward();
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
    _controller =
        VideoPlayerController.asset('assets/videos/vaporwave/vaporwave.mp4');
    _controller
      ..addListener(() {
        setState(() {
          if (Preferences.videoOnLoop) {
            _controller.play();
          } else {
            _controller.pause();
          }
        });
      })
      ..setLooping(true)
      ..setVolume(100)
      ..initialize().then((value) => setState(() {}));

    if (Preferences.videoOnLoop) {
      _controller.play();
    } else {
      _controller.pause();
    }

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
      child: VideoPlayer(_controller),
    );
  }
}
