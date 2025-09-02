import 'package:avk/config/assets/lottie.dart';
import 'package:avk/router/path_exporter.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(child: appLottie.splashScreenLottie,));
  }
}
