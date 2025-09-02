import 'package:avk/router/path_exporter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI().setupDependencies();
  runApp(const MyApp());
}
